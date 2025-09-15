# 🤖 Claude Agentic Business Agents

Transform Claude Code into a complete business automation powerhouse with 5 specialized AI agents that handle marketing, fundraising, content creation, finance, and product management.

## 🎯 What's Included

### 🚀 5 Production-Ready Business Agents

1. **Marketing CMO** 📈
   - Social media automation (Reddit, LinkedIn)
   - Campaign performance analysis
   - Content strategy and execution
   - Trend analysis and competitive intelligence

2. **Fundraising CRO** 💰
   - Grant discovery and application automation
   - Investor outreach and proposal generation  
   - Government funding opportunities (Grants.gov)
   - Pitch deck creation and funding strategy

3. **Content Creator** 🎨
   - Multi-modal content generation
   - AI image creation (Replicate)
   - Professional voiceovers (ElevenLabs)
   - Cinematic videos (Google Veo 3)
   - Background music (Mubert)

4. **Financial CFO** 📊
   - Financial analysis and reporting
   - Budget planning and runway calculations
   - Revenue forecasting and metrics
   - Investment decision support

5. **Product CPO** 🔧
   - User behavior analysis
   - Feature prioritization
   - Product roadmap planning
   - Market research and validation

### 🛠️ 20+ Automation Scripts

**Marketing Automation:**
- `reddit.sh` - Reddit community engagement
- `linkedin-fetch.sh` - LinkedIn marketing automation
- `email-send.sh` - Professional email campaigns

**Content Creation:**
- `image-generator.sh` - AI image generation with custom models
- `audio-generator.sh` - Professional voiceovers with style presets
- `veo3-video-generator.sh` - 8-second cinematic videos with audio
- `music-generator.sh` - Background music generation

**Fundraising:**
- `grants-gov-fetch.sh` - Government grant discovery
- `proposal-generator.sh` - Automated proposal creation

## 🏃 Quick Start

### Installation

```bash
# Clone the repository
git clone https://github.com/[your-username]/claude-agentic-agents
cd claude-agentic-agents

# Install agents (stable version)
chmod +x install.sh
./install.sh

# OR install development version (latest features)
chmod +x install-live-agents.sh
./install-live-agents.sh
```

### Setup API Keys

```bash
# Copy environment template
cp .env.template .env

# Edit with your API keys
nano .env
```

See [API_KEY_SETUP_GUIDE.md](API_KEY_SETUP_GUIDE.md) for detailed setup instructions.

### Test Installation

```bash
# Verify everything works
./test_installation.sh
```

## 🎮 Usage Examples

### Marketing Automation
```bash
# Analyze Reddit trends and create posts
claude "analyze r/programming trends and create 3 posts about our AI tool"

# Run complete social media campaign
claude "create a marketing campaign for our product launch across Reddit and LinkedIn"
```

### Content Creation
```bash
# Generate marketing assets
claude "create a professional headshot, voiceover script, and promotional video for our CEO"

# Multi-modal content pipeline
claude "generate blog images, audio summary, and social media video for our latest feature"
```

### Fundraising
```bash
# Find relevant grants
claude "search for AI startup grants and create application timeline"

# Generate investor materials
claude "create pitch deck and financial projections for Series A"
```

### Financial Analysis
```bash
# Runway calculation
claude "analyze our current burn rate and calculate runway scenarios"

# Budget planning
claude "create quarterly budget plan with hiring projections"
```

### Product Strategy
```bash
# Feature prioritization
claude "analyze user feedback and prioritize next 5 features to build"

# Market research
claude "research competitor pricing and recommend our pricing strategy"
```

## 🔧 Advanced Features

### Agent Intelligence System
Each agent maintains persistent memory and learns from your business:
- Strategic decisions and outcomes
- Successful campaigns and content
- Market insights and trends
- Financial patterns and projections

### Multi-Modal Content Creation
Create complete content packages:
- Professional images with custom styles
- High-quality voiceovers in multiple styles
- Cinematic videos with native audio
- Background music tailored to your brand

### Automation Workflows
Chain agents together for complex workflows:
```bash
# Complete product launch
claude "research market opportunity, create marketing campaign, generate content assets, and plan budget"
```

## 📚 Documentation

- **[API Key Setup Guide](API_KEY_SETUP_GUIDE.md)** - Step-by-step API configuration
- **[Integration Guide](INTEGRATION_GUIDE.md)** - Adding to existing Claude Code setups
- **[Agent Packaging Plan](AGENT_PACKAGING_PLAN.md)** - Architecture and distribution strategy

## 🔒 Security & Privacy

- All API keys stored locally in your `.env` file
- No data sent to external services except chosen APIs
- Open-source scripts you can inspect and modify
- Production-ready error handling and validation

## 🤝 Contributing

We welcome contributions! To contribute:

1. Fork the repository
2. Create a feature branch
3. Add/improve agents or automation scripts
4. Submit a pull request

### Adding New Agents

Follow the agent template in `AGENT_PACKAGING_PLAN.md` to create new specialized agents.

## 📝 License

MIT License - Use freely in your projects

## 🙏 Acknowledgments

Built with Claude Code and inspired by the need for truly autonomous business automation.

---

**Transform your business operations with AI agents that actually execute work, not just provide advice.** 🚀