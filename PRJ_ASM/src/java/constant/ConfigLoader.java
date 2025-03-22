package constant;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ConfigLoader {
    private static final Properties properties = new Properties();

    static {
        try (InputStream input = ConfigLoader.class.getClassLoader().getResourceAsStream("data/config.properties")) {
            if (input == null) {
                throw new IOException("File config.properties không tồn tại trong package data!");
            }
            properties.load(input);
        } catch (IOException e) {
            System.err.println("Không thể tải file cấu hình: " + e.getMessage());
        }
    }

    public static String get(String key) {
        return properties.getProperty(key);
    }
}
