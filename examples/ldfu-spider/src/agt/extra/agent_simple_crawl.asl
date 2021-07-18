
/**
 This example illustrate how to create a simple agent that create its own ldfu artifact in its workspace,
 the ldfu artifact allows to create triples from a graph and add observable properties (beliefs to the agent)
 into the belief base.

 We first create an artifact specific for the agent and focus on it. If you want to create an artifact,
 in a shared workspace for multiple agents, you can specify it instead in the .jcm file. The instanciation of the artifact
 takes 2 parameters, the program file for linked-data fu (which you shouldn't change), and a boolean (optional) to specify if registered
 ontologies as well as added triples should consider inferred axioms/triples.

 The crawl plan execute the crawl external action for all referenced entrypoints. To add entrypoints, the agent must
 own beliefs in the format
 entryPointCrawl(uri)  // uri of the resource graph, it can be either a real uri (ie : "https://www.wikidata.org/entity/Q2814098"),
                       // or a local path (ie: "ttl/instances_sosa.ttl").

* @author Noé SAFFAF
*/

entryPointCrawl("https://www.wikidata.org/entity/Q2814098").

!start.

+!start : entryPointCrawl(IRI) <-
    .my_name(NAME);
    .concat("ldfu_artifact_",NAME, NAME_ART);
    makeArtifact(NAME_ART,"hypermedia.LinkedDataFuSpider",["get.n3",true],ART_ID);
    focus(ART_ID);
    crawl(IRI);
    .


{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }
