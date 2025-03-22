import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Customer;
import dao.CustomerDAO;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/updateCustomer")
public class UserController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Kết nối DB
            Connection conn = DriverManager.getConnection("jdbc:sqlserver://localhost\\SQLEXPRESS:1433;databaseName=cakeManagement;user=sa;password=123");
            
            // Lấy dữ liệu từ form
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String profilePicture = request.getParameter("profilePicture");
            
            // Cập nhật customer
            CustomerDAO customerDAO = new CustomerDAO();
            Customer customer = customerDAO.getCustomerById(customerId);
            
            if (customer != null) {
                customer.setFirstName(firstName);
                customer.setLastName(lastName);
                customer.setPhone(phone);
                customer.setAddress(address);
                customer.setProfilePicture(profilePicture);
                
                try {
                    if (customerDAO.updateCustomer(customer)) {
                        response.sendRedirect("profile111.jsp?success=true");
                    } else {
                        response.sendRedirect("profile111.jsp?error=true");
                    }
                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(UserController.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            conn.close();
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("profile.jsp111?error=true");
        }
    }
}