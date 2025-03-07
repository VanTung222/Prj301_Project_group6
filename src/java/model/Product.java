 
package model;

public class Product {
    private int id;
    private String name;
    private double price;
    private String description;
    private int favoriteCount;

    public Product(int id, String name, double price, String description, int favoriteCount) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.description = description;
        this.favoriteCount = favoriteCount;
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public double getPrice() { return price; }
    public String getDescription() { return description; }
    public int getFavoriteCount() { return favoriteCount; }
    
}
