
### Performance evaluation

The performance evaluation is only centered on CPU performances, we evaluate different navigation through 6 scenarios :
- SingletonGraphSosa : Only one URI to query using sosa OWL vocabulary and a custom virtual MonoNode graph
- SingletonGraph : Only one URI to query using a custom OWL vocabulary and a custom virtual MonoNode graph (both small and big ontologies)
- SimulatedGraph : Multiple URIs to query using a custom  OWL vocabulary and a custom virtual balanced "poor" graph (both small and big ontologies)
- SimulatedRichGraph : Multiple URIs to query using a custom  OWL vocabulary and a custom virtual balanced "rich" graph (both small and big ontologies)
- WikidataGraph : Multiple URIs to query using a custom  OWL vocabulary and the wikidata Knowledge Graph
- reasoners : Same as SimulatedRichGraph but using different OWL reasoners for comparison

We use Apache Jena Fuseki to host our virtual graphs, and we generate them with JavaCode. To obtain the same graph, you should refer to [this project](https://gitlab.emse.fr/isi/internships/master-saffaf/-/tree/master/hypermedia_ldfu_Noe) which contains a graph generator project which also include exporting to Apache Jena Fuseki