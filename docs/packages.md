
## Graph Bulk Import Packages

We want to separate the data extraction stages for the various data
sources from the actual backend. Since loading data via an API can be
very slow and writing bespoke data loaders for each data source is a bit
insane, a flat-file based interface seems like a reasonable compromise.

While there are a number of file formats for graph storage, they usually
condense all data into a single file. Given the size of some of our
source datasets, that approach may be impractical. We will have to go
for a folder of files instead.

See also: NetworkX [JSON Graph](http://goo.gl/KNZcvo), also GEXF, GraphML.

Basic format:

    /eu_reginterests
      graph.yaml
      edges/
        0001.yaml
        0002.yaml
        [...]
      nodes/
