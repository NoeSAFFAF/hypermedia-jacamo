package tools;

import cartago.Artifact;
import cartago.OPERATION;

import java.util.List;

/**
 * @author : Noé SAFFAF
 * @since : 29/06/2021, mar.
 **/
public class CPUTrackerArtifact extends Artifact {
    private long lastRegisteredTime;
    private long totalTime;
    private List<Long> registeredTimeList;

    @OPERATION
    public void sayHello(){
        System.out.println("Hello From CPU Tracker Artifact");
    }
}
