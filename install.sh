#!/bin/bash
# install.sh - Master installer for Claude Agnetic System v3.0

set -euo pipefail

# Configuration
CLAUDE_HOME="${CLAUDE_HOME:-$HOME/.claude}"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VERSION="3.0.0"
BACKUP_SUFFIX=".backup-$(date +%s)"

# Colors for Batman theme
export BLACK='\033[0;30m'
export YELLOW='\033[1;33m'
export GRAY='\033[0;37m'
export DARK_GRAY='\033[1;30m'
export WHITE='\033[1;37m'
export NC='\033[0m' # No Color

# Batman ASCII art
show_batman_logo() {
    cat << 'EOF'
       _,    _   _    ,_
  .o888P     Y8o8Y     Y888o.
 d88888      88888      88888b
d888888b_  _d88888b_  _d888888b
8888888888888888888888888888888
8888888888888888888888888888888
YJGS8P"Y888P"Y888P"Y888P"Y8888P
 Y888   '8'   Y8P   '8'   888Y
  '8o          V          o8'
    `                     `
    
    CLAUDE AGNETIC SYSTEM v3.0
    The Dark Knight of Development
EOF
}

# Installation steps
main() {
    echo -e "${YELLOW}$(show_batman_logo)${NC}"
    echo -e "\n${YELLOW}🦇 Welcome to the Batcave, Master Wayne!${NC}"
    echo -e "${GRAY}Initializing Wayne Tech systems...${NC}\n"
    
    # Pre-flight checks
    check_dependencies
    
    # Create directory structure
    create_directory_structure
    
    # Install components
    install_core_system
    install_mcp_servers
    install_persona_system
    install_commands
    install_orchestrator
    install_hooks
    install_business_os
    install_documentation
    
    # Configure environment
    configure_environment
    
    # Run tests
    run_installation_tests
    
    # Show completion
    show_completion_message
}

