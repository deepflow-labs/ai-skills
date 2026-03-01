---
name: review-skill
description: >
  Reviews a Claude Code skill for quality, correctness, and adherence to Anthropic's official
  best practices. Triggers when someone asks to review a skill, audit a skill, check skill
  quality, validate a SKILL.md, or says things like "is this skill good?", "review my skill",
  or "check this skill before merging".
---

# Review Skill — Quality Assessment

Reviews a Claude Code skill against the [official Anthropic best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices) and the team conventions in CLAUDE.md. Produces a structured assessment with pass/fail verdicts and actionable recommendations.

## Step 1: Identify the Skill to Review

Ask the user which skill to review. Accept any of:
- A skill name (e.g., `create-bug`) — search for it in `.claude/skills/` or `skills/`
- A file path to a SKILL.md
- "This skill" if they're already in a skill directory

Read the skill's SKILL.md and any files it references (README.md, templates, scripts).

## Step 2: Run the Assessment

Evaluate the skill against each criterion below. For each item, assign **Pass**, **Fail**, or **N/A** (if the criterion doesn't apply to this type of skill).

### Frontmatter

| # | Criterion | What to check |
|---|-----------|---------------|
| 1 | **Name format** | Lowercase letters, numbers, hyphens only. Max 64 characters. Verb-first (e.g., `create-bug`, not `bug-creator`). No reserved words ("anthropic", "claude"). |
| 2 | **Description — what + when** | Must describe both what the skill does AND when to invoke it. Should include natural trigger terms users would say. |
| 3 | **Description — third person** | Written as a capability declaration ("Creates a..." not "Use this to..." or "I will..."). |
| 4 | **Description — length** | Non-empty, max 1024 characters. No XML tags. |

### Content

| # | Criterion | What to check |
|---|-----------|---------------|
| 5 | **Body length** | Under 500 lines. If over, details should be moved to reference files. |
| 6 | **Progressive disclosure** | SKILL.md serves as overview/table of contents. Details in supporting files. Simple skills can be self-contained. |
| 7 | **Reference depth** | Any referenced files are one level deep from SKILL.md (no nested chains). |
| 8 | **Conciseness** | Only includes context Claude does not already know. No obvious padding or restating general knowledge. |
| 9 | **Consistent terminology** | Uses the same term for the same concept throughout (e.g., doesn't mix "ticket" and "issue" interchangeably without reason). |
| 10 | **No time-sensitive info** | No hardcoded dates, version numbers, or references that will go stale. |

### Workflow

| # | Criterion | What to check |
|---|-----------|---------------|
| 11 | **Clear steps** | Workflow has numbered or named sequential steps. Each step has a clear purpose. |
| 12 | **Examples** | Includes at least one concrete example with expected input/output. Abstract placeholders alone don't count. |
| 13 | **Error handling** | Defines what to do when things go wrong (missing tools, missing info, API failures). Does not "punt to Claude" without guidance. |
| 14 | **Edge cases** | Documents non-obvious scenarios and how to handle them. |
| 15 | **No magic numbers** | All constants, field names, and configuration values are explained. |

### Safety

| # | Criterion | What to check |
|---|-----------|---------------|
| 16 | **User approval gate** | Destructive or external actions (creating tickets, sending messages, modifying resources) require explicit user confirmation before executing. |
| 17 | **No hardcoded secrets** | No API keys, passwords, tokens, or credentials in the skill files. |

## Step 3: Present the Results

Format the review as a report. Use this structure:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔍 SKILL REVIEW: {skill-name}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Score: {pass-count}/{total-applicable} passed

FRONTMATTER
  1. Name format .............. {Pass/Fail}
  2. Description what+when .... {Pass/Fail}
  3. Description third person . {Pass/Fail}
  4. Description length ....... {Pass/Fail}

CONTENT
  5.  Body length ............. {Pass/Fail}
  6.  Progressive disclosure .. {Pass/Fail/N/A}
  7.  Reference depth ......... {Pass/Fail/N/A}
  8.  Conciseness ............. {Pass/Fail}
  9.  Consistent terminology .. {Pass/Fail}
  10. No time-sensitive info .. {Pass/Fail}

WORKFLOW
  11. Clear steps ............. {Pass/Fail}
  12. Examples ................ {Pass/Fail}
  13. Error handling .......... {Pass/Fail}
  14. Edge cases .............. {Pass/Fail}
  15. No magic numbers ........ {Pass/Fail}

SAFETY
  16. User approval gate ...... {Pass/Fail/N/A}
  17. No hardcoded secrets .... {Pass/Fail}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Step 4: Provide Recommendations

After the scorecard, provide:

1. **Failures** — For each failed criterion, explain exactly what's wrong and suggest a specific fix. Quote the problematic text and show what it should be changed to.

2. **Strengths** — Call out 1-2 things the skill does well. This keeps feedback balanced and helps the author understand what to preserve.

3. **Verdict** — One of:
   - **Ready to merge** — All criteria pass (or only N/A items remain)
   - **Minor fixes needed** — 1-2 small failures that are quick to address
   - **Needs rework** — 3+ failures or structural issues that require significant changes

Ask: **"Want me to fix any of these issues?"**

## Example

A completed review might look like:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔍 SKILL REVIEW: create-bug
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Score: 15/16 passed

FRONTMATTER
  1. Name format .............. Pass
  2. Description what+when .... Pass
  3. Description third person . Pass
  4. Description length ....... Pass

CONTENT
  5.  Body length ............. Pass
  6.  Progressive disclosure .. N/A
  7.  Reference depth ......... N/A
  8.  Conciseness ............. Pass
  9.  Consistent terminology .. Pass
  10. No time-sensitive info .. Pass

WORKFLOW
  11. Clear steps ............. Pass
  12. Examples ................ Fail
  13. Error handling .......... Pass
  14. Edge cases .............. Pass
  15. No magic numbers ........ Pass

SAFETY
  16. User approval gate ...... Pass
  17. No hardcoded secrets .... Pass

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

**Failures:**
#12 Examples — The SKILL.md uses `{placeholders}` in the ticket template but
has no concrete example with real-looking data showing a completed interaction.

**Strengths:**
- Conversational collection approach avoids interrogation-style UX
- User approval gate before issue creation is well-implemented

**Verdict: Minor fixes needed**

Want me to fix any of these issues?
```

## Edge Cases

- **Skill has no SKILL.md** — This is not a valid skill. Tell the user and point them to `/skill-creator`.
- **Skill is a placeholder/stub** — Note it as such. Suggest using `/skill-creator` to build it out.
- **Multiple skills to review** — Review them one at a time. Ask which to start with.
