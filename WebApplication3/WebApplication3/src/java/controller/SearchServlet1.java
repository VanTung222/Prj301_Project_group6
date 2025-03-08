/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Product;
import model.ProductDAO;

/**
 *
 * @author Admin
 */
@WebServlet(name="SearchServlet1", urlPatterns={"/searchne"})
public class SearchServlet1 extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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
                out.print("{\"id\": " + p.getProductID() + ", \"name\": \"" + p.getName() + "\", \"image\": \"" + p.getImage() + "\", \"price\": " + p.getPrice() + "}");
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

    /**
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}


