# NEWS INTELLIGENCE SETUP GUIDE
## *Free News Monitoring for CMO Agent*

---

## 🆓 **FREE SETUP (Immediate)**

### **1. Free APIs (No Keys Required)**
These work immediately with no setup:

**Reddit Monitoring:**
```bash
claude /cmo "monitor Reddit discussions about context-aware AI"
# Uses: r/artificial, r/MachineLearning, r/ChatGPT, r/OpenAI, r/singularity
```

**HackerNews Monitoring:**
```bash
claude /cmo "check HackerNews trends for AI and context discussions"
# Monitors: Top 50 stories for AI-related keywords
```

**Competitor Tracking:**
```bash
claude /cmo "track competitor mentions on Reddit and HackerNews"
# Monitors: OpenAI, Anthropic, Claude, ChatGPT mentions
```

---

## 🔑 **ENHANCED SETUP (Free Tier)**

### **2. NewsAPI.org Free Account**

**Benefits:**
- 1,000 requests per day (FREE)
- Access to 80,000+ news sources
- Real-time news monitoring
- Competitor news tracking

**Setup Steps:**
1. Go to https://newsapi.org/
2. Click "Get API Key"
3. Sign up for free account
4. Copy your API key
5. Add to `.env` file:

```bash
# Add this line to your .env file
NEWS_API_KEY=your_free_api_key_here
```

**Test Setup:**
```bash
# Test the news intelligence setup
./lib/news-intelligence-fetch.sh setup-check
```

---

## 📊 **CMO USAGE EXAMPLES**

### **Daily Intelligence Gathering**
```bash
claude /cmo "generate daily intelligence report with market trends"
```

### **Competitor Monitoring**
```bash
claude /cmo "track competitor mentions across Reddit and news"
```

### **Brand Monitoring**
```bash
claude /cmo "monitor news about context-aware AI and competitors"
```

### **Sentiment Analysis**
```bash
claude /cmo "analyze sentiment around AI discussions this week"
```

---

## 🛠 **TECHNICAL DETAILS**

### **Available Commands**
The CMO agent now includes these news intelligence functions:

```bash
# Reddit monitoring (always free)
./lib/news-intelligence-fetch.sh reddit-monitor 'query=AI&subreddits=artificial,MachineLearning'

# HackerNews trends (always free)  
./lib/news-intelligence-fetch.sh hackernews-monitor 'keywords=AI,context,intelligence'

# NewsAPI monitoring (requires free API key)
./lib/news-intelligence-fetch.sh newsapi-monitor 'query=context-aware AI&api-key=YOUR_KEY'

# Competitor tracking (multi-source)
./lib/news-intelligence-fetch.sh competitor-tracking 'competitors=openai,anthropic&sources=all_free'

# Generate comprehensive report
./lib/news-intelligence-fetch.sh generate-report
```

### **Data Sources**
- **Reddit**: 5+ AI-focused subreddits, real-time discussions
- **HackerNews**: Top 50 stories, keyword filtering
- **NewsAPI.org**: 80,000+ sources (with free API key)
- **Memory Integration**: All intelligence stored in CMO memory

### **Intelligence Categories**
- **Brand Monitoring**: Mentions of Dytto, context-aware AI
- **Competitive Intelligence**: Competitor activities and mentions
- **Community Intelligence**: Developer discussions and trends
- **Market Trends**: Industry insights and emerging topics

---

## 💡 **USAGE PATTERNS**

### **Daily Routine**
```bash
# Morning intelligence brief
claude /cmo "generate daily intelligence report"

# Check competitor activity
claude /cmo "what are competitors discussing today?"

# Monitor brand mentions
claude /cmo "any new mentions of context-aware AI?"
```

### **Weekly Analysis**
```bash
# Weekly trend analysis
claude /cmo "analyze AI discussion trends from this week"

# Competitor strategy insights
claude /cmo "what marketing strategies are competitors using?"

# Content opportunity identification
claude /cmo "what topics are trending that we should create content about?"
```

### **Campaign Support**
```bash
# Pre-campaign intelligence
claude /cmo "research current AI sentiment before launching campaign"

# Campaign monitoring
claude /cmo "track mentions and sentiment during campaign launch"

# Post-campaign analysis
claude /cmo "analyze campaign impact on brand mentions and sentiment"
```

---

## 📈 **EXPECTED BENEFITS**

### **Free Tier (No API Key)**
- **Real-time community intelligence** from Reddit discussions
- **Tech industry pulse** from HackerNews trends
- **Competitor activity monitoring** across free sources
- **Daily intelligence reports** with actionable insights

### **Enhanced Tier (Free NewsAPI Key)**
- **Comprehensive news monitoring** from 80,000+ sources
- **Professional competitor intelligence** from news sources
- **Brand mention tracking** across news media
- **Enhanced sentiment analysis** with news data

---

## 🚀 **GETTING STARTED**

### **Step 1: Test Free Features**
```bash
claude /cmo "test news intelligence with free sources"
```

### **Step 2: Add NewsAPI Key (Optional)**
```bash
# Add to .env file
echo "NEWS_API_KEY=your_free_key_here" >> .env
```

### **Step 3: Verify Setup**
```bash
claude /cmo "verify news intelligence setup"
```

### **Step 4: Generate First Report**
```bash
claude /cmo "generate daily intelligence report"
```

---

## 🔧 **TROUBLESHOOTING**

### **Common Issues**

**"No data found"**
- Check internet connection
- Verify Reddit/HackerNews access
- Try different keywords

**"API key error"**  
- Verify NewsAPI key in .env file
- Check API key validity at newsapi.org
- Ensure key has remaining quota

**"Permission denied"**
- Make script executable: `chmod +x lib/news-intelligence-fetch.sh`
- Check file permissions

### **Support**

For setup help or issues:
1. Check script logs for error messages
2. Test individual functions manually
3. Verify environment variable setup
4. Review API key quotas and limits

---

*Your CMO agent now has comprehensive news intelligence capabilities, both free and enhanced, to provide market insights and competitive intelligence for strategic decision-making.*

---

## 📚 **NEXT STEPS**

1. **Set up daily automation** - Schedule intelligence reports
2. **Customize monitoring** - Add specific competitors and keywords  
3. **Integrate with content strategy** - Use insights for content planning
4. **Expand sources** - Consider premium APIs as needed
5. **Build custom alerts** - Set up notifications for important mentions