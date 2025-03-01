package controller;

import emtyp.GoogleAccount;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.DBUtils;

@WebServlet(name = "SignupServlet", urlPatterns = {"/signup"})
public class SignupServlet extends HttpServlet {
    public static final String ERROR = "error.jsp";
    public static final String SUCCESS = "success.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        String code = request.getParameter("code");
        String error = request.getParameter("error");
        if (error != null) {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
        GoogleLogin gg = new GoogleLogin();
        String accessToken = gg.getToken(code);
        GoogleAccount acc = gg.getUserInfo(accessToken);
        //check tk da dky chua
        System.out.println(code);
        System.out.println(acc);

        try {
            Connection con = DBUtils.getConnection();
            String sql = "INSERT INTO userSignUp(GoogleID, Email, FullName, GivenName, FamilyName, ProfilePicture, VerifiedEmail) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = con.prepareStatement(sql);
            stmt.setString(1, acc.getId());
            stmt.setString(2, acc.getEmail());
            stmt.setString(3, acc.getFullName());
            stmt.setString(4, acc.getGiven_name());
            stmt.setString(5, acc.getFamily_name());
            stmt.setString(6, acc.getPicture());
            stmt.setBoolean(7, acc.isVerified_email());
            int rowsInserted = stmt.executeUpdate();
            stmt.close();
            con.close();

            if (rowsInserted > 0) {
                url = SUCCESS;
            } else {
                url = ERROR;
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("error.jsp " + e.getMessage());
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

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
