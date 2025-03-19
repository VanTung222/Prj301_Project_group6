package model;

import java.sql.Date;

public class FavoriteProduct {
    private int favoriteId;
    private int customerId;
    private int productId;
    private Date addedDate;
    private Product product; // Reference to the associated product

    public FavoriteProduct() {
    }

    public FavoriteProduct(int favoriteId, int customerId, int productId, Date addedDate) {
        this.favoriteId = favoriteId;
        this.customerId = customerId;
        this.productId = productId;
        this.addedDate = addedDate;
    }

    // Getters and Setters
    public int getFavoriteId() {
        return favoriteId;
    }

    public void setFavoriteId(int favoriteId) {
        this.favoriteId = favoriteId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public Date getAddedDate() {
        return addedDate;
    }

    public void setAddedDate(Date addedDate) {
        this.addedDate = addedDate;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
}