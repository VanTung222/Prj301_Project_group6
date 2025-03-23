package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.ShippingAddress;
import utils.DBUtils;

public class ShippingAddressDAO {

    public int addShippingAddress(ShippingAddress address) throws SQLException, ClassNotFoundException {
        try (Connection conn = DBUtils.getConnection()) {
            String query = "INSERT INTO Shipping_Addresses (Customer_ID, First_Name, Last_Name, Address, City, " +
                          "Country_State, Postcode, Phone, Email) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, address.getCustomerId());
            stmt.setString(2, address.getFirstName());
            stmt.setString(3, address.getLastName());
            stmt.setString(4, address.getAddress());
            stmt.setString(5, address.getCity());
            stmt.setString(6, address.getCountryState());
            stmt.setString(7, address.getPostcode());
            stmt.setString(8, address.getPhone());
            stmt.setString(9, address.getEmail());
            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // Trả về Address_ID
            }
            throw new SQLException("Failed to add shipping address.");
        }
    }

    public List<ShippingAddress> getShippingAddresses(int customerId) throws SQLException, ClassNotFoundException {
        List<ShippingAddress> addresses = new ArrayList<>();
        try (Connection conn = DBUtils.getConnection()) {
            String query = "SELECT DISTINCT * FROM Shipping_Addresses WHERE Customer_ID = ?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                ShippingAddress address = new ShippingAddress();
                address.setAddressId(rs.getInt("Address_ID"));
                address.setCustomerId(rs.getInt("Customer_ID"));
                address.setFirstName(rs.getString("First_Name"));
                address.setLastName(rs.getString("Last_Name"));
                address.setAddress(rs.getString("Address"));
                address.setCity(rs.getString("City"));
                address.setCountryState(rs.getString("Country_State"));
                address.setPostcode(rs.getString("Postcode"));
                address.setPhone(rs.getString("Phone"));
                address.setEmail(rs.getString("Email"));
                addresses.add(address);
            }
        }
        return addresses;
    }
}