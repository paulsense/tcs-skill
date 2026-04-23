# TCS - Test Case Skill for Claude Code

A Claude Code skill that generates Jira Xray test cases from user stories and UI screenshots.

## What It Does

Creates ready-to-import CSV test cases for Jira Xray from:
- Jira user story XML exports
- UI screenshots (Figma designs, mockups)
- Your common setup steps

Saves time on repetitive test case writing while following ISTQB best practices.

## Installation

**Using the install script (recommended):**

Mac/Linux:
```bash
bash install.sh
```

Windows (PowerShell):
```powershell
powershell -ExecutionPolicy Bypass -File install.ps1
```

**Manual installation:**
- Copy `tcs.md` to `~/.claude/skills/` (Mac/Linux) or `%USERPROFILE%\.claude\skills\` (Windows)

Then restart Claude Code and verify with `/skills`.

## Usage

The skill has two modes: **generate** (create new test cases) and **refactor** (consolidate existing test cases).

### Generate Mode (Default)

Create new test cases from a Jira user story:

```
/tcs "ATS-632.xml"
```

With UI screenshots:
```
/tcs "ATS-632.xml" "ui1.png,ui2.png"
```

With custom common steps:
```
/tcs "ATS-632.xml" "ui1.png,ui2.png" "Login as admin, Navigate to Users page"
```

**Parameters:**
1. `story` - Path to Jira XML export or story text (required)
2. `images` - Comma-separated image paths (optional, use `""` to skip)
3. `common_steps` - Setup steps for all test cases (optional, use `""` for defaults)

**Output:**
- Creates 3-5 CSV files in current directory: `TC1_Verify_Feature.csv`, `TC2_Validate_UI.csv`, etc.
- Each file has 3 columns: "Action", "Data", "Expected Result"
- Ready for direct import into Jira Xray

### Refactor Mode

Consolidate existing test cases into minimal comprehensive coverage:

```
/tcs "" "" "" "refactor" "existing_testcases.csv"
```

Or simply provide the existing test cases (auto-detects refactor mode):
```
/tcs "" "" "" "" "my_existing_tcs.txt"
```

**Parameters:**
1-3. Leave empty with `""`
4. `mode` - Set to `"refactor"` (optional if providing existing_tcs)
5. `existing_tcs` - Path to file with existing test cases (required for refactor)

**Output:**
- Analyzes existing test cases for redundancy
- Shows consolidation plan and coverage verification
- Creates consolidated CSV files (typically reduces count by 30-50%)

## What the CSV Files Look Like

Each CSV file contains:
```csv
# Title: Verify user can copy interview
# Description: Test interview copy functionality with confirmation and cancellation
"Action","Data","Expected Result"
"Login to application","admin credentials","User logged in"
"Navigate to test area","","Test area displayed"
"Click Copy Interview","","Modal opens with source selection"
"Select source vacancy","Vacancy ABC-123","Source selected"
"Click Confirm","","Interview copied successfully"
"Click Copy Interview","","Modal opens"
"Click Cancel","","Modal closes, no changes made"
```

Import directly into Jira Xray.

## Key Features

**Smart Consolidation:**
- Creates 1 test case per workflow (not per scenario)
- Combines positive/negative/edge cases into comprehensive tests
- Targets 3-5 test cases for typical stories

**UI-Aware:**
- Analyzes screenshots to identify buttons, forms, navigation
- References specific UI elements in test steps
- Validates visual changes

**ISTQB-Compliant:**
- Action-oriented test case titles
- Clear expected results
- Proper test coverage principles

## Tips

**1. Use full paths if files aren't found:**
```
/tcs "C:\Users\YourName\Desktop\story.xml"
```

**2. Be specific with common steps:**
```
Good: "Login as admin, Open Settings, Select User Management"
Unclear: "Do the setup"
```

**3. Images help significantly:**
UI screenshots enable the skill to generate more accurate, detailed test steps.

## Troubleshooting

**"Unknown skill: tcs"**
- Verify `tcs.md` is in `~/.claude/skills/` directory
- Fully quit and restart Claude Code (not just close window)
- Check filename is exactly `tcs.md` (not `tcs.md.txt`)

**"File not found"**
- Use absolute file paths
- Verify file exists at specified location
- Check for typos in filename

**CSV won't import to Jira**
- Open CSV in text editor to verify format
- Ensure exactly 3 columns: "Action", "Data", "Expected Result"
- Comment lines (starting with #) are fine

## Examples

**Simple story:**
```
/tcs "bugfix-ATS-500.xml" "" "Login, Navigate to Dashboard"
```

**Full feature with UI:**
```
/tcs "feature-ATS-632.xml" "mockup1.png,mockup2.png,mockup3.png" "Login as QA user, Open Vacancies module"
```

**Refactor existing tests:**
```
/tcs "" "" "" "refactor" "old_test_cases.txt"
```

---

*Built for QA engineers by a QA engineer. Consolidates test cases, reduces maintenance, maintains coverage.*
