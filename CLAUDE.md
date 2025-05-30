# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Claude Adventure Mode is a tool that transforms Claude Code sessions into RPG-style coding quests. It modifies Claude's responses to include fantasy adventurer roleplay while maintaining full technical capabilities.

## Key Files and Structure

- `ADVENTURE_MODE.md` - The core instructions that get injected into user's `~/.claude/CLAUDE.md`
- `scripts/claude-adventure` - Shell script that toggles adventure mode on/off
- `install.sh` - Installation script that sets up the tool in user's home directory

## Development Commands

```bash
# Install adventure mode (for testing installation flow)
./install.sh

# Toggle adventure mode (after installation)
claude-adventure        # Toggle current state
claude-adventure on     # Enable
claude-adventure off    # Disable
```

## Architecture

### Installation System
- Installs to `~/.claude/` directory structure
- Preserves existing adventure mode state during upgrades
- Configures PATH for multiple shell types (bash, zsh, fish)
- Creates `~/.claude/scripts/` directory for the toggle script

### Toggle Mechanism
- Uses marker-based insertion: `### BEGIN/END CLAUDE ADVENTURE MODE INSTRUCTIONS`
- Safely adds/removes adventure content from `~/.claude/CLAUDE.md`
- Preserves any other content in user's CLAUDE.md file
- Handles edge cases like empty files and missing dependencies

### Adventure Mode Behavior
When active, Claude will:
- Maintain RPG character persona in project directories
- Create/update `.ADVENTURE_MODE.md` files to track quest progress
- Never include adventure elements in code, commits, or documentation
- Support "FOCUS MODE" safeword to temporarily disable roleplay

## Testing Considerations

When modifying the adventure mode behavior:
1. Test installation on fresh system (no existing ~/.claude)
2. Test upgrade scenario (with adventure mode active)
3. Verify marker-based insertion/removal doesn't affect other CLAUDE.md content
4. Check PATH configuration works for bash, zsh, and fish shells