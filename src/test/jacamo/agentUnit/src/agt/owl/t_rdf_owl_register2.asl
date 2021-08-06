/**
 * @author Noé SAFFAF
 */

//entryPointRegister("ttl/known_ont/owl").
//entryPointRegister("ttl/known_ont/rdf").
//entryPointRegister("ttl/known_ont/rdfs").
entryPointRegister("ttl/known_ont/example_ont").

!testUnit.

+!testUnit : true <-
    !create_artifact_ldfu(true);
    for (entryPointRegister(IRI)){
        register(IRI);
    }
    crawl("ttl/known_ont/instance_objProp.ttl");
	.

{ include("ldfu_agent.asl") }