import org.intermine.neo4j.Neo4jLoaderProperties;
import org.intermine.neo4j.Neo4jModelParser;

import org.apache.commons.io.IOUtils;
import org.intermine.metadata.ModelParserException;
import org.intermine.neo4j.cypher.QueryGenerator;
import org.intermine.pathquery.PathException;
import org.intermine.pathquery.PathQuery;
import org.intermine.webservice.client.services.QueryService;
import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.io.InputStream;

/**
 * Created by yash on 5/8/17.
 */
public class TestModelParser {
    public static void main(String[] args) throws IOException, ModelParserException, SAXException, ParserConfigurationException, PathException {
        Neo4jLoaderProperties props = new Neo4jLoaderProperties();
        Neo4jModelParser parser = new Neo4jModelParser();

        parser.process(props);
        PathQuery pathQuery = getPathQuery("pathquery.xml", props.getQueryService());

        System.out.println(QueryGenerator.pathQueryToCypher(pathQuery).toString());

        System.out.println(parser.getRelationshipType("Gene", "Chromosome"));
    }

    private static PathQuery getPathQuery(String name, QueryService queryService) throws IOException {
        String path = name;
        System.out.println("Path is " + path);
        InputStream is = TestModelParser.class.getClassLoader().getResourceAsStream(path);
        if (is == null) {
            System.out.println("Could not find the required XML file: " + path);
        }
        String pathQueryString = IOUtils.toString(is).replaceAll("\n$", "");
        PathQuery pathQuery = queryService.createPathQuery(pathQueryString);
        return pathQuery;
    }
}
