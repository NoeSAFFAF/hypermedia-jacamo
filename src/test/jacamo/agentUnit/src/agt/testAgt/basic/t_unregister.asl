/**
 * @author Noé SAFFAF
 */

entryPointRegister("https://www.w3.org/ns/sosa/").
entryPointRegister("https://www.w3.org/ns/ssn/").

!testUnit.

+!testUnit : true <-
    !create_artifact_ldfu(true);
    !multipleRegister;
    unregister("http://www.w3.org/ns/ssn/");
	.print("Test Assertion : Unit merged register test");
	.count(class(_), C1);
	.count(objectProperty(_), C2);
	.count(dataProperty(_), C3);

	if (C1>0 & C2>0 & C3>0
	  & class("http://www.w3.org/ns/sosa/Sensor")
	  & not class("http://www.w3.org/ns/ssn/Stimulus")) {
	    .print("Test unregister : Passed");
	} else {
		.print("Test unregister : Failed, the belief Stimulus should have been removed");
	};
	.

+!multipleRegister : true <-
    for (entryPointRegister(IRI)){
        register(IRI);
    };
    .

{ include("ldfu_agent.asl") }
