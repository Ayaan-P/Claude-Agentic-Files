# CMO Agent Integration Development Guide

This guide provides step-by-step instructions for creating new integrations for the CMO agent system. Follow this template to build consistent, well-documented integrations.

## 🏗️ **Integration Architecture**

### **File Structure**
```
/lib/
├── {service}-fetch.sh          # Main integration script
├── {service}-auth.sh           # Authentication helper (if needed)
└── {service}-examples.sh       # Usage examples

/commands/
└── cmo.md                      # Updated with new integration docs

/.env                           # API keys and configuration
```

### **Integration Components**
1. **Authentication** - API key management and OAuth flows
2. **Data Fetching** - Retrieve analytics and content
3. **Content Publishing** - Post content to platform
4. **Error Handling** - Robust failure management
5. **Logging** - Integration with CMO logging system
6. **Documentation** - Usage examples and setup guide

---

## 📝 **Step 1: Create Main Integration Script**

Create `/lib/{service}-fetch.sh` with this template:

```bash
#!/bin/bash
# {Service Name} Integration for CMO Agent
# Usage: ./{service}-fetch.sh <action> [params]

set -e

ACTION="$1"
PARAMS="$2"

# Help text
if [[ -z "$ACTION" ]]; then
    echo "Usage: $0 <action> [params]"
    echo "Actions:"
    echo "  setup-check          - Verify API setup"
    echo "  account-info         - Get account information"
    echo "  analytics           - Get performance analytics"
    echo "  post-content        - Publish content"
    echo "  list-content        - List existing content"
    echo ""
    echo "Examples:"
    echo "  $0 setup-check"
    echo "  $0 analytics 'timeframe=30d&metrics=engagement'"
    echo "  $0 post-content 'title=Hello World&content=My first post'"
    exit 1
fi

# Environment loading
ENV_PATHS=(
    "/home/ayaan/Projects/Claude-Agentic-Files.env"
    "./.env"
    "../Claude-Agentic-Files/.env"
    "$HOME/.env"
)

for env_path in "${ENV_PATHS[@]}"; do
    if [[ -f "$env_path" ]]; then
        source "$env_path"
        break
    fi
done

# CMO Logging Integration
LOG_DIR="$HOME/.claude/marketing_intelligence/logs"
SOURCES_DIR="$HOME/.claude/marketing_intelligence/sources"
mkdir -p "$LOG_DIR" "$SOURCES_DIR"

# Logging functions
log_info() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] INFO: $1" >&2
}

log_error() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: $1" >&2
}

# Save raw API responses for audit
save_api_response() {
    local endpoint="$1"
    local response="$2"
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local file="$SOURCES_DIR/{service}_${endpoint}_${timestamp}.json"
    
    echo "$response" > "$file"
    log_info "Saved API response: $file"
}

# Parameter parsing
parse_params() {
    if [[ -n "$PARAMS" ]]; then
        IFS='&' read -ra PARAM_ARRAY <<< "$PARAMS"
        for param in "${PARAM_ARRAY[@]}"; do
            if [[ $param =~ ^([^=]+)=(.*)$ ]]; then
                local key="${BASH_REMATCH[1]}"
                local value="${BASH_REMATCH[2]}"
                # URL decode value
                value=$(printf '%b' "${value//%/\\\\\\\\x}" | sed 's/+/ /g')
                declare -g "PARAM_$key"="$value"
            fi
        done
    fi
}

# API authentication check
check_auth() {
    if [[ -z "${SERVICE_API_KEY}" ]]; then
        log_error "{Service} API key not found"
        echo "Please add {SERVICE_API_KEY} to your .env file"
        echo "Get API key from: https://{service}.com/developers"
        return 1
    fi
    return 0
}

# Generic API call wrapper
api_call() {
    local method="$1"
    local endpoint="$2"
    local data="$3"
    local base_url="https://api.{service}.com"
    
    local curl_opts=(
        -s
        -w "%{http_code}"
        -H "Authorization: Bearer ${SERVICE_API_KEY}"
        -H "Content-Type: application/json"
        -H "User-Agent: DyttoCMO/1.0"
    )
    
    if [[ "$method" == "POST" && -n "$data" ]]; then
        curl_opts+=(-d "$data")
    fi
    
    local response
    response=$(curl "${curl_opts[@]}" -X "$method" "$base_url$endpoint")
    
    local http_code=${response: -3}
    response=${response%???}
    
    if [[ $http_code -ge 200 && $http_code -lt 300 ]]; then
        save_api_response "$(basename "$endpoint")" "$response"
        echo "$response"
        return 0
    else
        log_error "API call failed: HTTP $http_code"
        echo "$response" >&2
        return 1
    fi
}

# Parse parameters
parse_params

# Action implementations
case "$ACTION" in
    "setup-check")
        log_info "Checking {Service} API setup"
        
        if check_auth; then
            # Test API connectivity
            if api_call "GET" "/account" >/dev/null; then
                echo '{"status": "ready", "message": "{Service} integration is properly configured"}'
            else
                echo '{"status": "error", "message": "API credentials configured but connection failed"}'
                exit 1
            fi
        else
            echo '{"status": "incomplete", "message": "{Service} API key required"}'
            exit 1
        fi
        ;;
        
    "account-info")
        if ! check_auth; then exit 1; fi
        
        log_info "Fetching {Service} account information"
        api_call "GET" "/account"
        ;;
        
    "analytics")
        if ! check_auth; then exit 1; fi
        
        timeframe="${PARAM_timeframe:-30d}"
        metrics="${PARAM_metrics:-basic}"
        
        log_info "Fetching analytics for timeframe: $timeframe"
        api_call "GET" "/analytics?timeframe=$timeframe&metrics=$metrics"
        ;;
        
    "post-content")
        if ! check_auth; then exit 1; fi
        
        title="${PARAM_title}"
        content="${PARAM_content}"
        
        if [[ -z "$title" || -z "$content" ]]; then
            log_error "Title and content parameters required"
            echo "Usage: $0 post-content 'title=Post Title&content=Post content here'"
            exit 1
        fi
        
        log_info "Publishing content: $title"
        
        # Create JSON payload
        local payload
        payload=$(jq -n \
            --arg title "$title" \
            --arg content "$content" \
            '{
                title: $title,
                content: $content,
                status: "published",
                timestamp: now | strftime("%Y-%m-%dT%H:%M:%SZ")
            }')
        
        api_call "POST" "/posts" "$payload"
        ;;
        
    "list-content")
        if ! check_auth; then exit 1; fi
        
        limit="${PARAM_limit:-10}"
        status="${PARAM_status:-published}"
        
        log_info "Listing content (limit: $limit, status: $status)"
        api_call "GET" "/posts?limit=$limit&status=$status"
        ;;
        
    *)
        log_error "Unknown action: $ACTION"
        echo "Supported actions: setup-check, account-info, analytics, post-content, list-content"
        exit 1
        ;;
esac
```

