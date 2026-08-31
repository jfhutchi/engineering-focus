# Installing Engineering Focus

Engineering Focus is currently a development-stage instruction/policy framework. The portable workstation installer places a local copy under your home directory; provider-specific activation depends on the agent product you use.

## Clone

```bash
git clone https://github.com/jfhutchi/engineering-focus.git
cd engineering-focus
```

For the current development branch during bootstrap:

```bash
git checkout bootstrap-v0.1
```

## Windows

From PowerShell:

```powershell
.\workstation\install.ps1
```

The default destination is:

```text
$HOME\.engineering-focus
```

To replace an existing installation:

```powershell
.\workstation\install.ps1 -Force
```

To use another destination:

```powershell
.\workstation\install.ps1 -Destination C:\Tools\engineering-focus
```

## Linux / macOS / WSL

```bash
bash workstation/install.sh
```

The default destination is:

```text
~/.engineering-focus
```

To replace an existing installation:

```bash
ENGINEERING_FOCUS_FORCE=1 bash workstation/install.sh
```

Or specify a destination as the first argument:

```bash
bash workstation/install.sh /opt/engineering-focus
```

## What the installer does

It copies the portable policy distribution:

- canonical `SKILL.md`;
- core policy and mode definitions;
- handoff/telemetry schemas;
- mode overlays;
- integration guidance;
- license and attribution notices.

## What the installer does not do

The installer does **not** silently modify configuration for Codex, Copilot, Claude, OpenAI products, IDEs, or other agents.

Automatic provider modification is intentionally deferred until each target configuration mechanism is verified and can be installed/reverted safely.

See `integrations/README.md` for the current integration status.

## Repository-level use

For agent systems that honor repository instruction files, this repository contains initial adapters including:

- `AGENTS.md`;
- `.github/copilot-instructions.md`;
- `CLAUDE.md`;
- `.codex-plugin/plugin.json`;
- `skills/engineering-focus/agents/openai.yaml`.

These are development-stage adapters. Verify behavior in the target runtime before relying on them as enforcement.

## Uninstall workstation copy

Windows:

```powershell
.\workstation\uninstall.ps1
```

Linux/macOS/WSL:

```bash
bash workstation/uninstall.sh
```

## Verify the repository contract

```bash
python -m pip install -r requirements-dev.txt
pytest
```

This validates the mode definitions, policy invariants, JSON schemas, examples, attribution, and current Codex skill-path assumption.
