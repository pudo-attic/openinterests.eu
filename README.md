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

### Dependencies

OpenInterests requires a working installation of [monnet](http://github.com/pudo/monnet) to be able to load the data extracted by those scrapers. Both
packages need to be installed in the same namespace, and environment variables should be shared.

### Installation and Usage

TODO: Dependencies aren't documented at this stage. 

For usage information, please check the ``Makefile`` - it holds commands to perform most of the tasks currently supported by this repository.

### Get involved

OpenInterests is an open source project, developed without commercial intent or funding. If you want to help, we'd love to see your pull requests.

An important aspect of the project is the underlying data. While it is presented in one way on the site, many other interpretations are possible. If you want to play with the data, please check out [the data store](http://opendatalabs.org/eu) for dumps and partial excerpts in machine-readable form.

