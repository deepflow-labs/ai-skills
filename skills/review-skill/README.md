# review-skill

Reviews a Claude Code skill for quality and adherence to [Anthropic's official best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices).

## What it does

1. **Reads** the target skill's SKILL.md and supporting files
2. **Evaluates** against 17 criteria covering frontmatter, content, workflow, and safety
3. **Presents** a structured scorecard with pass/fail verdicts
4. **Recommends** specific fixes for any failures, with a final verdict

## Prerequisites

None — this skill only reads files.

## Usage

```
/deepflow-labs-tools:review-skill
```

Then tell it which skill to review (by name or path).

## Example

```
User: /review-skill
User: Review the create-bug skill

Claude: [reads SKILL.md, evaluates against criteria]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔍 SKILL REVIEW: create-bug
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Score: 16/17 passed
...

Verdict: Minor fixes needed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Want me to fix any of these issues?
```
