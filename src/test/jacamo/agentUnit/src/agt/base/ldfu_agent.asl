/**
 * @author Noé SAFFAF
 */

+!create_artifact_ldfu(INFERRED_BOOL) : true <-
     .my_name(NAME);
     .concat("ldfu_artifact_",NAME, NAME_ART);
     makeArtifact(NAME_ART,"hypermedia.LinkedDataFuSpider",["get.n3",INFERRED_BOOL],ART_ID);
     focus(ART_ID);
     .

+!count :true <-
    .count(rdf(_, _, _), Count) ;
    .print("found ", Count, " triples.");
  	.

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }