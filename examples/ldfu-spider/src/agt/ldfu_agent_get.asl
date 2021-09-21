// A rule to check a property and add perform a new Get operation
+rdf(_,"http://www.opengis.net/ont/geosparql#sfWithin",OBJECT_URI) : not hasMadeRequestURI(OBJECT_URI) <-
        +hasMadeRequestURI(OBJECT_URI);
        get(OBJECT_URI) ;
.


+!start :
    entryPoint(URI)
    <-
    // register SOSA to retrieve OWL class/property definitions and derive unary/binary predicates
    register("http://www.w3.org/ns/sosa/") ;
    // get RDF triples and the addition of new observable properties triggers rules for performing more actions
    +hasMadeRequestURI(URI);
    get(URI) ;
    // look up resource and print it
    !lookUpRDF ;
    !lookUpDerived ;
  .

+!lookUpRDF :
    rdf(Platform, "http://www.w3.org/1999/02/22-rdf-syntax-ns#type", "http://www.w3.org/ns/sosa/Platform")
    <-
    .print("found ", Platform, " (with query using the rdf/3 predicate).");
  .

+!lookUpDerived :
    platform(Platform)
    <-
    .print("found ", Platform, " (with query using the platform/1 predicate, derived from the OWL class sosa:Platform).");
  .

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }