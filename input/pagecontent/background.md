The profiles in this guide were not designed from first principles. They
formalise what HL7 Australia already publishes, so this page sets out what was
surveyed, what AU practice actually looks like, and where it is and is not
consistent.

### What was surveyed

Four inputs, all read from primary sources — live profile JSON and published IG
resources:

- **NCTS profiles** — the profiles AU IGs claim today.
- **HL7 R4 core `ShareableValueSet` / `ShareableCodeSystem`** — the FHIR minimum.
- **CRMI** (Canonical Resource Management Infrastructure) — HL7's layered,
  governance-rich model.
- **Current AU practice** — what AU Base, AU Core and AU eRequesting actually
  publish.

#### Landscape at a glance

| Dimension | NCTS | R4 core `Shareable*` | CRMI | AU IGs today |
|---|---|---|---|---|
| FHIR version | STU3 (live `-2`); AU cites `-4` | R4, normative | R4, STU / ci-build (non-normative) | R4 |
| Layering | role pair (composed vs expanded) | none | capability lattice (shareable / computable / publishable / executable) | uses NCTS composed / complete |
| Mandatory identity | url, version, name, experimental, date, publisher, description, copyright, identifier `1..1` (system fixed), compose/content | url, version, name, status, experimental, publisher, description | (shareable) url, version, title, experimental, description | populated by house style |
| Must-support | none | none | extensive | n/a |
| Governance metadata | none | none | large standardised suite | none |
| ValueSet definition vs expansion | split; composed **forbids** expansion | not addressed | computable (definition) + expanded (snapshot) | definition-only (`compose`) |
| CodeSystem content | `complete` only (fixed); no fragment profile | ≥1 inline concept | shareable + publishable only | complete + inline, plus `not-present` stubs |
| `jurisdiction = AU` | not constrained | not constrained | must-support (publishable) | always AU (house style) |

#### Key findings

- **AU practice is already NCTS-shaped and consistent.** Every AU-authored
  value set and code system in AU Base and AU eRequesting claims an NCTS profile
  — `composed-value-set-4` / `complete-code-system-4` — under the
  `terminology.hl7.org.au` namespace, with a uniform house style:
  `publisher = HL7 Australia`, `jurisdiction = AU`, `experimental = false`, a
  business `identifier` (OID), and mandatory `copyright`. **AU Core authors no
  terminology of its own** — it is pure reuse of AU Base, THO, NCTS and FHIR
  core.
- **The one systematic gap is governance.** Neither the NCTS profiles nor
  current AU practice carries any lifecycle or governance metadata — approval
  date, review date, effective period, provenance, version algorithm. That block
  is exactly what CRMI standardises.
- **The NCTS profiles are simple** — pure cardinality and fixed values, with no
  must-support, extensions or invariants. Composed ValueSet is definition-only
  and forbids expansion; Complete CodeSystem fixes `content = complete` and so
  cannot represent SNOMED CT or LOINC, which is no obstacle here since AU does
  not republish them. One discrepancy remains to be reconciled: AU IGs cite the
  `-4` (R4) NCTS profiles, but only the STU3 `-2` versions are retrievable from
  the live service.
- **CRMI's layering is a capability lattice, not inheritance.** A resource
  *claims* `shareable` / `computable` / `publishable` / `executable` codes, gated
  by invariants, and can satisfy several at once. Its **Publishable** layer
  carries the full publication and governance metadata; its core — identifier,
  contact, jurisdiction, copyright, date, description — is what AU already
  populates.

### The common-ground floor

Formalising what AU already does needs no debate.

**Metadata expected by every family and populated across AU IGs:** `url`,
`version`, `name` / `title`, `status`, `experimental`, `publisher`,
`description`, `date`, `contact`; code systems also `caseSensitive`, `content`,
`count`.

**Metadata universal in AU by convention, but not in the Shareable or CRMI
minimum:** business `identifier` (OID), `jurisdiction = AU`, `copyright`. NCTS
does mandate identifier and copyright. AU also pins values:
`publisher = HL7 Australia`, `experimental = false`.

**Structure — settled:**

