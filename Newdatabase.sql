DROP DATABASE cakeManagement;
CREATE DATABASE cakeManagement3
GO
USE cakeManagement3


-- Tạo bảng Customers
IF OBJECT_ID('Customers', 'U') IS NOT NULL DROP TABLE Customers;
CREATE TABLE Customers (
    Customer_ID INT IDENTITY(1,1) PRIMARY KEY,
    GoogleID NVARCHAR(50), 
    Username VARCHAR(50) UNIQUE NOT NULL,
    Email NVARCHAR(255),
    FirstName NVARCHAR(255),
    LastName NVARCHAR(255),
    Password NVARCHAR(255) NOT NULL,
    ProfilePicture NVARCHAR(255),
    Address NVARCHAR(MAX),
    Phone NVARCHAR(20),
    Registration_Date DATE,
    Role BIT DEFAULT 1 -- 0: Admin, 1: Customer
);

-- Chèn dữ liệu vào bảng Customers
INSERT INTO Customers (GoogleID, Username, Email, FirstName, LastName, Password, ProfilePicture, Address, Phone, Registration_Date, Role)
VALUES 
(NULL, 'VanTung222', 'TungTVDE180109@fpt.edu.vn', 'Tran Van', 'Tung', '123', 'img/team/team-1.jpg', 'Eale Easup, Dak Lak', '0326651443', '2025-03-08', 1),
(NULL, 'HongQuan', 'HongQuan@example.com', 'Nguyen', 'Quan', '123', 'img/team/team-2.jpg', 'Ha Noi', '0987654321', '2025-03-11', 1),
(NULL, 'SyGia', 'SyGia@example.com', 'Le', 'Gia', '123', 'img/team/team-3.jpg', 'Hai Phong', '0912345678', '2025-03-12', 1),
(NULL, 'HuaMinhDat', 'HuaMinhDat@example.com', 'Hua', 'Minh Dat', '123', 'img/team/team-4.jpg', 'Da Nang', '0908765432', '2025-03-16', 1),
(NULL, 'QuocHung', 'QuocHung@example.com', 'Do', 'Hung', '123', 'img/team/team-5.jpg', 'Can Tho', '0934567890', '2025-03-20', 1),
(NULL, 'admin', 'admin@example.com', NULL, NULL, 'admin123', 'img/team/team-6.jpg', NULL, NULL, '2025-03-22', 0);

-- Kiểm tra dữ liệu bảng Customers
SELECT * FROM Customers;

-- Tạo bảng Supplier
IF OBJECT_ID('Supplier', 'U') IS NOT NULL DROP TABLE Supplier;
CREATE TABLE Supplier (
    ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Phone VARCHAR(20),
    Email VARCHAR(255)
);

-- Chèn dữ liệu vào bảng Supplier
INSERT INTO Supplier (ID, Name, Phone, Email) 
VALUES 
(1, 'SweetTreats Supplies', '0987654321', 'contact@sweettreats.com'),
(2, 'Baking Essentials Co.', '0978123456', 'info@bakingessentials.com'),
(3, 'Cake Masters Ltd.', '0967345678', 'support@cakemasters.com'),
(4, 'Premium Ingredients Inc.', '0956123456', 'sales@premiumingredients.com');

-- Kiểm tra dữ liệu bảng Supplier
SELECT * FROM Supplier;

-- Tạo bảng Product_Category
IF OBJECT_ID('Product_Category', 'U') IS NOT NULL DROP TABLE Product_Category;
CREATE TABLE Product_Category (
    Category_ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Created_Date DATE,
    Updated_Date DATE
);

-- Chèn dữ liệu vào bảng Product_Category
INSERT INTO Product_Category (Category_ID, Name, Created_Date, Updated_Date) 
VALUES 
(1, 'Cupcakes', '2024-03-07', '2024-03-07'),
(2, 'Cookies', '2024-03-07', '2024-03-07'),
(3, 'Cakes', '2024-03-07', '2024-03-07'),
(4, 'Pastries', '2024-03-07', '2024-03-07');

-- Kiểm tra dữ liệu bảng Product_Category
SELECT * FROM Product_Category;

-- Tạo bảng Product
IF OBJECT_ID('Product', 'U') IS NOT NULL DROP TABLE Product;
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

