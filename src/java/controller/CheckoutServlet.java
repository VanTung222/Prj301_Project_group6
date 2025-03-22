//package controller;
//
//import dao.CartDAO;
//import dao.OrderDAO;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import java.io.IOException;
//import java.sql.SQLException;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//import model.CartItem;
//
//@WebServlet(name = "CheckoutServlet", urlPatterns = {"/CheckoutServlet"})
//public class CheckoutServlet extends HttpServlet {
//
//    private CartDAO cartDAO = new CartDAO();
//    private OrderDAO orderDAO = new OrderDAO();
//
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        HttpSession session = request.getSession(false);
//        if (session == null || session.getAttribute("customerId") == null) {
//            response.sendRedirect("login.jsp");
//            return;
//        }
//
//        int customerId = (int) session.getAttribute("customerId");
//        System.out.println("Customer ID in CheckoutServlet: " + customerId); // Debug customerId
//
//        try {
//            List<CartItem> cartItems = cartDAO.getCartItems(customerId);
//            System.out.println("Cart Items Size in CheckoutServlet: " + (cartItems != null ? cartItems.size() : "null")); // Debug cartItems
//
//            if (cartItems == null || cartItems.isEmpty()) {
//                request.setAttribute("error", "Your cart is empty. Please add items to your cart before checking out.");
//                request.getRequestDispatcher("cart.jsp").forward(request, response);
//                return;
//            }
//
//            double total = cartItems.stream()
//                    .mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity())
//                    .sum();
//
//            Map<String, String> shippingInfo = new HashMap<>();
//            orderDAO.getLastShippingInfo(customerId, shippingInfo);
//
//            request.setAttribute("cartItems", cartItems);
//            request.setAttribute("total", total);
//            request.setAttribute("shippingInfo", shippingInfo);
//            request.getRequestDispatcher("checkout.jsp").forward(request, response);
//        } catch (SQLException | ClassNotFoundException e) {
//            e.printStackTrace();
//            request.setAttribute("error", "Error retrieving cart: " + e.getMessage());
//            request.getRequestDispatcher("cart.jsp").forward(request, response);
//        }
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        HttpSession session = request.getSession(false);
//        if (session == null || session.getAttribute("customerId") == null) {
//            response.sendRedirect("login.jsp");
//            return;
//        }
//
//        int customerId = (int) session.getAttribute("customerId");
//        try {
//            List<CartItem> cartItems = cartDAO.getCartItems(customerId);
//            if (cartItems.isEmpty()) {
//                request.setAttribute("error", "Your cart is empty");
//                request.getRequestDispatcher("cart.jsp").forward(request, response);
//                return;
//            }
//
//            String firstName = request.getParameter("firstName");
//            String lastName = request.getParameter("lastName");
//            String address = request.getParameter("address");
//            String city = request.getParameter("city");
//            String countryState = request.getParameter("countryState");
//            String postcode = request.getParameter("postcode");
//            String phone = request.getParameter("phone");
//            String email = request.getParameter("email");
//            String orderNotes = request.getParameter("orderNotes");
//            String paymentMethod = request.getParameter("paymentMethod");
//
//            double totalAmount = cartItems.stream()
//                    .mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity())
//                    .sum();
//
//            int orderId = orderDAO.createOrder(customerId, totalAmount, firstName, lastName, address, city, countryState,
//                    postcode, phone, email, orderNotes, paymentMethod, cartItems);
//
//            cartDAO.clearCart(customerId);
//
//            // Lưu thông tin để hiển thị ở trang xác nhận
//            request.setAttribute("orderId", orderId);
//            request.setAttribute("paymentMethod", paymentMethod);
//            request.setAttribute("total", totalAmount);
//            request.getRequestDispatcher("order-confirmation.jsp").forward(request, response);
//        } catch (SQLException | ClassNotFoundException e) {
//            request.setAttribute("error", "Error processing order: " + e.getMessage());
//            request.getRequestDispatcher("checkout.jsp").forward(request, response);
//        }
//    }
//}
//code mới
package controller;

import dao.CartDAO;
import dao.OrderDAO;
import dao.PaymentDAO;
import dao.CustomerDAO;
import dao.DiscountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.Multipart;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;
import model.CartItem;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/CheckoutServlet"})
public class CheckoutServlet extends HttpServlet {

    private CartDAO cartDAO = new CartDAO();
    private OrderDAO orderDAO = new OrderDAO();
    private PaymentDAO paymentDAO = new PaymentDAO();
    private CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customerId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int customerId = (int) session.getAttribute("customerId");
        System.out.println("Customer ID in CheckoutServlet: " + customerId); // Debug

        try {
            List<CartItem> cartItems = cartDAO.getCartItems(customerId);
            System.out.println("Cart Items Size in CheckoutServlet: " + (cartItems != null ? cartItems.size() : "null")); // Debug

            if (cartItems == null || cartItems.isEmpty()) {
                request.setAttribute("error", "Your cart is empty. Please add items to your cart before checking out.");
                request.getRequestDispatcher("cart.jsp").forward(request, response);
                return;
            }

            double subtotal = cartItems.stream()
                    .mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity())
                    .sum();
            double appliedDiscount = session.getAttribute("appliedDiscount") != null ? (double) session.getAttribute("appliedDiscount") : 0;
            double finalTotal = subtotal * (1 - appliedDiscount / 100);

            Map<String, String> shippingInfo = new HashMap<>();
            orderDAO.getLastShippingInfo(customerId, shippingInfo);

            request.setAttribute("cartItems", cartItems);
            request.setAttribute("total", finalTotal);
            request.setAttribute("shippingInfo", shippingInfo);
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error retrieving cart: " + e.getMessage());
            request.getRequestDispatcher("cart.jsp").forward(request, response);
        }
    }

