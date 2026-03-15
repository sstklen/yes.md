[中文版](docs/README.zh.md) · [日本語版](docs/README.ja.md)

# YES.md

> PUA says NO. YES says YES.

A Claude Code skill that makes AI **safe, evidence-based, and thorough** — with encouragement, not pressure.

**別 PUA 你的 AI，YES 它。**

**🌐 [English](skills/yes/SKILL.md) | [中文](skills/yes-zh/SKILL.md) | [日本語](skills/yes-ja/SKILL.md)**

## Why Your CLAUDE.md Doesn't Work

Your CLAUDE.md has one layer. AI reads it, then **chooses** whether to follow it.

YES.md has six layers. AI has to get past all six to cut corners.

| Layer | What | How | Who Enforces |
|:-----:|------|-----|:------------:|
| **1** | **Format** — AI actually understands your rules | [AI.MD](https://github.com/sstklen/ai-md) converts prose to structured-label format | Format |
| **2** | **Trigger** — activates at exactly the right moment | 20+ specific trigger conditions in SKILL.md description | Skill engine |
| **3** | **Hooks** — blocks dangerous commands, reminds checks | Scripts run automatically before/after AI actions | **Machine** |
| **4** | **Anti-Slack** — 7 lazy patterns caught and corrected | Deflecting, guessing, spinning, surface-fix, empty questions... | AI self-correction |
| **5** | **Gates** — no backup = no edit, no test = no "done" | Hard stop rules that halt progress until requirements are met | AI self-discipline |
| **6** | **Memory** — mistakes get recorded, never repeated | Error logs + knowledge base persist across sessions | External storage |

> **Layer 3 is the key.** Everything else relies on AI self-discipline. Hooks are **scripts that run automatically** — the AI cannot bypass them even if it wants to.

Most tools give you Layer 4 or 5 alone. That's why they don't work. **Six layers together is why YES.md works.**

## The Problem

AI coding assistants have seven bad habits:

| Bad Habit | What Happens |
|-----------|-------------|
| 🎲 **Guessing** | "Probably a permissions issue" — without checking |
| 🙈 **Deflecting** | "Please check your environment manually" |
| 🩹 **Surface fixing** | Fixes one bug, ignores three related ones |
| 🔄 **Blind retrying** | Same command 3 times, then gives up |
| 🤷 **Empty questions** | "Can you confirm X?" — without investigating X |
| 💬 **Advice, not action** | "I suggest..." instead of actual code |
| 🛠️ **Ignoring tools** | Has WebSearch but guesses. Has Bash but doesn't run. |

**PUA-style skills fix habit #4** (blind retry / giving up).

**YES.md fixes all seven.**

## How It Works

### Three Pillars

| Pillar | What It Does |
|--------|-------------|
| **Safety Gates** | Backup before editing. Check blast radius. Verify after changes. Pre-flight before deploy. |
| **Evidence Rules** | No guessing. No "probably." Every claim needs data, line numbers, or tool output. |
| **Ripple Awareness** | After every fix: check same pattern elsewhere, check upstream/downstream, check edge cases. |

### Hooks (Machine-Enforced)

Rules rely on AI self-discipline. Hooks don't. They are **scripts that run automatically** before and after AI actions.

| Hook | When | What It Does |
|------|------|-------------|
| `pre-bash-guard.sh` | Before any Bash command | Blocks `rm -rf`, `git reset --hard`, `DROP TABLE`, and other destructive commands |
| `post-edit-check.sh` | After any Write/Edit | Reminds AI to run ripple-check before saying "done" |
| `post-deploy-health.sh` | After deploy commands | Reminds AI to verify containers, endpoints, and logs |

The AI cannot skip these. That's the point.

### Anti-Slack Detection

YES.md identifies 7 specific AI avoidance behaviors and forces self-correction — without waiting for the user to notice:

```
Deflecting to user     → Do it yourself first
Unverified blame       → Run the command, then speak
Spinning in circles    → Full stop, fundamentally different approach
Surface-only fix       → Ripple Check
Empty questions        → Investigate first, then ask
Advice without action  → Ship code, not suggestions
Tool neglect           → Use the tool, not your memory
```

### Debugging Escalation

| Failures | Action |
|:--------:|--------|
| 2 | **Switch**: fundamentally different approach (not parameter tweaks) |
| 3 | **Five-Step Audit**: read error word-by-word → WebSearch → read 50 lines context → verify assumptions → invert hypothesis |
| 4 | **Isolate**: minimal reproduction |
| 5+ | **Structured Handoff**: verified facts, eliminated causes, narrowed scope, next steps |

**Key difference from PUA**: Level 3 forces a direction check BEFORE continuing. Persistence in the wrong direction is worse than stopping.

### Conclusion Integrity

Before any root-cause claim, four mandatory questions:

1. **Data source?** — log / DB / API / curl?
2. **Time range?** — all data or just recent?
3. **Sample vs total?** — how much did you see?
4. **Other possibilities?** — what else could explain this?

Incomplete data = "⚠️ Based on partial data..." (never "definitely" or "the culprit is").

## YES.md vs PUA

| Capability | YES.md | PUA |
|-----------|:------:|:---:|
| Debugging persistence | ✅ | ✅ |
| Debugging direction (accuracy) | ✅ | ❌ |
| Anti-slack behavior detection | ✅ | ✅ |
| Post-fix ripple check | ✅ | ⭕️ |
| Safety gates (backup, deploy) | ✅ | ❌ |
| Evidence-based diagnosis | ✅ | ❌ |
| Conclusion integrity checks | ✅ | ❌ |
| Bug closure protocol | ✅ | ❌ |

> ✅ = yes | ⭕️ = partial | ❌ = no

**They complement each other.** PUA keeps AI going. YES.md keeps AI correct. Use both for maximum effect.

## Install

### Claude Code

```bash
# Marketplace
claude plugin marketplace add sstklen/yes.md
claude plugin install yes@sstklen

# Manual
git clone https://github.com/sstklen/yes.md.git ~/.claude/plugins/yes
```

### OpenAI Codex CLI

```bash
mkdir -p ~/.codex/skills/yes
curl -o ~/.codex/skills/yes/SKILL.md \
  https://raw.githubusercontent.com/sstklen/yes.md/main/skills/yes/SKILL.md
```

### Project-level (current project only)

```bash
mkdir -p .agents/skills/yes
curl -o .agents/skills/yes/SKILL.md \
  https://raw.githubusercontent.com/sstklen/yes.md/main/skills/yes/SKILL.md
```

### Choose Your Language

| Language | Skill Directory | Command |
|----------|----------------|---------|
| English | `skills/yes/` | Default |
| 中文 | `skills/yes-zh/` | Replace `yes` with `yes-zh` in commands above |
| 日本語 | `skills/yes-ja/` | Replace `yes` with `yes-ja` in commands above |

## Trigger

### Automatic

Activates when AI:
- Guesses without evidence ("probably", "might be", "should be")
- Deflects to user ("please check...", "you should manually...")
- Fails 2+ times on the same task
- Makes a root-cause claim
- Completes a fix (triggers Ripple Check)
- Modifies config/env/deployment files (triggers Safety Gates)

### Manual

Type `/yes` in any conversation.

## Pair With

- **5x-cto** ([`sstklen/5x-cto`](https://github.com/sstklen/5x-cto)) — Full dev pipeline (requirements → spec → cards → build → review). YES.md governs, 5x-cto orchestrates. Together = safe + structured end-to-end.
- **PUA** (`tanweai/pua`) — PUA adds persistence pressure, YES.md adds accuracy structure
- **systematic-debugging** — Method-level debugging, YES.md adds governance layer

## Origin

Battle-tested over months of real production work — daily deployments, multi-service debugging, and hard lessons learned from things going wrong. Every rule in YES.md exists because something broke without it.

## License

MIT

## Credits

By [sstklen](https://github.com/sstklen) — PUA says NO. YES says YES.