-- Chèn dữ liệu vào bảng Product
INSERT INTO Product (Name, Price, Stock, Product_Description, Product_Category_ID, Supplier_ID, Product_img)
VALUES 
('Dozen Cupcakes', 32.00, 100, 'A dozen delicious cupcakes', 4, 1, 'img/shop/product-1.jpg'),
('Cookies and Cream', 30.00, 100, 'Delicious cookies and cream flavored cupcakes', 4, 4, 'img/shop/product-2.jpg'),
('Gluten Free Mini Dozen', 31.00, 100, 'Gluten-free mini cupcakes, perfect for any occasion', 4, 1, 'img/shop/product-3.jpg'),
('Cookie Dough', 25.00, 100, 'Cupcake with cookie dough topping', 4, 2, 'img/shop/product-4.jpg'),
('Vanilla Salted Caramel', 5.00, 100, 'Classic vanilla with salted caramel topping', 1, 2, 'img/shop/product-5.jpg'),
('German Chocolate', 14.00, 100, 'Rich chocolate cupcake with coconut and pecan frosting', 1, 3, 'img/shop/product-6.jpg'),
('Dulce De Leche', 32.00, 100, 'Sweet caramel-flavored cupcake and cream flavored cupcakes', 1, 4, 'img/shop/product-7.jpg'),
('Mississippi Mud', 8.00, 100, 'Chocolate cupcake with marshmallow frosting', 4, 3, 'img/shop/product-8.jpg'),
('Red Velvet', 28.00, 100, 'Moist red velvet cupcake with cream cheese frosting', 1, 2, 'img/shop/product-9.jpg'),
('Matcha Green Tea', 30.00, 100, 'Cupcake infused with matcha green tea flavor', 2, 3, 'img/shop/product-10.jpg'),
('Lemon Raspberry', 27.00, 100, 'Tangy lemon cupcake with fresh raspberry topping', 3, 4, 'img/shop/product-11.jpg'),
('Triple Chocolate', 35.00, 100, 'Chocolate cupcake with dark, milk', 1, 1, 'img/shop/product-12.jpg');

-- Kiểm tra dữ liệu bảng Product
SELECT * FROM Product;

-- Tạo bảng Employee
IF OBJECT_ID('Employee', 'U') IS NOT NULL DROP TABLE Employee;
CREATE TABLE Employee (
    Employee_ID INT PRIMARY KEY,
    Name NVARCHAR(255),
    Password NVARCHAR(255),
    Salary DECIMAL(10,2),
    Address NVARCHAR(MAX),
    Phone NVARCHAR(20),
    Role NVARCHAR(100)
);

