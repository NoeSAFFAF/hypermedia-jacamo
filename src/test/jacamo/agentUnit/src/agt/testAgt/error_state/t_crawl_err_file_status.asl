/**
 * @author Noé SAFFAF
 */

entryPointCrawl("IDoNotExist").


!testUnit.

+!testUnit : entryPointCrawl(IRI) <-
    !create_artifact_ldfu(false);
    .print("Test Assertion : Unit Crawl Error File State");
    crawl(IRI, MSG);
    .print(MSG);

    if (MSG == ERROR){
        .print("Test Crawl Error File State : Passed");
    } else {
        .print("Test Crawl Error File State : Failed");
    }
.

{ include("ldfu_agent.asl") }