# Logging retention: Martin-owned encryption rollback watch

- Backend repository: `/Users/mrbubbles/dev/novari/novari-education-backend`
- Branch: `chore/logging-improvements`
- Commit under discussion: `408cf2365372c11b033d53cb4787cf52254b7ac7`
- Parent: `6a8102f3b3bc1c686acb1b07d1526a5f7f101d4c`
- Current decision: keep the commit for now while awaiting Martin's answer. Do not roll anything back without a new explicit instruction.

## Exact shared encryption additions

Only these production additions enter Martin's shared encryption area:

1. `libs/hidrive/encryptedFileStore.js`
   - added `SECURITY_AUDIT_RETENTION_PATH_PATTERN`
   - added exported `resumeSecurityAuditRetentionEncryptedDelete()`
   - accepts only normalized `/server-logs/security-audit/months/YYYY-MM/(12-months|24-months)/(events.json|manifest.json)` paths
   - existing `deleteEncryptedFile()`, upload, download, move, envelope, keys, metadata schema, rotation and general recovery code were not modified
2. `db/hidrive.connect.js`
   - added the import above
   - added `encryptedOnlyResumeRetentionDeleteFile()`
   - added only `resumeRetentionDeleteFile` to `securityAuditArchiveStorage`
   - existing general `deleteFile` adapter remains unchanged

The new path is called only by Logging retention through `libs/observability/securityAuditArchiveRetention.js`. Existing callers do not use it and their code paths remain unchanged relative to the parent commit.

## Narrow rollback if Martin requests removal

Preserve the broader 12-/24-month Logging retention feature, but remove only our shared-encryption extension and its dependent claims:

- remove the regex and `resumeSecurityAuditRetentionEncryptedDelete()` from `libs/hidrive/encryptedFileStore.js`
- remove its import, adapter and `resumeRetentionDeleteFile` property from `db/hidrive.connect.js`
- switch the Logging retention caller in `libs/observability/securityAuditArchiveRetention.js` back to the existing `securityAuditArchiveStorage.deleteFile()` contract, explicitly accepting the previously known rare crash-between-physical-delete-and-metadata-delete edge case
- update only the directly dependent assertions in:
  - `tests/encryption/encryptedFileStore.test.js`
  - `tests/encryption/hidriveConnectDownload.test.js`
  - `tests/observability/securityAuditArchiveRetention.test.js`
- remove or correct only the dedicated-resume claims in `README.md`, `CHANGELOG.md`, `docs/project-docs/quality-compliance/retention-and-deletion.md`, and `docs/project-docs/security/logging-policy.md`
- perform a fresh focused review and verification before a normal corrective commit/push

Do not revert or alter Martin's existing encryption functions. A full revert of `408cf236...` would also remove the entire Logging archive-retention implementation and is not the preferred response unless explicitly requested.
