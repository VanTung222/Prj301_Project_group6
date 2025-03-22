package model;

import java.util.Date;
import java.util.List;

public class Order {

    private int orderId;
    private int customerId;
    private Integer employeeId; // Có thể null
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
    private Integer shipperId; // Có thể null
    private Date estimatedDeliveryDate;
    private String status;
    private List<OrderDetail> orderDetails; // Danh sách chi tiết đơn hàng

    // Constructor
    public Order() {
    }

    // Constructor đầy đủ
    public Order(int orderId, int customerId, Integer employeeId, Date orderDate, double totalAmount,
            String shippingFirstName, String shippingLastName, String shippingAddress, String city,
            String countryState, String postcode, String phone, String email, String orderNotes,
            String couponCode, double discountAmount, String paymentMethod, Integer shipperId,
            Date estimatedDeliveryDate, String status) {
        this.orderId = orderId;
        this.customerId = customerId;
        this.employeeId = employeeId;
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
        this.shipperId = shipperId;
        this.estimatedDeliveryDate = estimatedDeliveryDate;
        this.status = status;
    }

    // Getters và Setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public Integer getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(Integer employeeId) {
        this.employeeId = employeeId;
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

    public Integer getShipperId() {
        return shipperId;
    }

    public void setShipperId(Integer shipperId) {
        this.shipperId = shipperId;
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

    public List<OrderDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }
}
