/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import dao.ProductDAO;
 
@WebServlet(name="SearchServlet1", urlPatterns={"/searchne"})
public class SearchServlet1 extends HttpServlet {

 
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SearchServlet1</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchServlet1 at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
          String keyword = request.getParameter("keyword");
        ProductDAO productDao = new ProductDAO();
        List<Product> productList = new ArrayList<>();
        
        try {
            if (keyword != null && !keyword.trim().isEmpty()) {
                productList = productDao.searchProductsByName(keyword);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Kiểm tra nếu request từ AJAX
        String isAjax = request.getParameter("ajax");
        if ("true".equals(isAjax)) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");

            // Chuyển danh sách sản phẩm thành JSON
            PrintWriter out = response.getWriter();
            out.print("[");
            for (int i = 0; i < productList.size(); i++) {
                Product p = productList.get(i);
                out.print("{\"id\": " + p.getProductId() + ", \"name\": \"" + p.getName() + "\", \"image\": \"" + p.getProductImg() + "\", \"price\": " + p.getPrice() + "}");
                if (i < productList.size() - 1) {
                    out.print(",");
                }
            }
            out.print("]");
            out.flush();
            return;
        }

        // Nếu không phải AJAX, trả về trang JSP bình thường
        request.setAttribute("keyword", keyword);
        request.setAttribute("productList", productList);
        request.getRequestDispatcher("search.jsp").forward(request, response);
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }
 
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}


