<div class="stu-note" markdown="1">

This profile is a **first cut for HL7 AU Terminology Work Group discussion**. It encodes only the metadata and structure that current AU value sets already follow (Option 1, "bless current practice"). Its parent is base R4 `ValueSet`, not the NCTS Composed Value Set profile. Whether to align to NCTS or CRMI, and whether to add governance metadata, are open Work Group decisions.

</div><!-- stu-note -->

### Usage Scenarios

The following are supported usage scenarios for this profile:

- Author a new value set for publication by HL7 Australia
- Check an existing HL7 Australia value set against the common AU metadata floor, for example as part of implementation guide QA
- Understand which metadata a consumer can rely on being present in any HL7 Australia value set

### Profile Specific Implementation Guidance

- This profile applies to value sets **authored by HL7 Australia**. Value sets published by other bodies, such as the NCTS or HL7 International (THO), are governed by their publishers and are out of scope.
- Whether the value sets in an existing HL7 Australia implementation guide declare conformance to this profile is a decision for the work group that owns that guide.
- HL7 Australia value sets are **definition-only**:
  - `ValueSet.compose` **SHALL** be populated
  - `ValueSet.expansion` **SHALL NOT** be populated; systems obtain an expansion at the time of use from a terminology server, e.g. using the [`$expand`](http://hl7.org/fhir/R4/valueset-operation-expand.html) operation
- Reference terminologies such as SNOMED CT-AU and LOINC are included by reference in `ValueSet.compose.include.system`; their content is never republished as part of an HL7 Australia value set.
- `ValueSet.url` **SHOULD** be in the HL7 Australia namespace `http://terminology.hl7.org.au/ValueSet/`, which all current HL7 Australia value sets use. The final path segment need not match the resource id.
- `ValueSet.identifier:oid` **SHALL** carry the value set's OID, conforming to [AU OID Identifier](StructureDefinition-au-oid-identifier.html): `system` = `urn:ietf:rfc:3986` and `value` = `urn:oid:[OID]`. Other business identifiers **MAY** also be included.
- `ValueSet.status` is not fixed. A value set that is no longer recommended for use **MAY** be published as `retired`.
- `ValueSet.publisher` is fixed to "HL7 Australia" and `ValueSet.experimental` to `false`. `ValueSet.jurisdiction` **SHALL** include Australia (`urn:iso:std:iso:3166#AU`).
- `ValueSet.immutable`, `ValueSet.useContext`, `ValueSet.purpose`, `ValueSet.compose.lockedDate` and `ValueSet.compose.inactive` **MAY** be populated, but no current HL7 Australia value set uses them.

<div class="stu-note" markdown="1">

Governance and lifecycle metadata, such as `versionAlgorithm`, `approvalDate`, `lastReviewDate` and `effectivePeriod`, and an AU stewardship extension are under consideration and are not part of this profile.

</div><!-- stu-note -->
