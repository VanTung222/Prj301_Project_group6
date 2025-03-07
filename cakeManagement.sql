drop database cakeManagement
CREATE DATABASE cakeManagement
USE cakeManagement


CREATE TABLE Customers (
    Customer_ID INT IDENTITY(1,1) PRIMARY KEY,
	GoogleID NVARCHAR(50), 
    Email NVARCHAR(255),
	Username VARCHAR(50) UNIQUE NOT NULL,
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

INSERT INTO Product (Name, Price, Stock, Product_Description, Product_Category_ID, Supplier_ID, Product_img) 
VALUES 
('Dozen Cupcakes', 32.00, 100, 'A dozen delicious cupcakes', 4, 1, 'img/shop/product-1.jpg'),
('Cookies and Cream', 30.00, 100, 'Delicious cookies and cream flavored cupcakes', 4, 4, 'img/shop/product-2.jpg'),
('Gluten Free Mini Dozen', 31.00, 100, 'Gluten-free mini cupcakes, perfect for any occasion', 4, 1, 'img/shop/product-3.jpg'),
('Cookie Dough', 25.00, 100, 'Cupcake with cookie dough topping', 4, 2, 'img/shop/product-4.jpg'),
('Vanilla Salted Caramel', 5.00, 100, 'Classic vanilla with salted caramel topping', 1, 2, 'img/shop/product-5.jpg'),
('German Chocolate', 14.00, 100, 'Rich chocolate cupcake with coconut and pecan frosting', 1, 3, 'img/shop/product-6.jpg'),
('Dulce De Leche', 32.00, 100, 'Sweet caramel-flavored cupcake', 1, 4, 'img/shop/product-7.jpg'),
('Mississippi Mud', 8.00, 100, 'Chocolate cupcake with marshmallow frosting', 4, 3, 'img/shop/product-8.jpg');

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
	Product_ID INT,
    Created_Date DATE,
    Updated_Date DATE,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
	FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
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
