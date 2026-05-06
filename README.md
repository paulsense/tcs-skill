# TCS — Test Case Skill for Claude Code

Generates Jira Xray CSV test cases from Jira user story XMLs and UI screenshots. Consolidates positive/negative/edge cases into a few comprehensive workflows instead of one TC per variant.

## Install

Installs to `~/.claude/skills/tcs/SKILL.md`.

Mac/Linux:
```bash
mkdir -p ~/.claude/skills/tcs && curl -fsSL https://raw.githubusercontent.com/paulsense/tcs-skill/main/tcs/SKILL.md -o ~/.claude/skills/tcs/SKILL.md
```

Windows (PowerShell):
```powershell
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\skills\tcs" | Out-Null; Invoke-WebRequest -Uri "https://raw.githubusercontent.com/paulsense/tcs-skill/main/tcs/SKILL.md" -OutFile "$env:USERPROFILE\.claude\skills\tcs\SKILL.md"
```

Or, if you've cloned the repo, copy `tcs/SKILL.md` into `~/.claude/skills/tcs/SKILL.md` yourself.

Restart Claude Code, then verify with `/skills`.

## Usage

**Generate** (default): create test cases from a story.
```
/tcs "ATS-632.xml" "ui1.png,ui2.png" "Login as admin, Navigate to Users"
```
Args: `story` (XML path or text), `images` (comma-separated, optional), `common_steps` (optional). Use `""` to skip an arg.

**Refactor**: consolidate existing TCs.
```
/tcs "" "" "" "refactor" "existing_tcs.csv"
```

Output: 3–5 CSV files in the current directory, each with `Action`, `Data`, `Expected Result` columns — ready to import into Jira Xray.

## CSV format

```csv
# Title: Verify user can copy interview
# Description: Copy flow with confirm and cancel
"Action","Data","Expected Result"
"Login to application","admin credentials","User logged in"
"Click Copy Interview","","Modal opens"
"Click Confirm","","Interview copied"
"Click Cancel","","Modal closes, no changes"
```

## Tips

- Use absolute paths if files aren't found.
- Be specific with common steps (`"Login as admin, Open Settings"` beats `"do setup"`).
- Screenshots noticeably improve step accuracy.

## Troubleshooting

- **"Unknown skill: tcs"** — file must be at `~/.claude/skills/tcs/SKILL.md` (subdirectory, not `tcs.md`). Fully restart Claude Code.
- **"File not found"** — use absolute paths.
- **CSV won't import** — confirm exactly 3 columns; `#` comment lines are fine.
