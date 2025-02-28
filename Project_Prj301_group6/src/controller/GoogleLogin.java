
package controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import constant.Iconstant;
import emtyp.GoogleAccount;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;


public class GoogleLogin {
    public static String getToken(String code) throws IOException {
        CloseableHttpClient httpClient = HttpClients.createDefault();

        HttpPost post = new HttpPost(Iconstant.GOOGLE_LINK_GET_TOKEN);

        List<NameValuePair> params = new ArrayList<>();
        params.add(new BasicNameValuePair("client_id", Iconstant.GOOGLE_CLIENT_ID));
        params.add(new BasicNameValuePair("client_secret", Iconstant.GOOGLE_CLIENT_SECRET));
        params.add(new BasicNameValuePair("redirect_uri", Iconstant.GOOGLE_REDIRECT_URI));
        params.add(new BasicNameValuePair("code", code));
        params.add(new BasicNameValuePair("grant_type", Iconstant.GOOGLE_GRANT_TYPE));
        
        post.setEntity(new UrlEncodedFormEntity(params));

        CloseableHttpResponse response = httpClient.execute(post);
        String responseString = EntityUtils.toString(response.getEntity());
        JsonObject jsonObject = new Gson().fromJson(responseString, JsonObject.class);

        return jsonObject.get("access_token").getAsString();
    }
    
    public static GoogleAccount getUserInfo(final String accessToken) throws IOException {

         CloseableHttpClient httpClient = HttpClients.createDefault();
        HttpGet get = new HttpGet(Iconstant.GOOGLE_LINK_GET_USER_INFO + accessToken);

        CloseableHttpResponse response = httpClient.execute(get);
        String responseString = EntityUtils.toString(response.getEntity());

        return new Gson().fromJson(responseString, GoogleAccount.class);

    }
}
