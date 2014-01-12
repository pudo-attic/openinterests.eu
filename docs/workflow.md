
## Import/Update workflow

Bulk import

1. Data is stored in a graph package by the extraction/transformation process
2. The graph importer will use the ``identifier`` given in the graph
   package config to search for existing nodes/entities.
3. If no entity is found, one will be created and all attributes are
   set.
4. If an entity exists, non-existing attributes will be set, others
   updated.


## Canonicalization

1. The core engine will export a CSV file containing a list of names,
   identifiers and aliases. 
2. [external foo]
3. The core engine imports the same type of list, merging entities where
   a new canonical form has been defined. Merges are treated as updates,
   except that exisiting attributes are kept unmodified.


