<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ page
import="model.Admin, model.Customer, java.util.*" %> <% // Check if admin is
logged in Admin admin = (Admin) session.getAttribute("admin"); if (admin ==
null) { response.sendRedirect(request.getContextPath() + "/admin-login.jsp");
return; } // Get customers list from request List<Customer>
  customers = (List<Customer
    >) request.getAttribute("customers"); %>
    <!DOCTYPE html>
    <html lang="vi">
      <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Customer Management</title>
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
        <!-- DataTables CSS -->
        <link
          href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css"
          rel="stylesheet"
        />
        <style>
          .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: 280px;
            background: #2c3e50;
            padding: 20px;
            color: white;
          }
          .main-content {
            margin-left: 280px;
            padding: 20px;
          }
          .nav-link {
            color: rgba(255, 255, 255, 0.8);
            padding: 12px 20px;
            border-radius: 10px;
            margin-bottom: 5px;
          }
          .nav-link:hover,
          .nav-link.active {
            background: rgba(255, 255, 255, 0.1);
            color: white;
          }
          .customer-table {
            background: white;
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
          }
          .btn-action {
            padding: 5px 10px;
            font-size: 14px;
          }
        </style>
      </head>
      <body class="bg-light">
        <!-- Sidebar -->
        <div class="sidebar">
          <h3 class="mb-4 text-center">Admin Panel</h3>
          <div class="d-flex flex-column">
            <a
              href="${pageContext.request.contextPath}/admin/dashboard"
              class="nav-link"
            >
              <i class="bi bi-speedometer2 me-2"></i> Dashboard
            </a>
            <a
              href="${pageContext.request.contextPath}/admin/customers"
              class="nav-link active"
            >
              <i class="bi bi-people me-2"></i> Customers
            </a>
            <a
              href="${pageContext.request.contextPath}/admin/statistics"
              class="nav-link"
            >
              <i class="bi bi-graph-up me-2"></i> Statistics
            </a>
            <form
              action="${pageContext.request.contextPath}/admin/logout"
              method="post"
              class="mt-auto"
            >
              <button
                type="submit"
                class="nav-link text-danger border-0 bg-transparent w-100 text-start"
              >
                <i class="bi bi-box-arrow-right me-2"></i> Logout
              </button>
            </form>
          </div>
        </div>

        <!-- Main Content -->
        <div class="main-content">
          <div class="d-flex justify-content-between align-items-center mb-4">
            <h2>Customer Management</h2>
            <div class="d-flex align-items-center">
              <i class="bi bi-person-circle me-2"></i>
              Welcome, <%= admin.getFullName() %>
            </div>
          </div>

          <% if (request.getAttribute("success") != null) { %>
          <div
            class="alert alert-success alert-dismissible fade show"
            role="alert"
          >
            <i class="bi bi-check-circle me-2"></i>
            <%= request.getAttribute("success") %>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="alert"
              aria-label="Close"
            ></button>
          </div>
          <% } %> <% if (request.getAttribute("error") != null) { %>
          <div
            class="alert alert-danger alert-dismissible fade show"
            role="alert"
          >
            <i class="bi bi-exclamation-circle me-2"></i>
            <%= request.getAttribute("error") %>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="alert"
              aria-label="Close"
            ></button>
          </div>
          <% } %>

          <div class="customer-table">
            <div class="table-responsive">
              <table id="customerTable" class="table table-hover">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Address</th>
                    <th>Actions</th>
                  </tr>
                </thead>
                <tbody>
                  <% if (customers != null) { for (Customer customer :
                  customers) { %>
                  <tr>
                    <td><%= customer.getCustomerId() %></td>
                    <td><%= customer.getUsername() %></td>
                    <td><%= customer.getFullName() %></td>
                    <td><%= customer.getEmail() %></td>
                    <td>
                      <%= customer.getPhone() != null ? customer.getPhone() :
                      "N/A" %>
                    </td>
                    <td>
                      <%= customer.getAddress() != null ? customer.getAddress()
                      : "N/A" %>
                    </td>
                    <td>
                      <button
                        class="btn btn-sm btn-primary btn-action me-1"
                        onclick="viewCustomerDetails(<%= customer.getCustomerId() %>)"
                      >
                        <i class="bi bi-eye"></i>
                      </button>
                      <button
                        class="btn btn-sm btn-danger btn-action"
                        onclick="deleteCustomer(<%= customer.getCustomerId() %>)"
                      >
                        <i class="bi bi-trash"></i>
                      </button>
                    </td>
                  </tr>
                  <% } } %>
                </tbody>
              </table>
            </div>
          </div>
        </div>

        <!-- Delete Confirmation Modal -->
        <div class="modal fade" id="deleteModal" tabindex="-1">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title">Confirm Delete</h5>
                <button
                  type="button"
                  class="btn-close"
                  data-bs-dismiss="modal"
                ></button>
              </div>
              <div class="modal-body">
                Are you sure you want to delete this customer? This action
                cannot be undone.
              </div>
              <div class="modal-footer">
                <button
                  type="button"
                  class="btn btn-secondary"
                  data-bs-dismiss="modal"
                >
                  Cancel
                </button>
                <form
                  action="${pageContext.request.contextPath}/admin/delete-customer"
                  method="post"
                  style="display: inline"
                >
                  <input
                    type="hidden"
                    id="deleteCustomerId"
                    name="customerId"
                  />
                  <button type="submit" class="btn btn-danger">Delete</button>
                </form>
              </div>
            </div>
          </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- DataTables JS -->
        <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
        <script>
          $(document).ready(function () {
            $("#customerTable").DataTable({
              pageLength: 10,
              language: {
                search: "Search customers:",
                lengthMenu: "Show _MENU_ entries per page",
                info: "Showing _START_ to _END_ of _TOTAL_ customers",
                infoEmpty: "No customers available",
                infoFiltered: "(filtered from _MAX_ total customers)",
              },
            });
          });

          function deleteCustomer(customerId) {
            document.getElementById("deleteCustomerId").value = customerId;
            var deleteModal = new bootstrap.Modal(
              document.getElementById("deleteModal")
            );
            deleteModal.show();
          }

          function viewCustomerDetails(customerId) {
            // Implement view customer details functionality
            window.location.href =
              "${pageContext.request.contextPath}/admin/customer-details?id=" +
              customerId;
          }
        </script>
      </body>
    </html>
  </Customer></Customer
>
