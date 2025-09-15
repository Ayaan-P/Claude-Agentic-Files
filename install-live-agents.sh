#!/bin/bash
# Live Agent Installation - Links to your actively developed agents

GLOBAL_AGENTS_DIR="$HOME/.claude/agents"
SOURCE_AGENTS_DIR="$(dirname "$0")/agents"

echo "🔗 Installing live-linked agents..."

# For development/testing: Link directly to your global agents
# This means any improvements you make are immediately available

AGENTS=("marketing-cmo" "fundraising-cro" "content-creator" "financial-cfo" "product-cpo")

for agent in "${AGENTS[@]}"; do
    if [ -f "$GLOBAL_AGENTS_DIR/${agent}.md" ]; then
        echo "🔗 Linking ${agent}..."
        
        # Remove existing file if present
        rm -f "$SOURCE_AGENTS_DIR/${agent}.md"
        
        # Create symbolic link
        ln -s "$GLOBAL_AGENTS_DIR/${agent}.md" "$SOURCE_AGENTS_DIR/${agent}.md"
        
        echo "   ✅ Live link created"
    else
        echo "   ❌ ${agent}.md not found in global agents"
    fi
done

echo "✅ Live agent installation complete!"
echo "ℹ️  These agents will automatically reflect your global improvements"