# CLAUDE.md — DeepFlow Labs AI Skills

## Repository Overview

This repo is the **deepflow-labs-tools** Claude Code plugin and marketplace. It distributes team skills and MCP server configs (Linear, Clerk, Convex, Vercel, Playwright) that are available across all DeepFlow Labs repositories after installation.

### Plugin Architecture

- **Plugin manifest**: `.claude-plugin/plugin.json` — defines plugin identity and version
- **Marketplace catalog**: `.claude-plugin/marketplace.json` — lists available plugins
- **Skills**: `skills/` at the repo root — each subdirectory is a skill with `SKILL.md` + `README.md`
- **MCP config**: `.mcp.json` — ships MCP server configs (Linear, Clerk, Convex, Vercel, Playwright) with the plugin

Skills are namespaced when installed: `/deepflow-labs-tools:review-skill`, etc.

---

## Creating New Skills

**Always use `/skill-creator`** to create new skills. It guides you through writing a well-structured skill with proper validation and documentation.

### Skill Design Pattern

All creation skills (bugs, epics, PRDs, design docs) follow this flow:

1. **Interview** — Collect required information from the user
2. **Draft** — Format the content using the appropriate template
3. **Review** — Present the draft, check for missing fields, suggest improvements
4. **Execute** — Only after user approval, create the artifact (Linear issue, doc, etc.)

### Skill Writing Guidelines

- **Be explicit** — Claude follows instructions literally; leave nothing ambiguous
- **Declare prerequisites** — State what MCP servers, CLI tools, or env vars are needed
- **Include examples** — Show expected input/output so Claude understands the format
- **Include validation** — Add steps where Claude checks its own work before proceeding
- **Keep skills focused** — One skill = one workflow. Don't combine unrelated tasks
- **Ask, don't guess** — Skills should ask the user for missing information

### Naming Convention

- Directories: **verb-first kebab-case** (e.g., `create-bug`, `review-document`)
- Skills become `/deepflow-labs-tools:<skill-name>` when the plugin is installed

### Testing During Development

Test plugin changes locally without installing:

```bash
claude --plugin-dir ./
```

---

## Reviewing Skills

Every skill should be reviewed against the [official Anthropic best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices) before merging.

### Quality Checklist

**Frontmatter:**
- [ ] `name` — Lowercase letters, numbers, hyphens only. Max 64 characters. Verb-first.
- [ ] `description` — Written in **third person** ("Creates a..." not "Use this to..."). Describes both **what the skill does** and **when to invoke it**. Includes natural trigger terms. Max 1024 characters.

**Content:**
- [ ] Body is under **500 lines** — move details to separate reference files if needed
- [ ] References are **one level deep** from SKILL.md (no nested reference chains)
- [ ] **Progressive disclosure** — SKILL.md is an overview; details live in supporting files
- [ ] **Concise** — only includes context Claude does not already know
- [ ] **Consistent terminology** throughout
- [ ] **No time-sensitive information** (dates, versions that will go stale)

**Workflow:**
- [ ] Clear, sequential steps
- [ ] Concrete examples with expected input/output
- [ ] Error handling is explicit (fallback paths, not "punt to Claude")
- [ ] Edge cases documented
- [ ] No magic numbers — all constants explained

**Safety:**
- [ ] Destructive or external actions require user confirmation
- [ ] No hardcoded secrets

### How to Review

1. **Use `/deepflow-labs-tools:review-skill`** — reviews against the checklist above
2. **Use `/skill-creator`** — Anthropic's official skill creator can also review existing skills
3. **Manual review** — walk through the checklist above

---

## Versioning

Bump the `version` field in `.claude-plugin/plugin.json` when making changes to skills. Users with auto-update enabled will receive the new version automatically.

---

## Branch & Workflow Convention

### Branch naming format

```
{acronym}-DEEPFLOW-{ticket}-{description}
```

- **acronym**: Developer's personal 2–4 letter code (lowercase)
- **ticket**: Linear issue number. Use `0000` for chores without a ticket
- **description**: Kebab-case summary

**Example:** `dro-DEEPFLOW-0000-add-new-skill`

### Resolving the developer acronym

```bash
gh pr list --author @me --state all --limit 10 --json headRefName --jq '.[].headRefName'
```

Extract the prefix before the first `-DEEPFLOW-`. If no previous branches exist, ask the user for their acronym.
