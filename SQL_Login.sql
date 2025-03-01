 CREATE DATABASE managementSignUp
USE managementSignUp
DROP TABLE userSignUp

CREATE TABLE userSignUp (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    GoogleID NVARCHAR(50) UNIQUE,
    Email NVARCHAR(100) UNIQUE,
    FullName NVARCHAR(100) ,
    GivenName NVARCHAR(50),
    FamilyName NVARCHAR(50),
    ProfilePicture NVARCHAR(255),
    VerifiedEmail BIT DEFAULT 1
);

SELECT * FROM userSignUp


CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL
);

SELECT * FROM users

drop table usersV2
CREATE TABLE usersV2 (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50)  UNIQUE,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL
);

SELECT * FROM usersV2
