<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Review</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="menu.jsp"/>
    
    <div class="container py-5">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <div class="card-header">
                        <h4>Edit Review</h4>
                    </div>
                    <div class="card-body">
                        <form action="review" method="post">
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="id" value="${review.reviewId}">
                            
                            <div class="mb-3">
                                <label class="form-label">Rating</label>
                                <select name="rating" class="form-select" required>
                                    <option value="1" ${review.rating == 1 ? 'selected' : ''}>1 Star</option>
                                    <option value="2" ${review.rating == 2 ? 'selected' : ''}>2 Stars</option>
                                    <option value="3" ${review.rating == 3 ? 'selected' : ''}>3 Stars</option>
                                    <option value="4" ${review.rating == 4 ? 'selected' : ''}>4 Stars</option>
                                    <option value="5" ${review.rating == 5 ? 'selected' : ''}>5 Stars</option>
                                </select>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Comment</label>
                                <textarea name="comment" class="form-control" rows="4" required minlength="10">${review.comment}</textarea>
                                <div class="form-text">Minimum 10 characters required.</div>
                            </div>
                            
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary">Update Review</button>
                                <a href="shop-details.jsp?product_id=${review.productId}" class="btn btn-secondary">Cancel</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="footer.jsp"/>
    <script src="js/bootstrap.bundle.min.js"></script>
</body>
</html> 