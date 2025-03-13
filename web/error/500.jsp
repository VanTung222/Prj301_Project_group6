<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@ page
isErrorPage="true" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>500 - Lỗi máy chủ</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <style>
      body {
        height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
      }
      .error-container {
        text-align: center;
        padding: 2rem;
      }
      .error-code {
        font-size: 6rem;
        font-weight: bold;
        color: #dc3545;
        margin-bottom: 1rem;
      }
      .error-message {
        font-size: 1.5rem;
        color: #6c757d;
        margin-bottom: 2rem;
      }
    </style>
  </head>
  <body>
    <div class="error-container">
      <div class="error-code">500</div>
      <div class="error-message">Đã xảy ra lỗi máy chủ</div>
      <p class="text-muted mb-4">
        Vui lòng thử lại sau hoặc liên hệ quản trị viên nếu lỗi vẫn tiếp tục.
      </p>
      <a href="/" class="btn btn-primary">
        <i class="bi bi-house-door"></i> Về trang chủ
      </a>
    </div>
  </body>
</html>
