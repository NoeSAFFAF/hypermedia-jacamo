/**
 * @author Noé SAFFAF
 */

entryPointGet("http://localhost:3030/simulatedRichGraph?graph=NodeID_1").

!start.

+!create_artifact_ldfu : true <-
     .my_name(NAME);
     .concat("ldfu_artifact_",NAME, NAME_ART);
     makeArtifact(NAME_ART,"org.hypermedea.LinkedDataFuSpider",["getRichGraph.n3",true,"JFact"],ART_ID);
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
	register("onto/simulatedGraphForReasoners.ttl");
	!profileWithCPUArtifact;
	.




+!profileWithCPUArtifact : true <-
     for (.range(I,1,10)){
        for (entryPointGet(IRI)){
            !startMeasurement;
            +hasMadeRequest(nodeID_1);
            get(IRI);
            while (hasChild(_,CHILD)[o_uri(IRI_CHILD)] & not hasMadeRequest(CHILD) ) {
                +hasMadeRequest(CHILD);
                get(IRI_CHILD);
            }
            !endMeasurement;
        };
     };
     writeEvaluationReport("agentGraphReasonerJFact.csv");
.


+!startMeasurement : true <-
    .print("Start measuring time");
    startTimeMeasure;
.

+!endMeasurement : true <-
    endTimeMeasure(TIME);
    .print("Get exec time : ",TIME);
    //removeAllObsPropertiesBinding;
    while (hasMadeRequest(URI)){
        -hasMadeRequest(URI);
    }
.


{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }