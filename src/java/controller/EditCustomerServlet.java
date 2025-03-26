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
import java.util.regex.Pattern;

@WebServlet(name = "EditCustomerServlet", urlPatterns = {"/EditCustomerServlet/*"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class EditCustomerServlet extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "uploads"; // Thư mục lưu ảnh
    private static final Pattern NAME_PATTERN = Pattern.compile("^[A-Za-zÀ-ỹ\\s]{2,}$", Pattern.UNICODE_CHARACTER_CLASS);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo(); // Lấy phần sau /EditCustomerServlet/

        if (pathInfo != null && pathInfo.startsWith("/get/")) {
            // Xử lý yêu cầu lấy thông tin khách hàng để chỉnh sửa
            try {
                String idStr = pathInfo.substring(5); // Lấy ID từ URL
                int customerId = Integer.parseInt(idStr);
                if (customerId <= 0) {
                    request.getSession().setAttribute("message", "ID khách hàng không hợp lệ!");
                    request.getSession().setAttribute("messageType", "error");
                    response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
                    return;
                }

                CustomerDAO dao = new CustomerDAO();
                Customer customer = dao.getCustomerById(customerId);

                if (customer != null) {
                    // Lưu thông tin khách hàng vào session để hiển thị trong modal
                    request.getSession().setAttribute("editCustomer", customer);
                    response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
                } else {
                    request.getSession().setAttribute("message", "Không tìm thấy khách hàng!");
                    request.getSession().setAttribute("messageType", "error");
                    response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
                }
            } catch (NumberFormatException e) {
                request.getSession().setAttribute("message", "ID không hợp lệ: " + e.getMessage());
                request.getSession().setAttribute("messageType", "error");
                response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
            } catch (SQLException e) {
                Logger.getLogger(EditCustomerServlet.class.getName()).log(Level.SEVERE, null, e);
                request.getSession().setAttribute("message", "Lỗi khi lấy thông tin khách hàng: " + e.getMessage());
                request.getSession().setAttribute("messageType", "error");
                response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
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
            request.setCharacterEncoding("UTF-8");

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
                request.getSession().setAttribute("message", "Mật khẩu và xác nhận mật khẩu không khớp!");
                request.getSession().setAttribute("messageType", "error");
                response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
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
                    // Validate input
                    if (username == null || username.trim().isEmpty() ||
                        email == null || email.trim().isEmpty() ||
                        firstName == null || firstName.trim().isEmpty() ||
                        lastName == null || lastName.trim().isEmpty() ||
                        phone == null || phone.trim().isEmpty() ||
                        address == null || address.trim().isEmpty()) {
                        request.getSession().setAttribute("message", "Vui lòng điền đầy đủ thông tin bắt buộc (Tên đăng nhập, Email, Họ, Tên, Số điện thoại, Địa chỉ)!");
                        request.getSession().setAttribute("messageType", "error");
                        response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
                        return;
                    }

                    // Validate username format
                    if (!username.matches("^[A-Za-z0-9_]{3,}$")) {
                        request.getSession().setAttribute("message", "Tên đăng nhập phải có ít nhất 3 ký tự và không chứa ký tự đặc biệt!");
                        request.getSession().setAttribute("messageType", "error");
                        response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
                        return;
                    }

                    // Validate email format
                    if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
                        request.getSession().setAttribute("message", "Email không hợp lệ!");
                        request.getSession().setAttribute("messageType", "error");
                        response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
                        return;
                    }

                    // Validate firstName and lastName format
                    if (!NAME_PATTERN.matcher(firstName).matches() || !NAME_PATTERN.matcher(lastName).matches()) {
                        request.getSession().setAttribute("message", "Họ và Tên phải có ít nhất 2 ký tự và không chứa số hoặc ký tự đặc biệt!");
                        request.getSession().setAttribute("messageType", "error");
                        response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
                        return;
                    }

                    // Validate phone number format
                    if (!phone.matches("(84|0[3|5|7|8|9])+([0-9]{8})")) {
                        request.getSession().setAttribute("message", "Số điện thoại không hợp lệ!");
                        request.getSession().setAttribute("messageType", "error");
                        response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
                        return;
                    }

                    // Validate address length
                    if (address.length() < 10) {
                        request.getSession().setAttribute("message", "Địa chỉ phải có ít nhất 10 ký tự!");
                        request.getSession().setAttribute("messageType", "error");
                        response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
                        return;
                    }

                    // Validate password format (if provided)
                    if (password != null && !password.trim().isEmpty() && !password.matches("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$")) {
                        request.getSession().setAttribute("message", "Mật khẩu phải có ít nhất 6 ký tự, bao gồm chữ và số!");
                        request.getSession().setAttribute("messageType", "error");
                        response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
                        return;
                    }

                    // Lấy thông tin khách hàng hiện tại
                    Customer existingCustomer = dao.getCustomerById(customerId);
                    if (existingCustomer == null) {
                        request.getSession().setAttribute("message", "Không tìm thấy thông tin khách hàng!");
                        request.getSession().setAttribute("messageType", "error");
                        response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
                        return;
                    }

                    // Cập nhật thông tin mới vào đối tượng Customer
                    existingCustomer.setUsername(username);
                    existingCustomer.setEmail(email);
                    existingCustomer.setFirstName(firstName);
                    existingCustomer.setLastName(lastName);
                    existingCustomer.setAddress(address);
                    existingCustomer.setPhone(phone);
                    existingCustomer.setRole(role);
                    if (password != null && !password.trim().isEmpty()) {
                        existingCustomer.setPassword(password); // Cập nhật mật khẩu nếu có
                    }
                    if (profilePicturePath != null) {
                        existingCustomer.setProfilePicture(profilePicturePath); // Cập nhật ảnh đại diện nếu có
                    }

                    // Cập nhật thông tin vào database
                    if (dao.updateCustomer(existingCustomer)) {
                        request.getSession().setAttribute("message", "Cập nhật thông tin khách hàng thành công!");
                        request.getSession().setAttribute("messageType", "success");
                    } else {
                        request.getSession().setAttribute("message", "Không thể cập nhật thông tin khách hàng!");
                        request.getSession().setAttribute("messageType", "error");
                    }
                    response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
                } else {
                    // Thêm khách hàng mới
                    if (username == null || username.trim().isEmpty() ||
                        email == null || email.trim().isEmpty() ||
                        firstName == null || firstName.trim().isEmpty() ||
                        lastName == null || lastName.trim().isEmpty() ||
                        phone == null || phone.trim().isEmpty() ||
                        address == null || address.trim().isEmpty() ||
                        password == null || password.trim().isEmpty()) {
                        request.getSession().setAttribute("message", "Vui lòng điền đầy đủ thông tin bắt buộc (bao gồm mật khẩu khi thêm mới)!");
                        request.getSession().setAttribute("messageType", "error");
                        response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
                        return;
                    }

                    // Validate username format
                    if (!username.matches("^[A-Za-z0-9_]{3,}$")) {
                        request.getSession().setAttribute("message", "Tên đăng nhập phải có ít nhất 3 ký tự và không chứa ký tự đặc biệt!");
                        request.getSession().setAttribute("messageType", "error");
                        response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
                        return;
                    }

                    // Validate email format
                    if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
                        request.getSession().setAttribute("message", "Email không hợp lệ!");
                        request.getSession().setAttribute("messageType", "error");
                        response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
                        return;
                    }

                    // Validate firstName and lastName format
                    if (!NAME_PATTERN.matcher(firstName).matches() || !NAME_PATTERN.matcher(lastName).matches()) {
                        request.getSession().setAttribute("message", "Họ và Tên phải có ít nhất 2 ký tự và không chứa số hoặc ký tự đặc biệt!");
                        request.getSession().setAttribute("messageType", "error");
                        response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
                        return;
                    }

                    // Validate phone number format
                    if (!phone.matches("(84|0[3|5|7|8|9])+([0-9]{8})")) {
                        request.getSession().setAttribute("message", "Số điện thoại không hợp lệ!");
                        request.getSession().setAttribute("messageType", "error");
                        response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
                        return;
                    }

                    // Validate address length
                    if (address.length() < 10) {
                        request.getSession().setAttribute("message", "Địa chỉ phải có ít nhất 10 ký tự!");
                        request.getSession().setAttribute("messageType", "error");
                        response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
                        return;
                    }

                    // Validate password format
                    if (!password.matches("^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$")) {
                        request.getSession().setAttribute("message", "Mật khẩu phải có ít nhất 6 ký tự, bao gồm chữ và số!");
                        request.getSession().setAttribute("messageType", "error");
                        response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
                        return;
                    }

                    // Gọi insertCustomerAll với đúng thứ tự tham số
                    boolean inserted = dao.insertCustomerAll(username, email, firstName, lastName, password, profilePicturePath, address, phone, role);
                    if (inserted) {
                        request.getSession().setAttribute("message", "Thêm khách hàng mới thành công!");
                        request.getSession().setAttribute("messageType", "success");
                    } else {
                        request.getSession().setAttribute("message", "Thêm khách hàng mới thất bại!");
                        request.getSession().setAttribute("messageType", "error");
                    }
                    response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
                }
            } catch (SQLException | ClassNotFoundException e) {
                Logger.getLogger(EditCustomerServlet.class.getName()).log(Level.SEVERE, null, e);
                request.getSession().setAttribute("message", "Đã xảy ra lỗi khi cập nhật/thêm khách hàng!");
                request.getSession().setAttribute("messageType", "error");
                response.sendRedirect(request.getContextPath() + "/CustomerManagerAd");
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