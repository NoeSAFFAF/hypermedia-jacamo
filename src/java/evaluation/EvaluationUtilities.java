package evaluation;
import tools.CSVTools;

import java.util.*;

/**
 * @author : Noé SAFFAF
 * @since : 22/06/2021, mar.
 **/
public class EvaluationUtilities {
    public static void writeData(List<Long> longList, String fileName){
        Map<String, String> map = new LinkedHashMap();
        int i = 0;
        for (Long l : longList){
            i++;
            map.put(Integer.toString(i),l.toString());
        }
        CSVTools.writeMapToCSV(map,fileName);
    }
}
