/**
 * @author Noé SAFFAF
 */

entryPointRegister("ttl/example_ontology.ttl").

!testUnit.

+!testUnit : entryPointRegister(IRI) <-
    !create_artifact_ldfu(true);
    register(IRI)
	.print("Test Assertion : Unit Consistency test");
    isConsistent(C);
    if(C){
        .print("Test Consistency : Passed");
    } else {
        .print("Test Satisfiable and Consistency : Failed");
    }
    .

{ include("ldfu_agent.asl") }

