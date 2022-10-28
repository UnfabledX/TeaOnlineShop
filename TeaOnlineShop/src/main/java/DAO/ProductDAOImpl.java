package DAO;

import entities.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import rowMappers.ProductRowMapper;

import java.util.List;

@Repository
public class ProductDAOImpl implements ProductDAO {

    private static final String SQL_SELECT_ALL_PRODUCTS = "SELECT * FROM tea_onlineshop.products";
    private static final String SQL_INSERT_PRODUCT = "INSERT INTO tea_onlineshop.products (name,description,price) " +
            "VALUES(?,?,?)";
    private static final String SQL_UPDATE_PRODUCT = "UPDATE tea_onlineshop.products SET name=?, description=?, price=? WHERE id=?";
    private static final String SQL_GET_PRODUCT = "SELECT * FROM tea_onlineshop.products WHERE id=?";
    private static final String SQL_DELETE_PRODUCT = "DELETE FROM tea_onlineshop.products WHERE id=?";

    @Autowired
    private JdbcTemplate jdbcTemplate;

    /**
     * Returns all products
     * from database.
     *
     * @return List of products
     */
    @Override
    public List<Product> loadProducts() {
        return jdbcTemplate.query(SQL_SELECT_ALL_PRODUCTS, new ProductRowMapper());
    }

    /**
     * Saves product to database.
     *
     * @param product Product entity to be saved.
     */
    @Override
    public void saveProduct(Product product) {
        Object[] sqlParameters = {product.getName(), product.getDescription(), product.getPrice()};
        jdbcTemplate.update(SQL_INSERT_PRODUCT, sqlParameters);
    }

    /**
     * Updates given product such as name,
     * description, price.
     *
     * @param product Product entity to be updated.
     */
    @Override
    public void updateProduct(Product product) {
        Object[] sqlParameters = {product.getName(), product.getDescription(), product.getPrice(), product.getId()};
        jdbcTemplate.update(SQL_UPDATE_PRODUCT, sqlParameters);
    }

    /**
     * Receives product entity from
     * database by its ID
     *
     * @param id Product ID
     * @return product with given ID
     */
    @Override
    public Product getProduct(int id) {
        return jdbcTemplate.queryForObject(SQL_GET_PRODUCT, new ProductRowMapper(), id);
    }

    /**
     * Deletes product from
     * database by its ID
     *
     * @param id Product ID
     */
    @Override
    public void deleteProduct(int id) {
        jdbcTemplate.update(SQL_DELETE_PRODUCT, id);
    }
}





























