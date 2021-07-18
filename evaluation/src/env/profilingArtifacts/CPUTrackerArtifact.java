package profilingArtifacts;

import cartago.Artifact;
import cartago.OPERATION;
import cartago.OpFeedbackParam;

import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * @author : Noé SAFFAF
 * @since : 29/06/2021, mar.
 **/
public class CPUTrackerArtifact extends Artifact {
    private long lastRegisteredTime;
    private long totalTime;
    private List<Long> registeredTimeList;

    public void init() {
        totalTime = 0;
        lastRegisteredTime = 0;
        registeredTimeList = new ArrayList<>();
    }

    @OPERATION
    public void startTimeMeasure(){
        lastRegisteredTime = System.currentTimeMillis();
    }

    @OPERATION
    public void endTimeMeasure(OpFeedbackParam<Long> op_timeElapsed){
        long timeElapsed = System.currentTimeMillis() - lastRegisteredTime;
        registeredTimeList.add(timeElapsed);
        op_timeElapsed.set(timeElapsed);
    }

    @OPERATION
    public void writeEvaluationReport(String fileName){
        Map<String, String> map = new LinkedHashMap();
        int i = 0;
        for (Long l : registeredTimeList){
            i++;
            map.put(Integer.toString(i),l.toString());
        }
        writeMapToCSV(map,fileName);
    }

    private static void writeMapToCSV(Map<String,String> map, String fileName){
        String path = "\\output\\";
        String eol = System.getProperty("line.separator");
        System.out.println(System.getProperty("user.dir")+path+fileName);
        try (Writer writer = new FileWriter(System.getProperty("user.dir") +path+ fileName)) {
            for (Map.Entry<String, String> entry : map.entrySet()) {
                writer.append(entry.getKey())
                        .append(',')
                        .append(entry.getValue())
                        .append(eol);
            }
        } catch (IOException ex) {
            ex.printStackTrace(System.err);
        }
    }
}
