/**
 * @author Noé SAFFAF
 */

entryPointGet("IDoNotExist").


!testUnit.

+!testUnit : entryPointGet(IRI) <-
    !create_artifact_ldfu(false);
    get(IRI, MSG);
    .print(MSG);
.

{ include("ldfu_agent.asl") }

