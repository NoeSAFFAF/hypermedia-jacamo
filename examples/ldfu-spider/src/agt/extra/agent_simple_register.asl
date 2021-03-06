
/*
 This example illustrate how to create a simple agent that create its own ldfu artifact in its workspace,
 the ldfu artifact allows to create triples from a graph and add observable properties (beliefs to the agent)
 into the belief base.

 The "create_artifact_ldfu" plan creates an artifact to the workspace of the agent. If you want to create an artifact,
 in a shared workspace for multiple agents, you can specify it instead in the .jcm file. The instanciation of the artifacts
                                                                                         takes 2 parameters, the program file for linked-data fu (which you shouldn't change), and a boolean to specify if registered
                                                                                         ontologies as well as added triples should consider inferred axioms/triples. By default, it is set to false (not inferred).


 The register plan execute the register external action of all referenced entrypoints. To add entrypoints, the agent must
 own belief in the format
 entryPointRegister(origin)  // uri of the ontology, it can be either a real uri (ie : "https://www.wikidata.org/entity/Q2814098"),
                             // or a local path (ie: "ttl/sosa.ttl").
 It returns all unary/binary predicates from an ontology.

 registerPlan takes two parameters, one to name the merged ontology (just put whatever you want, not used atm), the second is
 to specify if we consider inferred axioms (true if the case, false otherwise)

* @author Noé SAFFAF
*/

entryPointRegister("https://www.w3.org/ns/sosa/").


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
