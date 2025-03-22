/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
import java.sql.Timestamp;
import java.util.Date;

public class Order {

    private int orderID;
    private int customerID;
    private Integer employeeID; // Có thể null
    private Date orderDate;
    private double totalAmount;
    private String shippingFirstName;
    private String shippingLastName;
    private String shippingAddress;
    private String city;
    private String countryState;
    private String postcode;
    private String phone;
    private String email;
    private String orderNotes;
    private String couponCode;
    private double discountAmount;
    private String paymentMethod;
    private Integer shipperID;
    private Date estimatedDeliveryDate;
    private String status;

    public Order() {
    }

    public Order(int orderID, int customerID, Integer employeeID, Date orderDate, double totalAmount,
            String shippingFirstName, String shippingLastName, String shippingAddress, String city,
            String countryState, String postcode, String phone, String email, String orderNotes,
            String couponCode, double discountAmount, String paymentMethod, Integer shipperID,
            Date estimatedDeliveryDate, String status) {
        this.orderID = orderID;
        this.customerID = customerID;
        this.employeeID = employeeID;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.shippingFirstName = shippingFirstName;
        this.shippingLastName = shippingLastName;
        this.shippingAddress = shippingAddress;
        this.city = city;
        this.countryState = countryState;
        this.postcode = postcode;
        this.phone = phone;
        this.email = email;
        this.orderNotes = orderNotes;
        this.couponCode = couponCode;
        this.discountAmount = discountAmount;
        this.paymentMethod = paymentMethod;
        this.shipperID = shipperID;
        this.estimatedDeliveryDate = estimatedDeliveryDate;
        this.status = status;
    }

    public Order(int aInt, int aInt0, Timestamp timestamp, double aDouble) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    // Getters  Setters

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public Integer getEmployeeID() {
        return employeeID;
    }

    public void setEmployeeID(Integer employeeID) {
        this.employeeID = employeeID;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getShippingFirstName() {
        return shippingFirstName;
    }

    public void setShippingFirstName(String shippingFirstName) {
        this.shippingFirstName = shippingFirstName;
    }

    public String getShippingLastName() {
        return shippingLastName;
    }

    public void setShippingLastName(String shippingLastName) {
        this.shippingLastName = shippingLastName;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCountryState() {
        return countryState;
    }

    public void setCountryState(String countryState) {
        this.countryState = countryState;
    }

    public String getPostcode() {
        return postcode;
    }

    public void setPostcode(String postcode) {
        this.postcode = postcode;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getOrderNotes() {
        return orderNotes;
    }

    public void setOrderNotes(String orderNotes) {
        this.orderNotes = orderNotes;
    }

    public String getCouponCode() {
        return couponCode;
    }

    public void setCouponCode(String couponCode) {
        this.couponCode = couponCode;
    }

    public double getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(double discountAmount) {
        this.discountAmount = discountAmount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public Integer getShipperID() {
        return shipperID;
    }

    public void setShipperID(Integer shipperID) {
        this.shipperID = shipperID;
    }

    public Date getEstimatedDeliveryDate() {
        return estimatedDeliveryDate;
    }

    public void setEstimatedDeliveryDate(Date estimatedDeliveryDate) {
        this.estimatedDeliveryDate = estimatedDeliveryDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
}
