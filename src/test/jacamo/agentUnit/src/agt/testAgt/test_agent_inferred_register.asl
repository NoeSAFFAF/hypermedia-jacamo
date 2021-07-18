/**
 * @author Noé SAFFAF
 */

entryPointRegister("ttl/example_ontology.ttl").

!testUnit.

+!testUnit : entryPointRegister(IRI) <-
    !create_artifact_ldfu(true);
    register(IRI);
	.print("Test Assertion : Unit inferred register test");
    if (system(exampleSensor)){
        .print("Test inferred register : Passed");
    } else {
        .print("Test inferred register : Failed, the inferred belief in the example has not been added");
    }
	.

{ include("ldfu_agent.asl") }