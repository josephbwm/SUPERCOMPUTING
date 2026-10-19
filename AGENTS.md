AGENTS.md

# Role and Workflow
- ALWAYS generate a short, checkable implementation plan before altering or creating any files.
- Pause for user approval on the plan if the task modifies more than 3 files or changes core dependencies.
# Execution Policies
- NEVER execute destructive terminal commands (e.g., `rm -rf` or sweeping deletes) without explicit user permission.
- If a custom script or CLI tool is available in the workspace, run it with `--help` first to check flags rather than consuming token bandwidth reading the entire script source code.
# Workspace Isolation
- Prefer working in an isolated Git worktree (`worktree mode` / `branch` mode) when tackling complex, multi-file feature additions to keep the main working directory clean.
- Ensure any child subagents spin up within their own isolated context scopes to minimize token overlapping and prevent conflicting code edits.
# Code Patterns
- Adhere strictly to the existing formatting and architectural patterns found in the repository (e.g., TypeScript strict mode, functional components).
- Do not add placeholders, `TODO` comments, or truncated snippets in the final code output unless explicitly requested. Write out full, operational functions.

## GitHub Interaction Rules

## Commit Protocols
- All local modifications must be committed to a feature branch; NEVER commit directly to 'main' or 'master'.
- Follow the Conventional Commits specification (e.g., `feat: add authentication endpoint`, `fix: resolve null pointer`).

## Remote Actions
- ALWAYS ask for explicit user confirmation before executing a `git push` or creating a Pull Request.
- Before opening a Pull Request, compile a short markdown summary outlining the files changed and tests passed.
