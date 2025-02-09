<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Details</title>
</head>
<body>
    <h1>User Details</h1>
    <p>User ID: ${user.id}</p>
    <p>Email: ${user.email}</p>
    <p>Name: ${user.name}</p>
    <p>Role: ${user.role}</p>
    <a href="/b2b/index">Back to Home</a>
</body>
</html>

<!-- link: http://localhost:8080/profile/1 -->