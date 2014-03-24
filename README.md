## OpenInterests

The intent of this project is to create a simplified, searchable
presentation of actors involved in EU politics and institutions and the relationships between them. In particular, the database will include: 

* Information from the register of interests (lobby register)
* Personnel information from the register of EP accredditations
* Expense information from the EC's financial transparency system
* Potentially: contract awards made by EU institutions

As a secondary objective, the site's software will be built to be 
re-usable as a data graph storage.

See
[DESIGN](https://github.com/pudo/openinterests.eu/blob/master/DESIGN.md)
for more information.

### Structure

This repository contains a set of sub-projects, in particular: 

* ``openinterests`` - the application front-end, i.e. HTML rendering logic.
* ``sources`` - extraction and parsing scripts for the various data sources, including:
    * ``sources/experts`` - EC/EP Register of Expert Groups, i.e. data about the structure and membership of EU advisory bodies on a variety of topics.
    * ``sources/fts`` - EC Financial Transparency System, i.e. direct expenditures of the European Commission. 
    * ``sources/interests`` - EC/ECP Register of Interests, i.e. the EU's lobby register (such as it is). Includes companies, think tanks and NGOs which lobby the Commission or Parliament. Includes EP accredditation data.
    * ``sources/ted`` - Tenders Electronic Daily, the EU's joint procurement system. This includes tenders and contract awards not just for EU bodies, but also the member states.
* ``data`` - has reference data, in particular with regards to the geographic units of the EU.
* ``docs`` - some documentation.

### Installation and Usage

TODO: Dependencies aren't documented at this stage. 

For usage information, please check the ``Makefile`` - it holds commands to perform most of the tasks currently supported by this repository.

### Get involved

OpenInterests is an open source project, developed without commercial intent or funding. If you want to help, we'd love to see your pull requests.

An important aspect of the project is the underlying data. While it is presented in one way on the site, many other interpretations are possible. If you want to play with the data, please check out [the data store](http://opendatalabs.org/eu) for dumps and partial excerpts in machine-readable form.

