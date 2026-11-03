// =============================================================================
// AU ValueSet — FIRST CUT for Terminology Work Group discussion
//
// Scope: the "common ground" floor only — Option 1, "bless current practice".
// The evidence and options are in the Terminology WG's analysis (Confluence).
// Every constraint below was measured against all 30 AU-authored ValueSets in
// AU Base 6.0.0 / AU Core 2.0.0 / AU eRequesting 1.0.0 on 2026-07-27 and holds
// 30/30 — so this profile breaks no existing AU resource.
//
// Parent is base R4, NOT the NCTS Composed Value Set profile. Alignment is an
// open WG decision (see the WG analysis, cross-cutting decisions), so the first
// cut stays neutral and
// restates the constraints rather than inheriting them. Switching to
// NCTS-derived is a one-line Parent: change plus dropping the restatements.
//
// Governance metadata (Options 2 and 3) is deliberately absent — see the
// commented block at the foot of this file for the shape it would take.
// =============================================================================

Profile:     AUValueSet
Parent:      ValueSet
Id:          au-valueset
Title:       "AU ValueSet"
Description: """
Constraints common to all value sets authored by HL7 Australia. Captures the
metadata floor and the definition-only structure that current AU practice
already follows universally. FIRST CUT — for Work Group discussion.
"""

* ^status = #draft
* ^experimental = false

// -----------------------------------------------------------------------------
// Identity
// -----------------------------------------------------------------------------
* url 1..1
  // Business identifier: a single OID, as an RFC 3986 URI. Matches NCTS.
  // A second, non-OID identifier would need this relaxed to 1..* and sliced.
* identifier 1..1
* identifier.system 1..1
* identifier.system = "urn:ietf:rfc:3986" (exactly)
* identifier.value 1..1
* identifier.value ^comment = "The value set's OID, expressed as a URI (urn:oid:...)."
* version 1..1
* name 1..1
* title 1..1
  // status is mandatory in base R4 and is NOT pinned here: AU Base already
  // publishes one retired value set, so fixing #active would break it.
* status 1..1
* status ^comment = "Not fixed. A value set that is no longer recommended for use may be published as retired."

// -----------------------------------------------------------------------------
// Publication metadata
// -----------------------------------------------------------------------------
* experimental 1..1
* experimental = false (exactly)
* publisher 1..1
* publisher = "HL7 Australia" (exactly)
* description 1..1
* date 1..1
  // 23 of 30 carry one contact, 7 carry two — so 1..*, not 1..1.
* contact 1..*
* contact ^comment = "At least one contact is required; more than one is permitted."
  // Pattern, not fixed: additional jurisdiction codings stay legal.
* jurisdiction 1..1
* jurisdiction = urn:iso:std:iso:3166#AU
* jurisdiction ^comment = "Must include Australia (urn:iso:std:iso:3166#AU). Additional jurisdiction codings are permitted."
* copyright 1..1

// -----------------------------------------------------------------------------
// Structure — definition-only
// -----------------------------------------------------------------------------
  // AU value sets are a definition; the terminology server expands at use time.
  // Verified: compose present 30/30, expansion present 0/30.
* compose 1..1
* expansion 0..0
* expansion ^comment = "HL7 Australia value sets are definition-only. Obtain an expansion at the time of use from a terminology server, e.g. using $expand."

// -----------------------------------------------------------------------------
// NOT constrained here, and why
// -----------------------------------------------------------------------------
// immutable, useContext, purpose, compose.lockedDate, compose.inactive
//   — available in R4, unused across all 30 AU value sets today.
//
// -----------------------------------------------------------------------------
// Option 2 (lightweight) would add:
//   * extension contains
//       http://hl7.org/fhir/StructureDefinition/artifact-versionAlgorithm named versionAlgorithm 0..1
//
// Option 3 (fuller governance) would add, on top of Option 2:
//   * extension contains
//       http://hl7.org/fhir/StructureDefinition/valueset-approvalDate    named approvalDate    0..1 and
//       http://hl7.org/fhir/StructureDefinition/valueset-lastReviewDate  named lastReviewDate  0..1 and
//       http://hl7.org/fhir/StructureDefinition/valueset-effectivePeriod named effectivePeriod 0..1
//   plus author / reviewer for provenance. Only meaningful once a WG review
//   process backs them — they stay optional until then.
//
// The AU stewardship extension (role x party) is NOT here: it does not exist
// yet, and depends on two new AU code systems (AU Work Group, stewardship-role).
// -----------------------------------------------------------------------------
