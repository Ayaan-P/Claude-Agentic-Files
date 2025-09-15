# CMO Marketing Tools - API Key Setup Guide

This guide will walk you through setting up API credentials for all 6 marketing intelligence platforms integrated with your CMO agent.

## 📋 Prerequisites

- Admin access to your marketing platforms
- Ability to create developer applications
- Basic familiarity with API keys and OAuth

## 🚀 Quick Start Checklist

| Platform | Status | Priority | Complexity |
|----------|--------|----------|------------|
| ✅ Instagram Business | ⬜ | High | Medium |
| ✅ Stripe Revenue | ⬜ | High | Easy |
| ✅ OpenAI Content | ⬜ | High | Easy |
| ✅ Google Analytics 4 | ⬜ | Medium | Hard |
| ✅ Google Ads | ⬜ | Medium | Hard |
| ✅ Google Trends | ⬜ | Low | N/A (Alpha) |

## 1. Instagram Business API Setup

### Requirements
- Instagram Business or Creator account
- Facebook Page connected to Instagram
- Facebook Developer account

### Step-by-Step Setup

1. **Go to Facebook Developers Console**
   - Visit: https://developers.facebook.com/
   - Click "My Apps" → "Create App"

2. **Create Facebook App**
   - Choose "Business" as app type
   - Enter app name: "Your Business CMO Integration"
   - Enter contact email

3. **Add Instagram Basic Display Product**
   - In app dashboard, click "Add Product"
   - Find "Instagram Basic Display" and click "Set Up"

4. **Configure Instagram Basic Display**
   - Go to Instagram Basic Display → Basic Display
   - Create Instagram App
   - Add Instagram Test User (your own account)

5. **Get Access Token**
   - Go to Instagram Basic Display → Basic Display
   - Click "Generate Token" next to your test user
   - Copy the long-lived access token

6. **Add to Environment**
   ```bash
   INSTAGRAM_ACCESS_TOKEN=your_long_lived_access_token_here
   ```

### Test Your Setup
```bash
./lib/instagram-fetch.sh account-info
```

---

## 2. Stripe Revenue Attribution Setup

### Requirements
- Stripe account with API access
- Live or test API keys

### Step-by-Step Setup

1. **Go to Stripe Dashboard**
   - Visit: https://dashboard.stripe.com/
   - Navigate to "Developers" → "API keys"

2. **Get API Keys**
   - Copy "Secret key" (starts with `sk_live_` or `sk_test_`)
   - **Important**: Never share or commit this key

3. **Add to Environment**
   ```bash
   STRIPE_API_KEY=sk_live_your_secret_key_here
   ```

### Test Your Setup
```bash
./lib/stripe-fetch.sh revenue-summary
```

---

## 3. OpenAI Content Generation Setup

### Requirements
- OpenAI API account
- Credit card for billing (pay-per-use)

### Step-by-Step Setup

1. **Go to OpenAI Platform**
   - Visit: https://platform.openai.com/
   - Sign up or log in to your account

2. **Create API Key**
   - Navigate to "API keys" in left sidebar
   - Click "Create new secret key"
   - Give it a name: "CMO Marketing Integration"
   - Copy the key (starts with `sk-`)

3. **Set Usage Limits (Recommended)**
   - Go to "Usage limits" in left sidebar
   - Set monthly spending limit (e.g., $50)

4. **Add to Environment**
   ```bash
   OPENAI_API_KEY=sk-your_openai_api_key_here
   ```

### Test Your Setup
```bash
./lib/openai-content-fetch.sh generate-text "prompt=Hello world"
```

---

## 4. Google Analytics 4 Setup

### Requirements
- Google Analytics 4 property
- Google Cloud Console access
- Python 3.8+ with pip

### Step-by-Step Setup

1. **Install Python Dependencies**
   ```bash
   pip3 install google-analytics-data google-auth google-auth-oauthlib
   ```

2. **Go to Google Cloud Console**
   - Visit: https://console.cloud.google.com/
   - Create new project or select existing one

3. **Enable Google Analytics Reporting API**
   - Go to "APIs & Services" → "Library"
   - Search for "Google Analytics Reporting API"
   - Click and enable it

4. **Create Service Account**
   - Go to "APIs & Services" → "Credentials"
   - Click "Create Credentials" → "Service Account"
   - Name: "CMO GA4 Integration"
   - Role: "Viewer"

5. **Download Service Account JSON**
   - Click on created service account
   - Go to "Keys" tab → "Add Key" → "Create new key"
   - Choose JSON format and download

6. **Get GA4 Property ID**
   - Go to Google Analytics 4
   - Admin → Property Settings
   - Copy "Property ID" (numbers only)

7. **Grant Service Account Access**
   - In GA4 Admin → Property Access Management
   - Add service account email as "Viewer"

8. **Add to Environment**
   ```bash
   GA4_PROPERTY_ID=123456789
   GA4_SERVICE_ACCOUNT_JSON=/path/to/your/service-account.json
   ```

### Test Your Setup
```bash
./lib/ga4-fetch.sh setup-check
```

---

## 5. Google Ads API Setup

### Requirements
- Google Ads account with campaigns
- Google Cloud Console access
- Python 3.8+ with pip

### Step-by-Step Setup

1. **Install Python Dependencies**
   ```bash
   pip3 install google-ads google-auth google-auth-oauthlib
   ```

2. **Apply for Developer Token**
   - Visit: https://developers.google.com/google-ads/api/docs/get-started
   - Fill out developer token application
   - **Note**: This can take several days to approve

