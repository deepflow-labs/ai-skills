<p align="center">
  <strong>deepflow-labs-tools</strong><br/>
  <em>The single setup point for Claude Code at DeepFlow Labs</em>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/plugin-v1.0.0-blue" alt="Plugin Version" />
  <img src="https://img.shields.io/badge/skills-1-green" alt="Skills Count" />
  <img src="https://img.shields.io/badge/MCP_servers-5-orange" alt="MCP Servers" />
  <img src="https://img.shields.io/badge/official_plugins-10-purple" alt="Official Plugins" />
</p>

---

Run the setup script once and get **everything** you need for Claude Code across all DeepFlow Labs repositories — team skills, MCP servers (Linear, Clerk, Convex, Vercel, Playwright), and recommended official plugins.

**You don't need to configure Claude Code in each repo.** This is the one place where it all gets set up.

---

## Table of Contents

- [Why This Exists](#-why-this-exists)
- [Quick Setup](#-quick-setup)
- [What You Get](#-what-you-get)
- [Roadmap — Skills We're Building](#-roadmap--skills-were-building)
- [Using Skills Effectively](#-using-skills-effectively)
- [MCP Servers](#-mcp-servers)
- [How It Works Across Repos](#-how-it-works-across-repos)
- [Contributing](#-contributing)
- [Creating & Updating Skills](#-creating--updating-skills)
- [Testing Locally](#-testing-locally)
- [Versioning & Updates](#-versioning--updates)
- [Plugin Structure](#-plugin-structure)
- [Troubleshooting](#-troubleshooting)

---

## 🧭 Why This Exists

We all do the same operational tasks repeatedly — writing PRDs, filing bugs in Linear, creating GitHub issues, reviewing PRs, scaffolding features. Each person does them slightly differently, and the quality varies.

This repo fixes that by turning those repeatable processes into **shared, versioned skills** that Claude Code executes consistently. Think of it as **runbooks for AI** — instead of a wiki page describing how to write a good bug report, we encode that process as a skill that Claude follows step by step, every time.

**The goals are simple:**

1. **Standardize** — Everyone follows the same process for creating bugs, PRDs, epics, and other operational artifacts
2. **Elevate quality** — Skills enforce structure, required fields, and review steps that are easy to skip manually
3. **Save time** — Instead of context-switching to Linear/GitHub and filling out templates, describe what you need and let Claude handle the formatting and creation
4. **Share knowledge** — When someone figures out a better workflow, they encode it as a skill and the whole team benefits

**The rule of thumb:** if you find yourself doing something repeatable in Linear, GitHub, or any other tool — it should probably be a skill in this repo.

---

## 🚀 Quick Setup

> **One-time setup — run once, productive everywhere.**
> After this, every `claude` session in any DeepFlow Labs repo has access to team skills, MCP servers, and all recommended plugins.

### Option A: Setup script (recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/deepflow-labs/ai-skills/main/setup.sh | bash
```

Or clone and run locally:

```bash
git clone git@github.com:deepflow-labs/ai-skills.git
cd ai-skills
./setup.sh
```

The script installs everything: marketplace, team plugin, and all 10 official plugins. It's idempotent — safe to run again if you want to check for missing plugins.

### Option B: Manual setup

If you prefer to install things individually:

<details>
<summary><strong>Click to expand manual steps</strong></summary>

#### 1. Add the marketplace and team plugin

```bash
claude plugin marketplace add deepflow-labs/ai-skills
claude plugin install deepflow-labs-tools@deepflow-labs-tools
```

#### 2. Install recommended official plugins

```bash
# Service integrations
claude plugin install github@claude-plugins-official          # GitHub PRs, issues, code search

# Development workflows
claude plugin install commit-commands@claude-plugins-official # Git commit, push, PR
claude plugin install pr-review-toolkit@claude-plugins-official # PR review agents
claude plugin install code-review@claude-plugins-official     # Code review
claude plugin install code-simplifier@claude-plugins-official # Code simplification
claude plugin install feature-dev@claude-plugins-official     # Guided feature development
claude plugin install skill-creator@claude-plugins-official   # Create & review skills
claude plugin install hookify@claude-plugins-official         # Create hooks from conversation

# Output style (optional)
claude plugin install explanatory-output-style@claude-plugins-official  # Educational insights
```

#### 3. Authenticate MCP servers

On first use, you'll be prompted:

| Service | How to authenticate |
|---------|-------------------|
| **Linear** | Browser-based OAuth via `mcp-remote` — log in with your Linear account |
| **Clerk** | Browser-based OAuth — log in with your Clerk account |
| **Convex** | Uses your existing `npx convex` login |
| **Vercel** | Browser-based OAuth — log in with your Vercel account |
| **GitHub** | Uses your existing `gh auth` credentials (via official plugin) |
| **Playwright** | No auth needed — works out of the box |

</details>

### That's it

Open Claude Code in **any** DeepFlow Labs repo and start working:

```
/deepflow-labs-tools:review-skill     # Review a skill for quality
/commit                               # Commit, push, open PR
/code-review                          # Review code
/feature-dev                          # Guided feature development
```

Everything is installed at **user scope** — it works in every repo, no per-repo configuration needed.

> **Important: Enable auto-updates.** After running the setup, open Claude and run `/plugin` → **Marketplaces** → **deepflow-labs-tools** → **Enable auto-update**. This is off by default for third-party marketplaces. Without it, you won't automatically receive new skills or improvements when we update the marketplace.

---

## 📦 What You Get

### Team Skills

| Skill | Command | What it does |
|-------|---------|-------------|
| **Review Skill** | `/deepflow-labs-tools:review-skill` | Reviews any Claude Code skill against 17 quality criteria from [Anthropic's best practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices). Produces a structured scorecard with pass/fail verdicts. |

### MCP Servers (bundled with plugin)

| Server | What Claude can do with it |
|--------|---------------------------|
| **Linear** | Create/search issues, manage projects, update statuses, post comments, track cycles |
| **Clerk** | Manage users, organizations, sessions, and authentication flows |
| **Convex** | Query and mutate your Convex backend, inspect tables, run functions |
| **Vercel** | Manage deployments, check build status, configure domains, view logs |
| **Playwright** | Automate browser interactions — navigate pages, click elements, fill forms, take screenshots |

---

## 🗺️ Roadmap — Skills We're Building

These are the skills we plan to build. If you have ideas for others, open an issue or comment on existing ones.

| Skill | Status | What it will do |
|-------|--------|----------------|
| `review-skill` | **Available** | Reviews Claude Code skills against 17 quality criteria |
| `create-bug` | Planned | Interview you about a bug, then create a well-structured Linear issue with repro steps, expected vs actual behavior, and severity |
| `create-prd` | Planned | Walk you through writing a PRD with problem statement, requirements, success metrics, and scope |
| `create-epic` | Planned | Break down a large initiative into a Linear project with milestones and sub-issues |
| `create-design-doc` | Planned | Guide you through an architecture/design document with trade-offs, alternatives, and decision records |
| `create-issue` | Planned | Create well-structured GitHub issues with technical context from the codebase |
| `triage-bugs` | Planned | Review untriaged bugs in Linear and help prioritize them |
| `sprint-review` | Planned | Summarize what was completed in the current cycle and generate a sprint review report |

**Have an idea?** If you find yourself doing something repetitive in Linear, GitHub, Slack, or anywhere else — that's a candidate for a skill. Just build it and open a PR.

---

## 💡 Using Skills Effectively

### Review Skill — quality gate for new skills

Before merging any new or updated skill, run the reviewer:

```
/deepflow-labs-tools:review-skill
Review the create-bug skill
```

> **It checks 17 criteria across 4 categories:**
> - **Frontmatter** — name format, description quality, trigger terms
> - **Content** — length, progressive disclosure, conciseness, terminology
> - **Workflow** — clear steps, examples, error handling, edge cases
> - **Safety** — user approval gates, no hardcoded secrets

---

## 🔌 MCP Servers

The plugin ships a `.mcp.json` that configures five MCP servers. These are available in every Claude Code session where the plugin is installed.

### Linear (Project Management)

```
Transport: stdio (via mcp-remote bridge)
URL: https://mcp.linear.app/sse
Auth: Browser-based OAuth on first use
```

**What you can do:**
- Create and search issues
- Manage projects, cycles, and milestones
- Update issue statuses, priorities, and labels
- Post and read comments
- Assign issues to team members

### Clerk (Authentication)

```
Transport: HTTP (remote)
URL: https://mcp.clerk.com/mcp
Auth: Browser-based OAuth on first use
```

**What you can do:**
- Manage users and organizations
- Inspect sessions and authentication flows
- View sign-in activity and user metadata
- Debug auth-related issues with live data

### Convex (Backend)

```
Transport: stdio
Package: convex@latest (built-in MCP command)
Auth: Uses your existing Convex login
```

**What you can do:**
- Query tables and inspect data
- Run Convex functions (queries, mutations, actions)
- Debug backend logic with live data
- Explore your Convex schema

> **Note:** By default connects to your **development** deployment. Production access requires explicit flags.

### Vercel (Deployment)

```
Transport: HTTP (remote)
URL: https://mcp.vercel.com
Auth: Browser-based OAuth on first use
```

**What you can do:**
- Check deployment status and build logs
- Manage domains and environment variables
- View project configuration
- Inspect serverless function logs

### Playwright (Browser Automation)

```
Transport: stdio
Package: @playwright/mcp@latest
Auth: None required
```

**What you can do:**
- Navigate to URLs and interact with web pages
- Click elements, fill forms, select options
- Take screenshots for visual verification
- Automate repetitive browser workflows

---

## 🤝 How It Works Across Repos

Once you run the setup script, **everything is installed at user scope** — meaning it follows you into every DeepFlow Labs repo automatically. No per-repo plugin configuration needed.

### What each repo needs in `.claude/settings.json`

Just two things — repo-specific permissions and a marketplace pointer:

```json
{
  "permissions": {
    "allow": ["...repo-specific rules..."],
    "deny": ["...repo-specific rules..."]
  },
  "extraKnownMarketplaces": {
    "deepflow-labs-tools": {
      "source": {
        "source": "github",
        "repo": "deepflow-labs/ai-skills"
      }
    }
  }
}
```

That's it. **No `enabledPlugins` list needed.** The `extraKnownMarketplaces` pointer ensures that if someone hasn't run the setup script yet, Claude will prompt them to install the marketplace when they first open that repo.

### What comes from where

| What you get | Where it comes from |
|-------------|-------------------|
| Team skills (`review-skill`) | `deepflow-labs-tools` plugin (this repo) |
| MCP servers (Linear, Clerk, Convex, Vercel, Playwright) | Plugin's `.mcp.json` (this repo) |
| Official plugins (code review, PR toolkit, commit commands, etc.) | Setup script installs at user scope |
| Repo-specific permissions (safe git commands, denied destructive ops) | Each repo's `.claude/settings.json` |

---

## 🤝 Contributing

Spot a repeatable process? Build the skill and open a PR. No formal proposal needed — we're a small team, so move fast.

### How to add a skill

1. Clone this repo and run `claude --plugin-dir ./`
2. **Use `/skill-creator` to build the skill** — don't write SKILL.md files from scratch. The skill-creator is itself a skill that guides you through the entire process: it generates proper frontmatter, sequential steps, examples, error handling, and edge cases. It also knows about the MCP servers we have available (Linear, Clerk, Convex, Vercel, Playwright), so the skills it produces are wired into our existing stack from the start.
3. Test it locally, review it with `/deepflow-labs-tools:review-skill`
4. Open a PR

> **There's a skill for creating skills.** This is intentional — it ensures every skill follows the same structure, uses the right MCP integrations, and meets quality standards before it ever hits a PR. Don't hand-write SKILL.md files.

### What makes a good skill candidate?

- You do it **more than twice a week**
- It follows a **predictable structure** (e.g., bug reports always need repro steps)
- It involves **copy-pasting between tools** (e.g., Linear template + GitHub context)
- The **quality varies** depending on who does it or how rushed they are
- It's **tedious but important** (e.g., writing thorough PR descriptions)

---

## ✏️ Creating & Updating Skills

### Creating a new skill

1. **Clone this repo and start Claude Code:**
   ```bash
   cd ai-skills && claude
   ```

2. **Use the skill creator — don't write SKILL.md files by hand:**
   ```
   /skill-creator
   ```
   Follow the prompts. It generates a properly structured skill with frontmatter, steps, examples, and edge cases.

3. **Add a `README.md`** to your skill directory with: what it does, prerequisites, and a usage example.

4. **Test locally** (see [Testing Locally](#-testing-locally) below).

5. **Review the skill** before opening a PR:
   ```
   /deepflow-labs-tools:review-skill
   ```

6. **Create a PR** targeting `main`:
   - Include the new skill directory under `skills/`
   - Bump the version in `.claude-plugin/plugin.json` (see [Versioning](#-versioning--updates))
   - Follow the branch naming convention: `{acronym}-DEEPFLOW-{ticket}-{description}`

### Updating an existing skill

1. Edit the `SKILL.md` (and `README.md` if needed)
2. Test locally: `claude --plugin-dir ./`
3. Review: `/deepflow-labs-tools:review-skill`
4. Bump the version in `.claude-plugin/plugin.json`
5. Create a PR targeting `main`

### Skill design pattern

All creation skills (bugs, epics, PRDs, design docs) follow this flow:

```
Interview → Draft → Review → Execute
```

| Phase | What happens |
|-------|-------------|
| **Interview** | Collect required information from the user conversationally |
| **Draft** | Format the content using the appropriate template |
| **Review** | Present the draft, flag weak fields, suggest improvements |
| **Execute** | Only after user approval, create the artifact |

### Skill writing guidelines

- **Be explicit** — Claude follows instructions literally; leave nothing ambiguous
- **Declare prerequisites** — state what MCP servers, CLI tools, or env vars are needed
- **Include examples** — show expected input/output so Claude understands the format
- **Include validation** — add steps where Claude checks its own work before proceeding
- **Keep skills focused** — one skill = one workflow
- **Ask, don't guess** — skills should ask the user for missing information

### Naming convention

- Directories: **verb-first kebab-case** (e.g., `create-bug`, `review-document`)
- Skills are namespaced when installed: `/deepflow-labs-tools:<skill-name>`

---

## 🧪 Testing Locally

### Option 1: `--plugin-dir` (fastest iteration)

Load the plugin directly from your local checkout — changes are reflected immediately, no install needed:

```bash
claude --plugin-dir /path/to/ai-skills
```

Then test your skills:

```
/deepflow-labs-tools:review-skill
```

> **Use this for the inner development loop.** Edit a SKILL.md, restart Claude, and immediately test the change.

### Option 2: Install from branch (integration test)

Test the full marketplace install flow from your branch before merging:

```bash
# Add marketplace from your branch
claude plugin marketplace add deepflow-labs/ai-skills#your-branch-name

# Install the plugin
claude plugin install deepflow-labs-tools@deepflow-labs-tools

# Launch Claude and verify
claude
```

> **Use this once before merging** to validate the entire distribution pipeline works end-to-end.

### What to verify

- [ ] Skills appear in autocomplete when typing `/deepflow-labs-tools:`
- [ ] At least one skill executes correctly (e.g., `review-skill` starts the assessment flow)
- [ ] MCP servers are accessible (Linear authentication prompt appears on first use)
- [ ] Namespace is correct — skills show as `(deepflow-labs-tools)` in the autocomplete menu

---

## 📌 Versioning & Updates

### How versioning works

The `version` field in `.claude-plugin/plugin.json` controls update detection. **You must bump it whenever you change skills** — otherwise users won't receive the update.

```jsonc
// .claude-plugin/plugin.json
{
  "name": "deepflow-labs-tools",
  "version": "1.1.0"  // ← bump this
}
```

Use [semantic versioning](https://semver.org/):

| Change type | Version bump | Example |
|-------------|-------------|---------|
| Typo fix, wording improvement | **Patch** `1.0.0 → 1.0.1` | Fix a formatting issue in review-skill |
| New skill, enhanced workflow | **Minor** `1.0.0 → 1.1.0` | Add a `create-issue` skill |
| Breaking change, skill rename | **Major** `1.0.0 → 2.0.0` | Rename `review-skill` to `audit-skill` |

### How updates reach users

| Method | How it works |
|--------|-------------|
| **Auto-update** | Claude Code checks for updates at startup, re-clones the repo, and caches the new version. **You must enable this manually** — it's off by default for third-party marketplaces. Enable via `/plugin` → **Marketplaces** → **deepflow-labs-tools** → **Enable auto-update**. |
| **Manual update** | Run `/plugin marketplace update deepflow-labs-tools` or from the terminal: `claude plugin marketplace update deepflow-labs-tools` |
| **New installs** | Always get the latest version from `main` |

> **How it works under the hood:** There is no central plugin registry. When you add a marketplace, Claude Code clones the GitHub repo to `~/.claude/plugins/cache/`. When an update is detected (version bump in `plugin.json`), it re-clones fresh. The repo is never pulled — each version is a clean clone cached side-by-side.

---

## 📁 Plugin Structure

```
ai-skills/
├── setup.sh                     # One-time setup script — installs everything
├── .claude-plugin/
│   ├── plugin.json              # Plugin identity: name, version, description
│   └── marketplace.json         # Marketplace catalog
├── skills/                      # Team skills distributed with the plugin
│   └── review-skill/
│       ├── SKILL.md             # The prompt Claude executes
│       └── README.md            # Human-readable docs
├── .mcp.json                    # MCP server configs (Linear, Clerk, Convex, Vercel, Playwright)
├── .claude/
│   └── settings.json            # Permissions for this repo
├── CLAUDE.md                    # Conventions for contributing
└── README.md                    # This file
```

---

## 🧩 What Gets Installed

The setup script installs everything in one shot. Here's the full list:

| Category | Name | What it does |
|----------|------|-------------|
| **Team plugin** | `deepflow-labs-tools` | Team skills + 5 MCP servers (see above) |
| **Service integrations** | `github` | GitHub PRs, issues, code search, branch management |
| **Dev workflows** | `commit-commands` | `/commit` — git commit, push, and PR creation |
| | `pr-review-toolkit` | Multi-agent PR review: code review, silent failures, type analysis |
| | `code-review` | Focused code review for bugs, security, and quality |
| | `code-simplifier` | Simplifies and refines recently written code |
| | `feature-dev` | Guided feature development with architecture focus |
| | `skill-creator` | Create, review, and optimize Claude Code skills |
| | `hookify` | Create hooks to prevent unwanted behaviors |
| **Output style** | `explanatory-output-style` | Adds educational insights to Claude's responses |

All official plugins are from `claude-plugins-official`. The team plugin is from the `deepflow-labs-tools` marketplace (this repo).

---

## 🔧 Troubleshooting

| Problem | Solution |
|---------|----------|
| `/plugin` command not found | Update Claude Code: `brew upgrade claude-code` or `npm update -g @anthropic-ai/claude-code`. Requires v2.1+. |
| Marketplace not loading | Verify you have access to the repo: `gh repo view deepflow-labs/ai-skills`. |
| Skills not appearing after install | Restart Claude Code. If still missing, clear cache: `rm -rf ~/.claude/plugins/cache` and reinstall. |
| Linear MCP not connecting | The `mcp-remote` bridge may need a retry. Restart Claude Code and re-authenticate when prompted. |
| Clerk MCP not working | Re-authenticate — the OAuth token may have expired. Visit your Clerk dashboard to verify API access. |
| Convex MCP not working | Ensure you're logged in: `npx convex login`. The MCP connects to your dev deployment by default. |
| Vercel MCP not working | Re-authenticate via the OAuth prompt. Ensure your Vercel account has access to the target project. |
| Playwright not working | Ensure `npx` is available. On first use, Playwright may need to download browser binaries — this happens automatically. |
| Plugin not auto-updating | Run `claude plugin marketplace update deepflow-labs-tools` manually, or enable auto-update in `/plugin` → **Marketplaces**. |
| Skills show without namespace | This is normal — Claude Code shows the short name with `(deepflow-labs-tools)` label in autocomplete. |
| Want to test a branch before merge | `claude plugin marketplace add deepflow-labs/ai-skills#branch-name` |

---

<p align="center">
  <em>Built with <a href="https://claude.com/claude-code">Claude Code</a> by the DeepFlow Labs Team</em>
</p>
