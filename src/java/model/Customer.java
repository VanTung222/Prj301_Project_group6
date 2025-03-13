package model;

import java.util.Date;

public class Customer {
    private int customerId;
    private String googleId;
    private String username;
    private String email;
    private String firstName;
    private String lastName;
    private String password;
    private String profilePicture;
    private String address;
    private String phone;
    private Date registrationDate;
    private boolean role; // 1: user, 0: admin

    // Constructor đầy đủ
    public Customer(int customerId, String googleId, String username, String email, String firstName, 
                    String lastName, String password, String profilePicture, String address, 
                    String phone, Date registrationDate, boolean role) {
        this.customerId = customerId;
        this.googleId = googleId;
        this.email = email;
        this.username = username;
        this.firstName = firstName;
        this.lastName = lastName;
        this.password = password;
        this.profilePicture = profilePicture;
        this.address = address;
        this.phone = phone;
        this.registrationDate = registrationDate;
        this.role = role;
    }

    public Customer(int customerId, String googleId, String username, String email,  String firstName, String lastName, String profilePicture, boolean role) {
        this.customerId = customerId;
        this.googleId = googleId;
        this.email = email;
        this.username = username;
        this.firstName = firstName;
        this.lastName = lastName;
        this.profilePicture = profilePicture;
        this.role = role;
    }
    

    // Constructor tối thiểu cho đăng nhập
    public Customer(int customerId, String username, String email, String password) {
        this.customerId = customerId;
        this.username = username;
        this.email = email;
        this.password = password;
    }
    
    // Phương thức lấy họ tên đầy đủ
    public String getFullName() {
        if (firstName == null && lastName == null) return username;
        if (firstName == null) return lastName;
        if (lastName == null) return firstName;
        return firstName + " " + lastName;
    }

    // Getters và Setters
    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public String getGoogleId() { return googleId; }
    public void setGoogleId(String googleId) { this.googleId = googleId; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getProfilePicture() { return profilePicture; }
    public void setProfilePicture(String profilePicture) { this.profilePicture = profilePicture; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public Date getRegistrationDate() { return registrationDate; }
    public void setRegistrationDate(Date registrationDate) { this.registrationDate = registrationDate; }

    public boolean isRole() { return role; }
    public void setRole(boolean role) { this.role = role; }
}