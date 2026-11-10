# AI Agent Operating Guidelines & Rules

This document outlines mandatory guidelines, execution policies, and operational boundaries for any AI assistant operating within this repository (`SUPERCOMPUTING` / APSC 424: Supercomputing for Science).

---

## 1. Core Operating Principles

- **Plan First**: ALWAYS generate a concise, checkable implementation plan before modifying or creating any files.
- **Seek Approval When Warranted**: Pause and request user approval on the plan before proceeding if a task alters more than 3 files, introduces new dependencies, or changes architectural boundaries.
- **Complete Implementations**: Write fully operational code and scripts. Do NOT leave placeholders, `TODO` comments, ellipses (`...`), or truncated stubs unless explicitly requested by the user.
- **Minimal Surface-Area Edits**: Keep diffs clean and focused on the requested task. Do not reformat unrelated files or remove existing comments and docstrings.
- **Verification & Validation**: Whenever practical, verify script syntax, validate execution paths, and run quick local checks before finalizing changes.
- **Explain Dense Commands**: When introducing complex shell pipelines or one-liners (`awk`, `sed`, `xargs`, advanced regex, or obscure compiler/tool flags), include a concise comment or explanation of what key non-default flags do.

---

## 2. Safety & Command Execution

- **Non-Destructive Operations**: NEVER execute destructive commands (e.g., `rm -rf`, sweeping deletions, `git reset --hard`, or `git clean -fd`) without explicit user permission.
- **Resource Consciousness**: Run custom scripts or CLI tools with `--help` or inspect targeted sections first, rather than reading full large source or data files unnecessarily.
- **Login Node Policy & Prohibition**: Per W&M Research Computing policy (10/20/26 update), AI coding agents and VS Code Server are STRICTLY PROHIBITED from running directly on Slurm or Kubernetes front-end/login nodes (e.g., `bora`, `femto`, etc.).
- **Dev Server Boundaries (`dev.sciclone.wm.edu`)**:
  - Interactive agent operations, remote editing, and job preparation must run on the dedicated development server (`dev.sciclone.wm.edu`) or within an interactive Slurm compute allocation.
  - `dev` is a shared system, NOT a compute node: high CPU or memory usage will trigger automatic process termination. Never run multi-threaded compilations, model training, or data-heavy benchmarks locally on `dev`.
  - Cache, extension, and temporary agent files MUST be placed in local node storage (`/local/<USER>`), NOT in shared NFS `$HOME`. Remember that `/local/<USER>` is unbacked up; keep critical code and results in repo/project storage.
- **Slurm Cluster Selection & Default (`bora`)**: Slurm commands on `dev` are cluster-agnostic by default. Unless explicitly instructed otherwise, **always default to the `bora` cluster** by ensuring `module load slurm/bora` is active before submitting or inspecting jobs (`sinfo`, `squeue`, `sbatch`). Only switch to other cluster modules (e.g., `slurm/astral`, `slurm/femto`, `slurm/gulf`, `slurm/kuro`) when explicit GPU or alternative architecture resources are requested.
- **Environment & Software Modules**: Use the Lmod module system (`module load python/3.12.7`, `module load miniforge3/24.9.2-0`, `module load uv/0.13.1`). Do not attempt system-level package installations.
- **Cluster & Batch Safety**: Do NOT submit batch jobs (`sbatch`), launch long-running background tasks, or trigger intensive computational workloads without explicit instruction. For heavy agent testing, request an interactive compute allocation via `salloc`.
- **Data Preservation**: NEVER overwrite, modify, or delete raw scientific datasets (e.g., `.fasta`, `.csv`, `.gz`), benchmark outputs, course assignment submissions, or Slurm logs (`.out`, `.err`) unless explicitly directed.
- **Secrets & Credential Protection**: NEVER hardcode, commit, or log sensitive credentials, cluster passwords, personal access tokens, or private SSH keys.

---

## 3. High-Performance Computing & Code Standards

- **Environment & Course Context**: Respect course conventions for HPC (bash, Slurm scheduling, Python, C/C++, MPI, OpenMP).
- **Conda Activation**: ALWAYS hook conda into subshells or scripts using `eval "$(conda shell.bash hook)"`. NEVER execute `conda init` (it permanently modifies and overrides `~/.bashrc`).
- **Unix Line Endings (LF)**: ALWAYS write and save shell and Slurm batch scripts with Unix line endings (`LF`), NEVER Windows line endings (`CRLF`), to prevent interpreter failures (`/bin/bash^M: bad interpreter`) on the cluster.
- **Path Portability**: Avoid hardcoding absolute user paths (e.g., `/home/username/...`) in scripts or configs. Always set working directories explicitly (e.g., `cd "${SLURM_SUBMIT_DIR:-.}"`) and use relative paths or standard environment variables (`$HOME`, `$SCRATCH`).
- **Batch & Shell Scripting**: Write robust, portable shell and Slurm batch scripts. Use safe scripting practices (e.g., `set -euo pipefail` where applicable), clean up temporary scratch files with traps (`trap 'rm -rf "$TMP_DIR"' EXIT`), and document `#SBATCH` resource directives clearly.
- **Maintain Repository Patterns**: Follow the established directory layout (`assignments/`, `lessons/`, `practice/`, `quizzes/`) and adhere to existing naming and formatting conventions.

---

## 4. Reproducibility & Pipeline Logging

- **When to Log**: For non-trivial pipelines, multi-step workflows, benchmarks, or major project milestones, record the critical steps taken. Do NOT create or update logs for routine chores, minor bugfixes, or trivial edits.
- **Where to Log**: Maintain entries in the relevant project or assignment's existing documentation (e.g., `README.md` or a dedicated `PIPELINE_LOG.md` if one exists in that directory).
- **What to Capture**:
  - Environment details (e.g., modules loaded, conda environments, compiler versions).
  - Exact commands, script invocations, key non-default flags, and Slurm resource parameters used.
  - Input file sources/locations and expected output artifact paths.
  - Key troubleshooting steps, caveats, or anomalies encountered.
- **Keep it Lightweight**: Keep entries concise and reproducible; avoid dumping raw terminal chatter or unparsed logs. Focus on what another researcher needs to replicate the run.

---

## 5. Context & Subagent Management

- **Isolated Scopes**: When delegating work to subagents, assign tightly scoped, isolated roles and prompts to avoid context bloat and conflicting edits.
- **Worktree / Branch Isolation**: For complex multi-file features or substantial refactoring, prefer using an isolated Git worktree or feature branch to keep the primary working directory clean.

---

## 6. Git & GitHub Protocols

### Commit Protocols
- **Feature Branches**: Commit local modifications to a dedicated feature branch; NEVER commit directly to `main` or `master`.
- **Conventional Commits**: Format commit messages according to the Conventional Commits specification (e.g., `feat: ...`, `fix: ...`, `docs: ...`, `chore: ...`).
- **Clean Commits & Large Data Guard**: NEVER stage or commit raw scientific datasets (e.g., `.fastq`, `.bam`, `.sam`, `.tar.gz`), intermediate pipeline data, or compiled binary executables to Git. Ensure `.gitignore` is actively updated to exclude them.

### Remote Actions
- **Explicit Confirmation**: ALWAYS obtain explicit user confirmation before executing `git push`, force-pushing, or creating/merging Pull Requests.
- **PR Summaries**: Before opening a Pull Request, prepare a clear markdown summary detailing the changes, motivations, and test/validation results.
