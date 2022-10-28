package rowMappers;

import entities.Product;
import org.springframework.jdbc.core.RowMapper;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductRowMapper implements RowMapper<Product> {
    @Override
    public Product mapRow(ResultSet rs, int rowNum) throws SQLException {
        int id = rs.getInt("id");
        String name = rs.getString("name");
        String description = rs.getString("description");
        BigDecimal price = BigDecimal.valueOf(rs.getDouble("price"));
        Product product = new Product(name, description, price);
        product.setId(id);
        return product;
    }
}
