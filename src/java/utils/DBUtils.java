package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtils {

    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        String user = "sa";
        String password = "Tung@123456789";
        Connection connection = null;
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String url = "jdbc:sqlserver://TUNG\\VANTUNG:1433;databaseName=managementSignUp;encrypt=false;trustServerCertificate=true";
        connection = DriverManager.getConnection(url, user, password);
        return connection;
    }
//    private static final String URL = "jdbc:sqlserver://127.0.0.1:1433;databaseName=managementSignUp;encrypt=false;trustServerCertificate=true";
//    private static final String USER = "sa";
//    private static final String PASSWORD = "Tung@123456789";
//
//    public static Connection getConnection() throws SQLException, ClassNotFoundException {
//        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
//        return DriverManager.getConnection(URL, USER, PASSWORD);
//    }
}           
