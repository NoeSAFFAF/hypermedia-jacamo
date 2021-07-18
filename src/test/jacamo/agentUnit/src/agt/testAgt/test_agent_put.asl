/**
 * @author Noé SAFFAF
 */

endPointPut("http://localhost:3030/dataLdfu?graph=putTest").
entryPointCrawl("http://localhost:3030/dataLdfu?graph=putTest").

!testUnit.

+!create_object_and_put : endPointPut(IRI) <-
    .union(["rdf(http://www.w3.org/ns/sosa/ExampleSensor1,http://www.w3.org/1999/02/22-rdf-syntax-ns#type,http://www.w3.org/ns/sosa/Sensor)"],
            ["rdf(http://www.w3.org/ns/sosa/ExampleSensor2,http://www.w3.org/1999/02/22-rdf-syntax-ns#type,http://www.w3.org/ns/sosa/Sensor)"],
            OBJECT);
    -endPointPut(IRI);
    put(IRI,OBJECT);
    .


+!testUnit : entryPointCrawl(IRI) <-
    !create_artifact_ldfu(false);
    !create_object_and_put;
    crawl(IRI);
	.print("Test Assertion : Unit put test");
	.count(rdf(_, _, _), Count) ;
    if (Count>0) {
   		.print("Test simple put : Passed")
   	} else {
   		.print("Test simple put : Failed, No rdf belief was added")
   	}
    .

{ include("ldfu_agent.asl") }

