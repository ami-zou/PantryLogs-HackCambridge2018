package computerVisioning;
import java.net.URI;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;

//https://docs.microsoft.com/en-us/azure/cognitive-services/Computer-vision/QuickStarts/Java
public class Main {
    // Replace the subscriptionKey string value with your valid subscription key.
    public static final String subscriptionKey = "3c948fecbdf64ac4957ab87e575c4fd5";
    public static final String region = "unitedstates";
    public static final String uriBase = "https://westcentralus.api.cognitive.microsoft.com/vision/v1.0/analyze"; //analyze
    
    //For analyze 
    public static void main(String[] arg) {
    		HttpClient httpclient = new DefaultHttpClient();
    		
    		try
            {
                URIBuilder builder = new URIBuilder(uriBase);

                // Request parameters. All of them are optional.
                builder.setParameter("visualFeatures", "Categories,Description,Color");
                builder.setParameter("language", "en");

                // Prepare the URI for the REST API call.
                URI uri = builder.build();
                HttpPost request = new HttpPost(uri);

                // Request headers.
                request.setHeader("Content-Type", "application/json");
                request.setHeader("Ocp-Apim-Subscription-Key", subscriptionKey);

                // Request body.
                StringEntity reqEntity = new StringEntity("{\"url\":\"https://upload.wikimedia.org/wikipedia/commons/1/12/Broadway_and_Times_Square_by_night.jpg\"}");
                request.setEntity(reqEntity);

                // Execute the REST API call and get the response entity.
                HttpResponse response = httpclient.execute(request);
                HttpEntity entity = response.getEntity();

                if (entity != null)
                {
                    // Format and display the JSON response.
                    String jsonString = EntityUtils.toString(entity);
                    JSONObject json = new JSONObject(jsonString);
                    System.out.println("REST Response:\n");
                    System.out.println(json.toString(2));
                }
            }
            catch (Exception e)
            {
                // Display error message.
                System.out.println(e.getMessage());
            }
    }
}
