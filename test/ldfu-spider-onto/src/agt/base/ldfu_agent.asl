/**
 * @author Noé SAFFAF
 */

+!create_artifact_ldfu(INFERRED_BOOL) : true <-
     .my_name(NAME);
     .concat("ldfu_artifact_",NAME, NAME_ART);
     makeArtifact(NAME_ART,"hypermedia.LinkedDataFuSpider",["get.n3",INFERRED_BOOL],ART_ID);
     focus(ART_ID);
     .


+!getPlan : true <-
    for (entryPointGet(IRI)){
        get(IRI);
        -entryPointGet(IRI);
    };
    .

+!putPlan : true <-
    for (endPointPut(IRI, OBJECT)){
        put(IRI, OBJECT);
        -endPointPut(IRI, OBJECT);
    };
    .

+!postPlan : true <-
    for (endPointPost(IRI, OBJECT)){
        post(IRI, OBJECT);
        -endPointPost(IRI, OBJECT);
    }
    .

+!deletePlan : true <-
    for (endPointDelete(IRI, A)){
        .print("helloe");
        delete(IRI, A);
        -endPointDelete(IRI, A);
    }
    .

+!registerPlan : true <-
	for (entryPointRegister(IRI)){
       register(IRI);
       -entryPointRegister(IRI)
 	}
	.

+!unregisterPlan(IRI) : true <-
    unregister(IRI);
	.



+!crawlPlan : true <-
	for (entryPointCrawl(IRI)){
    	crawl(IRI);
    	-entryPointCrawl(IRI);
	}
	.


+!printRdf: true <-
	for (rdf(O1,O2,O3)){
		.print("rdf(",O1,", ",O2,", ",O3,")");
	}
	.

+!count : true <-
    .count(rdf(_, _, _), Count) ;
    .print("found ", Count, " triples.");
  	.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }