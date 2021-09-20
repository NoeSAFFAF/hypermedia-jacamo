/**
 * @author Noé SAFFAF
 */

entryPointCrawl("http://www.wikidata.org/entity/Q70972").




!start.

+!create_artifact_ldfu : true <-
     .my_name(NAME);
     .concat("ldfu_artifact_",NAME, NAME_ART);
     makeArtifact(NAME_ART,"org.hypermedea.LinkedDataFuSpider",["getGraph.n3",true,"Hermit"],ART_ID);
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
	.print("Test Unit : Measure Wikidata");
	register("onto/wikidata/wikidataOwl1.ttl");
	!profileWithCPUArtifact;
	.

/*
pendingRequestURI(URI) :-
	participantIn(_,OBJECT)[o_uri(URI)] &
	not hasMadeRequest(URI)
.

pendingRequestURI(URI) :-
	participant(_,OBJECT)[o_uri(URI)] &
	not hasMadeRequest(URI)
.

+pendingRequestURI(URI) : true <-
	get(URI);
	+hasMadeRequest(URI)
.*/

+!profileWithCPUArtifact : true <-
     for (.range(I,1,1)){
        for (entryPointCrawl(IRI)){
            !startMeasurement;
            +hadMadeRequest(IRI,O);
            .print("Currently exploring : ", IRI, " with depth : 0");
            get(IRI);
            +depth(SUBJECT,0);
            while ((participantIn(SUBJECT,CHILD)[o_uri(IRI_CHILD)] & not hasMadeRequest(CHILD) & depth(SUBJECT,D) & D < 3) |
                    (participant(SUBJECT,CHILD)[o_uri(IRI_CHILD)] & not hasMadeRequest(CHILD) & depth(SUBJECT,D) & D < 3)) {
                +hasMadeRequest(CHILD);
                +depth(CHILD,D+1);
                .print("Currently exploring : ", CHILD, " with depth : ", D+1);
                get(IRI_CHILD);
            }
            !endMeasurement;
        };
     };
     //writeEvaluationReport("agentWikidata.csv");
.


+!startMeasurement : true <-
    .print("Start measuring time");
    startTimeMeasure;
.

+!endMeasurement : true <-
    endTimeMeasure(TIME);
    .print("Get exec time : ",TIME);
    //removeAllObsPropertiesBinding;
.


{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }