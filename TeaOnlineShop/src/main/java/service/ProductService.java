package service;

import entities.Product;

import java.util.List;

public interface ProductService {
    List<Product> loadProducts();

    void saveProduct(Product product);

    void updateProduct(Product product);

    Product getProduct(int id);

    void deleteProduct(int id);
}