check_dependencies() {
    echo -e "${GRAY}[INFO]${NC} Checking dependencies..."
    
    local deps=("bash" "jq" "curl" "git" "python3")
    local missing=()
    
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            missing+=("$dep")
        fi
    done
    
    if [[ ${#missing[@]} -gt 0 ]]; then
        echo -e "${YELLOW}[ERROR]${NC} Missing dependencies: ${missing[*]}"
        echo "Please install the missing dependencies and try again."
        exit 1
    fi
    
    echo -e "${GRAY}[INFO]${NC} All dependencies satisfied"
}

create_directory_structure() {
    echo -e "${GRAY}[INFO]${NC} Creating Batcave directory structure..."
    
    local dirs=(
        "$CLAUDE_HOME"
        "$CLAUDE_HOME/bin"
        "$CLAUDE_HOME/lib"
        "$CLAUDE_HOME/commands"
        "$CLAUDE_HOME/hooks/pre_tool_use"
        "$CLAUDE_HOME/hooks/post_tool_use"
        "$CLAUDE_HOME/hooks/notification"
        "$CLAUDE_HOME/hooks/stop"
        "$CLAUDE_HOME/mcp/servers"
        "$CLAUDE_HOME/mcp/lib"
        "$CLAUDE_HOME/mcp/logs"
        "$CLAUDE_HOME/personas/profiles"
        "$CLAUDE_HOME/personas/lib"
        "$CLAUDE_HOME/orchestrator/state"
        "$CLAUDE_HOME/orchestrator/logs"
        "$CLAUDE_HOME/tasks"
        "$CLAUDE_HOME/scratchpads"
        "$CLAUDE_HOME/logs"
        "$CLAUDE_HOME/cache"
        "$CLAUDE_HOME/docs/getting-started"
        "$CLAUDE_HOME/docs/use-cases"
        "$CLAUDE_HOME/docs/reference"
        "$CLAUDE_HOME/docs/advanced"
        "$CLAUDE_HOME/state"
        "$CLAUDE_HOME/scripts"
    )
    
    for dir in "${dirs[@]}"; do
        mkdir -p "$dir"
    done
    
    echo -e "${GRAY}[INFO]${NC} Directory structure created"
}

install_core_system() {
    echo -e "${GRAY}[INFO]${NC} Installing core system..."
    
    # Copy core libraries
    cp -r "$REPO_DIR/lib/"* "$CLAUDE_HOME/lib/"
    
    # Copy scripts
    if [[ -d "$REPO_DIR/scripts" ]]; then
        cp -r "$REPO_DIR/scripts/"* "$CLAUDE_HOME/scripts/"
        chmod +x "$CLAUDE_HOME/scripts/"*.sh
    fi
    
    # Create default settings
    cat > "$CLAUDE_HOME/settings.json" <<EOF
{
    "version": "$VERSION",
    "theme": "batman",
    "persona": {
        "default": "master_wayne",
        "auto_activation": true,
        "aliases": ["Master Wayne", "Batman", "Bruce Wayne"]
    },
    "mcp": {
        "enabled": true,
        "auto_selection": true,
        "servers": {
            "project-memory": {
                "command": "python",
                "args": ["$CLAUDE_HOME/mcp/servers/project-memory-server.py"]
            }
        }
    },
    "orchestration": {
        "enabled": true,
        "default_mode": "adaptive",
        "max_parallel_stages": 3
    },
    "cache": {
        "enabled": true,
        "default_ttl": 3600,
        "max_size_mb": 100
    },
    "notifications": {
        "voice": true,
        "batman_theme": true
    },
    "hooks": {
        "PreToolUse": [
            {
                "matcher": "Bash",
                "hooks": [
                    {
                        "type": "command",
                        "command": "python $CLAUDE_HOME/hooks/pre_tool_use/safety_guard.py"
                    },
                    {
                        "type": "command",
                        "command": "python $CLAUDE_HOME/hooks/pre_tool_use/context_validator.py"
                    }
                ]
            }
        ],
        "PostToolUse": [
            {
                "matcher": "Write|Edit|MultiEdit",
                "hooks": [
                    {
                        "type": "command",
                        "command": "python $CLAUDE_HOME/hooks/post_tool_use/auto_format.py"
                    }
                ]
            },
            {
                "matcher": ".*",
                "hooks": [
                    {
                        "type": "command",
                        "command": "python $CLAUDE_HOME/hooks/post_tool_use/progress_tracker.py"
                    },
                    {
                        "type": "command",
                        "command": "python $CLAUDE_HOME/hooks/post_tool_use/business_memory_updater.py"
                    }
                ]
            }
        ],
        "Notification": [
            {
                "matcher": ".*",
                "hooks": [
                    {
                        "type": "command",
                        "command": "python $CLAUDE_HOME/hooks/notification/voice_notify.py"
                    }
                ]
            }
        ],
        "Stop": [
            {
                "matcher": ".*",
                "hooks": [
                    {
                        "type": "command",
                        "command": "python $CLAUDE_HOME/hooks/stop/session_logger.py"
                    }
                ]
            }
        ]
    },
    "env": {
        "CLAUDE_DANGEROUS_MODE": "true",
        "CLAUDE_AUTO_COMMIT": "false",
        "CLAUDE_PARALLEL_ENABLED": "true"
    }
}
EOF
    
    echo -e "${GRAY}[INFO]${NC} Core system installed"
}

install_mcp_servers() {
    echo -e "${GRAY}[INFO]${NC} Installing MCP servers..."
    
    # Copy MCP system files
    cp -r "$REPO_DIR/mcp/"* "$CLAUDE_HOME/mcp/"
    
    # Setup MCP servers
    if [[ -f "$REPO_DIR/setup/mcp.sh" ]]; then
        source "$REPO_DIR/setup/mcp.sh"
        setup_mcp_servers "$CLAUDE_HOME"
    fi
    
    # Install MCP servers
    if [[ -f "$CLAUDE_HOME/mcp/install_servers.sh" ]]; then
        cd "$CLAUDE_HOME/mcp"
        ./install_servers.sh
    fi
    
    echo -e "${GRAY}[INFO]${NC} MCP servers configured"
}

install_persona_system() {
    echo -e "${GRAY}[INFO]${NC} Installing persona system..."
    
    # Copy persona system files
    cp -r "$REPO_DIR/personas/"* "$CLAUDE_HOME/personas/"
    
    # Setup personas
    if [[ -f "$REPO_DIR/setup/personas.sh" ]]; then
        source "$REPO_DIR/setup/personas.sh"
        setup_personas "$CLAUDE_HOME"
    fi
    
    # Ensure all persona files are executable
    chmod +x "$CLAUDE_HOME/personas/"*.sh
    
    echo -e "${GRAY}[INFO]${NC} Persona system activated"
}

install_commands() {
    echo -e "${GRAY}[INFO]${NC} Installing enhanced commands..."
    
    # Copy all command files
    cp -r "$REPO_DIR/commands/"* "$CLAUDE_HOME/commands/"
    
    echo -e "${GRAY}[INFO]${NC} Commands installed"
}

install_orchestrator() {
    echo -e "${GRAY}[INFO]${NC} Installing orchestration system..."
    
    # Copy orchestrator files
    cp -r "$REPO_DIR/orchestrator/"* "$CLAUDE_HOME/orchestrator/"
    
    # Make orchestrator scripts executable
    chmod +x "$CLAUDE_HOME/orchestrator/"*.sh
    
    echo -e "${GRAY}[INFO]${NC} Orchestrator configured"
}

install_hooks() {
    echo -e "${GRAY}[INFO]${NC} Installing Batman-themed hooks..."
    
    # Copy hook files
    cp -r "$REPO_DIR/hooks/"* "$CLAUDE_HOME/hooks/"
    
    # Make hook scripts executable
    find "$CLAUDE_HOME/hooks" -name "*.py" -exec chmod +x {} \;
    find "$CLAUDE_HOME/hooks" -name "*.sh" -exec chmod +x {} \;
    
    echo -e "${GRAY}[INFO]${NC} Hooks installed"
}

install_business_os() {
    echo -e "${GRAY}[INFO]${NC} Installing Business OS components..."
    
    # Create business-specific directories
    mkdir -p "$CLAUDE_HOME/memory"
    mkdir -p "$CLAUDE_HOME/context"
    
    # Copy business commands
    echo -e "${GRAY}[INFO]${NC} Installing business executive commands..."
    for cmd in cmo.md cfo.md cpo.md briefing.md; do
        if [[ -f "$REPO_DIR/commands/$cmd" ]]; then
            cp "$REPO_DIR/commands/$cmd" "$CLAUDE_HOME/commands/"
        fi
    done
    
    # Copy business context files
    if [[ -d "$REPO_DIR/context" ]]; then
        echo -e "${GRAY}[INFO]${NC} Installing business context files..."
        cp -r "$REPO_DIR/context/"* "$CLAUDE_HOME/context/" 2>/dev/null || true
    fi
    
    # Install project memory MCP server
    echo -e "${GRAY}[INFO]${NC} Installing project memory server..."
    if [[ -f "$REPO_DIR/mcp/project-memory-server.py" ]]; then
        cp "$REPO_DIR/mcp/project-memory-server.py" "$CLAUDE_HOME/mcp/servers/"
        chmod +x "$CLAUDE_HOME/mcp/servers/project-memory-server.py"
    fi
    
    # Install business memory updater hook
    echo -e "${GRAY}[INFO]${NC} Installing business memory updater..."
    if [[ -f "$REPO_DIR/hooks/post_tool_use/business_memory_updater.py" ]]; then
        cp "$REPO_DIR/hooks/post_tool_use/business_memory_updater.py" "$CLAUDE_HOME/hooks/post_tool_use/"
        chmod +x "$CLAUDE_HOME/hooks/post_tool_use/business_memory_updater.py"
    fi
    
    # Create sample .env file if not exists
    if [[ ! -f "$REPO_DIR/.env" ]]; then
        echo -e "${GRAY}[INFO]${NC} Creating sample .env file..."
        cat > "$REPO_DIR/.env" << 'EOF'
# Business API Keys (add your actual keys)

# Marketing (Instagram Business API)
INSTAGRAM_ACCESS_TOKEN=your_token_here

# Revenue (Stripe)
STRIPE_API_KEY=sk_live_your_key_here

# Analytics (Mixpanel)
MIXPANEL_PROJECT_TOKEN=your_token_here
MIXPANEL_API_SECRET=your_secret_here

# Alternative Analytics (PostHog)
POSTHOG_API_KEY=your_key_here
POSTHOG_PROJECT_ID=your_project_id

# Support (Intercom)
INTERCOM_ACCESS_TOKEN=your_token_here
EOF
    fi
    
    echo -e "${GRAY}[INFO]${NC} Business OS components installed"
}

install_documentation() {
    echo -e "${GRAY}[INFO]${NC} Installing documentation..."
    
    # Copy documentation
    if [[ -d "$REPO_DIR/docs" ]]; then
        cp -r "$REPO_DIR/docs/"* "$CLAUDE_HOME/docs/"
    fi
    
    echo -e "${GRAY}[INFO]${NC} Documentation installed"
}

configure_environment() {
    echo -e "${GRAY}[INFO]${NC} Configuring environment..."
    
    # Detect shell
    local shell_rc=""
    if [[ -n "${ZSH_VERSION:-}" ]]; then
        shell_rc="$HOME/.zshrc"
    elif [[ -n "${BASH_VERSION:-}" ]]; then
        shell_rc="$HOME/.bashrc"
    else
        case "$SHELL" in
            */zsh) shell_rc="$HOME/.zshrc" ;;
            */bash) shell_rc="$HOME/.bashrc" ;;
            *) echo -e "${YELLOW}[WARN]${NC} Could not detect shell type"; return 0 ;;
        esac
    fi
    
    if [[ -n "$shell_rc" ]] && [[ -f "$shell_rc" ]]; then
        # Check if already configured
        if grep -q "Claude Agnetic System" "$shell_rc"; then
            echo -e "${GRAY}[INFO]${NC} Environment already configured"
            return 0
        fi
        
        # Backup existing rc file
        cp "$shell_rc" "${shell_rc}${BACKUP_SUFFIX}"
        
        # Add Claude configuration
        cat >> "$shell_rc" << 'EOF'

# Claude Agnetic System - The Dark Knight Edition
export CLAUDE_HOME="$HOME/.claude"
export PATH="$CLAUDE_HOME/bin:$PATH"

# Source Claude utilities
if [[ -f "$CLAUDE_HOME/lib/utils.sh" ]]; then
    source "$CLAUDE_HOME/lib/utils.sh"
fi

# Enable advanced features
export CLAUDE_MCP_ENABLED=true
export CLAUDE_PERSONAS_ENABLED=true
export CLAUDE_ORCHESTRATOR_ENABLED=true
export CLAUDE_VOICE_ENABLED=true

# Batman theme
export CLAUDE_THEME="batman"
export CLAUDE_GREETING="Master Wayne"

# Aliases
alias batman='claude'
alias batcave='cd $CLAUDE_HOME'
alias alfred='claude /help'
alias wayne='claude /personas status'

# Business OS Memory Functions
store_memory() {
    python -c "
import sys
sys.path.append('$CLAUDE_HOME/mcp/servers')
from project_memory_server import store_memory
store_memory('$1')
"
}

recall_memory() {
    python -c "
import sys
sys.path.append('$CLAUDE_HOME/mcp/servers')
from project_memory_server import recall_memory
recall_memory('$1')
"
}

get_project_context() {
    python -c "
import sys
sys.path.append('$CLAUDE_HOME/mcp/servers')
from project_memory_server import get_project_context
get_project_context()
"
}
EOF
        
        echo -e "${GRAY}[INFO]${NC} Shell configuration updated"
    fi
}

run_installation_tests() {
    echo -e "${GRAY}[INFO]${NC} Running installation tests..."
    
    # Test core functionality
    if [[ -f "$CLAUDE_HOME/settings.json" ]]; then
        echo -e "${GRAY}[INFO]${NC}   ✓ Core files installed"
    else
        echo -e "${YELLOW}[ERROR]${NC}   ✗ Core files missing"
        return 1
    fi
    
    # Test MCP servers
    if [[ -d "$CLAUDE_HOME/mcp/servers" ]]; then
        echo -e "${GRAY}[INFO]${NC}   ✓ MCP servers configured"
    else
        echo -e "${YELLOW}[ERROR]${NC}   ✗ MCP servers missing"
        return 1
    fi
    
    # Test personas
    if [[ -f "$CLAUDE_HOME/personas/profiles/master_wayne.json" ]]; then
        echo -e "${GRAY}[INFO]${NC}   ✓ Master Wayne persona ready"
    else
        echo -e "${YELLOW}[ERROR]${NC}   ✗ Master Wayne persona missing"
        return 1
    fi
    
    # Test commands
    if [[ -f "$CLAUDE_HOME/commands/think.md" ]]; then
        echo -e "${GRAY}[INFO]${NC}   ✓ Commands installed"
    else
        echo -e "${YELLOW}[ERROR]${NC}   ✗ Commands missing"
        return 1
    fi
    
    # Test Business OS components
    if [[ -f "$CLAUDE_HOME/mcp/servers/project-memory-server.py" ]]; then
        echo -e "${GRAY}[INFO]${NC}   ✓ Project memory server installed"
    else
        echo -e "${YELLOW}[ERROR]${NC}   ✗ Project memory server missing"
        return 1
    fi
    
    if [[ -f "$CLAUDE_HOME/hooks/post_tool_use/business_memory_updater.py" ]]; then
        echo -e "${GRAY}[INFO]${NC}   ✓ Business memory updater installed"
    else
        echo -e "${YELLOW}[ERROR]${NC}   ✗ Business memory updater missing"
        return 1
    fi
    
    if [[ -f "$CLAUDE_HOME/commands/cmo.md" ]] && [[ -f "$CLAUDE_HOME/commands/cfo.md" ]]; then
        echo -e "${GRAY}[INFO]${NC}   ✓ Business commands installed"
    else
        echo -e "${YELLOW}[ERROR]${NC}   ✗ Business commands missing"
        return 1
    fi
    
    echo -e "${GRAY}[INFO]${NC} All tests passed"
}

