/**
 * @author Noé SAFFAF
 */

entryPointGet("http://www.IDoNotExist.org").


!testUnit.

+!testUnit : entryPointGet(IRI) <-
    !create_artifact_ldfu(false);
    .print("Test Assertion : Unit Get Error Http Status");
    get(IRI, MSG);
    .print(MSG);

    if (MSG == -1){
        .print("Test Get Error Http Status : Passed");
    } else {
        .print("Test Get Error Http Status : Failed");
    }

.

{ include("ldfu_agent.asl") }

