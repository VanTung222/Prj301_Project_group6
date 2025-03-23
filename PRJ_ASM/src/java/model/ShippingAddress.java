package model;

public class ShippingAddress {
    private int addressId;
    private int customerId;
    private String firstName;
    private String lastName;
    private String address;
    private String city;
    private String countryState;
    private String postcode;
    private String phone;
    private String email;

    // Getters và setters (giữ nguyên)
    public int getAddressId() { return addressId; }
    public void setAddressId(int addressId) { this.addressId = addressId; }
    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }
    public String getCountryState() { return countryState; }
    public void setCountryState(String countryState) { this.countryState = countryState; }
    public String getPostcode() { return postcode; }
    public void setPostcode(String postcode) { this.postcode = postcode; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    // Cập nhật toString() để hiển thị chi tiết hơn
    @Override
    public String toString() {
        return firstName + " " + lastName + ", " + address + ", " + city + ", " + countryState + ", " + postcode + " (Phone: " + phone + ", Email: " + email + ")";
    }
}