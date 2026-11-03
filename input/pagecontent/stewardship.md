### The need

A shared terminology guide hosts content **owned by different work groups**.
Governing that content — adding and removing codes, changing metadata, even
retiring a resource — requires knowing **who the stakeholders are**.

For each resource, four things are worth tracking persistently:

- **owner** — where the resource came from
- **approver** — who must agree to a change
- **consulted** — who must be asked
- **informed** — who must be told

That is a RACI, attached to the resource.

### Prior art, and its limits

HL7's own Terminology (THO) publication embeds **only the owning work group** in
the resource, via the `structuredefinition-wg` extension. Approve, consult and
inform live entirely in the surrounding **UTG process** — proposals, pull
requests and Jira, TSMG review — not as data on the resource.

Two limits for HL7 Australia:

1. It points at **HL7 International** work groups.
2. It tracks **owners only**.

Current AU Base resources carry neither the work group tag nor any governance
metadata.

### The proposal — represent it in the resource

One **AU stewardship extension**, repeating, carrying a **role × party** pair:

- **`role`** — `owner` / `approver` / `consulted` / `informed`, drawn from a
  `stewardship-role` code system.
- **`party`** — an **HL7 AU Work Group**, drawn from an AU work-group code
  system, or an external body such as ADHA, RCPA or Services Australia.

This goes beyond the THO approach on both axes — AU work groups rather than
international ones, and a full RACI rather than owners only. Being carried with
the resource, it is versioned with it and can be shown on its page.

**Worked example** (illustrative — no stewardship data exists yet). A work group
wants to add a code to a value set in AU Base. The resource's stewardship says:
owner and approver are the originating work group; consulted is any work group
whose IG binds that value set; informed is ADHA and implementers. The change
request routes itself, and nothing lands by surprise.

### What it needs

- **A new AU extension.** HL7's `structuredefinition-wg` cannot be reused: it
  binds the international work-group list as a **required** binding, so AU codes
  are not legal in it.
- **Two small AU code systems** as prerequisites — an **HL7 AU Work Group** code
  system and a **stewardship-role** code system. Both are themselves AU
  terminology, authored with the very profiles in this guide.

### Alternatives considered

- **An external stewardship registry** — queryable, but drifts from the
  resources it describes.
- **A hybrid** — owner in the resource, the rest in a registry.
- **THO-style owner-only** — simplest, but does not carry the approve, consult
  or inform axes that make change requests route themselves.

In-resource representation is the recommended approach, but the choice is open.
