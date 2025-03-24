<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <link rel="stylesheet" href="css/order-confirmation.css">
    
    <style>
        :root {
    --primary: #ff6b00;
    --primary-light: #ff9248;
    --primary-dark: #e65c00;
    --secondary: #2d3436;
    --success: #00c851;
    --success-light: rgba(0, 200, 81, 0.1);
    --background: #f8f9fa;
    --white: #ffffff;
    --gray-100: #f8f9fa;
    --gray-200: #e9ecef;
    --gray-300: #dee2e6;
    --border-radius: 20px;
    --box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
    --transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    --glass-bg: rgba(255, 255, 255, 0.95);
    --glass-border: rgba(255, 255, 255, 0.2);
}

body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 50%, #fff5e9 100%);
    min-height: 100vh;
    margin: 0;
    padding: 40px 0;
    color: var(--secondary);
}

.container {
    max-width: 1000px;
    margin: 0 auto;
    padding: 2rem;
    perspective: 1000px;
}

/* Success Header with Enhanced Effects */
.confirmation-header {
    text-align: center;
    margin-bottom: 4rem;
    animation: slideDown 0.8s cubic-bezier(0.4, 0, 0.2, 1);
    position: relative;
}

.success-icon {
    width: 100px;
    height: 100px;
    background: var(--success-light);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 2rem;
    color: var(--success);
    font-size: 3rem;
    position: relative;
    animation: scaleIn 0.6s cubic-bezier(0.4, 0, 0.2, 1) 0.3s both;
    box-shadow: 0 15px 35px rgba(0, 200, 81, 0.2);
}

.success-icon::after {
    content: '';
    position: absolute;
    width: 100%;
    height: 100%;
    border-radius: 50%;
    border: 2px solid var(--success);
    animation: ripple 1.5s cubic-bezier(0.4, 0, 0.2, 1) infinite;
}

.confirmation-header h1 {
    color: var(--success);
    font-size: 3rem;
    margin-bottom: 1rem;
    font-weight: 700;
    text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    letter-spacing: -0.5px;
}

.confirmation-header p {
    color: var(--secondary);
    font-size: 1.2rem;
    opacity: 0.9;
    max-width: 600px;
    margin: 0 auto;
    line-height: 1.6;
}

/* Enhanced Order Details Card */
.order-details {
    background: var(--glass-bg);
    backdrop-filter: blur(10px);
    border: 1px solid var(--glass-border);
    border-radius: var(--border-radius);
    box-shadow: var(--box-shadow);
    padding: 2.5rem;
    margin-bottom: 2.5rem;
    animation: slideUp 0.8s cubic-bezier(0.4, 0, 0.2, 1);
    transform-style: preserve-3d;
    transition: var(--transition);
}

.order-details:hover {
    transform: translateY(-5px) rotateX(2deg);
    box-shadow: 0 15px 50px rgba(0, 0, 0, 0.15);
}

.order-number {
    text-align: center;
    padding-bottom: 2rem;
    border-bottom: 2px solid var(--gray-200);
    margin-bottom: 2rem;
    position: relative;
}

.order-number::after {
    content: '';
    position: absolute;
    bottom: -2px;
    left: 50%;
    transform: translateX(-50%);
    width: 100px;
    height: 2px;
    background: linear-gradient(to right, var(--primary), var(--primary-light));
}

.order-number h2 {
    color: var(--primary);
    font-size: 1.8rem;
    margin-bottom: 0.8rem;
    font-weight: 700;
}

/* Enhanced Product Items */
.product-item {
    background: var(--white);
    display: flex;
    align-items: center;
    padding: 1.5rem;
    border: 1px solid var(--gray-200);
    border-radius: 15px;
    margin-bottom: 1.5rem;
    transition: var(--transition);
    position: relative;
    overflow: hidden;
}

.product-item::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: linear-gradient(45deg, transparent, rgba(255, 107, 0, 0.05), transparent);
    transform: translateX(-100%);
    transition: var(--transition);
}

.product-item:hover {
    transform: translateX(5px) translateY(-2px);
    border-color: var(--primary-light);
    box-shadow: 0 10px 30px rgba(255, 107, 0, 0.1);
}

.product-item:hover::before {
    transform: translateX(100%);
}

.product-image {
    width: 100px;
    height: 100px;
    border-radius: 12px;
    overflow: hidden;
    margin-right: 2rem;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    transition: var(--transition);
}

.product-item:hover .product-image {
    transform: scale(1.05);
}

/* Enhanced Buttons */
.btn {
    padding: 1.2rem 2.5rem;
    border-radius: 12px;
    font-size: 1.1rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 1px;
    cursor: pointer;
    transition: var(--transition);
    text-decoration: none;
    text-align: center;
    position: relative;
    overflow: hidden;
}

.btn-primary {
    background: linear-gradient(135deg, var(--primary), var(--primary-light));
    color: var(--white);
    border: none;
    flex: 1;
}

.btn-primary::after {
    content: '';
    position: absolute;
    width: 100%;
    height: 100%;
    top: 0;
    left: -100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    transition: var(--transition);
}

.btn-primary:hover::after {
    left: 100%;
}

.btn:hover {
    transform: translateY(-3px);
    box-shadow: 0 10px 25px rgba(255, 107, 0, 0.3);
}

/* New Animations */
@keyframes ripple {
    0% {
        transform: scale(1);
        opacity: 0.5;
    }
    100% {
        transform: scale(1.5);
        opacity: 0;
    }
}

@keyframes float {
    0%, 100% {
        transform: translateY(0);
    }
    50% {
        transform: translateY(-10px);
    }
}

/* Enhanced Responsive Design */
@media (max-width: 768px) {
    .container {
        padding: 1rem;
    }

    .confirmation-header h1 {
        font-size: 2.2rem;
    }

    .success-icon {
        width: 80px;
        height: 80px;
        font-size: 2.5rem;
    }

    .product-item {
        padding: 1.2rem;
    }

    .product-image {
        width: 80px;
        height: 80px;
        margin-right: 1.5rem;
    }

    .btn {
        padding: 1rem 2rem;
        font-size: 1rem;
    }
}

/* Glass Morphism Effects */
.summary-section {
    background: var(--glass-bg);
    backdrop-filter: blur(10px);
    border: 1px solid var(--glass-border);
    border-radius: 15px;
    padding: 1.8rem;
    transition: var(--transition);
}

.summary-section:hover {
    transform: translateY(-3px);
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

/* Print Styles with Enhanced Formatting */
@media print {
    body {
        background: var(--white);
        padding: 0;
        color: black;
    }

    .container {
        max-width: 100%;
        padding: 2rem;
    }

    .order-details,
    .shipping-info,
    .summary-section {
        box-shadow: none;
        border: 1px solid var(--gray-300);
        break-inside: avoid;
        page-break-inside: avoid;
    }

    .success-icon,
    .action-buttons {
        display: none;
    }
}

/* Thêm style cho các phần tử mới */
.payment-info {
    background: var(--glass-bg);
    backdrop-filter: blur(10px);
    border: 1px solid var(--glass-border);
    border-radius: var(--border-radius);
    padding: 2rem;
    margin: 2rem 0;
    animation: slideUp 0.8s cubic-bezier(0.4, 0, 0.2, 1);
}

.payment-info h3 {
    color: var(--primary);
    font-size: 1.5rem;
    margin-bottom: 1.5rem;
    font-weight: 600;
    text-align: center;
}

.payment-info p {
    font-size: 1.1rem;
    margin: 1rem 0;
    padding: 0.8rem;
    border-radius: 8px;
    background: rgba(255, 255, 255, 0.5);
    transition: var(--transition);
}

.payment-info p:hover {
    transform: translateX(5px);
    background: rgba(255, 255, 255, 0.8);
}

.total-amount {
    font-size: 1.5rem !important;
    font-weight: 700;
    color: var(--primary);
    background: linear-gradient(to right, rgba(255, 107, 0, 0.1), transparent) !important;
    border-left: 4px solid var(--primary);
}

.bank-info {
    display: grid;
    gap: 1rem;
    margin: 2rem 0;
}

.bank-info p {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: var(--white);
    padding: 1rem 1.5rem;
    border-radius: 10px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
}

.qr-code-section {
    text-align: center;
    margin: 2rem 0;
    padding: 2rem;
    background: var(--white);
    border-radius: var(--border-radius);
    box-shadow: var(--box-shadow);
}

.qr-code-section img {
    max-width: 200px;
    margin: 1rem 0;
}

.success-message {
    color: var(--success);
    background: var(--success-light);
    padding: 1rem 1.5rem;
    border-radius: 10px;
    margin: 1rem 0;
    display: flex;
    align-items: center;
    gap: 1rem;
    animation: slideIn 0.5s ease-out;
}

.success-message::before {
    content: '✓';
    display: inline-block;
    width: 24px;
    height: 24px;
    background: var(--success);
    color: white;
    border-radius: 50%;
    text-align: center;
    line-height: 24px;
}

.error-message {
    color: #ff4444;
    background: rgba(255, 68, 68, 0.1);
    padding: 1rem 1.5rem;
    border-radius: 10px;
    margin: 1rem 0;
    display: flex;
    align-items: center;
    gap: 1rem;
    animation: shake 0.5s ease-in-out;
}

.error-message::before {
    content: '!';
    display: inline-block;
    width: 24px;
    height: 24px;
    background: #ff4444;
    color: white;
    border-radius: 50%;
    text-align: center;
    line-height: 24px;
}

.primary-btn {
    display: inline-block;
    padding: 1rem 2rem;
    background: linear-gradient(135deg, var(--primary), var(--primary-light));
    color: var(--white);
    text-decoration: none;
    border-radius: 10px;
    font-weight: 600;
    transition: var(--transition);
    text-transform: uppercase;
    letter-spacing: 1px;
    position: relative;
    overflow: hidden;
    margin-top: 2rem;
}

.primary-btn::after {
    content: '';
    position: absolute;
    width: 100%;
    height: 100%;
    top: 0;
    left: -100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    transition: var(--transition);
}

.primary-btn:hover {
    transform: translateY(-3px);
    box-shadow: 0 10px 25px rgba(255, 107, 0, 0.3);
}

.primary-btn:hover::after {
    left: 100%;
}

@keyframes slideIn {
    from {
        opacity: 0;
        transform: translateX(-20px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

@keyframes shake {
    0%, 100% { transform: translateX(0); }
    25% { transform: translateX(-5px); }
    75% { transform: translateX(5px); }
}

/* Responsive adjustments */
@media (max-width: 768px) {
    .payment-info {
        padding: 1.5rem;
    }

    .payment-info h3 {
        font-size: 1.3rem;
    }

    .payment-info p {
        font-size: 1rem;
        padding: 0.6rem;
    }

    .total-amount {
        font-size: 1.3rem !important;
    }

    .bank-info p {
        flex-direction: column;
        text-align: center;
        gap: 0.5rem;
    }

    .qr-code-section img {
        max-width: 150px;
    }

    .primary-btn {
        width: 100%;
        text-align: center;
    }
}

/* Animation for new elements */
.payment-info, .bank-info, .qr-code-section {
    animation: fadeInUp 0.8s ease-out forwards;
}

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}s
    </style>
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