package controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;
import model.ProductDAO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name="SearchServlet", urlPatterns={"/SearchServlet"})
public class SearchServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
        String searchQuery = request.getParameter("search");

        ProductDAO productDAO = new ProductDAO();
        List<Product> productList = productDAO.searchProductsByName(searchQuery);

        PrintWriter out = response.getWriter();
        if (productList.isEmpty()) {
            out.println("<p style='color:red;'>⚠ Không tìm thấy sản phẩm nào.</p>");
        } else {
            for (Product product : productList) {
                out.println("<div class='col-lg-3 col-md-6 col-sm-6 product-item'>");
                out.println("  <div class='product__item'>");
                out.println("    <div class='product__item__pic set-bg' data-setbg='img/shop/product-" + product.getProductID() + ".jpg'>");
                out.println("      <div class='product__label'><span>Category</span></div>");
                out.println("    </div>");
                out.println("    <div class='product__item__text'>");
                out.println("      <h6><a href='shop-details.jsp?product_id=" + product.getProductID() + "'>" + product.getName() + "</a></h6>");
                out.println("      <div class='product__item__price'>$" + product.getPrice() + "</div>");
                out.println("      <div class='cart_add'><a href='#'>Add to cart</a></div>");
                out.println("    </div>");
                out.println("  </div>");
                out.println("</div>");
            }}}

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