---

## 🔑 **Step 2: Add Environment Configuration**

Add to `/home/ayaan/Projects/Claude-Agentic-Files.env`:

```bash
# {Service Name} Integration
{SERVICE_API_KEY}=your_api_key_here
{SERVICE_CLIENT_ID}=your_client_id_here       # If OAuth required
{SERVICE_CLIENT_SECRET}=your_client_secret_here # If OAuth required

# Optional: Service-specific settings
{SERVICE_BASE_URL}=https://api.{service}.com   # If custom endpoint
{SERVICE_RATE_LIMIT}=100                       # Requests per hour
{SERVICE_DEFAULT_CATEGORY}=marketing           # Default content category
```

---

## 📚 **Step 3: Update CMO Documentation**

Add to `/home/ayaan/Projects/Claude-Agentic-Filescommands/cmo.md`:

```markdown
**{Service Name} Integration:**
```bash
if [[ -n "${SERVICE_API_KEY}" ]]; then
    echo "📱 Fetching {Service} data..."
    
    # Get performance analytics
    .lib/{service}-fetch.sh analytics "timeframe=30d&metrics=engagement,reach,conversions"
    
    # Store performance data in memory
    echo "Storing {Service} performance data..." | store_memory agent_type=cmo context_type=performance
fi
```

**{Service Name} Content Publishing:**
```bash
# CRITICAL: When user asks to post to {Service}, you MUST actually post
# 1. Generate the content (title and body)
# 2. IMMEDIATELY use the Bash tool to execute this command:

