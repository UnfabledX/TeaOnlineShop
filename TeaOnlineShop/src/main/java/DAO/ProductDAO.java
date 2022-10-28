package DAO;

import entities.Product;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Interface ProductDAO. Represents operations which
 * can be done to products such as retrieving all
 * products from database, saving products to db etc.
 *
 * @author Oleksii Synelnyk
 */


public interface ProductDAO {

    List<Product> loadProducts();

    void saveProduct(Product product);

    void updateProduct(Product product);

    Product getProduct(int id);

    void deleteProduct(int id);
}
