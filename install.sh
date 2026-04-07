#!/bin/bash
# TCS Skill Installer for Mac/Linux
# Run with: bash install.sh

echo -e "\033[36mInstalling TCS skill for Claude Code...\033[0m"

# Define paths
SKILLS_DIR="$HOME/.claude/skills"
SKILL_FILE="$SKILLS_DIR/tcs.md"

# Create skills directory if it doesn't exist
if [ ! -d "$SKILLS_DIR" ]; then
    echo -e "\033[33mCreating skills directory...\033[0m"
    mkdir -p "$SKILLS_DIR"
fi

# Copy the skill file
if [ -f "tcs.md" ]; then
    echo -e "\033[33mCopying tcs.md to skills directory...\033[0m"
    cp "tcs.md" "$SKILL_FILE"
    echo -e "\033[32m✓ Installation complete!\033[0m"
    echo ""
    echo -e "\033[36mNext steps:\033[0m"
    echo -e "\033[0m1. Restart Claude Code completely\033[0m"
    echo -e "\033[0m2. Type '/skills' to verify installation\033[0m"
    echo -e "\033[0m3. Use with: /tcs \"story.xml\" \"ui.png\" \"common steps\"\033[0m"
else
    echo -e "\033[31m✗ Error: tcs.md not found in current directory\033[0m"
    echo -e "\033[33mPlease run this script from the directory containing tcs.md\033[0m"
    exit 1
fi
