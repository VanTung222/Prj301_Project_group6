package controller;

import com.google.gson.Gson;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Product;
import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name="SearchServlet", urlPatterns={"/SearchServlet"})
public class SearchServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
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
                    out.println("    <div class='product__item__pic set-bg' data-setbg='img/shop/product-" + product.getProductId() + ".jpg'>");
                    out.println("      <div class='product__label'><span>Category</span></div>");
                    out.println("    </div>");
                    out.println("    <div class='product__item__text'>");
                    out.println("      <h6><a href='shop-details.jsp?product_id=" + product.getProductId() + "'>" + product.getName() + "</a></h6>");
                    out.println("      <div class='product__item__price'>$" + product.getPrice() + "</div>");
                    out.println("      <div class='cart_add'><a href='#'>Add to cart</a></div>");
                    out.println("    </div>");
                    out.println("  </div>");
                    out.println("</div>");
                }}
        } catch (SQLException ex) {
            Logger.getLogger(SearchServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
