/**
 * @author Noé SAFFAF
 */

entryPointRegister("ttl/known_ont/owl").
entryPointRegister("ttl/known_ont/rdf").
entryPointRegister("ttl/known_ont/rdfs").

!testUnit.

+!testUnit : true <-
    !create_artifact_ldfu(true);
    for (entryPointRegister(IRI)){
        register(IRI);
    }
	.

{ include("ldfu_agent.asl") }