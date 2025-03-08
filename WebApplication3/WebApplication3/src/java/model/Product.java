package model;

public class Product {
    private int productID;
    private String name;
    private double price;
    private int stock;
    private String description;
    private int categoryID;
    private int supplierID;
    private String image; // Thêm thuộc tính ảnh sản phẩm

    // Constructor mặc định
    public Product() {}

    // Constructor đầy đủ
    public Product(int productID, String name, double price, int stock, String description, int categoryID, int supplierID, String image) {
        this.productID = productID;
        this.name = name;
        this.price = price;
        this.stock = stock;
        this.description = description;
        this.categoryID = categoryID;
        this.supplierID = supplierID;
        this.image = image;
    }

    // Getters và Setters
    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public int getSupplierID() {
        return supplierID;
    }

    public void setSupplierID(int supplierID) {
        this.supplierID = supplierID;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    @Override
    public String toString() {
        return "Product{" +
                "productID=" + productID +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", stock=" + stock +
                ", description='" + description + '\'' +
                ", categoryID=" + categoryID +
                ", supplierID=" + supplierID +
                ", image='" + image + '\'' +
                '}';
    }
}
