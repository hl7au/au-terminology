// =============================================================================
// AU OID Identifier — FIRST CUT for Terminology Work Group discussion
//
// An Identifier carrying an OID as an RFC 3986 URI (urn:oid:...). Used as the
// slice profile for the required OID identifier in AU ValueSet and
// AU CodeSystem, which slice identifier by profile so that other identifiers,
// including other urn:ietf:rfc:3986 URIs such as urn:uuid, fall outside the
// slice instead of being mistaken for the OID.
//
// The value check follows the AU Base identifier profiles (e.g. AU IHI), which
// constrain the value format with an invariant on the Identifier.
// =============================================================================

Profile:     AUOIDIdentifier
Parent:      Identifier
Id:          au-oid-identifier
Title:       "AU OID Identifier"
Description: """
An identifier whose value is an ISO object identifier (OID), expressed as a URI
(urn:oid:...). FIRST CUT — for Work Group discussion.
"""

* ^status = #draft
* ^experimental = false
* obeys au-oid-identifier-0
* system 1..1
* system = "urn:ietf:rfc:3986" (exactly)
* value 1..1
* value ^short = "urn:oid:[OID]"
* value ^comment = "An OID expressed as a URI, e.g. urn:oid:1.2.36.1.2001.1004.201.10001."

Invariant:   au-oid-identifier-0
Description: "The value SHALL be an OID expressed as a URI (urn:oid:...)"
Expression:  "value.matches('^urn:oid:[0-2]([.](0|[1-9][0-9]*))+$')"
Severity:    #error
