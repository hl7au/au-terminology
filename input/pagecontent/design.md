The choices behind the first-cut profiles, and the alternatives that remain
live. Nothing here is settled; see [Open questions](open-questions.html).

### Profile shape — one profile or layered

**Single profile per resource type — recommended.** HL7 Australia publishes one
class of terminology resource. Any governance metadata can simply be *optional*
on that one profile. Layering — a separate profile per tier — only pays off with
two genuinely different resource populations, which AU does not have.

**Layered, CRMI-style — kept as a live option.** For AU the lower rungs
collapse: every AU value set already has a `compose`, so *shareable* and
*computable* coincide. Layering's only real payoff, a machine-checkable "is this
governed?" tier via profile validation, is speculative here.

**The one genuine exception is the external-system stubs.** A Complete Code
System profile fixes `content = complete`, so it *cannot* apply to the
`not-present` stubs — the two values are mutually exclusive. Covering them needs
a **second, sibling CodeSystem profile**, not a constraint on the first. This is
not CRMI-style layering; it is two profiles for two genuinely different resource
populations, and it is the only place the single-profile recommendation does not
stretch.

A sketch of that sibling profile is carried as a comment at the foot of
`AUCodeSystem.fsh`. Note that one of the two stubs carries no `identifier` at
all while the other does, so a sibling profile could not mandate the full
metadata floor without that resource being remediated first.

### Governance metadata

**CRMI Publishable is the right reference point** — its core is what AU already
populates. Its long extension list should be treated as a **pick-list to curate,
not a package to adopt**; most entries are CRMI machinery or authoring burden.

| Verdict | Extensions | Rationale |
|---|---|---|
| **Keep** (cheap, effectively process-free) | `versionAlgorithm` | flags a code add or remove as breaking vs cosmetic |
| **Consider** (only once a review process backs them) | `approvalDate`, `lastReviewDate`, `effectivePeriod`, `author` / `reviewer` | governance and provenance; meaningful only with process |
| **Avoid** | `knowledgeCapability` (lattice marker); `cqf-publicationStatus` / `publicationDate` / `artifactComment` (duplicate `status` / `date`); `topic`, `copyrightLabel`, `authoritativeSource`, `packageSource`, `editor`, `endorser`, `useContext`, `purpose`; `relatedArtifact` (supersession only — not our use case); ValueSet-only `otherTitle`, `sourceReference`, `compose-createdBy`, `expression`, `supplement`, `expansion-parameter`, `warning` | machinery, duplication, or authoring burden |

These are largely standard FHIR / Extensions-Pack extensions — AU Base already
depends on the Extensions Pack — so adopting the *concepts* needs no CRMI
dependency.

### The option spectrum

Governance depth on the single AU profile, all avoiding the "Avoid" extensions
above:

| Option | What the profile adds | Effort |
|---|---|---|
| **1 — Bless current practice** | Publishable's core metadata, already populated; no governance extensions | lowest — ratifies the status quo as WG-owned R4 profiles |
| **2 — Lightweight** | + `versionAlgorithm` | low |
| **3 — Fuller governance** | + `approvalDate` / `lastReviewDate` / `effectivePeriod`, plus provenance | higher — only meaningful with a WG review process |

**The profiles published here implement Option 1.** The Option 2 and Option 3
shapes are written as commented blocks at the foot of `AUValueSet.fsh`, ready to
uncomment if the Work Group chooses either. Any option could instead be layered.
Governance fields stay optional until there is a process to back them.

### Choices made in the first cut, and how to reverse them

**Parent is base R4, not the NCTS profiles.** Alignment is an open decision, so
the first cut stays neutral and restates the constraints rather than inheriting
them. Switching to NCTS-derived is a one-line `Parent:` change per profile plus
deleting the restated constraints.

**`status` is not pinned to `#active`.** AU Base already publishes one retired
value set, so fixing it would break an existing resource.

**`identifier` is `1..1`, matching NCTS.** All 47 resources carry exactly one
OID. A second, non-OID identifier would need `1..*` plus a slice.

**`contact` is `1..*`, not `1..1`.** 23 of 30 value sets carry one contact,
7 carry two.

**`CodeSystem.valueSet` and `hierarchyMeaning` are left at base cardinality.**
Whether to mandate `valueSet` is an open question. `hierarchyMeaning` **should**
be populated, but mandating it would fail 14 of 17 existing code systems, so the
recommendation is made in the profile guidance rather than by cardinality.

### Cross-cutting decisions

Independent of the option chosen:

- **Alignment and ownership** — Work Group-authored standalone profiles, align
  to CRMI, or adopt the NCTS R4 profiles directly?
- **NCTS `-4` reconciliation** — confirm what the R4 (`-4`) NCTS profiles
  actually constrain; only the STU3 (`-2`) versions were retrievable from the
  live service.
- **External-system stubs** — profile the pattern via a sibling profile or leave
  it unprofiled, and who should declare these resources.

### Not yet drafted

- The **AU stewardship extension** — see [Stewardship](stewardship.html). It
  depends on two new AU code systems, neither of which exists yet.
- Any **governance or lifecycle metadata**, pending the choice of option.
- **ConceptMap** and **NamingSystem**, which are out of scope for this analysis.
