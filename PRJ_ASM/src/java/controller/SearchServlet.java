package controller;

import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

@WebServlet(name = "SearchServlet", urlPatterns = {"/search"})
public class SearchServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        try (PrintWriter out = response.getWriter()) {
            String keyword = request.getParameter("keyword");
            
            // Start HTML document
            out.println("<!DOCTYPE html>");
            out.println("<html lang='en'>");
            out.println("<head>");
            out.println("<meta charset='UTF-8'>");
            out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
            out.println("<title>Search Results - " + (keyword != null ? keyword : "") + "</title>");
            out.println("<link rel='stylesheet' href='css/bootstrap.min.css'>");
            out.println("<link rel='stylesheet' href='css/font-awesome.min.css'>");
            out.println("<link rel='stylesheet' href='css/style.css'>");
            out.println("<style>");
            out.println("body { background-color: #f5f5f5; font-family: 'Montserrat', sans-serif; }");
            out.println(".search-container { padding: 40px 0; }");
            out.println(".search-header { text-align: center; margin-bottom: 40px; }");
            out.println(".search-header h2 { color: #333; font-size: 32px; margin-bottom: 10px; }");
            out.println(".search-header p { color: #666; }");
            out.println(".search-form-container { max-width: 600px; margin: 0 auto 40px; position: relative; }");
            out.println(".search-input { width: 100%; height: 50px; padding: 0 60px 0 20px; border: 2px solid #ddd; border-radius: 25px; font-size: 16px; transition: all 0.3s; }");
            out.println(".search-input:focus { border-color: #f08632; outline: none; }");
            out.println(".search-button { position: absolute; right: 5px; top: 5px; height: 40px; width: 50px; border: none; background: #f08632; color: #fff; border-radius: 20px; cursor: pointer; }");
            out.println(".search-button:hover { background: #e67422; }");
            out.println(".product-card { background: #fff; border-radius: 10px; overflow: hidden; margin-bottom: 30px; box-shadow: 0 2px 15px rgba(0,0,0,0.1); transition: all 0.3s; }");
            out.println(".product-card:hover { transform: translateY(-5px); box-shadow: 0 5px 20px rgba(0,0,0,0.15); }");
            out.println(".product-image { width: 100%; height: 300px; object-fit: cover; }");
            out.println(".product-info { padding: 20px; }");
            out.println(".product-name { font-size: 24px; margin-bottom: 15px; color: #333; }");
            out.println(".product-name a { color: #333; text-decoration: none; transition: all 0.3s; }");
            out.println(".product-name a:hover { color: #f08632; }");
            out.println(".product-price { font-size: 24px; color: #f08632; font-weight: bold; margin-bottom: 10px; }");
            out.println(".product-stock { color: #666; margin-bottom: 15px; }");
            out.println(".product-description { color: #777; line-height: 1.6; margin-bottom: 20px; }");
            out.println(".btn-view-details { background: #333; color: #fff; padding: 10px 25px; border-radius: 25px; text-decoration: none; transition: all 0.3s; display: inline-block; }");
            out.println(".btn-view-details:hover { background: #f08632; color: #fff; }");
            out.println(".no-results { text-align: center; padding: 50px 20px; }");
            out.println(".no-results i { font-size: 64px; color: #ddd; margin-bottom: 20px; }");
            out.println(".no-results h3 { color: #333; margin-bottom: 10px; }");
            out.println(".no-results p { color: #666; }");
            out.println(".back-home-container { margin-bottom: 30px; }");
            out.println(".back-home { display: inline-flex; align-items: center; padding: 12px 25px; background: #f08632; color: #fff; text-decoration: none; border-radius: 30px; transition: all 0.3s ease; font-weight: 500; box-shadow: 0 4px 15px rgba(240, 134, 50, 0.2); }");
            out.println(".back-home:hover { background: #e67422; transform: translateX(-5px); box-shadow: 0 6px 20px rgba(240, 134, 50, 0.3); color: #fff; text-decoration: none; }");
            out.println(".back-home i { margin-right: 10px; font-size: 16px; transition: all 0.3s ease; }");
            out.println(".back-home:hover i { transform: translateX(-3px); }");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");
            
            // Include header
            out.println("<jsp:include page='header.jsp'/>");
            
            out.println("<div class='search-container'>");
            out.println("<div class='container'>");
            
            // Back to Home button
            out.println("<div class='back-home-container'>");
            out.println("<a href='index.jsp' class='back-home'><i class='fa fa-arrow-left'></i> Back to Home</a>");
            out.println("</div>");
            
            // Search header
            out.println("<div class='search-header'>");
            out.println("<h2>Search Results</h2>");
            if (keyword != null && !keyword.trim().isEmpty()) {
                out.println("<p>Showing results for: \"" + keyword + "\"</p>");
            }
            out.println("</div>");
            
            // Search form
            out.println("<div class='search-form-container'>");
            out.println("<form action='search' method='GET'>");
            out.println("<input type='text' class='search-input' name='keyword' value='" + (keyword != null ? keyword : "") + "' placeholder='Search for products...'>");
            out.println("<button type='submit' class='search-button'><i class='fa fa-search'></i></button>");
            out.println("</form>");
            out.println("</div>");
            
            // Search results
            if (keyword != null && !keyword.trim().isEmpty()) {
                ProductDAO productDAO = new ProductDAO();
                List<Product> products = productDAO.searchProductsByName(keyword);
                
                if (products.isEmpty()) {
                    out.println("<div class='no-results'>");
                    out.println("<i class='fa fa-search'></i>");
                    out.println("<h3>No products found</h3>");
                    out.println("<p>Try different keywords or check your spelling</p>");
                    out.println("</div>");
                } else {
                    out.println("<div class='row'>");
                    for (Product product : products) {
                        out.println("<div class='col-lg-6 col-md-6'>");
                        out.println("<div class='product-card'>");
                        out.println("<div class='row no-gutters'>");
                        out.println("<div class='col-md-6'>");
                        out.println("<img src='" + product.getProductImg() + "' alt='" + product.getName() + "' class='product-image'>");
                        out.println("</div>");
                        out.println("<div class='col-md-6'>");
                        out.println("<div class='product-info'>");
                        out.println("<h3 class='product-name'><a href='shop-details.jsp?product_id=" + product.getProductId() + "'>" + product.getName() + "</a></h3>");
                        out.println("<div class='product-price'>$" + String.format("%.2f", product.getPrice()) + "</div>");
                        out.println("<div class='product-stock'><i class='fa fa-cube'></i> " + product.getStock() + " in stock</div>");
                        out.println("<p class='product-description'>" + product.getDescription() + "</p>");
                        out.println("<a href='shop-details.jsp?product_id=" + product.getProductId() + "' class='btn-view-details'>View Details</a>");
                        out.println("</div>");
                        out.println("</div>");
                        out.println("</div>");
                        out.println("</div>");
                        out.println("</div>");
                    }
                    out.println("</div>");
                }
            }
            
            out.println("</div>");
            out.println("</div>");
            
            // Include footer
            out.println("<jsp:include page='footer.jsp'/>");
            
            // Scripts
            out.println("<script src='js/jquery-3.3.1.min.js'></script>");
            out.println("<script src='js/bootstrap.min.js'></script>");
            out.println("<script src='js/main.js'></script>");
            
            out.println("</body>");
            out.println("</html>");
        } catch (Exception e) {
            response.getWriter().println("<div class='alert alert-danger'>An error occurred while searching</div>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Search Servlet handles product search functionality";
    }
}


