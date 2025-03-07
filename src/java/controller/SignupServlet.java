package controller;

import emtyp.GoogleAccount;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import model.UserDAO;
import utils.DBUtils;

@WebServlet(name = "SignupServlet", urlPatterns = {"/signup"})
public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public static final String ERROR = "login.jsp";
    public static final String SUCCESS = "index.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        String error = request.getParameter("error");

        if (error != null) {
            request.setAttribute("error", "Google authentication failed!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        String code = request.getParameter("code");
        if (code != null) {
            handleGoogleSignup(request, response);
        } else {
            handleFormSignup(request, response);
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
        return "Short description";
    }// </editor-fold>

    private void handleGoogleSignup(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        GoogleLogin gg = new GoogleLogin();
        String accessToken = gg.getToken(code);
        GoogleAccount acc = gg.getUserInfo(accessToken);

        try {
            UserDAO userDAO = new UserDAO();
            if (!userDAO.isEmailExistsInUserSignUp(acc.getEmail()) && !userDAO.isEmailExistsInUsers(acc.getEmail())) {
                if (userDAO.insertUserSignUp(
                    acc.getId(),
                    acc.getEmail(),
                    acc.getFullName(),
                    acc.getGiven_name(),
                    acc.getFamily_name(),
                    acc.getPicture(),
                    acc.isVerified_email()
                )) {
                    response.sendRedirect(SUCCESS);
                } else {
                    request.setAttribute("error", "Google signup failed!");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Email already registered!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

     private void handleFormSignup(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username"); // Sửa thành username
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (username == null || email == null || password == null || 
            username.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "All fields are required!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try {
            UserDAO userDAO = new UserDAO();
            if (userDAO.isEmailExistsInUsers(email) || userDAO.isEmailExistsInUserSignUp(email)) {
                request.setAttribute("error", "Email already exists!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            if (userDAO.insertUser(username, email, password)) {
                request.setAttribute("message", "Registration successful! Please sign in.");
                response.sendRedirect("login.jsp");
            } else {
                request.setAttribute("error", "Registration failed!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
