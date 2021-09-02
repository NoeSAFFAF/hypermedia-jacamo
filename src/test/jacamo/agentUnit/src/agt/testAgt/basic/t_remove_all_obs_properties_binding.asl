/**
 * @author Noé SAFFAF
 */

entryPointCrawl("ttl/instances_sosa.ttl").
entryPointRegister("https://www.w3.org/ns/sosa/").

!testUnit.

+!testUnit : entryPointCrawl(IRI_CRAWL) & entryPointRegister(IRI_REGISTER) <-
    !create_artifact_ldfu(true);
    register(IRI_REGISTER);
    crawl(IRI_CRAWL);
    removeAllObsPropertiesBinding;
    .print("Test Assertion : Unit remove all obs properties bindings");
    .count(rdf(_, _, _), C1);
	if (C1 = 0 & not platform(examplePlatform1)) {
		.print("Test remove all obs properties binding : Passed")
	} else {
		.print("Test remove all obs properties binding : Failed")
	}
	.


{ include("ldfu_agent.asl") }




