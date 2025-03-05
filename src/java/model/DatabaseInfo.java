package model;

import com.sun.jdi.connect.spi.Connection;
import java.sql.*;


public interface DatabaseInfo {

    public static String DRIVERNAME = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    String DBURL = "jdbc:sqlserver://127.0.0.1:1433;databaseName=managementSignUp;encrypt=false;trustServerCertificate=true";

//    public static String DBURL="jdbc:sqlserver://DESKTOP-09JBLVE;databaseName=FruitShop;encrypt=false;trustServerCertificate=false;loginTimeout=30;";
    public static String USERDB = "sa";
    public static String PASSDB = "1357910";
    
    
     public static Connection getConnection() throws SQLException {
        return (Connection) DriverManager.getConnection(DBURL, USERDB, PASSDB);
    }

}
