/**
 * @author Noé SAFFAF
 */

entryPointGet("http://localhost:3030/dataLdfu").
//entryPointGet("https://www.w3.org/ns/sosa/").

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
	.print("Test : Unit measure get test");
	for (.range(I,1,100)){
	    for (entryPointGet(IRI)){
            get(IRI);
            getLastRegisteredTime(TIME);
            !count;
            .print("Get exec time : ",TIME);
            .abolish(rdf(_,_,_));
        };
	}
	getTotalTime(TOTALTIME);
	.print("Get Total time : ",TOTALTIME);
	writeEvaluationReport("getMeasurement10000.csv");
	.


{ include("ldfu_agent.asl") }

