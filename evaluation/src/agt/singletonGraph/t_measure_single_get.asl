/**
 * @author Noé SAFFAF
 */

entryPointGet("http://localhost:3030/simulatedSingleton?graph=NodeID_1").


!testUnit.

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

+!testUnit : true <-
    !create_artifact_ldfu;
    !create_artifact_cpu;
	.print("Test : Unit measure get test");
	!profileWithCPUArtifact;
	//!start;
	.

+!profileWithCPUArtifact : true <-
     for (.range(I,1,100)){
        for (entryPointGet(IRI)){
            startTimeMeasure;
            get(IRI);
            endTimeMeasure(TIME);
            .print("Get exec time : ",TIME);
            removeAllObsPropertiesBinding;
        };
     };
     writeEvaluationReport("agentGetSingle.csv");
     .

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }