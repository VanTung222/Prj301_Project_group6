package constant;

import util.ConfigUtil;

public class Iconstant {
    public static final String GOOGLE_CLIENT_ID = ConfigUtil.getEnv("GOOGLE_CLIENT_ID", "default_client_id");
    public static final String GOOGLE_CLIENT_SECRET = ConfigUtil.getEnv("GOOGLE_CLIENT_SECRET", "default_client_secret");
    public static final String GOOGLE_REDIRECT_URI = ConfigUtil.getEnv("GOOGLE_REDIRECT_URI", "http://localhost:8080/MyLogin/signup");
    public static final String GOOGLE_GRANT_TYPE = "authorization_code";
    public static final String GOOGLE_LINK_GET_TOKEN = "https://accounts.google.com/o/oauth2/token";
    public static final String GOOGLE_LINK_GET_USER_INFO = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=";
}
