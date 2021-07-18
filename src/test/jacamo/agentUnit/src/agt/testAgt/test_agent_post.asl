/**
 * @author Noé SAFFAF
 */

endPointPost("http://localhost:3030/dataLdfu?graph=postTest").
entryPointCrawl("http://localhost:3030/dataLdfu?graph=postTest").

!testUnit.

+!create_object_and_post : endPointPost(IRI) <-
    .union(["rdf(http://www.w3.org/ns/sosa/ExampleSensor1,http://www.w3.org/1999/02/22-rdf-syntax-ns#type,http://www.w3.org/ns/sosa/Sensor)"],
            ["rdf(http://www.w3.org/ns/sosa/ExampleSensor2,http://www.w3.org/1999/02/22-rdf-syntax-ns#type,http://www.w3.org/ns/sosa/Sensor)"],
            OBJECT);
    -endPointPost(IRI);
    post(IRI,OBJECT);
    .


+!testUnit : entryPointCrawl(IRI) <-
    !create_artifact_ldfu(false);
    !create_object_and_post;
    crawl(IRI);
	.print("Test Assertion : Unit post test");
	.count(rdf(_, _, _), Count) ;
    if (Count>0) {
      	.print("Test simple post : Passed")
    } else {
        .print("Test simple post : Failed, No rdf belief was added")
    }
    .

{ include("ldfu_agent.asl") }

