<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <link rel="stylesheet" href="css/order-confirmation.css">
    
    
</head>
<body>
    <div class="container">
        <h2>Order Confirmation</h2>
        <p style="color: green;">Order placed successfully. Order ID: ${orderId}</p>
        <c:if test="${not empty error}">
            <p style="color: red;">${error}</p>
        </c:if>
        <c:if test="${not empty emailError}">
            <p style="color: red;">${emailError}</p>
        </c:if>

        <c:choose>
            <c:when test="${paymentMethod == 'Bank Transfer'}">
                <h3>Please transfer the amount to the following account:</h3>
                <p>Total: <fmt:formatNumber value="${total}" type="number" minFractionDigits="2" maxFractionDigits="2" />$</p>
                <p>Bank: Example Bank</p>
                <p>Account Number: 1234-5678-9012</p>
                <p>Scan the QR code below to pay:</p>
                <p>After payment, please wait for admin approval.</p>
            </c:when>
            <c:when test="${paymentMethod == 'COD'}">
                <h3>Cash on Delivery (COD)</h3>
                <p>Total: <fmt:formatNumber value="${total}" type="number" minFractionDigits="2" maxFractionDigits="2" />$</p>
                <p>Your order is pending admin approval. You will pay upon delivery.</p>
            </c:when>
        </c:choose>

        <a href="index.jsp" class="primary-btn">Back to Home</a>
    </div>
</body>
</html>