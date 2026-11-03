Decisions requested of the HL7 AU Terminology Work Group. The profiles in this
guide are a first cut written to be neutral on every one of these; each is
reversible.

### 1. All-codes value sets

Should the profile mandate `CodeSystem.valueSet`? And should a **published,
explicit** all-codes ValueSet be required, or is the **implicit** one
acceptable?

Mandating the element would be satisfied by 15 of 17 existing code systems as
they stand, but would not fix the 12 dangling URLs — no profile can require that
a canonical URL resolves. See
[Background and evidence](background.html#element-level-conformance).

### 2. External-system code systems

Should the `content = not-present` stub pattern be profiled via a second,
sibling CodeSystem profile, or left unprofiled? And who should declare these
resources — HL7 Australia, ADHA, or THO?

Note that one of the two existing stubs carries no `identifier` at all, so a
sibling profile could not mandate the full metadata floor without that resource
being remediated first. See [Design decisions](design.html#profile-shape--one-profile-or-layered).

### 3. Profile shape

Bless current practice, lightweight, or fuller governance? See
[the option spectrum](design.html#the-option-spectrum). The first cut implements
the first of these.

### 4. One profile or layered

A single profile per resource type (recommended) or CRMI-style tiers?

### 5. Alignment

Work Group-authored standalone profiles, CRMI-aligned, or adopt the NCTS R4
profiles directly?

### 6. Stewardship

Should the RACI be represented in the resource, and is the extension approach in
[Stewardship](stewardship.html) the right one?

### 7. NCTS `-4` reconciliation

Confirm what the R4 (`-4`) NCTS profiles actually constrain. AU IGs cite them,
but only the STU3 (`-2`) versions were retrievable from the live service.

---

`hierarchyMeaning` is deliberately **not** on this list. The current steer is
that it stays optional; the reasoning is in
[Background and evidence](background.html#hierarchymeaning--occasional-and-legitimately-so).
