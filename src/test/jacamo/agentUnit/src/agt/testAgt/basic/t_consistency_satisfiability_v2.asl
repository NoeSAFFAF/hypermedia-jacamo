/**
 * @author Noé SAFFAF
 */

entryPointRegister("ttl/unsatisfiable_ontology.ttl").

!testUnit.

+!testUnit : entryPointRegister(IRI) <-
    !create_artifact_ldfu(true);
    register(IRI);
    .wait(1000);
	.print("Test Assertion : Unit Satisfiable and Consistency test");
    isConsistent(C);
    if(not C){
        .print("Test Satisfiable and Consistency : Passed");
    } else {
        .print("Test Satisfiable and Consistency : Failed");
    }
    .

{ include("ldfu_agent.asl") }

