/**
 * @author Noé SAFFAF
 */

entryPointCrawl("http://localhost:3030/simulatedRichGraph?graph=NodeID_1").

!start.

+!create_artifact_ldfu : true <-
     .my_name(NAME);
     .concat("ldfu_artifact_",NAME, NAME_ART);
     makeArtifact(NAME_ART,"org.hypermedea.LinkedDataFuSpider",["getRichGraph.n3"],ART_ID);
     focus(ART_ID);
     .

+!create_artifact_cpu : true <-
    .my_name(NAME);
    .concat("CPUTracker_artifact_",NAME, NAME_ART);
    makeArtifact(NAME_ART,"profilingArtifacts.CPUTrackerArtifact",[],ART_ID);
    focus(ART_ID);
    .

+!start : true <-
    !create_artifact_ldfu;
    !create_artifact_cpu;
	.print("Test Unit : Measure get in simulatedGraph");
	register("onto/simulatedGraph.ttl");
	!profileWithCPUArtifact;
	.


+!profileWithCPUArtifact : true <-
     for (.range(I,1,100)){
        for (entryPointCrawl(IRI)){
            !startMeasurement;
            crawl(IRI);
            !endMeasurement;
        };
     };
     !count;
     writeEvaluationReport("agentCrawlRichGraphWithOnto.csv");
.


+!startMeasurement : true <-
    .print("Start measuring time");
    startTimeMeasure;
.

+!endMeasurement : true <-
    endTimeMeasure(TIME);
    .print("Get exec time : ",TIME);
    removeAllObsPropertiesBinding;
.

+!count : true <-
    .count(rdf(_,"http://www.w3.org/1999/02/22-rdf-syntax-ns#type","http://www.semanticweb.org/noesaffaf/simulatedGraph#Node"),COUNT);
    .print("We have found : ", COUNT);
.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }