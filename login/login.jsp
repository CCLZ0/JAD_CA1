<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login/Register Toggle</title>
<link
	href="https://fonts.googleapis.com/css2?family=Recursive&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="../css/login.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<%@ include file="../web_elements/navbar.jsp"%>

	<div class="form-wrapper">
		<div class="container">
			<!-- Toggle bar for Login/Register -->
			<div class="toggle-bar">
				<div id="loginTab" class="active" onclick="toggleForm('login')">Log
					in</div>
				<div id="registerTab" onclick="toggleForm('register')">Sign up</div>
			</div>

			<!-- Display success or error messages if any -->
			<%
                String errCode = request.getParameter("error");
                String successCode = request.getParameter("success");

                if (errCode != null) { 
            %>
			<div id="errorBox" class="alert alert-danger">
				<%
                    switch (errCode) {
                        case "100":
                            out.print("Missing data! Please fill out all fields.");
                            break;
                        case "101":
                            out.print("Username, email, and password cannot be empty.");
                            break;
                        case "passwordMismatch":
                            out.print("Passwords do not match.");
                            break;
                        case "userExists":
                            out.print("Username or email already exists.");
                            break;
                        case "invalidLogin":
                            out.print("Invalid username/email or password.");
                            break;
                        case "registrationFailed":
                            out.print("Registration failed. Please try again.");
                            break;
                        default:
                            out.print("Unknown error occurred.");
                    }
                %>
			</div>
			<% } else if (successCode != null) { %>
			<div id="successBox" class="alert alert-success">Registration
				successful! You can now log in.</div>
			<% } %>

			<!-- Login Form -->
			<form id="loginForm" class="form active" action="verifyUser.jsp"
				method="post">
				<h2>Login</h2>
				<input type="text" name="email" placeholder="Email" required>
				<input type="password" name="password" placeholder="Password"
					required>
				<button type="submit" class="btn btn-primary">Login</button>
			</form>

			<form id="registerForm" class="form" action="registerUser.jsp"
				method="post">
				<h2>Register</h2>
				<input type="text" name="username" placeholder="Username" required>
				<input type="email" name="email" placeholder="Email" required>
				<input type="password" name="password" placeholder="Password"
					required> <input type="password" name="confirmPassword"
					placeholder="Confirm Password" required>
				<button type="submit" class="btn btn-primary">Register</button>
			</form>

		</div>
	</div>

	<script>
		function toggleForm(formType) {
			// Toggle active class on the tabs
			document.getElementById('loginTab').classList.toggle('active',
					formType === 'login');
			document.getElementById('registerTab').classList.toggle('active',
					formType === 'register');

			// Toggle active class on the forms
			document.getElementById('loginForm').classList.toggle('active',
					formType === 'login');
			document.getElementById('registerForm').classList.toggle('active',
					formType === 'register');
		}
	</script>
	<script src="../js/app.js"></script>
</body>
</html>





