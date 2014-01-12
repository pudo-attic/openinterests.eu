## OpenInterests

The intent of this project is to create a simplified, searchable
presentation of actors and relationships involved in EU politics and
institutions. In particular, the database will include: 

* Information from the register of interests (lobby register)
* Personnel information from the register of EP accredditations
* Expense information from the EC's financial transparency system
* Potentially: contract awards made by EU institutions


As a secondary objective, the site's software will be built to be 
re-usable as a data graph storage.

### User Stories

* As a researcher, I want to find details on a particular org/person so
  I understand what activities they are involved in. 
* As a researcher, I want to see all orgs/ppl involved in a particular
  sector or policy area so that I can understand what position there
  are.
* As a journalist, I want to quickly look up which companies are funding
  a think tank or policy forum.
* As a journalist, I want to find overlap between EC lobbying, expert
  groups, expenditures and procurement.
* As a researcher, I want to contribute data on an org or link to a news
  story.

### Implementation Options

* re-use detective.io
* fork nomenklatura, add relations
* bespoke DB schema, render directly

### What operations do I need?

User-facing:

* Rendering an entity page with core attributes and a grouped list of
  relations.
* Full-text search with facets. Show an appropriate preview for each
  entity.
* Tracking of entities or keywords with email alerts.
* Suggest edits with source.

Admin-facing:

* Fast import format for updated bulk loads.
* Approval queue for user-suggested edits. 
* Import and export of canonicalization lists.

