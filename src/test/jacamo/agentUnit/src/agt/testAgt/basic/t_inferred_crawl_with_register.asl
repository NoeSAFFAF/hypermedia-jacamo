/**
 * @author Noé SAFFAF
 */

entryPointCrawl("ttl/instances_custom_sosa.ttl").
entryPointRegister("ttl/custom_sosa.ttl").

!testUnit.

+!testUnit : entryPointCrawl(IRI_CRAWL) & entryPointRegister(IRI_REGISTER) <-
    !create_artifact_ldfu(true);
    register(IRI_REGISTER);
    crawl(IRI_CRAWL);
	.print("Test Assertion : Unit inferred Crawl with Register test");
    if (system(exampleSensor1) & system(exampleSensor2)){
        .print("Test inferred Crawl with Register : Passed");
    } else {
        .print("Test inferred Crawl with Register : Failed, the inferred belief in the example has not been added");
    }
	.

{ include("ldfu_agent.asl") }