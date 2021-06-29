package tools;

import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

/**
 * A couple of CSV tools
 * @author Noé Saffaf
 */
public class CSVTools {

    public static void writeMapToCSV(Map<String,String> map, String fileName){
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

    public static Map<String, String> readCSVtoMap(String resource) {
        Map<String, String> map = new HashMap();
        InputStream in = CSVTools.class.getClassLoader().getResourceAsStream(resource);
        Scanner myReader = new Scanner(in);
        while (myReader.hasNextLine()) {
            String data = myReader.nextLine();
            String[] s = data.split(",");
            if (s.length == 2) {
                map.put(s[0] + ":", IRITools.removeQuotationMarks(s[1]));
            }
        }
        myReader.close();
        return map;
    }

}