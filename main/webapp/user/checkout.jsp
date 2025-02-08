<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../web_elements/navbar.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout</title>
<link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<div class="container mt-5">
    <h2>Checkout</h2>
    
    <form id="payment-form">
        <div class="mb-3">
            <label for="name" class="form-label">Full Name</label>
            <input type="text" class="form-control" id="name" name="name" required>
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>
        <div class="mb-3">
            <label for="address" class="form-label">Address</label>
            <input type="text" class="form-control" id="address" name="address" required>
        </div>
        <div class="mb-3">
            <label for="card-element" class="form-label">Credit or debit card</label>
            <div id="card-element" class="form-control"></div>
            <div id="card-errors" role="alert" class="text-danger mt-2"></div>
        </div>
        <button type="submit" class="btn btn-primary">Pay Now</button>
    </form>
</div>

<script src="https://js.stripe.com/v3/"></script>
<script src="${pageContext.request.contextPath}/js/checkout.js"></script>
</body>
</html>
