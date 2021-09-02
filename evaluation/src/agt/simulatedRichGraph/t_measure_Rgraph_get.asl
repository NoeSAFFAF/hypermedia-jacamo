/**
 * @author Noé SAFFAF
 */

entryPointGet("http://localhost:3030/simulatedRichGraph?graph=NodeID_1").

!start.

+!create_artifact_ldfu : true <-
     .my_name(NAME);
     .concat("ldfu_artifact_",NAME, NAME_ART);
     makeArtifact(NAME_ART,"org.hypermedea.LinkedDataFuSpider",["get.n3"],ART_ID);
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
	!profileWithCPUArtifact;
	.


+!profileWithCPUArtifact : true <-
     for (.range(I,1,100)){
        for (entryPointGet(IRI)){
            !startMeasurement;
            +hasMadeRequest(IRI);
            get(IRI);
            while (rdf(_,"http://www.semanticweb.org/noesaffaf/simulatedGraph#hasChild",IRI_CHILD) & not hasMadeRequest(IRI_CHILD)) {
                +hasMadeRequest(IRI_CHILD);
                get(IRI_CHILD);
            }
            !endMeasurement;
        };
     };
     !count;
     writeEvaluationReport("agentGetRichGraph.csv");
.


+!startMeasurement : true <-
    .print("Start measuring time");
    startTimeMeasure;
.

+!endMeasurement : true <-
    endTimeMeasure(TIME);
    .print("Get exec time : ",TIME);
    removeAllObsPropertiesBinding;
    while (hasMadeRequest(URI)){
        -hasMadeRequest(URI);
    }
.

+!count : true <-
    .count(rdf(_,"http://www.w3.org/1999/02/22-rdf-syntax-ns#type","http://www.semanticweb.org/noesaffaf/simulatedGraph#Node"),COUNT);
    .print("We have found : ", COUNT);
.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }