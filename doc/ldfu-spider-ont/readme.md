# Linked Data-Fu Spider 
 
This project aims to create a Linked Data-Fu Spider CArtAgO artifact to support Linked Data navigation affordances for cross-plateform agents.
Available functionalities :
- Provides HTTP operations to the agent to generate RDF triples as Observable Properties, observed by agents and used to fire navigating rules within the agent layer
- Supports ontologies integration to collect derived predicates from collected ABox Data and registered TBox axioms from ontologies
- Supports reasoners to collect inferred predicates using OWL API 2 (HermiT, Pellet, JFact)
- Provides an operation to run LDFU engine (not suggested since it calls an external Linked Data navigation engine which is Linked Data-Fu and, therefore, do not delegate navigation to the agent, you should use HTTP CRUD Operations instead)

We suggest using a compatible MAS framework such Jason, or better [JaCaMo](http://jacamo.sourceforge.net/) to develop navigating agents.

### To Start

To familiarize oneself with Linked Data-Fu Spider, go to [/examples/ldfu-spider](/examples/ldfu-spider) build the project and run the `runLdfuSpider` task. Examples will be shown there with documentation.

### Instanciate the artifact

Initiate method :

**org.hypermedea.LinkedDataFuSpider(<OPTIONAL> String fileLDFUProgram, <OPTIONAL> Boolean inferred, <OPTIONAL> String reasoner)** : To initiate the LDFU-Spider artifact.
- **fileLDFUProgram** : A (local) n3 file's path containing a set of n3 rules to be provided to the Linked Data-Fu Engine for using the crawl operation. The current version doesn't allow to change the set of used rules, you will need to instantiate a new artifact if you desire to change n3 rules (but you shouldn't use crawl operation in the first place). Also, because of an issue in CArtAgO, you should provide a file, even empty, even if you do not plan to use the crawl operation.
- **inferred** : A boolean to specify if the OWL API should process inferred axioms using a reasoning (more resources-consuming)
- **reasoner** : The name of the reasoner the artifact should consider, currently there are three reasoners implemented which are `"Hermit"`,`"Pellet"`,`JFact`. By default if not provided, it uses `"Pellet"`.

### Main Operations (External actions of the ldfu-spider artifact)

The operations available in the Ldfu-spider artifact are follows :
- **register(String DocumentIRI)** : takes the passed OWL file (local path or URL) and registers all TBox vocabulary to the artifact. Also generates TBox observable properties (see below for examples)
- **unregister(String DocumentIRI)** : deindexes a registered OWL file and removes all observable properties resulted from it
- **get(String OriginURI, <OPTIONAL> OpFeedBackParam CodeStatus)** :  Performs a GET request and update the observable properties by adding RDF, derived and inferred observable properties, can also unify CodeStatus with the HTTP status code.
- **post(String OriginURI, Object[] payload, <OPTIONAL> OpFeedBackParam CodeStatus)** :  Performs a POST request with the payload as body and update the observable properties by adding RDF, derived and inferred observable properties, can also unify CodeStatus with the HTTP status code.
- **put(String OriginURI, Object[] payload, <OPTIONAL> OpFeedBackParam CodeStatus)** :  Performs a PUT request with the payload as body and update the observable properties by adding RDF, derived and inferred observable properties, can also unify CodeStatus with the HTTP status code.
- **delete(String OriginURI, Object[] payload, <OPTIONAL> OpFeedBackParam CodeStatus)** :  Performs a DELETE request with the payload as body and update the observable properties by adding RDF, derived and inferred observable properties, can also unify CodeStatus with the HTTP status code.
- **isSatisfiable(OpFeedbackParam<Boolean> Resp)** : Checks if the merged ontology is satisfiable (no unsatisfiable class). Unifies the response with a passed boolean.
- **isConsistent(OpFeedbackParam<Boolean> Resp)** : Checks if all ABox triples is consistent with the registered vocabulary (no inconsistent class assertion from unsatisfiable classes). Unifies the response with a passed boolean.
- **addObsPropertyBinding(Object[] payload)** : Adds custom triples in the artifact and generates its direct observable property as well as subsequent derived and inferred ones.
- **removeObsPropertyBinding(Object[] payload)** : Removes custom triples in the artifact and retract its direct observable property as well as subsequent derived and inferred ones.
- **removeAllObsPropertyBinding()** : Removes all ABox triples saved by the artifact (not ontologies) and their direct observable properties as well as subsequent derived and inferred ones. .


### Observable properties generation

##### TBox

For `register(pathTo/myOnto)` (TBox) :

OWL triples  | Type  | Observable property
------------- | ------------- | ------------- 
<ont:Sensor rdf:type owl:Class>   | Class declaration | **class(sensor)**[o_uri(ont:Sensor)]
<ont:System rdf:type owl:Class>   | Class declaration | **class(system)**[o_uri(ont:System)]
<ont:hosts  rdf:typeowl:ObjectProperty> | Property declaration | **objectProperty(hosts)**[p_uri(ont:hosts)] 
<ont:Sensor  rdfs:subClassOf ont:System> | Property expression | No observable property generated

##### ABox

For `get(URI)`,`post(URI)`,`put(URI)`,`delete(URI)`,`crawl(ENTRYPPOINT_URI)` (ABox) :

RDF triples  | Type  | Observable property
------------- | ------------- | ------------- 
<ex:MySensor  rdf:type ont:Sensor> | Default RDF conversion | **rdf(ex:MySensor,rdf:type,ont:Sensor)**
 _| Derived assertion axiom | **sensor(mySensor)**[s_uri(ont:Sensor),o_uri(ex:MySensor)]
 _| Inferred assertion axiom | **system(mySensor)**[s_uri(ont:System),o_uri(ex:MySensor)]
 <ex:MySensor ont:hosts ex:MyComponent> | Default RDF conversion | **rdf(ex:MySensor,ont:hosts,ex:MyComponent)**
 _| Derived assertion axiom | **hosts(mySensor,myComponent)**[s_uri(ex:mySensor),p_uri(ont:hosts),o_uri(ex:MyComponent)]

### Tests

The project combine both JUnit Tests and JaCaMo test unit agents to cover all provided functionalities. Tests can be found in the [source](/src/test)

### Performance evaluation

The performance evaluation is only centered on CPU performances, we evaluate different navigation through 6 scenarios :
- SingletonGraphSosa : Only one URI to query using sosa OWL vocabulary and a custom virtual MonoNode graph
- SingletonGraph : Only one URI to query using a custom OWL vocabulary and a custom virtual MonoNode graph (both small and big ontologies)
- SimulatedGraph : Multiple URIs to query using a custom  OWL vocabulary and a custom virtual balanced "poor" graph (both small and big ontologies)
- SimulatedRichGraph : Multiple URIs to query using a custom  OWL vocabulary and a custom virtual balanced "rich" graph (both small and big ontologies)
- WikidataGraph : Multiple URIs to query using a custom  OWL vocabulary and the wikidata Knowledge Graph
- reasoners : Same as SimulatedRichGraph but using different OWL reasoners for comparison

### Contact

Noé SAFFAF : noe.saffaf@etu.emse.fr