3. **Go to Google Cloud Console**
   - Visit: https://console.cloud.google.com/
   - Create new project or select existing one

4. **Enable Google Ads API**
   - Go to "APIs & Services" → "Library"
   - Search for "Google Ads API"
   - Click and enable it

5. **Create OAuth 2.0 Credentials**
   - Go to "APIs & Services" → "Credentials"
   - Click "Create Credentials" → "OAuth 2.0 Client ID"
   - Application type: "Desktop application"
   - Name: "CMO Google Ads Integration"

6. **Get Refresh Token**
   - Use OAuth playground or run authentication flow
   - Guide: https://developers.google.com/google-ads/api/docs/oauth/cloud-project
   - Save the refresh token

7. **Get Customer ID**
   - Go to Google Ads dashboard
   - Top right corner shows Customer ID (10 digits)

8. **Add to Environment**
   ```bash
   GOOGLE_ADS_DEVELOPER_TOKEN=your_developer_token
   GOOGLE_ADS_CLIENT_ID=your_oauth_client_id
   GOOGLE_ADS_CLIENT_SECRET=your_oauth_client_secret
   GOOGLE_ADS_REFRESH_TOKEN=your_oauth_refresh_token
   GOOGLE_ADS_CUSTOMER_ID=1234567890
   ```

### Test Your Setup
```bash
./lib/google-ads-fetch.sh setup-check
```

---

## 6. Google Trends API Setup (Alpha)

### Current Status
Google Trends API is currently in **Alpha** with limited access.

### How to Apply
1. **Visit Registration Page**
   - Go to: https://developers.google.com/search/docs/monitor-debug/trends-start
   - Sign up for alpha access

2. **Application Requirements**
   - Research or journalism use case
   - Regular analysis needs
   - Detailed description of intended use

3. **When Approved**
   ```bash
   GOOGLE_TRENDS_API_KEY=your_trends_api_key
   ```

### Current Functionality
The Google Trends integration provides **simulated data** until API access is available:

```bash
./lib/google-trends-fetch.sh setup-check
```

---

## 🔧 Environment File Template

Create a `.env` file in your Claude-Agentic-Files directory:

```bash
# ==========================================
# CMO Marketing Intelligence API Keys
# ==========================================

# Instagram Business API
INSTAGRAM_ACCESS_TOKEN=

# Stripe Revenue Attribution  
STRIPE_API_KEY=

# Google Analytics 4
GA4_PROPERTY_ID=
GA4_SERVICE_ACCOUNT_JSON=

# Google Ads API
GOOGLE_ADS_DEVELOPER_TOKEN=
GOOGLE_ADS_CLIENT_ID=
GOOGLE_ADS_CLIENT_SECRET=
GOOGLE_ADS_REFRESH_TOKEN=
GOOGLE_ADS_CUSTOMER_ID=

# OpenAI Content Generation
OPENAI_API_KEY=

# Google Trends API (Alpha - when available)
GOOGLE_TRENDS_API_KEY=

# Reddit Marketing (existing)
REDDIT_CLIENT_ID=
REDDIT_CLIENT_SECRET=
REDDIT_USERNAME=
REDDIT_PASSWORD=
```

## 🧪 Testing All Integrations

Run this comprehensive test script:

```bash
#!/bin/bash
echo "🧪 Testing CMO Marketing Integrations..."

echo "📱 Testing Instagram..."
./lib/instagram-fetch.sh account-info

echo "💰 Testing Stripe..."
./lib/stripe-fetch.sh revenue-summary

echo "📊 Testing GA4..."
./lib/ga4-fetch.sh setup-check

echo "🎯 Testing Google Ads..."
./lib/google-ads-fetch.sh setup-check

echo "🤖 Testing OpenAI..."
./lib/openai-content-fetch.sh generate-text "prompt=Test successful"

echo "📈 Testing Google Trends..."
./lib/google-trends-fetch.sh setup-check

echo "✅ All tests completed!"
```

## 🔒 Security Best Practices

1. **Never commit API keys to version control**
2. **Use test/sandbox keys during development**
3. **Rotate keys regularly (monthly)**
4. **Set usage limits and alerts**
5. **Use restricted API keys when possible**
6. **Monitor API usage and costs**

## 🆘 Troubleshooting

### Common Issues

**"Permission denied" errors**
- Check file permissions: `chmod +x ./lib/*.sh`
- Verify environment variables are loaded

**API authentication failures**
- Double-check API keys are correctly copied
- Ensure no extra spaces or characters
- Check if API keys have expired

**Python dependency errors**
- Install required packages: `pip3 install google-analytics-data google-ads`
- Check Python version: `python3 --version` (need 3.8+)

**Rate limit errors**
- Implement delays between requests
- Check API quotas and limits
- Consider upgrading API plans

### Getting Help

1. **Check integration logs** in terminal output
2. **Test individual scripts** before using CMO agent
3. **Verify .env file** has all required keys
4. **Check platform documentation** for API changes

## 🎉 Success!

Once all APIs are configured, your CMO agent will have access to:

- **Instagram**: Engagement metrics and audience insights
- **Stripe**: Revenue attribution and customer analytics  
- **GA4**: Website traffic and conversion funnels
- **Google Ads**: Campaign performance and optimization
- **OpenAI**: AI-powered content generation
- **Google Trends**: Market intelligence and trend analysis

Start using your fully-powered CMO agent:

```bash
claude /cmo "analyze our marketing performance across all channels"
claude /cmo "generate social media posts for our product launch"
claude /cmo "what's our customer acquisition cost trend?"
```