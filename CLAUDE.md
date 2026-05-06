# CLAUDE.md

Guidance for Claude Code when working in this repo.

## Repo overview

A Claude Code skill that turns Jira user stories (+ optional UI screenshots) into Jira Xray CSV test cases. Invoked via `/tcs`.

- **Source of truth:** `tcs/SKILL.md` (the skill definition).
- **Install target:** `~/.claude/skills/tcs/SKILL.md` (subdirectory layout — never `~/.claude/skills/tcs.md`). README has the one-line install commands.
- **User-facing docs:** `README.md`.

The skill has two modes declared in its YAML frontmatter (`args: [story, images, common_steps, mode, existing_tcs, app_map]`):
1. **GENERATE** (default) — produce 3–5 consolidated TCs from a story.
2. **REFACTOR** — consolidate existing TCs into minimal coverage.

## Non-negotiable output format

Jira Xray import is strict — breaking this causes import failures:
- Exactly 3 columns: `"Action","Data","Expected Result"` (those exact headers).
- Every value double-quoted.
- `# Title:` and `# Description:` comment lines precede each CSV.
- Common steps prefix every TC.

## Design principles to preserve

- One TC per workflow, not per scenario variant. Combine positive/negative/edge into a single comprehensive TC.
- Target 3–5 TCs per typical story; 10+ signals over-engineering.
- Action-oriented titles ("Verify…", "Validate…").
- Cell-level rules (see SKILL.md → "CELL-LEVEL STYLE RULES"): atomic Expected Results, no editorial asides, no `or` hedges, no bracketed `<placeholders>` in Data.

## Editing the skill

1. Edit `tcs/SKILL.md`.
2. Copy it to `~/.claude/skills/tcs/SKILL.md` (see README for the exact one-liners).
3. Fully restart Claude Code; verify with `/skills`.
4. Smoke-test both modes with a real story.

When changing consolidation logic, output format, or arg handling, also update the README if the user-visible behavior changes.
