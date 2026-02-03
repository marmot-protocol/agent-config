# Agent Config

A team repository for OpenCode configuration, agent skills, commands, plugins, and tools.

## Structure

```
opencode/
├── agents/          # Custom agent definitions
├── commands/        # Slash commands
├── plugins/         # TypeScript plugins
├── skills/          # Reusable skill definitions
└── tools/           # Custom tool implementations
```

## Agents

Custom agents for specialized tasks:

- **builder** - Implementation agent for writing and modifying code
- **searcher** - Search agent for navigating codebases
- **cr-*** - Code review agents (bugs, compliance, guidelines, history, issues, summarizer, validator, gatekeeper)

## Commands

Available slash commands:

- `/commit` - Create git commits
- `/commit_message` - Generate commit messages
- `/code-review` - Run code review (ported from the excellent Claude Code code-review tool)
- `/create-git-worktree` - Create isolated git worktrees
- `/fix-gh-issue` - Fix a specified GitHub issue
- `/learn` - Learn from sessions and update AGENTS.md
- `/rmslop` - Remove unnecessary AI slop
- `/spellcheck` - Check spelling in markdown files

## Skills

Reusable skill definitions:

- **commit-code** - End-to-end git commit workflow
- **create-git-worktree** - Git worktree creation
- **karpathy-guidelines** - Coding best practices
- **search-code** - Code search patterns
- **write-commit** - Commit message authoring

## Tools

Custom tool implementations:

- **commit** - Git commit with safety checks
- **commit_message** - Commit message generation
- **diff-analyze** - Git diff analysis

## Installation

```bash
# Install everything
./install.sh

# Install specific components
./install.sh skills
./install.sh commands
./install.sh agents
./install.sh plugins
./install.sh tools
```

The script will prompt before overwriting any existing files.

## License

MIT License - see [LICENSE](LICENSE) for details.
