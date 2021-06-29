/**
 * @author Noé SAFFAF
 */

entryPointCrawl("http://localhost:3030/dataLdfu?graph=evaluationTest").

!testUnit.

+!create_artifact_ldfu_evaluation(INFERRED_BOOL) : true <-
     .my_name(NAME);
     .concat("ldfu_artifact_",NAME, NAME_ART);
     makeArtifact(NAME_ART,"hypermedia.LinkedDataFuSpider",["get.n3",INFERRED_BOOL,true],ART_ID);
     focus(ART_ID);
     .

+!testUnit : true <-
    !create_artifact_ldfu_evaluation(false);
    .wait(1000);
	.print("Test : Unit measure crawl test");
	!start;
	.
	
+!start : doStart <-
	for (.range(I,1,100)){
	    for (entryPointCrawl(IRI)){
            crawl(IRI);
            getLastRegisteredTime(TIME);
            .print("Crawl exec time : ",TIME);
            !count;
            .abolish(rdf(_, _, _));
        };
	}
	getTotalTime(TOTALTIME);
	.print("Crawl exec Total time : ",TOTALTIME);
	writeEvaluationReport("crawlMeasurement10000t.csv");
	.

-!start : true <-
	.print("Wait for start");
	.wait(2000);
	!start;
	.

{ include("ldfu_agent.asl") }

