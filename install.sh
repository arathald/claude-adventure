#!/bin/bash

# Claude Adventure Mode Installation Script
# Installs adventure mode components and configures PATH

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
CLAUDE_SCRIPTS_DIR="$CLAUDE_DIR/scripts"
CLAUDE_FILE="$CLAUDE_DIR/CLAUDE.md"
PATH_LINE='export PATH="$HOME/.claude/scripts:$PATH"'
PATH_CHECK='$HOME/.claude/scripts'
START_MARKER="### BEGIN CLAUDE ADVENTURE MODE INSTRUCTIONS"

# Ensure target directories exist
mkdir -p "$CLAUDE_DIR"
mkdir -p "$CLAUDE_SCRIPTS_DIR"

# Install adventure mode components
install_adventure_mode() {
    echo "Installing Claude Adventure Mode components..."
    
    # Check if adventure mode is currently active
    local was_active=false
    if [[ -f "$CLAUDE_FILE" ]] && grep -qF "$START_MARKER" "$CLAUDE_FILE"; then
        was_active=true
        echo "Adventure mode is currently active. Deactivating for upgrade..."
        "$CLAUDE_SCRIPTS_DIR/claude-adventure" off >/dev/null 2>&1
    fi
    
    # Copy ADVENTURE_MODE.md
    if [[ -f "$SCRIPT_DIR/ADVENTURE_MODE.md" ]]; then
        if [[ -f "$CLAUDE_DIR/ADVENTURE_MODE.md" ]]; then
            echo "✓ Updated ADVENTURE_MODE.md"
        else
            echo "✓ Installed ADVENTURE_MODE.md"
        fi
        cp "$SCRIPT_DIR/ADVENTURE_MODE.md" "$CLAUDE_DIR/"
    else
        echo "✗ Error: ADVENTURE_MODE.md not found in $SCRIPT_DIR"
        return 1
    fi
    
    # Copy claude-adventure script
    if [[ -f "$SCRIPT_DIR/scripts/claude-adventure" ]]; then
        if [[ -f "$CLAUDE_SCRIPTS_DIR/claude-adventure" ]]; then
            echo "✓ Updated claude-adventure script"
        else
            echo "✓ Installed claude-adventure script"
        fi
        cp "$SCRIPT_DIR/scripts/claude-adventure" "$CLAUDE_SCRIPTS_DIR/"
        chmod +x "$CLAUDE_SCRIPTS_DIR/claude-adventure"
    else
        echo "✗ Error: scripts/claude-adventure not found"
        return 1
    fi
    
    # Reactivate if it was active before
    if [[ "$was_active" == "true" ]]; then
        echo "Reactivating adventure mode..."
        "$CLAUDE_SCRIPTS_DIR/claude-adventure" on
    fi
    
    return 0
}

# Function to add path to a config file
add_to_config() {
    local config_file="$1"
    local shell_name="$2"
    
    if [[ -f "$config_file" ]]; then
        # Check if already added
        if grep -q "$PATH_CHECK" "$config_file"; then
            echo "✓ Already configured for $shell_name"
            return 0
        fi
    fi
    
    # Add the PATH export
    echo "" >> "$config_file"
    echo "# Claude Adventure Mode scripts" >> "$config_file"
    echo "$PATH_LINE" >> "$config_file"
    echo "✓ Added to $shell_name config: $config_file"
}

# Detect and configure for shells
configure_shells() {
    local configured=false
    local current_shell=$(basename "$SHELL")
    
    echo "Detected shell: $current_shell"
    
    # Configure based on current shell
    case "$current_shell" in
        bash)
            if [[ -f "$HOME/.bashrc" ]]; then
                add_to_config "$HOME/.bashrc" "bash"
                configured=true
            fi
            ;;
        zsh)
            if [[ -f "$HOME/.zshrc" ]]; then
                add_to_config "$HOME/.zshrc" "zsh"
                configured=true
            fi
            ;;
        fish)
            local fish_config="$HOME/.config/fish/config.fish"
            mkdir -p "$(dirname "$fish_config")"
            
            if ! grep -q "$PATH_CHECK" "$fish_config" 2>/dev/null; then
                echo "" >> "$fish_config"
                echo "# Claude Adventure Mode scripts" >> "$fish_config"
                echo 'set -gx PATH $HOME/.claude/scripts $PATH' >> "$fish_config"
                echo "✓ Added to fish config: $fish_config"
            else
                echo "✓ Already configured for fish"
            fi
            configured=true
            ;;
        *)
            # Unknown shell, try common config file
            local shell_rc="$HOME/.${current_shell}rc"
            if [[ -f "$shell_rc" ]]; then
                add_to_config "$shell_rc" "$current_shell"
                configured=true
            fi
            ;;
    esac
    
    # If we couldn't configure the current shell, fall back to .profile
    if [[ "$configured" == "false" ]]; then
        echo "Could not find config for $current_shell, using .profile as fallback"
        add_to_config "$HOME/.profile" "sh/profile"
    fi
    
    return 0
}

# Main setup
echo "Claude Adventure Mode Installer"
echo "==============================="
echo ""

# Install components first
if ! install_adventure_mode; then
    echo ""
    echo "Installation failed. Please check the error messages above."
    exit 1
fi

echo ""

# Configure shells
configure_shells

echo ""
echo "Installation complete! 🎮"
echo ""
echo "To activate the changes:"
echo "  • Restart your terminal, OR"
echo "  • Run: source ~/.bashrc (for bash)"
echo "  • Run: source ~/.zshrc (for zsh)"
echo "  • Run: source ~/.config/fish/config.fish (for fish)"
echo ""
echo "Usage: claude-adventure [on|off|toggle]"
echo ""

# Alternative: Create symlink in existing PATH location
echo "Alternative: Create a symlink in /usr/local/bin (requires sudo):"
echo "  sudo ln -sf $HOME/.claude/scripts/claude-adventure /usr/local/bin/claude-adventure"
