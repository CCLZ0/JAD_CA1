<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login/Register</title>
<link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
function toggleForm(formType) {
	// Toggle active class on the tabs
	document.getElementById('loginTab').classList.toggle('active', formType === 'login');
	document.getElementById('registerTab').classList.toggle('active', formType === 'register');

	// Toggle active class on the forms
	document.getElementById('loginForm').classList.toggle('active', formType === 'login');
	document.getElementById('registerForm').classList.toggle('active', formType === 'register');
}
</script>
</head>
<body>
<div class="container">
    <div class="form-wrapper mt-5">
    	<h1>Welcome to ShinePro B2B</h1>
        <div class="toggle-bar">
				<div id="loginTab" class="active" onclick="toggleForm('login')">Log
					in</div>
				<div id="registerTab" onclick="toggleForm('register')">Sign up</div>
			</div>
        
        <form id="loginForm" class="form active" action="${pageContext.request.contextPath}/b2b/login" method="post">
            <h2>Login</h2>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary">Login</button>
        </form>
        <form id="registerForm" class="form" action="${pageContext.request.contextPath}/b2b/register" method="post">
            <h2>Register</h2>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" class="form-control" id="name" name="name" required>
            </div>
            <button type="submit" class="btn btn-primary">Register</button>
        </form>
        <p>${message}</p>
    </div>
</div>
</body>
</html>