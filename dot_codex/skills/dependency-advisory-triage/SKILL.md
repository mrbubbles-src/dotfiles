---
name: dependency-advisory-triage
description: Extension to security-best-practices. Use alongside the security-best-practices skill when the user asks whether a repository, service, or dependency set is affected by a security advisory, vendor security email, CVE, compromised package notice, supply-chain incident, package-manager security default, npm/pnpm/Bun/PyPI advisory, or "are we affected?" security notice.
---

# Dependency Advisory Triage

Use this as a narrow add-on to `security-best-practices`. The goal is to answer: "Are we affected, what evidence proves it, and what should we do next?"

## When To Use

Use this for:

- vendor emails or dashboard warnings, such as Supabase or hosting-provider notices
- CVEs, GitHub advisories, OSV/Snyk/npm/PyPI/package-registry alerts
- supply-chain compromise reports, suspicious package releases, or package-manager security defaults
- questions like "are we affected?", "is this real for us?", or "what should we change?"

If the request is a broad secure-coding review, use `security-best-practices` first. If the request is about one advisory or incident, use this skill and read `security-best-practices` only for framework-specific fix guidance.

## Source Order

1. Primary advisory source: vendor/project/security bulletin, CVE record, GHSA, OSV, or official package-manager docs.
2. Local repo evidence: `package.json`, lockfiles, manifests, Dockerfiles, CI/deploy config, runtime config, imports, and service integration code.
3. Secondary analysis only when the primary source is unclear or the user provided a news link.

When current external facts matter, verify them from primary sources before concluding.

## Triage Workflow

1. Define the advisory.
   - affected package/service/product
   - vulnerable versions or configuration
   - attack window or malicious version range, if relevant
   - required attacker capabilities and impact
   - vendor-recommended remediation

2. Inspect local exposure.
   - identify the package manager and lockfile actually used
   - check direct and transitive dependencies with exact resolved versions
   - search imports, runtime entry points, build scripts, CI, deploy, and server/client boundaries
   - for service notices, confirm the specific project, API, integration, region/env, auth mode, and feature usage
   - for package compromises, check whether the malicious version was resolved or installed, not just whether a semver range could allow it

3. Classify status.
   - `Not present`: dependency/service is not used.
   - `Present, not affected`: used, but version/config/window is outside scope.
   - `Potentially affected`: evidence is incomplete or a vulnerable range/config is present.
   - `Affected but not reachable`: vulnerable component exists but no reachable path was found.
   - `Affected`: vulnerable version/config and plausible reachable path exist.

4. Recommend the smallest action.
   - update/pin/remove dependency
   - rotate secrets or invalidate sessions only when exposure evidence supports it
   - change package-manager security settings, lockfile policy, CI install mode, or registry policy
   - patch service configuration or code path
   - add follow-up monitoring/tests/docs only when they prevent the same miss from recurring

## Guardrails

- Do not declare "not affected" from package names alone; verify exact lockfile resolution or service configuration.
- Do not declare "affected" from a scary article alone; tie it to local version/config/reachability.
- Preserve evidence: cite files, commands, version ranges, and dates.
- Distinguish dev-only exposure from production/runtime exposure.
- Avoid broad dependency churn unless the advisory requires it.
- For supply-chain incidents, consider secrets and CI exposure separately from app runtime exposure.

## Useful Commands

Choose commands that match the repo:

```sh
rg '"(packageManager|dependencies|devDependencies|resolutions|overrides|catalog)"' package.json pnpm-lock.yaml bun.lock package-lock.json yarn.lock
npm ls <package>
pnpm why <package>
bun pm why <package>
python -m pip show <package>
```

Do not run install/update commands unless the user asked for a fix or the workflow already permits edits.

## Output

Finish with a compact advisory triage:

- advisory summary and date/source
- affected status
- local evidence
- immediate action
- prevention or follow-up
- unknowns, if any
