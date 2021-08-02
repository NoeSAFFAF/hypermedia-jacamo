/**
 * @author Noé SAFFAF
 */

entryPointGet("http://localhost:3030/dataLdfu?graph=evaluationTest").
entryPointRegister("https://www.w3.org/ns/sosa/").

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

+!testUnit : entryPointRegister(IRI_REGISTER) <-
    !create_artifact_ldfu;
    !create_artifact_cpu;
	.print("Test : Unit measure get with onto test");
	register(IRI_REGISTER)
	!profileWithCPUArtifact;
	.

+!profileWithCPUArtifact : true <-
     for (.range(I,1,100)){
        for (entryPointGet(IRI)){
            startTimeMeasure;
            get(IRI);
            endTimeMeasure(TIME);
            .print("Get exec time : ",TIME);
            .count(sensor(_), CountSensor);
            .print("found ", CountSensor, " sensors.");
            removeAllObsPropertiesBinding;
        };
     };
     writeEvaluationReport("agentGetDataWithOnto.csv");
     .

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }