# Security Policy

## Supported versions

Engineering Focus is pre-1.0. Security fixes are applied to the current development line unless a release note states otherwise.

## Reporting a vulnerability

Do not open a public issue for a vulnerability that could expose credentials, weaken agent/tool authorization boundaries, enable unsafe command execution, or bypass configured approval controls.

Use GitHub's private vulnerability reporting feature when enabled for this repository. If private reporting is unavailable, contact the repository owner through an appropriate private channel before publishing exploit details.

Include:

- affected version or commit;
- affected integration/runtime;
- reproduction steps;
- expected and observed behavior;
- impact;
- proposed mitigation, if known.

## Security model

Engineering Focus is a behavior and orchestration policy layer. It does not replace the security model of an AI provider, agent harness, operating system, CI/CD platform, or tool runtime.

Implementations must preserve these boundaries:

1. System/platform safety and authorization rules outrank Engineering Focus instructions.
2. A focus mode must never grant tools, credentials, filesystem access, network access, or execution authority the underlying agent does not already possess.
3. Cost or context optimization must not remove security-relevant evidence, approvals, warnings, or validation.
4. Cached artifacts must retain provenance and trust state.
5. Destructive or irreversible actions remain subject to the host platform's confirmation and authorization requirements.
6. `EXPLORATORY` mode expands idea generation, not permissions.

## Secrets

Never commit API keys, tokens, credentials, private prompts containing secrets, or organization-confidential policy overlays to this public repository.
