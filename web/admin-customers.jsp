<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin - Customers</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h2>Admin - Manage Customers</h2>
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Full Name</th>
                <th>Email</th>
                <th>Level</th>
                <th>Last Login</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="customer" items="${customers}">
                <tr>
                    <form action="update-customer" method="POST">
                        <td><input type="hidden" name="id" value="${customer.id}">${customer.id}</td>
                        <td><input type="text" name="name" value="${customer.name}"></td>
                        <td><input type="text" name="email" value="${customer.email}"></td>
                        <td>
                            <select name="level">
                                <option value="Admin" ${customer.level == 'Admin' ? 'selected' : ''}>Admin</option>
                                <option value="Member" ${customer.level == 'Member' ? 'selected' : ''}>Member</option>
                            </select>
                        </td>
                        <td><input type="text" name="lastLogin" value="${customer.lastLogin}"></td>
                        <td>
                            <button type="submit">Save</button>
                        </td>
                    </form>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
