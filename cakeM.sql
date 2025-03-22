drop database managerCake
CREATE DATABASE managerCake
USE managerCake

DROP TABLE Customers
CREATE TABLE Customers (
    Customer_ID INT IDENTITY(1,1) PRIMARY KEY,
	GoogleID NVARCHAR(50), 
	Username VARCHAR(50) UNIQUE NOT NULL,
	Email NVARCHAR(255),
	FirstName NVARCHAR(255),
    LastName NVARCHAR(255),
    Password NVARCHAR(255) not null,
	ProfilePicture NVARCHAR(255),
    Address NVARCHAR(MAX),
    Phone NVARCHAR(20),
    Registration_Date DATE,
    Role BIT DEFAULT 1
);
SELECT * FROM Customers

INSERT INTO Customers (Username, Email, Password, Role) 
VALUES ('admin1', 'admin1@gmail.com', '123', 0);


DROP TABLE Supplier
-- Supplier Table
CREATE TABLE Supplier (
    ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Phone VARCHAR(20),
    Email VARCHAR(255)
);

-- Product Category Table
DROP TABLE Product_Category

CREATE TABLE Product_Category (
    Category_ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Created_Date DATE,
    Updated_Date DATE
);

SELECT * FROM Product_Category

-- Product Table
DROP TABLE Product

CREATE TABLE Product (
    Product_ID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(255),
    Price DECIMAL(10,2),
    Stock INT,
    Product_Description TEXT,
    Product_Category_ID INT,
    Supplier_ID INT,
	Product_img NVARCHAR(255),
    FOREIGN KEY (Product_Category_ID) REFERENCES Product_Category(Category_ID),
    FOREIGN KEY (Supplier_ID) REFERENCES Supplier(ID)
);
SELECT * FROM Product

-- Employee Table
DROP TABLE Employee

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
DROP TABLE Shopping_Cart

