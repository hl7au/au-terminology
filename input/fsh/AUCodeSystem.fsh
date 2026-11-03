// =============================================================================
// AU CodeSystem — FIRST CUT for Terminology Work Group discussion
//
// Scope: the "common ground" floor only — Option 1, "bless current practice".
// The evidence and options are in the Terminology WG's analysis (Confluence).
// Every constraint below was measured against all 17 AU-authored CodeSystems in
// AU Base 6.0.0 / AU Core 2.0.0 / AU eRequesting 1.0.0 on 2026-07-27 and holds
// 17/17. Exception since the OID slice was added: AU Base resource-tag has the
// invalid OID urn:oid:22.16.840... (likely a typo for 2.16...), so 16/17 conform.
//
// Parent is base R4, NOT the NCTS Complete Code System profile — same reasoning
// as AUValueSet.fsh.
//
// IMPORTANT: this profile covers AU-AUTHORED code systems only. It fixes
// content = #complete, so it deliberately cannot apply to the two external
// system stubs in AU Base (mims-external, pbs-item-external), which are
// content = #not-present and today claim no profile at all. Covering those
// needs a SECOND, SIBLING profile — see the note at the foot of this file.
// This is the one place the "single profile per resource" recommendation does
// not stretch — see the WG analysis.
// =============================================================================

Profile:     AUCodeSystem
Parent:      CodeSystem
Id:          au-codesystem
Title:       "AU CodeSystem"
Description: """
Constraints common to all code systems authored by HL7 Australia. Captures the
metadata floor and the complete, fully-enumerated content that current AU
practice already follows universally. Does not cover external-system stubs
(content = not-present). FIRST CUT — for Work Group discussion.
"""

* ^status = #draft
* ^experimental = false

// -----------------------------------------------------------------------------
// Identity
// -----------------------------------------------------------------------------
* url 1..1
  // Business identifiers: an open slice, by profile, requires the OID (see
  // AUOIDIdentifier.fsh). Other identifiers are permitted, including other
  // urn:ietf:rfc:3986 URIs, which do not match the OID profile.
  // Measured: all 47 existing AU resources carry exactly one identifier, a urn:oid;
  // 46/47 are valid OIDs (AU Base resource-tag has urn:oid:22.16..., a likely typo).
* identifier 1..*
* identifier ^slicing.discriminator.type = #profile
* identifier ^slicing.discriminator.path = "$this"
* identifier ^slicing.rules = #open
* identifier ^slicing.description = "Slice for the code system's OID. Other identifiers are permitted."
* identifier contains oid 1..1
* identifier[oid] only AUOIDIdentifier
* identifier[oid] ^short = "The code system's OID"
* version 1..1
* name 1..1
* title 1..1
  // All 17 are #active today; not pinned, to match AUValueSet and leave
  // retirement available without a profile change.
* status 1..1
* status ^comment = "Not fixed. A code system that is no longer recommended for use may be published as retired."

// -----------------------------------------------------------------------------
// Publication metadata
// -----------------------------------------------------------------------------
* experimental 1..1
* experimental = false (exactly)
* publisher 1..1
* publisher = "HL7 Australia" (exactly)
* description 1..1
* date 1..1
* contact 1..*
* contact ^comment = "At least one contact is required; more than one is permitted."
* jurisdiction 1..1
* jurisdiction = urn:iso:std:iso:3166#AU
* jurisdiction ^comment = "Must include Australia (urn:iso:std:iso:3166#AU). Additional jurisdiction codings are permitted."
* copyright 1..1

// -----------------------------------------------------------------------------
// Content — complete and fully enumerated
// -----------------------------------------------------------------------------
* caseSensitive 1..1
* content 1..1
* content = #complete (exactly)
  // count is the TOTAL number of concepts, including nested ones.
* count 1..1
* count ^comment = "The total number of concepts in the code system, including nested concepts."
* concept 1..*

// -----------------------------------------------------------------------------
// Deliberately left OPEN — Work Group decisions
// -----------------------------------------------------------------------------
  // OPEN (WG open question): mandate the "all codes" value set pointer?
  // Measured today: populated 15/17, but only 3/17 point at a ValueSet that is
  // actually published. Mandating 1..1 would be satisfied by 15/17 as-is, but
  // would NOT fix the 12 dangling URLs — no profile can require that a
  // canonical URL resolves. That is an IG QA rule, not a profile constraint.
  // Left at base cardinality pending the WG decision.
* valueSet 0..1
* valueSet ^comment = "Whether this element should be mandatory, and whether it should be required to refer to a published value set, are open Work Group questions."

  // SHOULD be populated (guidance, not cardinality): mandating it would fail
  // 14/17 existing code systems. Declaring is-a without nested concepts is
  // legitimate — the element describes the code system's hierarchy semantics,
  // not whether this instance enumerates nesting. Measured: 3/17 populated, all #is-a.
* hierarchyMeaning 0..1
* hierarchyMeaning ^comment = "Should be populated, including for code systems with no nested concepts. Declaring is-a makes is-a and descendent-of filters well-defined."

// -----------------------------------------------------------------------------
// NOT constrained here, and why
// -----------------------------------------------------------------------------
// useContext, purpose, supplements, filter, property
//   — available in R4, unused across all 17 AU code systems today.
// versionNeeded, compositional
//   — false on all 17, but that is the meaningful default; not worth pinning.
//
// -----------------------------------------------------------------------------
// The sibling profile this one cannot absorb:
//
//   Profile: AUExternalCodeSystem
//   Parent:  CodeSystem
//   * content = #not-present (exactly)
//   * concept 0..0
//   * count   0..0
//   ... same publication floor, but url is the EXTERNAL system's namespace
//       (e.g. http://www.mims.com.au/codes), not terminology.hl7.org.au
//
// Not drafted here: whether to profile the stub pattern at all — and who
// should declare these resources (HL7 AU, ADHA, or THO) — is an open question.
//
// Option 2 / Option 3 governance extensions: see the foot of AUValueSet.fsh.
// -----------------------------------------------------------------------------

