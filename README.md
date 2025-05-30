# Claude Adventure Mode 🗡️

Transform your Claude Code sessions into epic coding quests! Adventure Mode adds a playful RPG layer to Claude's responses while maintaining full technical capabilities.

## What is Adventure Mode?

When activated, Claude becomes a legendary adventurer in the Terminal Kingdom, treating your coding tasks as quests to be completed. You become the Quest Giver, and Claude maintains character while delivering the same high-quality technical assistance.

## Installation

### Quick Install

```bash
git clone https://github.com/yourusername/claude-adventure.git
cd claude-adventure
./install.sh
```

The installer will:
- Copy adventure mode files to `~/.claude/`
- Add `~/.claude/scripts` to your PATH (only for your current shell)
- Preserve any existing adventure mode activation state during upgrades

### Manual Installation

If you prefer manual setup:

1. Copy `ADVENTURE_MODE.md` to `~/.claude/ADVENTURE_MODE.md`
2. Copy `scripts/claude-adventure` to `~/.claude/scripts/claude-adventure`
3. Make the script executable: `chmod +x ~/.claude/scripts/claude-adventure`
4. Add to your PATH: `export PATH="$HOME/.claude/scripts:$PATH"`

## Usage

### Basic Commands

```bash
# Enable adventure mode
claude-adventure on

# Disable adventure mode
claude-adventure off

# Toggle current state
claude-adventure
```

### How It Works

Adventure Mode uses a marker-based system to insert/remove instructions in your `~/.claude/CLAUDE.md` file:
- Activation adds content between `### BEGIN CLAUDE ADVENTURE MODE INSTRUCTIONS` and `### END CLAUDE ADVENTURE MODE INSTRUCTIONS`
- Deactivation cleanly removes only the marked section
- Any other content in your CLAUDE.md is preserved

### Starting Your Adventure

After enabling adventure mode, you may need to explicitly ask Claude to enter adventure mode at the start of each session:

```
"Let's enter adventure mode!"
"Begin our coding quest!"
"Adventure mode, please!"
```

Claude will then initialize the adventure state and greet you as a legendary adventurer.

### Adventure Features

When active, Claude will:
- 🎮 Maintain an adventurer persona throughout interactions
- 📊 Track experience points, level, and quest completions
- 🏆 Award titles based on technical achievements
- 📜 Create `.ADVENTURE_MODE.md` files in projects to maintain state
- ⚔️ Use thematic language while delivering precise technical solutions

## Upgrades

The installer automatically handles upgrades:

```bash
# Pull latest changes
cd ~/Code/claude-adventure
git pull

# Run installer - preserves activation state
./install.sh
```

If adventure mode is active during upgrade, the installer will:
1. Temporarily deactivate it
2. Update all components
3. Reactivate automatically

## File Structure

```
~/.claude/
├── ADVENTURE_MODE.md       # Adventure mode instructions
├── CLAUDE.md              # Your Claude configuration (created on first activation)
└── scripts/
    └── claude-adventure   # Toggle script
```

## Troubleshooting

### Command not found

If `claude-adventure` isn't recognized after installation:

```bash
# For immediate use in current session
source ~/.zshrc  # or ~/.bashrc for bash users

# Or create a system-wide symlink (requires sudo)
sudo ln -sf $HOME/.claude/scripts/claude-adventure /usr/local/bin/claude-adventure
```

### Checking Status

To verify if adventure mode is active:

```bash
# Check for activation markers
grep -q "BEGIN CLAUDE ADVENTURE MODE" ~/.claude/CLAUDE.md && echo "Active" || echo "Inactive"

# Or just run the toggle to see current state
claude-adventure
```

### Complete Removal

To fully uninstall:

```bash
# Disable adventure mode first
claude-adventure off

# Remove files
rm -f ~/.claude/ADVENTURE_MODE.md
rm -f ~/.claude/scripts/claude-adventure

# Remove PATH addition from your shell config
# Edit ~/.zshrc (or ~/.bashrc) and remove the line:
# export PATH="$HOME/.claude/scripts:$PATH"
```

## Contributing

Feel free to submit issues or pull requests! Some ideas:
- Additional titles and achievements
- Quest templates
- Integration with other Claude tools
- Alternative personas

## License

[Your chosen license]

---

*May your code quests be legendary! ⚔️✨*
