/**
 * @author Noé SAFFAF
 */

!testUnit.

+!testUnit : true <-
    .my_name(NAME);
    .concat("CPUTracker_artifact_",NAME, NAME_ART);
    makeArtifact(NAME_ART,"CPUTrackerArtifact",[],ART_ID);
    focus(ART_ID);
    //sayHello;
    .

{ include("ldfu_agent.asl") }

