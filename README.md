# TCS - Test Case Skill for Claude Code

A simple tool that helps you create Jira Xray test cases from user stories and UI screenshots.

## What Does This Do?

This skill helps you write test cases faster. Instead of manually writing test steps in Jira, you can:
- Give it a Jira user story (XML file)
- Add some UI screenshots (optional)
- Tell it what common steps to include
- Get back ready-to-use CSV files for Jira Xray

That's it. It saves time on the repetitive parts of test case writing.

## Installation

### Quick Install with Script (Recommended)

**Mac/Linux:**
```bash
git clone --depth 1 https://github.com/[YOUR-USERNAME]/[YOUR-REPO].git
bash [YOUR-REPO]/install.sh
```

**Windows (PowerShell):**
```powershell
git clone --depth 1 https://github.com/[YOUR-USERNAME]/[YOUR-REPO].git
powershell -ExecutionPolicy Bypass -File [YOUR-REPO]\install.ps1
```

Then restart Claude Code and type `/skills` to verify.

---

### One-Liner Install

**Mac/Linux:**
```bash
mkdir -p ~/.claude/skills && curl -o ~/.claude/skills/tcs.md https://raw.githubusercontent.com/[YOUR-USERNAME]/[YOUR-REPO]/main/tcs.md
```

**Windows (PowerShell):**
```powershell
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.claude\skills"; Invoke-WebRequest -Uri "https://raw.githubusercontent.com/[YOUR-USERNAME]/[YOUR-REPO]/main/tcs.md" -OutFile "$env:USERPROFILE\.claude\skills\tcs.md"
```

Then restart Claude Code and type `/skills` to verify.

---

### Manual Install

**If you prefer to install manually:**

**Windows:**
1. Press `Windows Key + R`
2. Type: `%USERPROFILE%\.claude\skills` and press Enter
3. If folder doesn't exist, create it
4. Download `tcs.md` and copy it into this folder
5. Restart Claude Code

**Mac:**
1. Press `Cmd + Shift + G` in Finder
2. Type: `~/.claude/skills` and press Enter
3. If folder doesn't exist, create it
4. Download `tcs.md` and copy it into this folder
5. Restart Claude Code

**Verify it worked:**
```
/skills
```
You should see `tcs` in the list.

## How to Use It

### Step 1: Export Your Jira Story

1. Open your Jira story (e.g., ATS-632)
2. Click the `•••` menu (top right)
3. Select "Export XML"
4. Save the file to your desktop or project folder

### Step 2: Take Screenshots of the UI (Optional)

If you have Figma designs or UI mockups:
- Take screenshots and save them as PNG/JPG files
- Put them in the same folder as your XML file

### Step 3: Run the Skill in Claude Code

Open Claude Code and type:

**Simple example (just the story):**
```
/tcs "ATS-632.xml"
```

**With UI screenshots:**
```
/tcs "ATS-632.xml" "screenshot1.png,screenshot2.png"
```

**With your own common steps:**
```
/tcs "ATS-632.xml" "" "Login as admin, Open Settings page"
```

**Full example:**
```
/tcs "C:\Desktop\ATS-632.xml" "ui1.png,ui2.png" "Login to app, Navigate to Users"
```

> **Note:** If you skip images or common steps, just use empty quotes `""` as a placeholder.

### What You'll Get

The skill creates CSV files like:
- `TC1_Copy_Interview_Successfully.csv`
- `TC2_Search_Vacancy.csv`
- `TC3_Cancel_Operation.csv`

Each file has test steps ready to import into Jira Xray.

## What the CSV Files Look Like

Each CSV file has:
- A title and description at the top (as comments)
- Three columns: "Action", "Data", "Expected Result"
- Your common steps first
- Then specific test steps for that scenario

Example:
```csv
# Title: Copy interview successfully
# Description: Verify user can copy interview questions from another vacancy
"Action","Data","Expected Result"
"Login to app","admin credentials","User logged in"
"Navigate to Vacancies","","Vacancies page opens"
"Click Copy Interview","","Modal opens"
```

You can import these directly into Jira Xray.

## Tips for Better Results

**1. Be specific with your common steps**
```
Good: "Login as admin, Navigate to Vacancies, Select vacancy ABC-123"
Not great: "Do the setup stuff"
```

**2. Use full file paths if it can't find your files**
```
Instead of: "story.xml"
Use: "C:\Users\YourName\Desktop\story.xml"
```

**3. Don't worry about too many test cases**
The skill usually creates 2-4 test cases per story. If you get too many, that's feedback for me to improve it.

**4. UI screenshots help a lot**
If you include screenshots, the skill can see buttons, forms, and navigation elements, which makes better test cases.

## Common Issues

### "Unknown skill: tcs"

**Problem:** Claude Code doesn't recognize the skill

**Fix:**
1. Make sure the file is named `tcs.md` (not `tcs.md.txt` - Windows sometimes hides extensions)
2. Check it's in the right folder: `.claude/skills/`
3. Completely close and reopen Claude Code (not just the window, actually quit the app)
4. Type `/skills` to verify it's there

### "File not found" errors

**Problem:** Skill can't find your XML or image files

**Fix:**
- Use the full file path: `C:\Users\YourName\Desktop\ATS-632.xml`
- Or make sure you're in the same folder as your files in Claude Code

### Jira won't import the CSV

**Problem:** CSV import fails in Jira Xray

**Fix:**
- Open the CSV file in a text editor to check it looks correct
- Make sure it has exactly 3 columns: "Action", "Data", "Expected Result"
- The `#` comment lines at the top are okay - Jira ignores them

## Questions or Problems?

If something isn't working or the instructions are unclear, open an issue on GitHub. I'm a QA engineer too, so I get it - just let me know what went wrong and I'll help.

## Share This

If this helped you, share it with your QA team. The more people use it, the better I can make it.

---

*Made by a QA engineer for QA engineers. No fancy stuff, just practical test case generation.*
