/**
 * @author Noé SAFFAF
 */

entryPointGet("http://localhost:3030/dataLdfu?graph=getTest").
//entryPointGet("https://www.w3.org/ns/sosa/").
//entryPointGet("ttl/sosa.ttl").

!testUnit.

+!testUnit : true <-
    !create_artifact_ldfu(false);
    !getPlan;
    .wait(1000);
	.print("Test Assertion : Unit get test");
	.count(rdf(_, _, _), Count) ;
    if (Count>0) {
        .print("Test simple get : Passed")
    } else {
        .print("Test simple get : Failed, No rdf belief was added")
    }
    .

{ include("ldfu_agent.asl") }

