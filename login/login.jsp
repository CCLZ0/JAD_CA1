<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login/Register Toggle</title>
<style>
/* Basic styling */
body {
    font-family: Arial, sans-serif;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}

.container {
    width: 400px;
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.toggle-bar {
    display: flex;
    justify-content: space-around;
    cursor: pointer;
    font-weight: bold;
}

.toggle-bar div {
    padding: 10px;
    width: 50%;
    text-align: center;
    border-bottom: 2px solid transparent;
}

.toggle-bar .active {
    border-color: #FF9500; /* Highlight color */
    color: #FF9500;
}

.form {
    display: none;
    margin-top: 20px;
}

.form.active {
    display: block;
}

.form input, .form button {
    width: 100%;
    padding: 10px;
    margin: 8px 0;
    box-sizing: border-box;
}

#errorBox, #successBox {
    padding: 1em;
    font-weight: bold;
    font-size: 1.1em;
    margin: 1em 0;
    border-radius: 5px;
    text-align: center;
}

#errorBox {
    border: 2px solid red;
    color: #cc0000;
}

#successBox {
    border: 2px solid green;
    color: green;
}
</style>
</head>
<body>

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
            <button type="submit">Login</button>
        </form>

        <!-- Register Form -->
        <form id="registerForm" class="form" action="registerUser.jsp" method="post">
            <h2>Register</h2>
            <input type="text" name="name" placeholder="Name" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
            <button type="submit">Register</button>
        </form>
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
</html>



