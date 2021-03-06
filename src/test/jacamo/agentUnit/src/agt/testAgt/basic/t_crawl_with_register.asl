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
	.print("Test Assertion : Unit crawl with register test");
	.count(rdf(_, _, _), C1) ;
	.count(is_hosted_by(_, _), C2);
	.count(sensor( _), C3);
	if (C1>0 & C2>0 & C3>0) {
		.print("Test simple crawl : Passed")
	} else {
		.print("Test simple crawl : Failed, at least one of rdf/sensor/isHostedBy belief is missing")
	}
	.


{ include("ldfu_agent.asl") }

