package controller;

import dao.CustomerDAO;
import emtyp.GoogleAccount;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
        return "Handles user signup via form or Google authentication";
    }

    private void handleGoogleSignup(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        GoogleLogin gg = new GoogleLogin();
        String accessToken = gg.getToken(code);
        GoogleAccount acc = gg.getUserInfo(accessToken);

        try {
            CustomerDAO customerDAO = new CustomerDAO();
            if (!customerDAO.isEmailExists(acc.getEmail())) {
                String username = acc.getEmail().split("@")[0]; // Tạo username từ email
                if (customerDAO.insertGoogleCustomer(
                    acc.getId(),
                    acc.getEmail(),
                    username,
                    acc.getGiven_name(),
                    acc.getFamily_name(),
                    acc.getPicture()
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
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (username == null || email == null || password == null || 
            username.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "All fields are required!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        try {
            CustomerDAO customerDAO = new CustomerDAO();
            if (customerDAO.isEmailExists(email)) {
                request.setAttribute("error", "Email already exists!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            if (customerDAO.insertCustomer(username, email, password)) {
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