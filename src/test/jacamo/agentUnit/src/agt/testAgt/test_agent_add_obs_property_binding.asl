/**
 * @author Noé SAFFAF
 */

entryPointRegister("https://www.w3.org/ns/sosa/").

!testUnit.

+!testUnit : entryPointRegister(IRI_REGISTER) <-
    !create_artifact_ldfu(false);
    register(IRI_REGISTER);
    addObsPropertyBinding("rdf(http://www.myexample.org/ExamplePlatform1,http://www.w3.org/1999/02/22-rdf-syntax-ns#type,http://www.w3.org/ns/sosa/Platform)");
	.print("Test Assertion : Unit remove obs property");
	if (rdf("http://www.myexample.org/ExamplePlatform1","http://www.w3.org/1999/02/22-rdf-syntax-ns#type","http://www.w3.org/ns/sosa/Platform")
	  & platform(examplePlatform1)) {
		.print("Test add obs property : Passed")
	} else {
		.print("Test add obs property : Failed")
	}
	.


{ include("ldfu_agent.asl") }




