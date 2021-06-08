package onto.classes;

import org.semanticweb.owlapi.model.OWLClass;

import java.util.Set;

public class SatisfiableResponse {
    private boolean isConsistent;
    private Set<OWLClass> inconsistentAxioms;

    public SatisfiableResponse(boolean isConsistent, Set<OWLClass> inconsistentAxioms) {
        this.isConsistent = isConsistent;
        this.inconsistentAxioms = inconsistentAxioms;
    }

    public boolean isConsistent() {
        return isConsistent;
    }

    public void setConsistent(boolean consistent) {
        isConsistent = consistent;
    }

    public Set<OWLClass> getInconsistentAxioms() {
        return inconsistentAxioms;
    }

    public void setInconsistentAxioms(Set<OWLClass> inconsistentAxioms) {
        this.inconsistentAxioms = inconsistentAxioms;
    }

    @Override
    public String toString() {
        String s = "Unsatisfiable Axioms : ";

        for (OWLClass o : inconsistentAxioms){
            s += "\n"+o.toString();
        }
        return s;
    }
}
