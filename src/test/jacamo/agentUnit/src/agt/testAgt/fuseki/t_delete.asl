/**
 * @author Noé SAFFAF
 */

endPointPut("http://localhost:3030/dataLdfu?graph=deleteTest").
endPointDelete("http://localhost:3030/dataLdfu?graph=deleteTest").
entryPointGet("http://localhost:3030/dataLdfu?graph=deleteTest").

!testUnit.

+!create_object_and_delete : endPointDelete(IRI) <-
    .union(["rdf(http://www.w3.org/ns/sosa/ExampleSensor1,http://www.w3.org/1999/02/22-rdf-syntax-ns#type,http://www.w3.org/ns/sosa/Sensor)"],
            ["rdf(http://www.w3.org/ns/sosa/ExampleSensor2,http://www.w3.org/1999/02/22-rdf-syntax-ns#type,http://www.w3.org/ns/sosa/Sensor)"],
            OBJECT);
    -endPointDelete(IRI);
    delete(IRI,OBJECT);
    .

+!create_object_and_put : endPointPut(IRI) <-
    .union(["rdf(http://www.w3.org/ns/sosa/ExampleSensor1,http://www.w3.org/1999/02/22-rdf-syntax-ns#type,http://www.w3.org/ns/sosa/Sensor)"],
            ["rdf(http://www.w3.org/ns/sosa/ExampleSensor2,http://www.w3.org/1999/02/22-rdf-syntax-ns#type,http://www.w3.org/ns/sosa/Sensor)"],
            OBJECT);
    -endPointPut(IRI);
    put(IRI,OBJECT);
    .

+!testUnit : entryPointGet(IRI_GET) <-
    !create_artifact_ldfu(false);
    !create_object_and_put;
    .wait(1000);
    get(IRI_GET);
    .count(rdf(_, _, _), Count);
    removeAllTripleObsProperties;
    !create_object_and_delete;
    get(IRI_GET);
    .count(rdf(_, _, _), Count2);
    .wait(1000);
	.print("Test Assertion : Unit delete test");
    if (Count>0 & Count2 = 0) {
       	.print("Test simple delete : Passed")
    } else {
       	.print("Test simple delete : Failed, No rdf deleted")
    }
    .

{ include("ldfu_agent.asl") }

