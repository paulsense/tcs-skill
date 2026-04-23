# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a **Claude Code skill** that generates Jira Xray test cases from user stories and UI screenshots. The skill (`tcs.md`) is installed into users' `~/.claude/skills/` directory and invoked via `/tcs` command.

**Core functionality:**
- Parses Jira XML exports to extract user stories and acceptance criteria
- Analyzes UI screenshots (Figma designs, mockups) to identify interactive elements
- Generates CSV files formatted for Jira Xray import (3 columns: Action, Data, Expected Result)
- Operates in two modes: `generate` (create new test cases) and `refactor` (consolidate existing test cases)

## Architecture

### Skill File Structure (`tcs.md`)

The skill uses YAML frontmatter to define parameters:
```yaml
args: [story, images, common_steps, mode, existing_tcs]
```

**Two operational modes:**
1. **GENERATE MODE** (default): Creates 3-5 consolidated test cases from user story + optional UI screenshots
2. **REFACTOR MODE**: Uses "ultrathink analysis" to consolidate existing test cases into minimal comprehensive coverage

### Key Design Principles

**Test Case Consolidation Philosophy:**
- One test case per distinct user workflow (NOT per scenario variant)
- Combine positive/negative/edge cases into single comprehensive test cases
- Target 3-5 TCs for typical stories; 10+ TCs indicates over-engineering
- Group related UI verification into cohesive test cases

**Example anti-patterns to avoid:**
- ❌ Separate TCs for "Deploy with Yes" vs "Deploy with No"
- ✅ Single TC "Verify Deploy Operation" covering both confirmation and cancellation

**CSV Output Requirements:**
- EXACTLY 3 columns: "Action", "Data", "Expected Result"
- All values must be double-quoted
- Title and Description precede each CSV block
- Common steps (setup) must prefix every test case

## Development Workflow

### Testing Changes

Since this is a skill definition, testing requires:

1. **Install to local Claude Code:**
   ```bash
   # Mac/Linux
   cp tcs.md ~/.claude/skills/tcs.md
   
   # Windows (PowerShell)
   Copy-Item tcs.md "$env:USERPROFILE\.claude\skills\tcs.md"
   ```

2. **Restart Claude Code** (full restart, not just window close)

3. **Verify installation:** `/skills` should list `tcs`

4. **Test with sample data:**
   ```
   /tcs "path/to/jira-export.xml" "screenshot.png" "Login,Navigate to page"
   ```

### Validation Checklist

When modifying the skill:

- [ ] YAML frontmatter is valid (name, description, args)
- [ ] Both GENERATE and REFACTOR modes function correctly
- [ ] CSV output has exactly 3 columns with proper quoting
- [ ] Common steps are correctly prefixed to all test cases
- [ ] File path handling works for both absolute and relative paths
- [ ] Image reading works (skill should handle PNG/JPG)
- [ ] Consolidation logic maintains coverage while reducing TC count

### Installation Scripts

`install.sh` and `install.ps1` copy `tcs.md` to the skills directory:
- Create `~/.claude/skills/` if needed
- Copy `tcs.md` to destination
- Provide user instructions for verification

**Do not modify these scripts** unless changing installation location or adding pre/post-install checks.

## Critical Constraints

### Output Format (Non-negotiable)

Jira Xray CSV import is strict:
- Must have exactly 3 columns (Action, Data, Expected Result)
- All values must be enclosed in double quotes
- Column headers must use these exact names
- Comments (Title/Description) use `#` prefix

**Breaking this format will cause Jira import failures.**

### Skill Invocation Pattern

Users can pass arguments in these ways:
- File paths (absolute or relative): `/tcs "C:\path\to\story.xml"`
- Comma-separated images: `/tcs "story.xml" "ui1.png,ui2.png"`
- Common steps as string: `/tcs "story.xml" "" "Login,Navigate"`
- Empty placeholders for skipped args: `/tcs "story.xml" "" ""`

The skill must detect file paths vs. literal text by checking for path separators (`/` or `\`) or `.xml` extension.

## Quality Standards

### Test Case Design (from skill documentation)

- Action-oriented titles starting with "Verify", "Validate", "Test"
- One TC per distinct workflow/feature (not per test condition)
- Reference specific UI elements by visible labels (when images provided)
- Include positive paths, boundary conditions, and negative scenarios within consolidated TCs
- Default common steps: Login → Navigate to page → Select user → Navigate to tab

### Consolidation Metrics (REFACTOR MODE)

When refactoring existing TCs:
- Calculate target TC count: `Distinct Workflows + UI Verification Areas`
- Document reduction percentage: `(Original - Target) / Original * 100%`
- Verify coverage preservation: all acceptance criteria, edge cases, negative scenarios maintained
- Show ultrathink analysis before outputting consolidated TCs

## Common Modifications

### Adding New Analysis Capabilities

If adding UI element detection or requirement extraction:
1. Update preprocessing logic in GENERATE MODE section
2. Document new capabilities in "From UI/UX images, identify:" list
3. Test with sample images containing those elements
4. Update README.md with examples of the new capability

### Adjusting Consolidation Logic

If changing consolidation rules in REFACTOR MODE:
1. Update "CONSOLIDATION TECHNIQUES" section with new pattern
2. Add to "Phase 2: Consolidation Opportunity Analysis"
3. Update examples in ultrathink analysis output
4. Test with real-world test case sets to verify coverage preservation

### Modifying Output Format

**Warning:** Only modify if Jira Xray format requirements change.
1. Update "OUTPUT FORMAT" section in both modes
2. Update CSV structure examples
3. Test import into actual Jira Xray instance
4. Update README.md troubleshooting section if needed

## File Descriptions

- **`tcs.md`**: The skill definition (main artifact)
- **`README.md`**: User-facing documentation (installation, usage, troubleshooting)
- **`install.sh`**: Mac/Linux installation script
- **`install.ps1`**: Windows installation script
- **`.gitattributes`**: Git line-ending configuration

## User-Facing vs. Internal

**User sees:**
- README.md (installation/usage guide)
- CSV outputs (test cases)
- Installation scripts

**User does NOT see:**
- This CLAUDE.md file
- Skill internal logic (ultrathink analysis, consolidation rules)
- Processing details (file reading, image analysis)

Keep documentation in README.md focused on "how to use", not "how it works internally".
