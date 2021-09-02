/**
 * @author Noé SAFFAF
 */

entryPointCrawl("ttl/instances_sosa.ttl").
entryPointRegister("https://www.w3.org/ns/sosa/").

!testUnit.

+!testUnit : entryPointCrawl(IRI_CRAWL) & entryPointRegister(IRI_REGISTER) <-
    !create_artifact_ldfu(false);
    register(IRI_REGISTER);
    crawl(IRI_CRAWL);
    removeObsPropertyBinding(["rdf(http://www.myexample.org/ExamplePlatform1,http://www.w3.org/1999/02/22-rdf-syntax-ns#type,http://www.w3.org/ns/sosa/Platform)"]);
	.print("Test Assertion : Unit remove obs property");
	if (not rdf("http://www.myexample.org/ExamplePlatform1","http://www.w3.org/1999/02/22-rdf-syntax-ns#type","http://www.w3.org/ns/sosa/Platform")
	  & not platform(examplePlatform1)) {
		.print("Test remove obs property : Passed")
	} else {
		.print("Test remove obs property : Failed")
	}
	.


{ include("ldfu_agent.asl") }




