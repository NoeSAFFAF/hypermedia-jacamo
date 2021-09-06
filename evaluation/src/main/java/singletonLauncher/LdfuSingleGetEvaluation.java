package singletonLauncher;

import edu.kit.aifb.datafu.*;
import edu.kit.aifb.datafu.consumer.impl.BindingConsumerCollection;
import edu.kit.aifb.datafu.io.input.request.EvaluateRequestOrigin;
import edu.kit.aifb.datafu.io.origins.RequestOrigin;
import edu.kit.aifb.datafu.io.sinks.BindingConsumerSink;
import org.semanticweb.yars.nx.Node;

import java.io.*;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.LogManager;
import java.util.logging.Logger;

/**
 * @author : Noé SAFFAF
 * @since : 01/07/2021, jeu.
 *
 *
 * Simple java code to run multiple identical get requests to a triplestore server (I use apache jena fuseki)
 * and measure the elapsed time for each operation en save the results in a file
 **/
public class LdfuSingleGetEvaluation {

    private static final String originURI = "http://localhost:3030/simulatedSingleton?graph=NodeID_1";
    //private static final String originURI = "http://localhost:3030/dataLdfu?graph=evaluationTest";
    private static final String fileName = "LdfuGetSingle.csv";
    private static final int n = 100;
    private static List<Long> longList;

    public static void main(String[] args) throws URISyntaxException, InterruptedException {


        longList = new ArrayList<Long>();
        // set logging level to warning
        Logger log = Logger.getLogger("edu.kit.aifb.datafu");
        log.setLevel(Level.OFF);
        LogManager.getLogManager().addLogger(log);


        for (int i = 1; i <= n; i++){
            long start = System.currentTimeMillis();
            RequestOrigin req = new RequestOrigin(new URI(originURI), Request.Method.GET);
            BindingConsumerCollection triples = new BindingConsumerCollection();
            EvaluateRequestOrigin eval = new EvaluateRequestOrigin();
            eval.setTripleCallback(new BindingConsumerSink(triples));

            eval.consume(req);
            eval.shutdown();
            for (Binding binding : triples.getCollection()) {
                Node[] st = binding.getNodes().getNodeArray();
            }

            long end = System.currentTimeMillis();
            longList.add(end-start);
        }

        Map<String, String> map = new LinkedHashMap();
        int i = 0;
        for (Long l : longList){
            i++;
            map.put(Integer.toString(i),l.toString());
        }
        String path = "\\output\\";
        String eol = System.getProperty("line.separator");
        System.out.println(System.getProperty("user.dir")+fileName);
        try (Writer writer = new FileWriter(System.getProperty("user.dir") + path + fileName)) {
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
