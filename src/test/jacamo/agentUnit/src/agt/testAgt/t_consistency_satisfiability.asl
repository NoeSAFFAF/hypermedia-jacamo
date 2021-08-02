/**
 * @author Noé SAFFAF
 */

entryPointRegister("https://www.w3.org/ns/sosa/").

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