CREATE TABLE Shopping_Cart (
    Cart_ID INT IDENTITY(1,1) PRIMARY KEY,
    Customer_ID INT,
    Product_ID INT,
    Quantity INT DEFAULT 1, -- Thêm ngay từ đầu thay vì ALTER sau
    Created_Date DATE DEFAULT GETDATE(),
    Updated_Date DATE DEFAULT GETDATE(),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

SELECT * FROM Shopping_Cart

-- Order Table
DROP TABLE Orders
SELECT * FROM Orders
-- Order Table (Đã chỉnh sửa)
CREATE TABLE Orders (
    Order_ID INT IDENTITY(1,1) PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Employee_ID INT, -- Có thể NULL nếu chưa có nhân viên xử lý
    Order_Date DATETIME DEFAULT GETDATE(),
    Total_Amount DECIMAL(10, 2) NOT NULL,
    Shipping_FirstName NVARCHAR(50) NOT NULL,  -- Tên người nhận
    Shipping_LastName NVARCHAR(50) NOT NULL,   -- Họ người nhận
    Shipping_Address NVARCHAR(255) NOT NULL,   -- Địa chỉ giao hàng
    City NVARCHAR(100) NOT NULL,
    Country_State NVARCHAR(100) NOT NULL,
    Postcode NVARCHAR(20) NOT NULL,
    Phone NVARCHAR(20) NOT NULL,
    Email NVARCHAR(255) NOT NULL,
    Order_Notes NVARCHAR(MAX),                 -- Ghi chú đơn hàng
    Coupon_Code NVARCHAR(50),                  -- Mã giảm giá
    Discount_Amount DECIMAL(10, 2) DEFAULT 0,  -- Số tiền giảm giá
	Payment_Method NVARCHAR(50) NOT NULL,      -- Phương thức thanh toán
    Shipper_ID INT,                            -- ID nhà vận chuyển
    Estimated_Delivery_Date DATE,              -- Ngày giao hàng dự kiến
    Status NVARCHAR(50) DEFAULT 'Pending' CHECK (Status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled')),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
    FOREIGN KEY (Shipper_ID) REFERENCES Shipper(Shipper_ID)
);

SELECT * FROM Orders

-- Order Detail Table (Đổi tên từ OrderDetail cho đồng bộ)
DROP Table OrderDetail
CREATE TABLE Order_Details (
    Order_Detail_ID INT IDENTITY(1,1) PRIMARY KEY,
    Order_ID INT,
    Product_ID INT,
    Quantity INT CHECK (Quantity > 0),
    Unit_Price DECIMAL(10, 2) NOT NULL, -- Giá tại thời điểm đặt hàng
    Subtotal AS (Quantity * Unit_Price), -- Tính tự động
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

-- Payment Table
DROP TABLE Payment
CREATE TABLE Payment (
    Payment_ID INT IDENTITY(1,1) PRIMARY KEY,
    Order_ID INT,
    Customer_ID INT,
    Employee_ID INT,
    Amount DECIMAL(10,2),
    Method NVARCHAR(50),
    Payment_Date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);

-- Review Table
DROP TABLE Review

CREATE TABLE Reviews (
    Review_ID INT IDENTITY(1,1) PRIMARY KEY,
    Product_ID INT NOT NULL,
    Customer_ID INT NOT NULL,
    Rating INT NOT NULL CHECK (Rating >= 1 AND Rating <= 5),
    Comment NVARCHAR(1000) NOT NULL,
    Review_Date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);
SELECT * FROM Reviews

-- Shipper Table
DROP TABLE Shipper

CREATE TABLE Shipper (
    Shipper_ID INT PRIMARY KEY,
    Shipment_Tracking NVARCHAR(255),
    Quantity INT
);



DROP TABLE Favorite_Products

CREATE TABLE Favorite_Products (
    Favorite_ID INT IDENTITY(1,1) PRIMARY KEY,
    Customer_ID INT,
    Product_ID INT,
    Added_Date DATE DEFAULT GETDATE(),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);
SELECT * FROM Favorite_Products


-- Insert Data

-- Insert data into Product_Category
INSERT INTO Product_Category (Category_ID, Name, Created_Date, Updated_Date) 
VALUES 
(1, 'Cupcakes', '2024-03-07', '2024-03-07'),
(2, 'Cookies', '2024-03-07', '2024-03-07'),
(3, 'Cakes', '2024-03-07', '2024-03-07'),
(4, 'Pastries', '2024-03-07', '2024-03-07');

-- Insert data into Shipper
INSERT INTO Shipper (Shipper_ID, Shipment_Tracking, Quantity) 
VALUES 
(1, 'TRACK123456', 50),
(2, 'TRACK789012', 100),
(3, 'TRACK345678', 75),
(4, 'TRACK901234', 120);

-- Insert data into Supplier
INSERT INTO Supplier (ID, Name, Phone, Email) 
VALUES 
(1, 'SweetTreats Supplies', '0987654321', 'contact@sweettreats.com'),
(2, 'Baking Essentials Co.', '0978123456', 'info@bakingessentials.com'),
(3, 'Cake Masters Ltd.', '0967345678', 'support@cakemasters.com'),
(4, 'Premium Ingredients Inc.', '0956123456', 'sales@premiumingredients.com');

INSERT INTO Product (Name, Price, Stock, Product_Description, Product_Category_ID, Supplier_ID, Product_img) 
VALUES 
('Dozen Cupcakes', 32.00, 100, 'A dozen delicious cupcakes and Delicious cookies', 4, 1, 'img/shop/product-1.jpg'),
('Cookies and Cream', 30.00, 100, 'Delicious cookies and cream flavored cupcakes', 4, 4, 'img/shop/product-2.jpg'),
('Gluten Free Mini Dozen', 31.00, 100, 'Gluten-free mini cupcakes, perfect for any occasion', 4, 1, 'img/shop/product-3.jpg'),
('Cookie Dough', 25.00, 100, 'Cupcake with cookie dough topping', 4, 2, 'img/shop/product-4.jpg'),
('Vanilla Salted Caramel', 5.00, 100, 'Classic vanilla with salted caramel topping', 1, 2, 'img/shop/product-5.jpg'),
('German Chocolate', 14.00, 100, 'Rich chocolate cupcake with coconut and pecan frosting', 1, 3, 'img/shop/product-6.jpg'),
('Dulce De Leche', 32.00, 100, 'Sweet caramel-flavored cupcake and cream flavored cupcakes', 1, 4, 'img/shop/product-7.jpg'),
('Mississippi Mud', 8.00, 100, 'Chocolate cupcake with marshmallow frosting', 4, 3, 'img/shop/product-8.jpg');

INSERT INTO Favorite_Products (Customer_ID, Product_ID)
VALUES 
(1, 1), 
(1, 2), 
(2, 3),
(2, 4);

INSERT INTO Reviews ( Customer_ID, Product_ID, Rating, Comment) VALUES
( 1, 1, 5, N'Sản phẩm rất tốt'),
( 2, 2, 4, N'Chất lượng ổn');



-- Cập nhật ProfilePicture cho bảng Customers
UPDATE Customers SET ProfilePicture = 'img/team/team-1.jpg' WHERE Customer_ID = 1;
UPDATE Customers SET ProfilePicture = 'img/team/team-2.jpg' WHERE Customer_ID = 2;
UPDATE Customers SET ProfilePicture = 'img/team/team-3.jpg' WHERE Customer_ID = 3;
UPDATE Customers SET ProfilePicture = 'img/team/team-4.jpg' WHERE Customer_ID = 4;
UPDATE Customers SET ProfilePicture = 'img/team/team-5.jpg' WHERE Customer_ID = 5;

INSERT INTO Shopping_Cart (Customer_ID, Product_ID, Quantity, Created_Date, Updated_Date)
VALUES (1, 1, 1, '2025-03-18', '2025-03-18')

INSERT INTO Customers (GoogleID, Email, Username, FirstName, LastName, Password, ProfilePicture, Address, Phone, Registration_Date, Role)
VALUES
  (NULL, 'john.doe@example.com', 'john_doe', 'John', 'Doe', 'password123', NULL, '123 Main St, City', '1234567890', '2025-03-21', 1),
  (NULL, 'jane.doe@example.com', 'jane_doe', 'Jane', 'Doe', 'password456', NULL, '456 Elm St, City', '0987654321', '2025-03-21', 1),
  (NULL, 'alice@example.com', 'alice', 'Alice', 'Smith', 'alicepwd', NULL, '789 Pine St, City', '1112223333', '2025-03-21', 1),
  (NULL, 'bob@example.com', 'bob', 'Bob', 'Johnson', 'bobpwd', NULL, '321 Oak St, City', '2223334444', '2025-03-21', 1),
  (NULL, 'charlie@example.com', 'charlie', 'Charlie', 'Brown', 'charliepwd', NULL, '654 Maple St, City', '3334445555', '2025-03-21', 1),
  (NULL, 'david@example.com', 'david', 'David', 'Williams', 'davidpwd', NULL, '987 Cedar St, City', '4445556666', '2025-03-21', 1),
  (NULL, 'emma@example.com', 'emma', 'Emma', 'Jones', 'emmapwd', NULL, '135 Spruce St, City', '5556667777', '2025-03-21', 1),
  (NULL, 'frank@example.com', 'frank', 'Frank', 'Miller', 'frankpwd', NULL, '246 Birch St, City', '6667778888', '2025-03-21', 1),
  (NULL, 'grace@example.com', 'grace', 'Grace', 'Davis', 'gracepwd', NULL, '357 Walnut St, City', '7778889999', '2025-03-21', 1),
  (NULL, 'henry@example.com', 'henry', 'Henry', 'Wilson', 'henrypwd', NULL, '468 Chestnut St, City', '8889990000', '2025-03-21', 1);