-- Tạo bảng Shopping_Cart
IF OBJECT_ID('Shopping_Cart', 'U') IS NOT NULL DROP TABLE Shopping_Cart;
CREATE TABLE Shopping_Cart (
    Cart_ID INT IDENTITY(1,1) PRIMARY KEY,
    Customer_ID INT,
    Product_ID INT,
    Quantity INT DEFAULT 1,
    Created_Date DATE DEFAULT GETDATE(),
    Updated_Date DATE DEFAULT GETDATE(),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

-- Chèn dữ liệu vào bảng Shopping_Cart
INSERT INTO Shopping_Cart (Customer_ID, Product_ID, Quantity, Created_Date, Updated_Date)
VALUES
(1, 1, 2, '2025-03-12', '2025-03-22'),   
(2, 3, 1, '2025-03-12', '2025-03-22'),  
(3, 5, 3, '2025-03-12', '2025-03-22'),  
(4, 7, 2, '2025-03-12', '2025-03-22'),  
(5, 8, 4, '2025-03-14', '2025-03-22'),  
(6, 2, 1, '2025-03-14', '2025-03-22'), 
(1, 4, 2, '2025-03-15', '2025-03-23'), 
(2, 6, 1, '2025-03-16', '2025-03-23'), 
(3, 10, 3, '2025-03-16', '2025-03-23'), 
(4, 12, 2, '2025-03-18', '2025-03-23');

-- Kiểm tra dữ liệu bảng Shopping_Cart
SELECT * FROM Shopping_Cart;

-- Tạo bảng Shipper
IF OBJECT_ID('Shipper', 'U') IS NOT NULL DROP TABLE Shipper;
CREATE TABLE Shipper (
    Shipper_ID INT PRIMARY KEY,
    Shipment_Tracking NVARCHAR(255),
    Quantity INT
);

-- Chèn dữ liệu vào bảng Shipper
INSERT INTO Shipper (Shipper_ID, Shipment_Tracking, Quantity) 
VALUES 
(1, 'TRACK123456', 50),
(2, 'TRACK789012', 100),
(3, 'TRACK345678', 75),
(4, 'TRACK901234', 120);

-- Kiểm tra dữ liệu bảng Shipper
SELECT * FROM Shipper;

CREATE TABLE Shipping_Addresses (
    Address_ID INT IDENTITY(1,1) PRIMARY KEY,
    Customer_ID INT,
    First_Name NVARCHAR(50),
    Last_Name NVARCHAR(50),
    Address NVARCHAR(255),
    City NVARCHAR(50),
    Country_State NVARCHAR(50),
    Postcode NVARCHAR(20),
    Phone NVARCHAR(20),
    Email NVARCHAR(100),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);
-- Tạo bảng Discount_Code
IF OBJECT_ID('Discount_Code', 'U') IS NOT NULL DROP TABLE Discount_Code;
CREATE TABLE Discount_Code (
    Discount_ID INT IDENTITY(1,1) PRIMARY KEY,
    Customer_ID INT,
    Code NVARCHAR(50) UNIQUE NOT NULL,
    Discount_Percentage DECIMAL(5,2) NOT NULL,
    Is_Used BIT DEFAULT 0,
    Created_Date DATETIME DEFAULT GETDATE(),
    Expiry_Date DATETIME NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

-- Chèn dữ liệu vào bảng Discount_Code
INSERT INTO Discount_Code (Customer_ID, Code, Discount_Percentage, Is_Used, Expiry_Date)
VALUES 
(1, 'SAVE10', 10.00, 0, '2025-04-30'),
(2, 'SPRING20', 20.00, 0, '2025-05-15'),
(3, 'WELCOME15', 15.00, 1, '2025-03-31');

-- Kiểm tra dữ liệu bảng Discount_Code
SELECT * FROM Discount_Code;

-- Tạo bảng Orders
IF OBJECT_ID('Orders', 'U') IS NOT NULL DROP TABLE Orders;
CREATE TABLE Orders (
    Order_ID INT IDENTITY(1,1) PRIMARY KEY,
    Customer_ID INT NOT NULL,
    Employee_ID INT, 
    Order_Date DATETIME DEFAULT GETDATE(),
    Total_Amount DECIMAL(10, 2) NOT NULL,
    Shipping_FirstName NVARCHAR(50) NOT NULL,
    Shipping_LastName NVARCHAR(50) NOT NULL,
    Shipping_Address NVARCHAR(255) NOT NULL,
    City NVARCHAR(100) NOT NULL,
    Country_State NVARCHAR(100) NOT NULL,
    Postcode NVARCHAR(20) NOT NULL,
    Phone NVARCHAR(20) NOT NULL,
    Email NVARCHAR(255) NOT NULL,
    Order_Notes NVARCHAR(MAX),
    Coupon_Code NVARCHAR(50),
    Discount_Amount DECIMAL(10, 2) DEFAULT 0,
    Payment_Method NVARCHAR(50) NOT NULL,
    Shipper_ID INT,
    Estimated_Delivery_Date DATE,
    Status NVARCHAR(50) DEFAULT 'Pending' CHECK (Status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled')),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
    FOREIGN KEY (Shipper_ID) REFERENCES Shipper(Shipper_ID)
);
ALTER TABLE Orders
ADD Shipping_Address_ID INT,
FOREIGN KEY (Shipping_Address_ID) REFERENCES Shipping_Addresses(Address_ID);
INSERT INTO Shipping_Addresses (Customer_ID, First_Name, Last_Name, Address, City, Country_State, Postcode, Phone, Email)
SELECT DISTINCT Customer_ID, Shipping_FirstName, Shipping_LastName, Shipping_Address, City, Country_State, Postcode, Phone, Email
FROM Orders;

-- Cập nhật Shipping_Address_ID trong Orders
UPDATE Orders
SET Shipping_Address_ID = (
    SELECT Address_ID
    FROM Shipping_Addresses sa
    WHERE sa.Customer_ID = Orders.Customer_ID
    AND sa.First_Name = Orders.Shipping_FirstName
    AND sa.Last_Name = Orders.Shipping_LastName
    AND sa.Address = Orders.Shipping_Address
    AND sa.City = Orders.City
    AND sa.Country_State = Orders.Country_State
    AND sa.Postcode = Orders.Postcode
    AND sa.Phone = Orders.Phone
    AND sa.Email = Orders.Email
)
WHERE EXISTS (
    SELECT 1
    FROM Shipping_Addresses sa
    WHERE sa.Customer_ID = Orders.Customer_ID
    AND sa.First_Name = Orders.Shipping_FirstName
    AND sa.Last_Name = Orders.Shipping_LastName
    AND sa.Address = Orders.Shipping_Address
    AND sa.City = Orders.City
    AND sa.Country_State = Orders.Country_State
    AND sa.Postcode = Orders.Postcode
    AND sa.Phone = Orders.Phone
    AND sa.Email = Orders.Email
);
SELECT * FROM Shipping_Addresses;
SELECT * FROM Shipping_Addresses WHERE Customer_ID = 7;

-- Tạo bảng Order_Details
IF OBJECT_ID('Order_Details', 'U') IS NOT NULL DROP TABLE Order_Details;
CREATE TABLE Order_Details (
    Order_Detail_ID INT IDENTITY(1,1) PRIMARY KEY,
    Order_ID INT,
    Product_ID INT,
    Quantity INT CHECK (Quantity > 0),
    Unit_Price DECIMAL(10, 2) NOT NULL,
    Subtotal AS (Quantity * Unit_Price),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

-- Tạo trigger để tự động cập nhật Stock khi thêm bản ghi vào Order_Details
DROP TRIGGER IF EXISTS UpdateStockOnOrder;
GO

CREATE TRIGGER UpdateStockOnOrder
ON Order_Details
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Khai báo biến để duyệt qua các bản ghi trong inserted
    DECLARE @Product_ID INT;
    DECLARE @Quantity INT;
    DECLARE @Stock INT;

    -- Khai báo con trỏ để duyệt qua các bản ghi trong inserted
    DECLARE stock_cursor CURSOR FOR
    SELECT Product_ID, Quantity
    FROM inserted;

    -- Mở con trỏ
    OPEN stock_cursor;
    FETCH NEXT FROM stock_cursor INTO @Product_ID, @Quantity;

    -- Duyệt qua từng bản ghi trong inserted
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Lấy số lượng tồn kho hiện tại của sản phẩm
        SELECT @Stock = Stock
        FROM Product
        WHERE Product_ID = @Product_ID;

        -- Kiểm tra xem số lượng tồn kho có đủ không
        IF @Stock IS NULL
        BEGIN
            RAISERROR ('Sản phẩm không tồn tại.', 16, 1);
            ROLLBACK TRANSACTION;
            CLOSE stock_cursor;
            DEALLOCATE stock_cursor;
            RETURN;
        END
        ELSE IF @Stock < @Quantity
        BEGIN
            RAISERROR ('Số lượng tồn kho không đủ để thực hiện đơn hàng cho sản phẩm %d.', 16, 1, @Product_ID);
            ROLLBACK TRANSACTION;
            CLOSE stock_cursor;
            DEALLOCATE stock_cursor;
            RETURN;
        END

        -- Cập nhật số lượng tồn kho
        UPDATE Product
        SET Stock = Stock - @Quantity
        WHERE Product_ID = @Product_ID;

        -- Lấy bản ghi tiếp theo
        FETCH NEXT FROM stock_cursor INTO @Product_ID, @Quantity;
    END;

    -- Đóng và giải phóng con trỏ
    CLOSE stock_cursor;
    DEALLOCATE stock_cursor;
END;
GO

-- Chèn dữ liệu vào bảng Orders
INSERT INTO Orders (Customer_ID, Order_Date, Total_Amount, Shipping_FirstName, Shipping_LastName, 
                    Shipping_Address, City, Country_State, Postcode, Phone, Email, Order_Notes, 
                    Coupon_Code, Discount_Amount, Payment_Method, Shipper_ID, Estimated_Delivery_Date, Status)
VALUES 
(1, '2025-03-02', 250.00, 'Tran', 'Tung', 'Eale Easup, Dak Lak', 'Buon Ma Thuot', 'Vietnam', '640000', 
 '0326651443', 'TungTVDE180109@fpt.edu.vn', 'Giao hàng vào buổi sáng', NULL, 0.0, 'Cash', 1, '2025-03-05', 'Pending'),
(2, '2025-03-05', 180.00, 'Nguyen', 'Quan', 'Ha Noi', 'Ha Noi', 'Vietnam', '100000', 
 '0987654321', 'HongQuan@example.com', 'Để lại ở bảo vệ', 'DISCOUNT10', 10.0, 'Credit Card', 2, '2025-03-08', 'Processing'),
(3, '2025-03-05', 300.00, 'Le', 'Gia', 'Hai Phong', 'Hai Phong', 'Vietnam', '180000', 
 '0912345678', 'SyGia@example.com', 'Kiểm tra hàng trước khi nhận', NULL, 0.0, 'Online Banking', 1, '2025-03-08', 'Shipped'),
(4, '2025-03-10', 220.00, 'Hua', 'Minh Dat', 'Da Nang', 'Da Nang', 'Vietnam', '550000', 
 '0908765432', 'HuaMinhDat@example.com', 'Liên hệ trước khi giao', 'SPRING2025', 15.0, 'Debit Card', 3, '2025-03-13', 'Delivered'),
(5, '2025-03-13', 320.00, 'Do', 'Hung', 'Can Tho', 'Can Tho', 'Vietnam', '900000', 
 '0934567890', 'QuocHung@example.com', 'Hàng dễ vỡ, xin nhẹ tay', NULL, 0.0, 'PayPal', 2, '2025-03-15', 'Processing'),
(1, '2025-03-13', 200.00, 'Tran', 'Tung', 'Eale Easup, Dak Lak', 'Buon Ma Thuot', 'Vietnam', '640000', 
 '0326651443', 'TungTVDE180109@fpt.edu.vn', 'Giao vào buổi chiều', 'SUMMER2025', 20.0, 'Cash', 1, '2025-03-16', 'Pending'),
(2, '2025-03-19', 280.00, 'Nguyen', 'Quan', 'Ha Noi', 'Ha Noi', 'Vietnam', '100000', 
 '0987654321', 'HongQuan@example.com', 'Yêu cầu kiểm tra kỹ', NULL, 0.0, 'Credit Card', 2, '2025-03-22', 'Shipped'),
(3, '2025-03-20', 350.00, 'Le', 'Gia', 'Hai Phong', 'Hai Phong', 'Vietnam', '180000', 
 '0912345678', 'SyGia@example.com', 'Hàng dễ vỡ', NULL, 0.0, 'Online Banking', 1, '2025-03-24', 'Processing'),
(4, '2025-03-23', 240.00, 'Hua', 'Minh Dat', 'Da Nang', 'Da Nang', 'Vietnam', '550000', 
 '0908765432', 'HuaMinhDat@example.com', 'Liên hệ sau 3h chiều', NULL, 0.0, 'Debit Card', 3, '2025-03-26', 'Delivered'),
(5, '2025-03-24', 400.00, 'Do', 'Hung', 'Can Tho', 'Can Tho', 'Vietnam', '900000', 
 '0934567890', 'QuocHung@example.com', 'Hàng cần gấp', 'FLASHSALE', 25.0, 'PayPal', 2, '2025-03-29', 'Pending');

-- Kiểm tra dữ liệu bảng Orders
SELECT * FROM Orders;

-- Chèn dữ liệu vào bảng Order_Details
INSERT INTO Order_Details (Order_ID, Product_ID, Quantity, Unit_Price)
VALUES 
(1, 1, 2, 50.00),  -- Đơn hàng 1, Sản phẩm 1, Số lượng 2, Đơn giá 50.00
(1, 2, 1, 100.00), -- Đơn hàng 1, Sản phẩm 2, Số lượng 1, Đơn giá 100.00
(2, 3, 3, 30.00),  -- Đơn hàng 2, Sản phẩm 3, Số lượng 3, Đơn giá 30.00
(3, 4, 1, 150.00), -- Đơn hàng 3, Sản phẩm 4, Số lượng 1, Đơn giá 150.00
(4, 2, 2, 80.00),  -- Đơn hàng 4, Sản phẩm 2, Số lượng 2, Đơn giá 80.00
(5, 1, 1, 50.00),  -- Đơn hàng 5, Sản phẩm 1, Số lượng 1, Đơn giá 50.00
(6, 3, 2, 30.00),  -- Đơn hàng 6, Sản phẩm 3, Số lượng 2, Đơn giá 30.00
(7, 5, 1, 200.00), -- Đơn hàng 7, Sản phẩm 5, Số lượng 1, Đơn giá 200.00
(8, 4, 2, 150.00), -- Đơn hàng 8, Sản phẩm 4, Số lượng 2, Đơn giá 150.00
(9, 2, 3, 80.00);  -- Đơn hàng 9, Sản phẩm 2, Số lượng 3, Đơn giá 80.00

-- Kiểm tra dữ liệu bảng Order_Details
SELECT * FROM Order_Details;

-- Kiểm tra số lượng tồn kho sau khi trigger thực thi
SELECT Product_ID, Name, Stock
FROM Product;

-- Tạo bảng Payment
IF OBJECT_ID('Payment', 'U') IS NOT NULL DROP TABLE Payment;
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

-- Tạo bảng Reviews
IF OBJECT_ID('Reviews', 'U') IS NOT NULL DROP TABLE Reviews;
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

-- Chèn dữ liệu vào bảng Reviews
INSERT INTO Reviews (Product_ID, Customer_ID, Rating, Comment)
VALUES 
(1, 1, 5, 'Sản phẩm tuyệt vời, chất lượng tốt!'),
(2, 1, 4, 'Sản phẩm ok, giá hợp lý nhưng giao hàng lâu.'),
(3, 2, 3, 'Chất lượng sản phẩm chưa ổn, hy vọng cải thiện.'),
(4, 3, 5, 'Mua lần thứ hai, rất hài lòng với sản phẩm này!'),
(5, 1, 2, 'Sản phẩm không như quảng cáo, thất vọng!'),
(1, 2, 4, 'Sản phẩm chất lượng tốt, sẽ mua lại!'),
(2, 3, 5, 'Rất hài lòng, chất lượng vượt mong đợi.'),
(3, 1, 3, 'Không như mong đợi, có thể cải thiện.'),
(4, 2, 4, 'Sản phẩm ổn, giao hàng nhanh chóng!'),
(5, 3, 1, 'Quá tệ, tôi không bao giờ mua lại sản phẩm này.'),
(1, 3, 5, 'Sản phẩm tuyệt vời, đáng mua!'),
(2, 2, 3, 'Chất lượng sản phẩm vừa phải, giá hơi cao.'),
(3, 3, 2, 'Không như quảng cáo, không đáng tiền.'),
(4, 1, 4, 'Sản phẩm tốt, nhưng cần cải thiện bao bì.'),
(5, 2, 3, 'Tôi không hài lòng, sản phẩm không đúng mô tả.');

-- Kiểm tra dữ liệu bảng Reviews
SELECT * FROM Reviews;

-- Tạo bảng Favorite_Products
IF OBJECT_ID('Favorite_Products', 'U') IS NOT NULL DROP TABLE Favorite_Products;
CREATE TABLE Favorite_Products (
    Favorite_ID INT IDENTITY(1,1) PRIMARY KEY,
    Customer_ID INT,
    Product_ID INT,
    Added_Date DATE DEFAULT GETDATE(),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

-- Chèn dữ liệu vào bảng Favorite_Products
INSERT INTO Favorite_Products (Customer_ID, Product_ID)
VALUES 
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5),
(3, 1),
(3, 4),
(4, 2),
(5, 3),
(5, 5);

-- Kiểm tra dữ liệu bảng Favorite_Products
SELECT * FROM Favorite_Products;