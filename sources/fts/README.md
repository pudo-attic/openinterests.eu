
## European Commission Grants & Commitments Database (FTS)

This is documentation on the process required to generate a valid CSV form of 
the FTS that can be imported into OpenSpending or used for more detailed
analysis.

### Reconciliation: Places, Countries, Companies

Recon stages can be run like this:

    # Country codes:
    python countries.py 
    # Geo-coding:
    python geo.py 
    # Companies:
    python beneficiaries.py 

Companies reconciliation and geo-coding may potentially take a long time, so
depending on the purpose this may not make sense to reproduce.

### EU Budget Reference Data

The FTS refers to budget line items in the European budget. These can be used 
to add context to the transaction, by adding in EU budget classifications. 

Budget codes can be applied using the appropriate script:

    python budget_codes.py 2011-11-22.budget_codes.txt

This will also print any unknown budget code identifiers occuring in the source
data.

### Regenerating the budget reference data

The required scraper and tools for the EU budget live at: https://github.com/pudo/dpkg-eu-budget

Given that you have loaded the budget CSV into a SQLite database, run the 
following statements:

    CREATE TABLE fts_reference (name TEXT, label TEXT, description TEXT, 
        legal_basis TEXT)
    INSERT INTO fts_reference 
      SELECT DISTINCT title_name AS name, title_label AS label, 
        "" AS description, "" AS legal_baiss FROM budget WHERE volume_name = "Section 3"; 
    INSERT INTO fts_reference 
      SELECT DISTINCT chapter_name AS name, chapter_label 
      AS label, "" AS description, "" AS legal_baiss FROM budget 
      WHERE volume_name = "Section 3"; 
    INSERT INTO fts_reference 
      SELECT DISTINCT article_name AS name, article_label AS label, 
        article_description AS description, article_legal_basis AS legal_basis 
      FROM budget WHERE volume_name = "Section 3";·
    INSERT INTO fts_reference 
      SELECT DISTINCT item_name AS name, item_label AS label, 
        item_description AS description, item_legal_basis AS legal_basis 
      FROM budget WHERE volume_name = "Section 3";·

