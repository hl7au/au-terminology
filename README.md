# HL7 AU Terminology Implementation Guide

**Status: draft — first cut, for HL7 AU Terminology Work Group discussion.**
This is **not** a published implementation guide. No canonical URL defined here
is registered, and nothing has been balloted.

Candidate profiles for the FHIR terminology resource types HL7 Australia
authors, together with the analysis behind them.

| Profile | Id | Covers |
|---|---|---|
| `AUValueSet` | `au-valueset` | all AU-authored value sets |
| `AUCodeSystem` | `au-codesystem` | AU-authored code systems (`content = complete`) |

Both encode the **common-ground floor only** — the metadata and structure that
current AU practice already follows universally. No governance metadata is
included yet; the shapes it would take are commented blocks at the foot of the
FSH files, and are written up in `input/pagecontent/design.md`.

Every constraint was measured against the published packages — **AU Base 6.0.0**,
**AU Core 2.0.0**, **AU eRequesting 1.0.0** — before being written, and the
generated profiles were then checked back against those same resources: all 47
AU-authored resources conform (30/30 value sets, 17/17 code systems). That is a
targeted check of the differential constraints, not a full FHIR validation.

## Contents

```
input/fsh/            the profiles, in FHIR Shorthand
input/pagecontent/    narrative pages
sushi-config.yaml     IG configuration
ig.ini                IG Publisher configuration
```

Narrative pages:

- `index.md` — overview, scope, what's here
- `background.md` — what was surveyed, how AU practice looks, element-level measurements
- `design.md` — profile shape, governance metadata, the option spectrum
- `stewardship.md` — proposed model for tracking owner / approver / consulted / informed
- `open-questions.md` — decisions requested of the Work Group

## Build

Generate the resources with [SUSHI](https://fshschool.org/docs/sushi/):

```
sushi build .
```

Build the full IG with the [HL7 IG Publisher](https://github.com/HL7/fhir-ig-publisher):

```
./_build.sh          # or _build.bat on Windows
```

## Feedback

Via the HL7 AU Terminology Work Group, or as issues on this repository.

## Licence

Content is licensed CC0-1.0.
