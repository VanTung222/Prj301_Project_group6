package controller;

import com.sun.webkit.Timer;
import emtyp.GoogleAccount;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.UserDAO;
import utils.DBUtils;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    public static final String ERROR = "error.jsp";
    public static final String SUCCESS = "success.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String username = request.getParameter("userID");
            String password = request.getParameter("password");
            String roleID = request.getParameter("roleID");
            String fullName = request.getParameter("fullName");
            UserDAO dao = new UserDAO();
            //boolean check = dao.checkLogin(username, password);
            
            
            
        } catch (Exception e) {
            System.out.println("Page invalid" + e);
        } finally {
            response.sendRedirect(url);
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
}
