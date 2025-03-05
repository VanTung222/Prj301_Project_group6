 
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


--------------------------------------------------------------------------------



-- Supplier Table
CREATE TABLE Supplier (
    ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Phone VARCHAR(20),
    Email VARCHAR(255)
);

-- Product Category Table
CREATE TABLE Product_Category (
    Category_ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Created_Date DATE,
    Updated_Date DATE
);

-- Product Table
CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Price DECIMAL(10,2),
    Stock INT,
    Product_Description TEXT,
    Product_Category_ID INT,
    Supplier_ID INT,
    FOREIGN KEY (Product_Category_ID) REFERENCES Product_Category(Category_ID),
    FOREIGN KEY (Supplier_ID) REFERENCES Supplier(ID)
);

CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    FirstName NVARCHAR(255),
    LastName NVARCHAR(255),
    Email NVARCHAR(255),
    Password NVARCHAR(255),
    Address NVARCHAR(MAX),
    Phone NVARCHAR(20),
    Registration_Date DATE,
    Role NVARCHAR(50)
);

-- Employee Table
CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Name NVARCHAR(255),
    Password NVARCHAR(255),
    Salary DECIMAL(10,2),
    Address NVARCHAR(MAX),
    Phone NVARCHAR(20),
    Role NVARCHAR(100)
);

-- Shopping Cart Table
CREATE TABLE Shopping_Cart (
    Cart_ID INT PRIMARY KEY,
    Customer_ID INT,
    Created_Date DATE,
    Updated_Date DATE,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

-- Order Table
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT,
    Employee_ID INT,
    Status NVARCHAR(50),
    Order_Date DATE,
    Payment_Status NVARCHAR(50),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);

-- Order Detail Table
CREATE TABLE OrderDetail (
    OrderDetail_ID INT PRIMARY KEY,
    Order_ID INT,
    Product_ID INT,
    Quantity INT,
    Subtotal DECIMAL(10,2),
    Delivery_Address NVARCHAR(MAX),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

-- Payment Table
CREATE TABLE Payment (
    Payment_ID INT PRIMARY KEY,
    Order_ID INT,
    Customer_ID INT,
    Employee_ID INT,
    Amount DECIMAL(10,2),
    Method NVARCHAR(50),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);

-- Review Table
CREATE TABLE Review (
    Review_ID INT PRIMARY KEY,
    Customer_ID INT,
    Product_ID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment NVARCHAR(MAX),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

-- Shipper Table
CREATE TABLE Shipper (
    Shipper_ID INT PRIMARY KEY,
    Shipment_Tracking NVARCHAR(255),
    Quantity INT
);


CREATE TABLE Favorite_Products (
    Favorite_ID INT IDENTITY(1,1) PRIMARY KEY,
    Customer_ID INT,
    Product_ID INT,
    Added_Date DATE DEFAULT GETDATE(),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

-- Insert Data
INSERT INTO Supplier (ID, Name, Phone, Email) VALUES
(1, N'Công Ty TNHH Minh Phát', N'0987654321', N'minhphat@gmail.com'),
(2, N'Công Ty Cổ Phần Việt Hưng', N'0978123456', N'viethung@gmail.com');

INSERT INTO Product_Category (Category_ID, Name, Created_Date, Updated_Date) VALUES
(1, N'Điện tử', '2024-01-01', '2024-02-01'),
(2, N'Gia dụng', '2024-01-05', '2024-02-10');

INSERT INTO Product (Product_ID, Name, Price, Stock, Product_Description, Product_Category_ID, Supplier_ID) VALUES
(1, N'Điện thoại Samsung', 15000000, 50, N'Điện thoại thông minh Samsung', 1, 1),
(2, N'Máy giặt Toshiba', 7000000, 30, N'Máy giặt cửa ngang Toshiba', 2, 2);

INSERT INTO Customers (Customer_ID, FirstName, LastName, Email, Password, Address, Phone, Registration_Date, Role) VALUES
(1, N'Nguyễn', N'Văn A', N'nguyenvana@gmail.com', N'123456', N'Hà Nội', N'0912345678', '2024-02-20', N'Customer'),
(2, N'Trần', N'Thị B', N'tranthib@gmail.com', N'654321', N'TP. HCM', N'0987654321', '2024-02-22', N'Customer');

INSERT INTO Employee (Employee_ID, Name, Password, Salary, Address, Phone, Role) VALUES
(1, N'Lê Hoàng C', N'abcdef', 12000000, N'Đà Nẵng', N'0934567890', N'Nhân viên bán hàng'),
(2, N'Phạm Minh D', N'123abc', 15000000, N'Hải Phòng', N'0961234567', N'Quản lý kho');

INSERT INTO Orders (Order_ID, Customer_ID, Employee_ID, Status, Order_Date, Payment_Status) VALUES
(1, 1, 1, N'Đang xử lý', '2024-02-25', N'Chưa thanh toán'),
(2, 2, 2, N'Hoàn thành', '2024-02-26', N'Đã thanh toán');

INSERT INTO OrderDetail (OrderDetail_ID, Order_ID, Product_ID, Quantity, Subtotal, Delivery_Address) VALUES
(1, 1, 1, 1, 15000000, N'Hà Nội'),
(2, 2, 2, 1, 7000000, N'TP. HCM');

INSERT INTO Payment (Payment_ID, Order_ID, Customer_ID, Employee_ID, Amount, Method) VALUES
(1, 2, 2, 2, 7000000, N'Chuyển khoản');

INSERT INTO Review (Review_ID, Customer_ID, Product_ID, Rating, Comment) VALUES
(1, 1, 1, 5, N'Sản phẩm rất tốt'),
(2, 2, 2, 4, N'Chất lượng ổn');

SELECT o.Order_ID, c.FirstName, c.LastName, e.Name AS Employee_Name, o.Status, o.Order_Date
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
JOIN Employee e ON o.Employee_ID = e.Employee_ID;

SELECT od.OrderDetail_ID, p.Name AS Product_Name, od.Quantity, od.Subtotal, od.Delivery_Address
FROM OrderDetail od
JOIN Product p ON od.Product_ID = p.Product_ID;

SELECT r.Review_ID, c.FirstName, c.LastName, p.Name AS Product_Name, r.Rating, r.Comment
FROM Review r
JOIN Customers c ON r.Customer_ID = c.Customer_ID
JOIN Product p ON r.Product_ID = p.Product_ID;