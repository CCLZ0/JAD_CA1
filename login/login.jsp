<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login/Register Toggle</title>
<link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css/login.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<%@ include file="../web_elements/navbar.jsp" %>
	<div class="form-wrapper">
		<div class="container">
	        <!-- Toggle bar for Login/Register -->
	        <div class="toggle-bar">
	            <div id="loginTab" class="active" onclick="toggleForm('login')">Log in</div>
	            <div id="registerTab" onclick="toggleForm('register')">Sign up</div>
	        </div>
	
	        <!-- Display success or error messages if any -->
	        <%
	            String errCode = request.getParameter("error");
	            String successCode = request.getParameter("success");
	            if (errCode != null) {
	        %>
	        <div id="errorBox">
	            <%
	                if (errCode.equals("100")) {
	                    out.print("Missing data!");
	                } else if (errCode.equals("101")) {
	                    out.print("Name and Password cannot be empty.");
	                } else if (errCode.equals("passwordMismatch")) {
	                    out.print("Passwords do not match.");
	                } else if (errCode.equals("userExists")) {
	                    out.print("Username already exists.");
	                } else if (errCode.equals("invalidLogin")) {
	                    out.print("You have entered an invalid Name/Password.");
	                } else if (errCode.equals("registrationFailed")) {
	                    out.print("Registration failed. Please try again.");
	                } else {
	                    out.print("Unknown error code.");
	                }
	            %>
	        </div>
	        <% } else if (successCode != null) { %>
	        <div id="successBox">
	            Registration successful! You can now log in.
	        </div>
	        <% } %>
	
	        <!-- Login Form -->
	        <form id="loginForm" class="form active" action="verifyUser.jsp" method="post">
	            <h2>Login</h2>
	            <input type="text" name="name" placeholder="Name" required>
	            <input type="password" name="password" placeholder="Password" required>
	            <button type="submit" class="submitBtn">Login</button>
	        </form>
	
	        <!-- Register Form -->
	        <form id="registerForm" class="form" action="registerUser.jsp" method="post">
	            <h2>Register</h2>
	            <input type="text" name="name" placeholder="Name" required>
	            <input type="password" name="password" placeholder="Password" required>
	            <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
	            <button type="submit" class="submitBtn">Register</button>
	        </form>
	    </div>
	</div>
    

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

</body>
<script src="../js/app.js"></script>
</html>



