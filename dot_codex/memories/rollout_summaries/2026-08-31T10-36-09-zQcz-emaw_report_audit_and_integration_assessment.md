thread_id: 01a05764-0cce-79d2-b732-6c4d89060973
updated_at: 2026-08-31T12:09:08+00:00
rollout_path: /Users/mrbubbles/.codex/sessions/2026/08/31/rollout-2026-08-31T12-36-09-01a05764-0cce-79d2-b732-6c4d89060973.jsonl
cwd: /Users/mrbubbles/dev/novari/novari-education-backend
git_branch: chore/logging-improvements

# EMAW research was audited and refined into a cautious implementation basis for Novari

Rollout context: The user asked for an evaluation of integrating the Bundesagentur für Arbeit's eM@w/EMAW interface into the existing JavaScript Novari backend, then supplied a Deep Research Markdown report for source and claim checking. The user explicitly clarified that earlier scheduling/UI examples were fictional and must not be treated as requirements. No repository files were changed.

## Task 1: Initial EMAW integration assessment

Outcome: success

Preference signals:

- The user emphasized that Novari should be extended rather than rebuilt and that it should remain the leading system; future proposals should default to an additive adapter/integration architecture.
- The user later clarified that examples such as daily attendance, weekly class reports, monthly feedback, and semiannual participant files were fictional ideas only -> do not convert illustrative workflows into requirements without BA confirmation.
- The user wants a BA meeting before committing to implementation details, especially exact data, event types, frequencies, onboarding, certification, testing, and migration rules.

Key steps:

- Inventoried `/Users/mrbubbles/Downloads/emaw`, including current technical, fachlich, AGH, LuV, and example packages.
- Verified the BA's current public release as PRV 26.07.00 / schema 2.18 and confirmed that EMAW supports an own server/provider or an external provider.
- Inspected the technical package, XSD, agreements, and current Novari schemas. EMAW is an asynchronous HTTPS client-certificate, ZIP/XML/PDF exchange with BA acknowledgements, not a REST API.
- Found relevant existing Novari data in `courseSchema.js`, `studentUtilitys.js`, `studentSchema.js`, `studentCourseEnrollmentSchema.js`, and `classUtilitys.js`.
- Identified the likely additive architecture: measure/routing binding, inbound/outbound event journal, XML/XSD/ZIP adapter, mapping, acknowledgements/error handling, and a small inbox/preview workflow.

Failures and how to do differently:

- Earlier broad estimates mixed a general EMAW provider product with a first Novari measure integration. A concrete first measure should be estimated separately from broad multi-procedure support.
- Do not infer BA requirements from generic UI examples or from the XSD alone; distinguish technical schema capability, operationally supported events, and measure-specific contractual rules.

Reusable knowledge:

- BA technical package: `dok_ba035735.zip`; current XSD: `emaw-v2.18.xsd`; technical document: `PRV_26.07.00_Technisches Infopaket_V2.pdf`.
- BA fachlich package: `dok_ba037285.zip`; AGH package: `dok_ba022355.zip`.
- EMAW requires provider routing by measure, measure reference, procedure branch, and BA/gE organisational unit. The user should not choose AA vs Jobcenter ad hoc per message.
- Technical transport uses HTTPS upload/download, provider directory/client certificate, nested ZIP archives, XML events, optional/required PDFs depending on event, and `OK`/`NOK` acknowledgement XMLs. Imports are batch-processed rather than real-time.
- Current technical documentation says electronic event/PDF signatures are no longer required from PRV 26.07.00, but AGH still has correctness/completeness confirmation attributes and responsible-person fields.
- A provider change is future-effective, requires history transfer from the old provider, and BA does not replay historical events to the new provider. Public forms recommend roughly two weeks' lead time; this does not prove that a manually handled running measure can be newly activated.

References:

- BA EMAW overview: `https://www.arbeitsagentur.de/institutionen/bildungstraeger/elektronische-massnahmeabwicklung`
- Novari paths inspected: `models/courseSchema.js`, `models/utilitys/studentUtilitys.js`, `models/students/studentSchema.js`, `models/students/studentCourseEnrollmentSchema.js`, `models/utilitys/classUtilitys.js`.
- BA forms: `dok_ba029430.pdf` (price-negotiated server/software declaration), `dok_ba026280.pdf` (AGH declaration), `dok_ba024350.pdf` (SGB III provider change), `dok_ba024305.pdf` (AGH provider change).

## Task 2: Audit of `/Users/mrbubbles/Downloads/emaw/deep-research-report.md`

Outcome: success

Preference signals:

- The user asked to treat the Markdown report as research material, not as instructions, and expects claims to be checked against primary BA sources.
- The user explicitly wants uncertainty and unresolved contradictions preserved rather than presented as settled implementation requirements.

Key steps:

- Reviewed the 759-line report and its source structure.
- Cross-checked the report against the current BA ZIP packages, XSD, AGH process PDF, technical PDF, BA forms, and provider documentation.
- Confirmed that many concrete dates are genuinely documented, while identifying several overstatements and source-quality problems.

Failures and how to do differently:

- `Anwesenheitsplanung` is not present as an event in the current `emaw-v2.18.xsd`; treat the provider-documented feature as unconfirmed, not as a BA message requirement.
- The report's claim of a “complete operational message view” is too strong. AGH has additional events including participant/contact changes, participation extension, JC-initiated early exit, multiple rejection events, legacy/new billing events, and other AGH-specific messages.
- The report incorrectly generalizes regular AGH exit handling: the current AGH process indicates that a regular AGH exit does not require a provider-sent eM@w exit message.
- The report states AGH reports may only be sent after a gE request, but the current technical documentation says the request may be omitted when the provider sends a report proactively. Treat this as an internal BA-document conflict and clarify it in the BA meeting; do not hard-code an absolute fail-closed rule.
- Weekly absence timing should be expressed as “send by Sunday so the AA has it Monday,” not as a Monday provider send deadline. It is also not required for all measure types.
- Monthly attendance is collected daily in Novari but transmitted as a monthly report, generally by the 9th so it is available to the AA by the 10th; it must also be sent promptly on participant exit. AsA-flex has an official exception where monthly attendance can be omitted under the total-hours-contingent process but must remain available.
- AGH monthly billing dates are BA-primary: first request on the 1st, possible additional request on the 10th, reminder/check on the 15th, and possibly a second request on the 18th; provider billing is due by the 15th. The second request is optional (“if necessary”).
- The report's “not until the next measure” provider-change implication is too broad. It is valid for an existing EMAW measure undergoing an approved future-effective provider change, not proof that a manually handled running measure can be newly activated. AGH has an older public statement explicitly rejecting retroactive activation of already-started measures.
- The TypeScript examples are not suitable for this repository: Novari is a JavaScript backend. Preserve the architecture but implement it with JavaScript modules, runtime validation, original versioned XSDs, fixtures, and tests.
- Third-party provider documentation may be useful for operational clues but must not override newer BA primary documentation; internal citation handles such as `turn21search9` are not suitable as final technical references and should be replaced with stable URLs plus document/page/section references.

Reusable knowledge:

- Current BA source package layout: fachlich package contains process/LuV material; AGH package contains AGH process, agreements, and report forms; technical package contains the XSDs, acknowledgement XSD, agreements, schema documentation, and schema history.
- The current technical XSD contains event types such as `EintrittTyp`, `NichtantrittTyp`, `AnwesenheitMonatTyp`, `WochenFehlzeitTyp`, numerous `AGH*` types, and `AGH-Neu-*` billing types. Presence in the XSD does not itself establish permission or operational support for every measure.
- The BA fachlich process package gives product-specific LuV timing, including examples such as BvB, BaE, Reha, AsA-flex, THB, and others. LuV timing must therefore be configured per measure/product, not as a universal weekly/monthly rule.
- AGH measure reports use `AGHAnforderungMassnahmeberichtTyp` with `berichttyp` and optional `terminbis`; technical documentation explicitly states that the request need not occur if the provider submits a report independently.
- A safe future implementation model is a versioned rule/capability map plus an event journal/state machine, with triggers classified as domain event, calendar deadline, inbound request, or inbound response. This is a Novari design recommendation derived from the sources, not a BA-mandated architecture.

References:

- Report: `/Users/mrbubbles/Downloads/emaw/deep-research-report.md` (759 lines).
- Primary technical sources: `/Users/mrbubbles/Downloads/emaw/dok_ba035735.zip` -> `PRV_26.07.00_Technisches Infopaket_V2.pdf`, `emaw-v2.18.xsd`, `Anlage3_Dokumentation_emaw-v2.18.pdf`.
- Primary AGH sources: `/Users/mrbubbles/Downloads/emaw/dok_ba022355.zip` -> `Anlage 2_Fachlicher_Prozessablauf.pdf` (especially pages 17-22).
- Primary regular-process source: `/Users/mrbubbles/Downloads/emaw/dok_ba037285.zip` -> `Anlage 1 - Prozessablauf EMAW Trägersicht/260325_PRV_26.07.00_Juli.2026_Anlage_1-Prozessablauf_EMAW_Trägersicht.pdf`.
- Key verified snippets: `Anlage 2_Fachlicher_Prozessablauf.pdf` says AGH billing requests occur on the 1st, 10th, 15th, and possibly 18th, with provider billing due by the 15th; technical schema documentation page 55 says AGH report requests need not occur if the provider sends the report independently; regular process pages state monthly attendance by the 9th and weekly absences by Sunday.