if [[ -n "${SERVICE_API_KEY}" ]]; then
    /home/ayaan/Projects/Claude-Agentic-Fileslib/{service}-fetch.sh post-content "title=Generated Title&content=Generated Content"
fi

# YOU MUST USE THE BASH TOOL TO RUN THE SCRIPT ABOVE
```
```

---

## 🧪 **Step 4: Create Test Script**

Create `/lib/{service}-examples.sh`:

```bash
#!/bin/bash
# {Service Name} Integration Examples and Tests

echo "🧪 Testing {Service} Integration"
echo "================================"

# Test 1: Setup Check
echo "1. Testing API setup..."
./lib/{service}-fetch.sh setup-check

# Test 2: Account Info
echo -e "\n2. Getting account information..."
./lib/{service}-fetch.sh account-info

# Test 3: Analytics
echo -e "\n3. Fetching analytics..."
./lib/{service}-fetch.sh analytics "timeframe=7d&metrics=engagement"

# Test 4: List Content
echo -e "\n4. Listing recent content..."
./lib/{service}-fetch.sh list-content "limit=5"

# Test 5: Post Content (commented out for safety)
echo -e "\n5. Content posting test (uncomment to test):"
echo "# ./lib/{service}-fetch.sh post-content 'title=Test Post&content=This is a test post from CMO agent'"

echo -e "\n✅ {Service} integration tests complete!"
```

---

## 🔐 **Step 5: OAuth Integration (If Required)**

Create `/lib/{service}-auth.sh` for OAuth flows:

```bash
#!/bin/bash
# {Service Name} OAuth Authentication Helper

# OAuth configuration
OAUTH_BASE_URL="https://oauth.{service}.com"
CLIENT_ID="${SERVICE_CLIENT_ID}"
CLIENT_SECRET="${SERVICE_CLIENT_SECRET}"
REDIRECT_URI="http://localhost:8080/callback"
SCOPE="read write"

# Generate OAuth URL
generate_auth_url() {
    local state=$(openssl rand -hex 16)
    echo "Visit this URL to authorize the application:"
    echo "${OAUTH_BASE_URL}/authorize?client_id=${CLIENT_ID}&redirect_uri=${REDIRECT_URI}&scope=${SCOPE}&state=${state}&response_type=code"
    echo ""
    echo "After authorization, you'll be redirected to:"
    echo "http://localhost:8080/callback?code=AUTHORIZATION_CODE"
    echo ""
    echo "Copy the authorization code and run:"
    echo "$0 exchange-token AUTHORIZATION_CODE"
}

# Exchange authorization code for access token
exchange_token() {
    local auth_code="$1"
    
    if [[ -z "$auth_code" ]]; then
        echo "Error: Authorization code required"
        echo "Usage: $0 exchange-token AUTHORIZATION_CODE"
        exit 1
    fi
    
    local response
    response=$(curl -s -X POST "${OAUTH_BASE_URL}/token" \
        -H "Content-Type: application/x-www-form-urlencoded" \
        -d "grant_type=authorization_code" \
        -d "client_id=${CLIENT_ID}" \
        -d "client_secret=${CLIENT_SECRET}" \
        -d "code=${auth_code}" \
        -d "redirect_uri=${REDIRECT_URI}")
    
    local access_token=$(echo "$response" | jq -r '.access_token // empty')
    
    if [[ -n "$access_token" ]]; then
        echo "✅ Authorization successful!"
        echo "Add this to your .env file:"
        echo "{SERVICE_API_KEY}=${access_token}"
    else
        echo "❌ Authorization failed:"
        echo "$response" | jq .
    fi
}

case "$1" in
    "auth-url")
        generate_auth_url
        ;;
    "exchange-token")
        exchange_token "$2"
        ;;
    *)
        echo "Usage: $0 <command>"
        echo "Commands:"
        echo "  auth-url        - Generate OAuth authorization URL"
        echo "  exchange-token  - Exchange authorization code for access token"
        ;;
esac
```

---

## 📖 **Step 6: Integration Patterns**

