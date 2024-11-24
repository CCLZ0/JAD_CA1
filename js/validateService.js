function validateForm() {
	const serviceName = document.getElementById('serviceName').value.trim();
	const description = document.getElementById('description').value.trim();
	const price = parseFloat(document.getElementById('price').value.trim());
	const categoryId = document.getElementById('categoryId').value.trim();
	const imgPath = document.getElementById('imgPath').value.trim();

	if (serviceName === '') {
		alert('Service Name is required.');
		return false;
	}
	if (description === '') {
		alert('Description is required.');
		return false;
	}
	if (isNaN(price) || price < 0) {
		alert('Price must be a valid number and cannot be negative.');
		return false;
	}
	if (categoryId === '') {
		alert('Please select a category.');
		return false;
	}
	if (imgPath === '') {
		alert('Image Path is required.');
		return false;
	}
	return true;
}

