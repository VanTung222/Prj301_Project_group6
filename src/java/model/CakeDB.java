package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CakeDB implements DatabaseInfo {

    public static Connection getConnect() {
        try {
            Class.forName(DRIVERNAME);
        } catch (ClassNotFoundException e) {
            System.out.println("Error loading driver: " + e);
        }
        try {
            return DriverManager.getConnection(DBURL, USERDB, PASSDB);
        } catch (SQLException e) {
            System.out.println("Error connecting to database: " + e);
        }
        return null;
    }

    public static Cake getCake(int id) {
        Cake cake = null;
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT Name, Price, Stock, Product_Description FROM Product WHERE Product_ID = ?");
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                cake = new Cake(id, rs.getString("Name"), rs.getDouble("Price"), rs.getInt("Stock"), rs.getString("Product_Description"));
            }
            con.close();
        } catch (Exception ex) {
            Logger.getLogger(CakeDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cake;
    }

    public static boolean addCake(Cake cake) {
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("INSERT INTO Product (Name, Price, Stock, Product_Description) VALUES (?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, cake.getName());
            stmt.setDouble(2, cake.getPrice());
            stmt.setInt(3, cake.getStock());
            stmt.setString(4, cake.getDescription());
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        } catch (Exception ex) {
            Logger.getLogger(CakeDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static boolean updateCake(Cake cake) {
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("UPDATE Product SET Name = ?, Price = ?, Stock = ?, Product_Description = ? WHERE Product_ID = ?");
            stmt.setString(1, cake.getName());
            stmt.setDouble(2, cake.getPrice());
            stmt.setInt(3, cake.getStock());
            stmt.setString(4, cake.getDescription());
            stmt.setInt(5, cake.getId());
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        } catch (Exception ex) {
            Logger.getLogger(CakeDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static boolean deleteCake(int id) {
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("DELETE FROM Product WHERE Product_ID = ?");
            stmt.setInt(1, id);
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        } catch (Exception ex) {
            Logger.getLogger(CakeDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public static List<Cake> listAllCakes() {
        List<Cake> cakes = new ArrayList<>();
        try (Connection con = getConnect()) {
            PreparedStatement stmt = con.prepareStatement("SELECT Product_ID, Name, Price, Stock, Product_Description FROM Product");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                cakes.add(new Cake(
                        rs.getInt("Product_ID"),
                        rs.getString("Name"),
                        rs.getDouble("Price"),
                        rs.getInt("Stock"),
                        rs.getString("Product_Description")
                ));
            }
        } catch (Exception ex) {
            Logger.getLogger(CakeDB.class.getName()).log(Level.SEVERE, null, ex);
        }
        return cakes;
    }

    public static void main(String[] args) {
        List<Cake> cakes = CakeDB.listAllCakes();
        for (Cake cake : cakes) {
            System.out.println(cake);
        }
    }
}