- **ValueSets are definition-only.** A `compose`, no stored expansion; the
  terminology server expands at use time. There is no `expanded`-style profile.
- **AU-authored CodeSystems are complete** — small, fully-enumerated content.
  SNOMED CT-AU and LOINC are referenced in `compose.include.system`, never
  published as CodeSystem resources.
- **The exception is external-system stubs.** AU Base carries two
  `content = not-present` code systems (`mims-external`, `pbs-item-external`)
  outside the `terminology.hl7.org.au` namespace. These are not AU-authored
  content and claim no profile at all today. Whether to profile the pattern is
  an open question.

This floor was verified as genuinely universal: all 47 AU-authored resources —
17 code systems and 30 value sets across the three IGs — populate every floor
element, with `publisher = HL7 Australia`, `experimental = false` and
jurisdiction AU holding in every case. Zero deviations.

### Element-level conformance

House style is uniform, but element-level conformance is not. Measured directly
from the published packages — AU Base 6.0.0, AU Core 2.0.0, AU eRequesting 1.0.0
— against the 17 AU-authored code systems.

#### `CodeSystem.valueSet` — near-universally populated, near-universally dangling

| | count |
|---|---|
| populated | 15/17 |
| …target ValueSet actually published | **3/17** |
| …target not published anywhere | **12/17** |
| absent | 2/17 |

The 12 were verified three ways: absent from all three packages; not expandable
on a terminology server (a deliberately bogus URL returns an identical error, so
this is a true negative); and `terminology.hl7.org.au` returns a soft-404 for
everything including a control URL, so the canonical redirect proves nothing
either way.

Two of the 12 are near-misses rather than phantoms —
`communication-request-category` and `task-business-status` do have an explicit
all-codes ValueSet, but eRequesting publishes it under its own URL rather than
the `terminology.hl7.org.au/ValueSet/<same-leaf>` the CodeSystem declares.

#### Explicit vs implicit all-codes ValueSet — implicit is the norm

An explicit all-codes ValueSet exists for 6 of 17; the implicit one is relied on
for 11 of 17. The two mechanisms agree in only 3 of 17 cases: 3 coherent; 10
declare `valueSet` with no all-codes ValueSet at all; 2 declare the wrong URL; 1
has an all-codes ValueSet but does not declare it; 1 has neither. Both
`not-present` external stubs do have explicit all-codes ValueSets and both omit
`CodeSystem.valueSet`.

#### `hierarchyMeaning` — occasional, and legitimately so

Populated on 3 of 17, all `is-a`. Exactly one code system has nested concepts
and declares it correctly; no code system expresses hierarchy via `parent` or
`child` properties. The other two declare `is-a` over flat enumerations, which
**is not an error**: the element describes the hierarchy semantics of the code
system, not whether this instance enumerates nesting, and declaring `is-a` makes
`is-a` and `descendent-of` filters well-defined.

The current steer is that it **should** be populated, but not mandated: it stays
at base R4 cardinality, so the 14 code systems that omit it today still
conform, and the profile guidance recommends it.

#### Consequences

- **Blessing current practice is not entirely cost-free.** There is no single
  consistent practice to bless: a profile mandating `valueSet` would fail 12 of
  17 existing resources at publication, so it would ratify the house style while
  implying a remediation backlog. The floor itself, though, is clean — the
  inconsistencies are all in elements *outside* it.
- **A profile cannot fix this on its own.** A StructureDefinition can require
  `CodeSystem.valueSet` to be present, but nothing in a profile can require that
  the URL it contains resolves. That is an IG **QA rule** — a concrete argument
  that the guide's process and governance remit needs publication checks as well
  as profiles.

### R4 elements available but unused

Base-R4 elements neither mandated nor commonly populated today, listed so a case
can be made for any of them:

- **ValueSet:** `useContext`, `purpose`, `immutable`, `compose.lockedDate`,
  `compose.inactive`.
- **CodeSystem:** `useContext`, `purpose`, `supplements`, `filter`, `property`,
  `hierarchyMeaning` (occasional today; now recommended, see above).

Lifecycle and provenance metadata is treated separately — see
[Design decisions](design.html).
