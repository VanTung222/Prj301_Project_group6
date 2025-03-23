package controller;

import dao.CustomerDAO;
import model.Customer;
import com.google.gson.Gson;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "EditCustomerServlet", urlPatterns = {"/EditCustomerServlet/*"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class EditCustomerServlet extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "uploads"; // Thư mục lưu ảnh

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo(); // Lấy phần sau /EditCustomerServlet/

        if (pathInfo != null && pathInfo.startsWith("/get/")) {
            // Xử lý yêu cầu lấy thông tin khách hàng (dành cho JavaScript)
            String idStr = pathInfo.substring(5); // Lấy ID từ URL
            try {
                int customerId = Integer.parseInt(idStr);
                CustomerDAO dao = new CustomerDAO();
                Customer customer = dao.getCustomerById(customerId);

                if (customer != null) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    PrintWriter out = response.getWriter();
                    Gson gson = new Gson();
                    out.print(gson.toJson(customer));
                    out.flush();
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy khách hàng");
                }
            } catch (SQLException e) {
                Logger.getLogger(EditCustomerServlet.class.getName()).log(Level.SEVERE, null, e);
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi lấy thông tin khách hàng");
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID không hợp lệ");
            }
        } else {
            // Xử lý yêu cầu tìm kiếm
            String search = request.getParameter("search");
            CustomerDAO dao = new CustomerDAO();
            try {
                List<Customer> customers = dao.getAllCustomers();
                if (search != null && !search.trim().isEmpty()) {
                    customers.removeIf(customer -> !customer.getUsername().toLowerCase().contains(search.toLowerCase()) &&
                                                  !customer.getEmail().toLowerCase().contains(search.toLowerCase()));
                }
                request.setAttribute("customers", customers);
                RequestDispatcher rd = request.getRequestDispatcher("/customers.jsp");
                rd.forward(request, response);
            } catch (SQLException e) {
                Logger.getLogger(EditCustomerServlet.class.getName()).log(Level.SEVERE, null, e);
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi tìm kiếm khách hàng");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo(); // Lấy phần sau /EditCustomerServlet/

        if (pathInfo != null && pathInfo.startsWith("/delete/")) {
            try {
                int customerId = Integer.parseInt(pathInfo.substring(8));
                CustomerDAO dao = new CustomerDAO();
                if (dao.deleteAccount(customerId)) {
                    request.getSession().setAttribute("message", "Xóa khách hàng thành công!");
                    request.getSession().setAttribute("messageType", "success");
                    response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
                } else {
                    request.getSession().setAttribute("message", "Không thể xóa khách hàng!");
                    request.getSession().setAttribute("messageType", "error");
                    response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
                }
            } catch (SQLException | NumberFormatException e) {
                Logger.getLogger(EditCustomerServlet.class.getName()).log(Level.SEVERE, null, e);
                request.getSession().setAttribute("message", "Lỗi: ID khách hàng không hợp lệ!");
                request.getSession().setAttribute("messageType", "error");
                response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(EditCustomerServlet.class.getName()).log(Level.SEVERE, null, ex);
                request.getSession().setAttribute("message", "Lỗi hệ thống khi xóa khách hàng!");
                request.getSession().setAttribute("messageType", "error");
                response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
            }
        } else {
            // Xử lý yêu cầu thêm/sửa khách hàng từ form
            int customerId = request.getParameter("customerId") != null && !request.getParameter("customerId").isEmpty() ?
                             Integer.parseInt(request.getParameter("customerId")) : 0;
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
            int role = Integer.parseInt(request.getParameter("role"));

            // Kiểm tra mật khẩu và xác nhận mật khẩu
            if (password != null && !password.equals(confirmPassword)) {
                response.getWriter().println("Mật khẩu và xác nhận mật khẩu không khớp!");
                return;
            }

            // Xử lý upload ảnh
            String profilePicturePath = null;
            Part filePart = request.getPart("profilePicture");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = extractFileName(filePart);
                String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();
                filePart.write(uploadPath + File.separator + fileName);
                profilePicturePath = UPLOAD_DIRECTORY + "/" + fileName;
            }

            CustomerDAO dao = new CustomerDAO();
            try {
                if (customerId > 0) {
                    // Cập nhật khách hàng
                    boolean updated = dao.updateCustomerProfile(customerId, username, email, firstName, lastName, phone, address, password);
                    if (profilePicturePath != null) {
                        dao.updateProfilePicture(customerId, profilePicturePath);
                    }
                    if (updated) {
                        response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
                    } else {
                        response.getWriter().println("Cập nhật thất bại!");
                    }
                } else {
                    // Thêm khách hàng mới
                    if (password == null || password.trim().isEmpty()) {
                        response.getWriter().println("Mật khẩu là bắt buộc khi thêm khách hàng mới!");
                        return;
                    }
                    // Gọi insertCustomerAll với đúng thứ tự tham số
                    boolean inserted = dao.insertCustomerAll(username, email, firstName, lastName, password, profilePicturePath, address, phone, role);
                    if (inserted) {
                        // Không cần gọi updateProfilePicture vì profilePicturePath đã được thêm trong insertCustomerAll
                        response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
                    } else {
                        response.getWriter().println("Thêm khách hàng thất bại!");
                    }
                }
            } catch (SQLException | ClassNotFoundException e) {
                Logger.getLogger(EditCustomerServlet.class.getName()).log(Level.SEVERE, null, e);
                response.getWriter().println("Đã xảy ra lỗi khi cập nhật/thêm khách hàng!");
            }
        }
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
}