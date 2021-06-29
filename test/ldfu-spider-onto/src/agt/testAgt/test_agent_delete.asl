/**
 * @author Noé SAFFAF
 */

endPointPut("http://localhost:3030/dataLdfu?graph=deleteTest").
endPointDelete("http://localhost:3030/dataLdfu?graph=deleteTest").
entryPointCrawl("http://localhost:3030/dataLdfu?graph=deleteTest").

!testUnit.

+!create_object_and_delete: endPointDelete(IRI) <-
    .union(["rdf(http://www.w3.org/ns/sosa/ExampleSensor1,http://www.w3.org/1999/02/22-rdf-syntax-ns#type,http://www.w3.org/ns/sosa/Sensor)"],
            ["rdf(http://www.w3.org/ns/sosa/ExampleSensor2,http://www.w3.org/1999/02/22-rdf-syntax-ns#type,http://www.w3.org/ns/sosa/Sensor)"],
            OBJECT);
    -endPointDelete(IRI);
    +endPointDelete(IRI,OBJECT);
    .print(OBJECT);
    !deletePlan;
    .

+!create_object_and_put : endPointPut(IRI) <-
    .union(["rdf(http://www.w3.org/ns/sosa/ExampleSensor1,http://www.w3.org/1999/02/22-rdf-syntax-ns#type,http://www.w3.org/ns/sosa/Sensor)"],
            ["rdf(http://www.w3.org/ns/sosa/ExampleSensor2,http://www.w3.org/1999/02/22-rdf-syntax-ns#type,http://www.w3.org/ns/sosa/Sensor)"],
            OBJECT);
    -endPointPut(IRI);
    +endPointPut(IRI,OBJECT);
    .print(OBJECT);
    !putPlan;
    .

+!testUnit : true <-
    !create_artifact_ldfu(false);
    !create_object_and_put;
    !crawlPlan;
    .count(rdf(_, _, _), Count);
    .abolish(rdf(_, _, _));
    !create_object_and_delete;
    !crawlPlan;
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

