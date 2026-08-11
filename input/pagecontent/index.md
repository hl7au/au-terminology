# HL7 AU Terminology Implementation Guide

<div class="stu-note" markdown="1">

**Draft — first cut, for HL7 AU Terminology Work Group discussion.**

This is not a published implementation guide. No canonical URL defined here is
registered, the profiles have not been balloted, and every design choice on
these pages is open for Work Group decision. See
[Open questions](open-questions.html).

</div>

## Purpose

The HL7 AU Terminology Work Group's implementation guide project has, among its
aims, *"process and governance guidance for terminology resources."* This
repository holds the first concrete step towards that: candidate profiles for
the terminology resource types HL7 Australia authors, together with the analysis
behind them.

Two questions drive the work:

1. **How should HL7 AU profile FHIR `ValueSet` and `CodeSystem`?**
2. **How should we track stewardship** — who a resource came from, and who
   approves, is consulted, or is informed when its content changes?

## Scope

Deliberately bounded:

- **FHIR R4.**
- **`ValueSet` and `CodeSystem` only.** `ConceptMap` and `NamingSystem` are not
  yet in scope.
- **AU-authored terminology.** The reference terminologies — SNOMED CT-AU,
  LOINC — are *referenced* by AU resources, never republished by them, so they
  are out of scope.

## What is here

| Profile | Id | Covers |
|---|---|---|
| [AU ValueSet](StructureDefinition-au-valueset.html) | `au-valueset` | all AU-authored value sets |
| [AU CodeSystem](StructureDefinition-au-codesystem.html) | `au-codesystem` | AU-authored code systems (`content = complete`) |

Both encode the **common-ground floor only** — the metadata and structure that
current AU practice already follows universally (see
[Background and evidence](background.html)). No governance metadata is included
yet; the shapes it would take are set out in
[Design decisions](design.html) and left as commented blocks in the FSH source.

Every constraint was measured against the published packages — **AU Base 6.0.0**,
**AU Core 2.0.0**, **AU eRequesting 1.0.0** — before being written, and the
generated profiles were then checked back against those same resources:
**all 47 AU-authored resources conform** (30/30 value sets, 17/17 code systems).
That is a targeted check of the differential constraints — cardinality, fixed
values, the jurisdiction pattern — not a full FHIR validation.

## Contents

- [Background and evidence](background.html) — what was surveyed, how AU
  practice actually looks, and the element-level measurements.
- [Design decisions](design.html) — profile shape, governance metadata, and the
  option spectrum.
- [Stewardship](stewardship.html) — the proposed model for tracking who owns,
  approves, is consulted about, and is informed of changes.
- [Open questions](open-questions.html) — the decisions requested of the Work
  Group.

## Feedback

Comments are welcome via the HL7 AU Terminology Work Group, or as issues on
[the repository](https://github.com/jimsteel/hl7-au-terminology-ig).
