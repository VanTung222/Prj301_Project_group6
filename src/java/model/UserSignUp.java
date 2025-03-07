package model;

public class UserSignUp {
    private int userID;
    private String googleID;
    private String email;
    private String fullName;
    private String givenName;
    private String familyName;
    private String profilePicture;
    private boolean verifiedEmail;

    public UserSignUp() {}

    public UserSignUp(int userID, String googleID, String email, String fullName, String givenName, 
                     String familyName, String profilePicture, boolean verifiedEmail) {
        this.userID = userID;
        this.googleID = googleID;
        this.email = email;
        this.fullName = fullName;
        this.givenName = givenName;
        this.familyName = familyName;
        this.profilePicture = profilePicture;
        this.verifiedEmail = verifiedEmail;
    }

    public int getUserID() { return userID; }
    public void setUserID(int userID) { this.userID = userID; }
    public String getGoogleID() { return googleID; }
    public void setGoogleID(String googleID) { this.googleID = googleID; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getGivenName() { return givenName; }
    public void setGivenName(String givenName) { this.givenName = givenName; }
    public String getFamilyName() { return familyName; }
    public void setFamilyName(String familyName) { this.familyName = familyName; }
    public String getProfilePicture() { return profilePicture; }
    public void setProfilePicture(String profilePicture) { this.profilePicture = profilePicture; }
    public boolean isVerifiedEmail() { return verifiedEmail; }
    public void setVerifiedEmail(boolean verifiedEmail) { this.verifiedEmail = verifiedEmail; }

    @Override
    public String toString() {
        return "UserSignUp{userID=" + userID + ", googleID='" + googleID + "', email='" + email + 
               "', fullName='" + fullName + "', givenName='" + givenName + "', familyName='" + familyName + 
               "', profilePicture='" + profilePicture + "', verifiedEmail=" + verifiedEmail + "}";
    }
}