<div class="stu-note" markdown="1">

This profile is a **first cut for HL7 AU Terminology Work Group discussion**. It encodes only the metadata and structure that current AU code systems already follow (Option 1, "bless current practice"). Its parent is base R4 `CodeSystem`, not the NCTS Complete Code System profile. Whether to align to NCTS or CRMI, and whether to add governance metadata, are open Work Group decisions.

</div><!-- stu-note -->

### Usage Scenarios

The following are supported usage scenarios for this profile:

- Author a new code system for publication by HL7 Australia
- Check an existing HL7 Australia code system against the common AU metadata floor, for example as part of implementation guide QA
- Understand which metadata and content a consumer can rely on being present in any HL7 Australia code system

### Profile Specific Implementation Guidance

- This profile applies to code systems **authored by HL7 Australia**, whose concepts are fully enumerated in the resource (`CodeSystem.content` = `complete`).
- Whether the code systems in an existing HL7 Australia implementation guide declare conformance to this profile is a decision for the work group that owns that guide.
- This profile does **not** apply to a CodeSystem resource that only declares an external code system without its content (`CodeSystem.content` = `not-present`), such as the MIMS and PBS item code system resources in AU Base. Such resources cannot conform to this profile.
- Every concept **SHALL** be included in `CodeSystem.concept`, and `CodeSystem.count` **SHALL** give the total number of concepts, including nested concepts.
- `CodeSystem.url` **SHOULD** be in the HL7 Australia namespace `http://terminology.hl7.org.au/CodeSystem/`, which all current HL7 Australia code systems use. The final path segment need not match the resource id.
- A code system carries exactly one business identifier, its OID, in `CodeSystem.identifier`.
- `CodeSystem.status` is not fixed. A code system that is no longer recommended for use **MAY** be published as `retired`.
- `CodeSystem.publisher` is fixed to "HL7 Australia" and `CodeSystem.experimental` to `false`. `CodeSystem.jurisdiction` **SHALL** include Australia (`urn:iso:std:iso:3166#AU`).
- `CodeSystem.valueSet`, the "all codes" value set, **MAY** be populated.
- `CodeSystem.caseSensitive` **SHALL** be populated.
- `CodeSystem.hierarchyMeaning` **SHOULD** be populated. It describes the meaning of the code system's hierarchy, and should be declared even when the code system has no nested concepts: declaring `is-a` makes `is-a` and `descendent-of` filters on the code system well-defined. All current HL7 Australia code systems that populate it use `is-a`.
- `CodeSystem.useContext`, `CodeSystem.purpose`, `CodeSystem.supplements`, `CodeSystem.filter` and `CodeSystem.property` **MAY** be populated, but no current HL7 Australia code system uses them.

<div class="stu-note" markdown="1">

Whether `CodeSystem.valueSet` should be mandatory, and whether it should be required to refer to an explicit, published "all codes" value set, is an open Work Group question. Most current HL7 Australia code systems populate it, but most of the URLs it carries do not resolve to a published value set, and a profile cannot require that a canonical URL resolves. So is whether external code system declarations (`content` = `not-present`) should get a profile of their own.

Governance and lifecycle metadata, and an AU stewardship extension, are under consideration and are not part of this profile.

</div><!-- stu-note -->
