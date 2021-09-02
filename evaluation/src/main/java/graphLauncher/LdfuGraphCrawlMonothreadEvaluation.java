package graphLauncher;

import edu.kit.aifb.datafu.*;
import edu.kit.aifb.datafu.consumer.impl.BindingConsumerCollection;
import edu.kit.aifb.datafu.engine.EvaluateProgram;
import edu.kit.aifb.datafu.io.origins.FileOrigin;
import edu.kit.aifb.datafu.io.origins.InternalOrigin;
import edu.kit.aifb.datafu.io.origins.RequestOrigin;
import edu.kit.aifb.datafu.io.sinks.BindingConsumerSink;
import edu.kit.aifb.datafu.parser.ProgramConsumerImpl;
import edu.kit.aifb.datafu.parser.QueryConsumerImpl;
import edu.kit.aifb.datafu.parser.notation3.Notation3Parser;
import edu.kit.aifb.datafu.parser.sparql.SparqlParser;
import edu.kit.aifb.datafu.planning.EvaluateProgramConfig;
import edu.kit.aifb.datafu.planning.EvaluateProgramGenerator;
import org.semanticweb.yars.nx.Node;

import java.io.*;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.LogManager;
import java.util.logging.Logger;

/**
 * @author : Noé SAFFAF
 * @since : 10/08/2021, mar.
 **/
public class LdfuGraphCrawlMonothreadEvaluation {
    private static final String COLLECT_QUERY = "construct { ?s ?p ?o . } where { ?s ?p ?o . }";
    private static Program program;
    private static BindingConsumerCollection triples;
    private static final String programFile = "getSimulationGraph.n3";
    private static final String originURI = "http://localhost:3030/simulatedGraph?graph=NodeID_1";
    private static final String fileName = "LdfuCrawlGraphMono.csv";
    private static List<Long> longList;

    private static final int n = 100;

    public static void main(String[] args)  throws edu.kit.aifb.datafu.parser.notation3.ParseException, IOException, edu.kit.aifb.datafu.parser.sparql.ParseException {
        longList = new ArrayList<Long>();

        InputStream is = LdfuGraphCrawlMonothreadEvaluation.class.getClassLoader().getResourceAsStream(programFile);
        System.out.println(is);
        Origin base = new FileOrigin(new File(programFile), FileOrigin.Mode.READ, null);
        Notation3Parser n3Parser = new Notation3Parser(is);
        ProgramConsumerImpl programConsumer = new ProgramConsumerImpl(base);

        n3Parser.parse(programConsumer, base);
        is.close();

        program = programConsumer.getProgram(base);

        QueryConsumerImpl queryConsumer = new QueryConsumerImpl(base);
        SparqlParser sparqlParser = new SparqlParser(new StringReader(COLLECT_QUERY));
        sparqlParser.parse(queryConsumer, new InternalOrigin(""));

        ConstructQuery query = queryConsumer.getConstructQueries().iterator().next();

        Logger log = Logger.getLogger("edu.kit.aifb.datafu");
        log.setLevel(Level.OFF);
        LogManager.getLogManager().addLogger(log);

        triples = new BindingConsumerCollection();
        program.registerConstructQuery(query, new BindingConsumerSink(triples));

        for (int i = 1; i <= n; i++) {
            long start = System.currentTimeMillis();
            if (program == null) {
                return;
            }

            EvaluateProgramConfig config = new EvaluateProgramConfig();
            config.setThreadingModel(EvaluateProgramConfig.ThreadingModel.SERIAL);
            config.setProcessingThreadCount(1);

            EvaluateProgram eval = new EvaluateProgramGenerator(program, config).getEvaluateProgram();
            eval.start();

            try {
                eval.getInputOriginConsumer().consume(new RequestOrigin(new URI(originURI), Request.Method.GET));
                eval.awaitIdleAndFinish();
                eval.shutdown();

                for (Binding binding : triples.getCollection()) {
                    Node[] st = binding.getNodes().getNodeArray();
                }
            } catch (InterruptedException e) {
                e.printStackTrace();
                // TODO recover or ignore?
            } catch (URISyntaxException e) {
                // TODO throw it to make operation fail?
                e.printStackTrace();
            }

            long end = System.currentTimeMillis();
            longList.add(end - start);
        }

        Map<String, String> map = new LinkedHashMap();
        int i = 0;
        for (Long l : longList) {
            i++;
            map.put(Integer.toString(i), l.toString());
        }
        String path = "\\output\\";
        String eol = System.getProperty("line.separator");
        System.out.println(System.getProperty("user.dir") + fileName);
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