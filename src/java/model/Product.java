package model;

public class Product {
    private int productId;
    private String name;
    private double price;
    private int stock;
    private String description;
    private int productCategoryId;
    private int supplierId;
    private String productImg;
    
    // Constructor đầy đủ
    public Product(int productId, String name, double price, int stock, String description, 
                   int productCategoryId, int supplierId, String productImg) {
        this.productId = productId;
        this.name = name;
        this.price = price;
        this.stock = stock;
        this.description = description;
        this.productCategoryId = productCategoryId;
        this.supplierId = supplierId;
        this.productImg = productImg;
    }
    public Product(int productId, String name, double price, String description, String productImg) {
        this.productId = productId;
        this.name = name;
        this.price = price;
        this.description = description;
        this.productImg = productImg;
    }
    
    // Constructor dùng cho WishlistServlet (bao gồm favoriteCount)
    public Product(int productId, String name, double price, String description, int favoriteCount, String productImg) {
        this.productId = productId;
        this.name = name;
        this.price = price;
        this.description = description;
        this.productImg = productImg;
        this.favoriteCount = favoriteCount;
    }
    
//    orders

    public Product(int productId, String name, double price, int stock, String description, String productImg) {
        this.productId = productId;
        this.name = name;
        this.price = price;
        this.stock = stock;
        this.description = description;
        this.productImg = productImg;
    }
    

    private int favoriteCount; // Để dùng trong Wishlist

    // Getters và Setters
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getProductCategoryId() { return productCategoryId; }
    public void setProductCategoryId(int productCategoryId) { this.productCategoryId = productCategoryId; }

    public int getSupplierId() { return supplierId; }
    public void setSupplierId(int supplierId) { this.supplierId = supplierId; }

    public String getProductImg() { return productImg; }
    public void setProductImg(String productImg) { this.productImg = productImg; }

    public int getFavoriteCount() { return favoriteCount; }
    public void setFavoriteCount(int favoriteCount) { this.favoriteCount = favoriteCount; }
}