//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        HttpSession session = request.getSession(false);
//        if (session == null || session.getAttribute("customerId") == null) {
//            response.sendRedirect("login.jsp");
//            return;
//        }
//
//        int customerId = (int) session.getAttribute("customerId");
//        try {
//            List<CartItem> cartItems = cartDAO.getCartItems(customerId);
//            if (cartItems.isEmpty()) {
//                request.setAttribute("error", "Your cart is empty");
//                request.getRequestDispatcher("cart.jsp").forward(request, response);
//                return;
//            }
//
//            String firstName = request.getParameter("firstName");
//            String lastName = request.getParameter("lastName");
//            String address = request.getParameter("address");
//            String city = request.getParameter("city");
//            String countryState = request.getParameter("countryState");
//            String postcode = request.getParameter("postcode");
//            String phone = request.getParameter("phone");
//            String email = request.getParameter("email");
//            String orderNotes = request.getParameter("orderNotes");
//            String paymentMethod = request.getParameter("paymentMethod");
//
//            double appliedDiscount = session.getAttribute("appliedDiscount") != null ? (double) session.getAttribute("appliedDiscount") : 0;
//            String discountCode = session.getAttribute("discountCode") != null ? (String) session.getAttribute("discountCode") : null;
//
//            double subtotal = cartItems.stream()
//                    .mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity())
//                    .sum();
//            double discountAmount = subtotal * (appliedDiscount / 100);
//            double finalTotal = subtotal - discountAmount;
//
//            int orderId = orderDAO.createOrder(customerId, finalTotal, firstName, lastName, address, city, countryState,
//                    postcode, phone, email, orderNotes, paymentMethod, cartItems, discountCode, discountAmount);
//
//            int paymentId = paymentDAO.createPayment(orderId, customerId, finalTotal, paymentMethod);
//
//            // Nếu mã giảm giá đã được áp dụng, đánh dấu là đã sử dụng
//            if (appliedDiscount > 0 && discountCode != null) {
//                new DiscountDAO().markDiscountAsUsed(discountCode);
//            }
//
//            // Gửi email thông báo thanh toán
//            String customerEmail = customerDAO.getCustomerEmail(customerId);
//            sendPaymentNotificationEmail(customerEmail, paymentId, finalTotal, paymentMethod);
//
//            // Nếu phương thức thanh toán là chuyển khoản, gửi mã QR và lên lịch nhắc nhở
//            if ("Bank Transfer".equalsIgnoreCase(paymentMethod)) {
//                String qrCodePath = generateQRCodeForBankTransfer(paymentId, finalTotal);
//                sendBankTransferEmail(customerEmail, paymentId, finalTotal, qrCodePath);
//                scheduleBankTransferReminder(paymentId, customerId, customerEmail, request);
//            }
//
//            // Kiểm tra tổng tiền chi tiêu và gửi mã giảm giá nếu đủ điều kiện
//            double totalSpent = paymentDAO.getTotalSpentByCustomer(customerId);
//            double threshold = 500.0; // Ngưỡng để nhận mã giảm giá (ví dụ: $500)
//            if (totalSpent >= threshold) {
//                String newDiscountCode = "DISCOUNT" + System.currentTimeMillis();
//                double discountPercentage = 5.0; // 5% giảm giá
//                Date expiryDate = new Date(System.currentTimeMillis() + 7 * 24 * 60 * 60 * 1000L); // Hết hạn sau 7 ngày
//
//                DiscountDAO discountDAO = new DiscountDAO();
//                discountDAO.createDiscountCode(customerId, newDiscountCode, discountPercentage, expiryDate);
//                sendDiscountCodeEmail(customerEmail, newDiscountCode, discountPercentage);
//            }
//
//            // Xóa giỏ hàng sau khi thanh toán thành công
//            cartDAO.clearCart(customerId);
//            session.removeAttribute("appliedDiscount");
//            session.removeAttribute("discountCode");
//
//            // Lưu thông tin để hiển thị ở trang xác nhận
//            request.setAttribute("orderId", orderId);
//            request.setAttribute("paymentMethod", paymentMethod);
//            request.setAttribute("total", finalTotal);
//            request.getRequestDispatcher("order-confirmation.jsp").forward(request, response);
//        } catch (SQLException | ClassNotFoundException | IOException | WriterException e) {
//            e.printStackTrace();
//            request.setAttribute("error", "Error processing order: " + e.getMessage());
//            request.getRequestDispatcher("checkout.jsp").forward(request, response);
//        }
//    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customerId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int customerId = (int) session.getAttribute("customerId");
        try {
            List<CartItem> cartItems = cartDAO.getCartItems(customerId);
            if (cartItems.isEmpty()) {
                request.setAttribute("error", "Your cart is empty");
                request.getRequestDispatcher("cart.jsp").forward(request, response);
                return;
            }

            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String countryState = request.getParameter("countryState");
            String postcode = request.getParameter("postcode");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String orderNotes = request.getParameter("orderNotes");
            String paymentMethod = request.getParameter("paymentMethod");

            double appliedDiscount = session.getAttribute("appliedDiscount") != null ? (double) session.getAttribute("appliedDiscount") : 0;
            String discountCode = session.getAttribute("discountCode") != null ? (String) session.getAttribute("discountCode") : null;

            double subtotal = cartItems.stream()
                    .mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity())
                    .sum();
            double discountAmount = subtotal * (appliedDiscount / 100);
            double finalTotal = subtotal - discountAmount;

            int orderId = orderDAO.createOrder(customerId, finalTotal, firstName, lastName, address, city, countryState,
                    postcode, phone, email, orderNotes, paymentMethod, cartItems, discountCode, discountAmount);

            int paymentId = paymentDAO.createPayment(orderId, customerId, finalTotal, paymentMethod);

            // Nếu mã giảm giá đã được áp dụng, đánh dấu là đã sử dụng
            if (appliedDiscount > 0 && discountCode != null) {
                new DiscountDAO().markDiscountAsUsed(discountCode);
            }

            // Gửi email thông báo thanh toán
            String customerEmail = customerDAO.getCustomerEmail(customerId);
            System.out.println("Customer Email: " + customerEmail); // Log email
            if (customerEmail != null && !customerEmail.isEmpty()) {
                sendPaymentNotificationEmail(customerEmail, paymentId, finalTotal, paymentMethod);
            } else {
                System.out.println("Customer email is null or empty, cannot send email.");
                request.setAttribute("emailError", "Cannot send email: Customer email is missing.");
            }

            // Nếu phương thức thanh toán là chuyển khoản, gửi mã QR và lên lịch nhắc nhở
            if ("Bank Transfer".equalsIgnoreCase(paymentMethod)) {
                try {
                    String qrCodePath = generateQRCodeForBankTransfer(paymentId, finalTotal);
                    sendBankTransferEmail(customerEmail, paymentId, finalTotal, qrCodePath);
                    scheduleBankTransferReminder(paymentId, customerId, customerEmail, request);
                } catch (Exception e) {
                    System.out.println("Error handling Bank Transfer: " + e.getMessage());
                    request.setAttribute("emailError", "Error sending bank transfer email: " + e.getMessage());
                }
            }

            // Kiểm tra tổng tiền chi tiêu và gửi mã giảm giá nếu đủ điều kiện
            double totalSpent = paymentDAO.getTotalSpentByCustomer(customerId);
            double threshold = 500.0; // Ngưỡng để nhận mã giảm giá (ví dụ: $500)
            if (totalSpent >= threshold) {
                String newDiscountCode = "DISCOUNT" + System.currentTimeMillis();
                double discountPercentage = 5.0; // 5% giảm giá
                Date expiryDate = new Date(System.currentTimeMillis() + 7 * 24 * 60 * 60 * 1000L); // Hết hạn sau 7 ngày

                DiscountDAO discountDAO = new DiscountDAO();
                discountDAO.createDiscountCode(customerId, newDiscountCode, discountPercentage, expiryDate);
                if (customerEmail != null && !customerEmail.isEmpty()) {
                    sendDiscountCodeEmail(customerEmail, newDiscountCode, discountPercentage);
                } else {
                    System.out.println("Cannot send discount code email: Customer email is missing.");
                }
            }

            // Xóa giỏ hàng sau khi thanh toán thành công
            cartDAO.clearCart(customerId);
            session.removeAttribute("appliedDiscount");
            session.removeAttribute("discountCode");

            // Lưu thông tin để hiển thị ở trang xác nhận
            request.setAttribute("orderId", orderId);
            request.setAttribute("paymentMethod", paymentMethod);
            request.setAttribute("total", finalTotal);
            request.getRequestDispatcher("order-confirmation.jsp").forward(request, response);
        } catch (SQLException | ClassNotFoundException | IOException  e) {
            e.printStackTrace();
            request.setAttribute("error", "Error processing order: " + e.getMessage());
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
    }

    private String generateQRCodeForBankTransfer(int paymentId, double amount) throws IOException, WriterException {
        String bankDetails = "Bank: Example Bank\n"
                + "Account Number: 123456789\n"
                + "Amount: $" + amount + "\n"
                + "Payment ID: " + paymentId + "\n"
                + "Please transfer within 10 minutes.";

        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        BitMatrix bitMatrix = qrCodeWriter.encode(bankDetails, BarcodeFormat.QR_CODE, 200, 200);
        String qrCodePath = getServletContext().getRealPath("/") + "images/qr-codes/payment_" + paymentId + ".png";
        File qrFile = new File(qrCodePath);
        qrFile.getParentFile().mkdirs(); // Tạo thư mục nếu chưa tồn tại
        MatrixToImageWriter.writeToPath(bitMatrix, "PNG", qrFile.toPath());

        return qrCodePath;
    }

    private void sendPaymentNotificationEmail(String email, int paymentId, double total, String paymentMethod) {
        final String username = "ndat020304@gmail.com"; // Thay bằng email của bạn
        final String password = "wsgz vuwc jlsr ycqq"; // Thay bằng app password của bạn

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject("Payment Confirmation - Payment ID: " + paymentId);
            message.setText("Dear Customer,\n\n"
                    + "Your payment has been initiated.\n"
                    + "Payment ID: " + paymentId + "\n"
                    + "Total Amount: $" + total + "\n"
                    + "Payment Method: " + paymentMethod + "\n\n"
                    + "Thank you for shopping with us!\n\n"
                    + "Best regards,\nYour Store");
            Transport.send(message);
            System.out.println("Payment notification email sent to: " + email);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    private void sendBankTransferEmail(String email, int paymentId, double amount, String qrCodePath) {
        final String username = "ndat020304@gmail.com";
        final String password = "wsgz vuwc jlsr ycqq";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject("Bank Transfer Instructions - Payment ID: " + paymentId);

            MimeBodyPart textPart = new MimeBodyPart();
            textPart.setText("Dear Customer,\n\n"
                    + "Please complete your payment via bank transfer within 10 minutes.\n"
                    + "Payment ID: " + paymentId + "\n"
                    + "Total Amount: $" + amount + "\n"
                    + "Scan the QR code below to view bank details:\n\n"
                    + "Best regards,\nYour Store");

            MimeBodyPart qrPart = new MimeBodyPart();
            qrPart.attachFile(new File(qrCodePath));

            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(textPart);
            multipart.addBodyPart(qrPart);

            message.setContent(multipart);
            Transport.send(message);
            System.out.println("Bank transfer email with QR code sent to: " + email);
        } catch (MessagingException | IOException e) {
            e.printStackTrace();
        }
    }

    private void scheduleBankTransferReminder(int paymentId, int customerId, String customerEmail, HttpServletRequest request) {
        ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
        scheduler.schedule(() -> {
            try {
                String status = paymentDAO.getPaymentStatus(paymentId);
                if ("Bank Transfer".equals(status)) { // Kiểm tra xem trạng thái vẫn là "Bank Transfer" (chưa hoàn tất)
                    sendBankTransferReminderEmail(customerEmail, paymentId);
                    HttpSession session = request.getSession(false);
                    if (session != null) {
                        session.setAttribute("paymentReminder", "Please complete your bank transfer for Payment ID: " + paymentId);
                    }
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            }
        }, 10, TimeUnit.MINUTES); // 10 phút
    }

    private void sendBankTransferReminderEmail(String email, int paymentId) {
         final String username = "ndat020304@gmail.com";
        final String password = "wsgz vuwc jlsr ycqq";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject("Reminder: Complete Your Bank Transfer - Payment ID: " + paymentId);
            message.setText("Dear Customer,\n\n"
                    + "You have not yet completed your bank transfer for Payment ID: " + paymentId + ".\n"
                    + "Please complete the payment as soon as possible.\n\n"
                    + "Best regards,\nYour Store");
            Transport.send(message);
            System.out.println("Bank transfer reminder email sent to: " + email);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    private void sendDiscountCodeEmail(String email, String discountCode, double discountPercentage) {
         final String username = "ndat020304@gmail.com";
        final String password = "wsgz vuwc jlsr ycqq";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject("Your Discount Code");
            message.setText("Dear Customer,\n\n"
                    + "Thank you for your purchases! As a reward, here is your discount code: " + discountCode + "\n"
                    + "Discount Percentage: " + discountPercentage + "%\n"
                    + "Use it on your next purchase!\n\n"
                    + "Best regards,\nYour Store");
            Transport.send(message);
            System.out.println("Discount code email sent to: " + email);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