show_completion_message() {
    echo -e "\n${YELLOW}🦇 Installation Complete!${NC}"
    echo -e "${GRAY}═══════════════════════════════════════${NC}"
    echo
    echo -e "${YELLOW}The Batcave is fully operational, Master Wayne!${NC}"
    echo
    echo -e "${WHITE}Next steps:${NC}"
    echo -e "1. Reload your shell: ${YELLOW}source ~/.zshrc${NC} (or ~/.bashrc)"
    echo -e "2. Test the system: ${YELLOW}claude /sync${NC}"
    echo -e "3. Read the guide: ${YELLOW}batman /help${NC}"
    echo
    echo -e "${WHITE}Available aliases:${NC}"
    echo -e "• ${YELLOW}batman${NC} - Same as 'claude'"
    echo -e "• ${YELLOW}batcave${NC} - Navigate to Claude home"
    echo -e "• ${YELLOW}alfred${NC} - Get help"
    echo -e "• ${YELLOW}wayne${NC} - Check persona status"
    echo
    echo -e "${WHITE}Quick start commands:${NC}"
    echo -e "• ${YELLOW}claude /think 'complex problem'${NC} - Advanced reasoning"
    echo -e "• ${YELLOW}claude /implement 'feature description'${NC} - Intelligent implementation"
    echo -e "• ${YELLOW}claude /architect 'system design'${NC} - Architecture design"
    echo -e "• ${YELLOW}claude /ui 'component description'${NC} - UI component generation"
    echo -e "• ${YELLOW}claude /review security --fix${NC} - Security review with fixes"
    echo
    echo -e "${WHITE}Business OS commands:${NC}"
    echo -e "• ${YELLOW}claude /cmo \"analyze marketing\"${NC} - Chief Marketing Officer"
    echo -e "• ${YELLOW}claude /cfo \"check runway\"${NC} - Chief Financial Officer"
    echo -e "• ${YELLOW}claude /cpo \"product metrics\"${NC} - Chief Product Officer"
    echo -e "• ${YELLOW}claude /briefing${NC} - Daily business intelligence"
    echo
    echo -e "${YELLOW}🦇 Welcome to Wayne Enterprises. Let's protect Gotham's codebase!${NC}"
    echo -e "${GRAY}═══════════════════════════════════════${NC}"
}

# Run installation
main "$@"