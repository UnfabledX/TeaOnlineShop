package entities;

import java.math.BigDecimal;

/**
 * Product entity. Represents main features
 * of any product, such as id, name, price,
 * initial description etc.
 *
 * @author Oleksii Synelnyk
 */

public class Product extends Entity {

    private String name;
    private String description;
    private BigDecimal price;

    public Product(String name, String description, BigDecimal price) {
        this.name = name;
        this.description = description;
        this.price = price;
    }

    public Product() {
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "Product{" +
                "name='" + name + "', \n" +
                "description='" + description + "', \n" +
                "price=" + price +
                '}';
    }
}
