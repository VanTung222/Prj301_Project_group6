package controller;

import dao.CustomerManagerDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Customer;

@WebServlet(name = "CustomerManagerAd", urlPatterns = {"/CustomerManagerAd"})
public class CustomerManagerAd extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CustomerManagerDAO dao = new CustomerManagerDAO();
        List<Customer> customers = null;
        try {
            customers = dao.getAllCustomers();
        } catch (SQLException ex) {
            Logger.getLogger(CustomerManagerAd.class.getName()).log(Level.SEVERE, null, ex);
        }

        request.setAttribute("customers", customers);
        RequestDispatcher dispatcher = request.getRequestDispatcher("customers.jsp");
        dispatcher.forward(request, response);
    }
}
