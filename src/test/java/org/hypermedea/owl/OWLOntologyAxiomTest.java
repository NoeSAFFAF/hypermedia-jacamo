package org.hypermedea.owl;

import org.junit.Test;
import org.semanticweb.owlapi.apibinding.OWLManager;
import org.semanticweb.owlapi.model.*;
import org.semanticweb.owlapi.util.ShortFormProvider;

import java.net.URISyntaxException;
import java.net.URL;


/**
 * @author : Noé SAFFAF
 * @since : 05/08/2021, jeu.
 **/


public class OWLOntologyAxiomTest {

    private final OWLOntologyManager ontologyManager = OWLManager.createOWLOntologyManager();
    private final OWLOntology ontology;

    public OWLOntologyAxiomTest() throws OWLOntologyCreationException, URISyntaxException {
        URL url1 = getClass().getClassLoader().getResource("test-rdf");
        URL url2 = getClass().getClassLoader().getResource("owl");
        URL url3 = getClass().getClassLoader().getResource("rdf-schema");
        ontologyManager.loadOntologyFromOntologyDocument(IRI.create(url1));
        ontologyManager.loadOntologyFromOntologyDocument(IRI.create(url2));
        ontology = ontologyManager.loadOntologyFromOntologyDocument(IRI.create(url3));
    }

    @Test
    public void test1(){

    }

    private OWLClassAssertionAxiom getClassAssertion() {
        for (OWLAxiom axiom : ontology.getAxioms()) {
            if (axiom.isOfType(AxiomType.CLASS_ASSERTION)) return (OWLClassAssertionAxiom) axiom;
        }
        return null;
    }

    private OWLObjectPropertyAssertionAxiom getObjectPropertyAssertion() {
        for (OWLAxiom axiom : ontology.getAxioms()) {
            if (axiom.isOfType(AxiomType.OBJECT_PROPERTY_ASSERTION)) return (OWLObjectPropertyAssertionAxiom) axiom;
        }

        return null;
    }

    private ShortFormProvider getNamingStrategy(NamingStrategyFactory.NamingStrategyType type) {
        return NamingStrategyFactory.createNamingStrategy(type, ontologyManager);
    }

}