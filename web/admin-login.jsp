<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Admin Login</title>
    <!-- Bootstrap CSS -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <!-- Bootstrap Icons -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"
      rel="stylesheet"
    />
    <style>
      body {
        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
      }
      .login-container {
        background: white;
        padding: 2rem;
        border-radius: 15px;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        width: 100%;
        max-width: 400px;
      }
      .login-header {
        text-align: center;
        margin-bottom: 2rem;
      }
      .login-header i {
        font-size: 3rem;
        color: #0d6efd;
      }
      .form-control {
        border-radius: 10px;
        padding: 0.75rem 1rem;
      }
      .btn-login {
        border-radius: 10px;
        padding: 0.75rem 1rem;
        font-weight: 500;
        width: 100%;
        background: linear-gradient(135deg, #0d6efd 0%, #0099ff 100%);
        border: none;
      }
      .btn-login:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(13, 110, 253, 0.3);
      }
      .error-message {
        color: #dc3545;
        margin-bottom: 1rem;
        text-align: center;
      }
    </style>
  </head>
  <body>
    <div class="login-container">
      <div class="login-header">
        <i class="bi bi-shield-lock mb-3"></i>
        <h2>Admin Login</h2>
        <p class="text-muted">Enter your credentials to access admin panel</p>
      </div>

      <% if (request.getAttribute("error") != null) { %>
      <div class="error-message">
        <i class="bi bi-exclamation-circle me-2"></i>
        <%= request.getAttribute("error") %>
      </div>
      <% } %>

      <form
        action="${pageContext.request.contextPath}/admin/login"
        method="post"
      >
        <div class="mb-3">
          <label for="username" class="form-label">Username</label>
          <div class="input-group">
            <span class="input-group-text"><i class="bi bi-person"></i></span>
            <input
              type="text"
              class="form-control"
              id="username"
              name="username"
              required
            />
          </div>
        </div>

        <div class="mb-4">
          <label for="password" class="form-label">Password</label>
          <div class="input-group">
            <span class="input-group-text"><i class="bi bi-key"></i></span>
            <input
              type="password"
              class="form-control"
              id="password"
              name="password"
              required
            />
          </div>
        </div>

        <button type="submit" class="btn btn-primary btn-login">
          <i class="bi bi-box-arrow-in-right me-2"></i>Login
        </button>
      </form>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
