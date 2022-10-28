package controllers;

import entities.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import service.ProductService;

import java.util.List;

@Controller
public class ProductController {

    @Autowired
    private ProductService productService;

    //@RequestMapping(value = "/showProducts", method = RequestMethod.GET) it's the same as below
    @GetMapping(value = {"/showProducts"}) //getmapping --> /showProducts link
    public String showProducts(Model model) {
        List<Product> productList = productService.loadProducts();
        model.addAttribute("products", productList);

        return "product-list"; //jsp page that is responsible for presentation
    }

    @GetMapping(value = {"/addProduct"})  //     /addProduct link
    public String addProduct(Model model) {
        Product product = new Product();
        model.addAttribute("product", product);
        //System.out.println(product);
        return "add-product"; //jsp page
    }

    @PostMapping(value = {"/saveButton"}) //form:form action="saveButton"
    public String saveProduct(Product product) {
        productService.saveProduct(product);
        return "redirect:/showProducts";
    }

    //Update product
    @GetMapping(value = {"/updateProduct"})
    public String updateProduct(@RequestParam("productId") int id,
                                Model model) {
        Product productFromDB = productService.getProduct(id);
        model.addAttribute("productFromDB", productFromDB);
        return "update-product";
    }

    @PostMapping(value = {"/updateButton"}) //form:form action="updateButton"
    public String changeProduct(Product product) {
        System.out.println(product);
        productService.updateProduct(product);
        return "redirect:/showProducts";
    }

    @GetMapping(value = {"/deleteProduct"})
    public String deleteProduct(@RequestParam("productId") int id) {
        productService.deleteProduct(id);
        return "redirect:/showProducts";
    }

}
