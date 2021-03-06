
/**
 This example illustrate how to create a simple agent that create its own ldfu artifact in its workspace,
 the ldfu artifact allows to create triples from a graph and add observable properties (beliefs to the agent)
 into the belief base.

 The "create_artifact_ldfu" plan creates an artifact to the workspace of the agent. If you want to create an artifact,
 in a shared workspace for multiple agents, you can specify it instead in the .jcm file.

* @author Noé SAFFAF
*/

entryPointRegister("https://www.w3.org/ns/sosa/").
entryPointRegister("https://www.w3.org/ns/ssn/").

!start.

+!start : entryPointRegister(IRI) <-
    .my_name(NAME);
    .concat("ldfu_artifact_",NAME, NAME_ART);
    makeArtifact(NAME_ART,"org.hypermedea.LinkedDataFuSpider",["get.n3"],ART_ID);
    focus(ART_ID);
    register(IRI);
    .


{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

