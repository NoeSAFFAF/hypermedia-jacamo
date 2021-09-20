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

For `register(https://www.w3.org/ns/sosa/)` :

OWL triples   | Type            |                             Observable property
OWL triples   | Type            |                             Observable property
ont:Sensor rdf:type owl:Class 
sosa:Sensor a rdfs:Class , owl:Class ;                  =>    class("sosa:Sensor")
sosa:Platform a rdfs:Class , owl:Class ;                =>    class("sosa:Platform")
sosa:isHostedBy a owl:ObjectProperty ;                  =>    objectProperty("sosa:isHostedBy")


And crawl operation adds individual and properties as triples as well as unary and binary predicates (obs properties)
if the class and the properties are defined in the registered ontologies.


Rdf Graph file for crawl                                      Observable Properties in Jacamo
ex:ExampleSensor a sosa:Sensor ;                        =>    rdf("http://www.myexample.org/ExampleSensor","http://www.w3.org/1999/02/22-rdf-syntax-ns#type","http://www.w3.org/ns/sosa/Sensor")
                                                              sensor("ex:ExampleSensor")[predicate_uri("https://www.w3.org/ns/sosa/Sensor")]

ex:ExamplePlatform a sosaPlatform ;                     =>    rdf("http://www.myexample.org/ExamplePlatform","http://www.w3.org/1999/02/22-rdf-syntax-ns#type","http://www.w3.org/ns/sosa/Platform")
                                                              platform("ex:ExamplePlatform")[predicate_uri("https://www.w3.org/ns/sosa/Platform")]


ex:ExampleSensor sosa:isHostedBy ex:ExamplePlateform    =>    rdf("http://www.myexample.org/ExampleSensor","http://www.w3.org/ns/sosa/isHostedBy","http://www.myexample.org/ExamplePlateform")
                                                              isHostedBy("ex:ExampleSensor","ex:ExamplePlateform")[predicate_uri("https://www.w3.org/ns/sosa/isHostedBy")]


If we also consider inferred Axioms, we also generate inferred observable properties :

(There is no vocabulary named "System" in sosa, so this is a simple illustrative case)

Registered Owl file                                           Observable Properties in Jacamo
sosa:Sensor rdfs:subClassOf sosa:System ;               =>    subClassOf("sosa:Sensor","sosa:System)

Rdf Graph file for crawl                                      Observable Properties in Jacamo
ex:ExampleSensor a sosa:Sensor ;                        =>    rdf("http://www.myexample.org/ExampleSensor","http://www.w3.org/1999/02/22-rdf-syntax-ns#type","http://www.w3.org/ns/sosa/Sensor")
                                                              sensor("ex:ExampleSensor")[predicate_uri("https://www.w3.org/ns/sosa/Sensor")]
                                                              system("ex:ExampleSensor")[predicate_uri("https://www.w3.org/ns/sosa/System")]
                                                                                                                        
