<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shine Pro</title>
<link href="https://fonts.googleapis.com/css2?family=Recursive&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<%@ include file="../web_elements/navbar.jsp"%>
	
	<div class="banner position-relative text-center text-white">
        <img src="../img/banner.png" class="img-fluid w-100" alt="Banner Image" id="bannerImg">
        <div class="overlay d-flex flex-column justify-content-center align-items-center">
            <h1 class="display-4 fw-bold text-shadow" id="overlayText">We leave your house sparkling clean!</h1>
            <div class="searchBar d-flex mt-3">
                <input type="text" class="form-control me-2" placeholder="Search" id="serviceSearch">
                <button class="btn btn-primary book-now-btn">Book Now</button>
                <div id="suggestions" class="suggestions-list d-none"></div>
            </div>
        </div>
    </div>
	
    <!-- Divider-->
    <div class="divider text-center py-4">
        <h2>Cleaning services for all!</h2>
    </div>

	<div class="row section align-items-center">
		<div class="col-md-6 img1">
			<img src="../img/cleaning.jpeg" alt="Image 1" class="img-fluid rounded">
		</div>
		<div class="col-md-6 content">
			<h2>Welcome to Shine Pro!</h2>
			<p>One of the rising and trusted names in the industry today,<br>Shine Pro provides a range of detailed professional cleaning services<br>and disinfection treatment to a wide range of customers.</p>
			<a href="serviceCategories.jsp"><button class="btn-custom">View Services</button></a>		
		</div>
	</div>

	<!-- Section 2 -->
	<div class="row section align-items-center">
		<div class="col-md-6 order-md-2 img2">
			<img src="../img/cleaning2.jpg" alt="Image 2" class="img-fluid rounded">
		</div>
		<div class="col-md-6 order-md-1 content pl-md-custom">
			<h2>Highest Standard of Service</h2>
			<p>We provide the highest standard of disinfection and cleaning services in Singapore,<br>designed to protect what matters to you using environmentally friendly cleaning products.</p>
		</div>
	</div>

	<%@ include file="../web_elements/footer.html"%>
	<script src="../js/search.js"></script>
</body>
</html>