/**
 * @author Noé SAFFAF
 */

entryPointCrawl("http://www.IDoNotExist.org").


!testUnit.

+!testUnit : entryPointCrawl(IRI) <-
    !create_artifact_ldfu(false);
    .print("Test Assertion : Unit Crawl Error Http State");
    crawl(IRI, MSG);
    .print(MSG);

    if (MSG == -1){
        .print("Test Crawl Error Http State : Passed");
    } else {
        .print("Test Crawl Error Http State : Failed");
    }
.

{ include("ldfu_agent.asl") }