### **For Social Media Platforms:**
```bash
# Key functions to implement:
- post_content()           # Publish posts
- get_analytics()          # Engagement metrics
- schedule_content()       # Queue posts
- get_audience_insights()  # Demographics
```

### **For Analytics Platforms:**
```bash
# Key functions to implement:
- get_traffic_data()       # Website traffic
- get_conversion_data()    # Goal completions
- get_audience_data()      # User demographics
- get_realtime_data()      # Live metrics
```

### **For E-commerce Platforms:**
```bash
# Key functions to implement:
- get_sales_data()         # Revenue metrics
- get_product_data()       # Product performance
- get_customer_data()      # Customer insights
- update_inventory()       # Stock management
```

### **For Communication Platforms:**
```bash
# Key functions to implement:
- send_message()           # Direct communication
- get_conversations()      # Message history
- create_broadcast()       # Mass messaging
- get_contact_list()       # Audience management
```

---

## 🎯 **Step 7: CMO Integration Points**

Add these integration points to the main CMO script:

### **Data Collection:**
```bash
# Add to data collection section
if [[ -n "${SERVICE_API_KEY}" ]]; then
    echo "📊 Fetching {Service} data..."
    
    # Get analytics data
    .lib/{service}-fetch.sh analytics "timeframe=30d" | store_memory agent_type=cmo context_type=analytics
    
    # Get account information
    .lib/{service}-fetch.sh account-info | store_memory agent_type=cmo context_type=account_data
fi
```

### **Content Publishing:**
```bash
# Add to content publishing section
{service}_post() {
    local title="$1"
    local content="$2"
    local category="${3:-marketing}"
    
    .lib/{service}-fetch.sh post-content "title=$title&content=$content&category=$category"
}
```

### **Analytics Reporting:**
```bash
# Add to analytics section
if [[ -n "${SERVICE_API_KEY}" ]]; then
    {service}_analytics=$(./lib/{service}-fetch.sh analytics "timeframe=30d&metrics=all")
    echo "Storing {Service} analytics data..." | store_memory agent_type=cmo context_type=performance
fi
```

---

## ✅ **Step 8: Testing Checklist**

Before considering the integration complete:

- [ ] **Authentication works** - API keys load correctly
- [ ] **API calls succeed** - All endpoints return expected data
- [ ] **Error handling robust** - Graceful failure modes
- [ ] **Logging integrated** - Responses saved to audit trail
- [ ] **CMO memory integration** - Data stored in agent memory
- [ ] **Content publishing works** - Can actually post content
- [ ] **Documentation complete** - Clear usage examples
- [ ] **Rate limiting respected** - No API abuse
- [ ] **Environment variables secure** - No keys in code

---

## 🚀 **Step 9: Deployment Instructions**

1. **Make scripts executable:**
```bash
chmod +x /lib/{service}-fetch.sh
chmod +x /lib/{service}-auth.sh
chmod +x /lib/{service}-examples.sh
```

2. **Test the integration:**
```bash
./lib/{service}-examples.sh
```

3. **Update CMO documentation:**
```bash
# Add integration docs to commands/cmo.md
# Test CMO agent with new integration
claude /cmo "test {service} integration"
```

4. **Set up monitoring:**
```bash
# Add API quota monitoring
# Set up failure alerts
# Configure backup data sources
```

---

## 💡 **Integration Examples**

### **Completed Integrations to Reference:**
- `reddit-fetch.sh` - Social media posting
- `dytto-blog-fetch.sh` - Content management
- `news-intelligence-fetch.sh` - Data aggregation
- `linkedin-fetch.sh` - Professional networking
- `instagram-fetch.sh` - Visual content platform

### **Quick Start Templates:**
```bash
# Copy existing integration as template
cp lib/reddit-fetch.sh lib/newservice-fetch.sh

# Update service-specific details
sed -i 's/reddit/newservice/g' lib/newservice-fetch.sh
sed -i 's/Reddit/NewService/g' lib/newservice-fetch.sh

# Customize API endpoints and authentication
```

This guide provides everything needed to create a robust, well-integrated service for the CMO agent system. Each integration follows the same patterns for consistency and maintainability.