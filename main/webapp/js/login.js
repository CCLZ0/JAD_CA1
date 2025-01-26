function toggleForm(formType) {
	// Toggle active class on the tabs
	document.getElementById('loginTab').classList.toggle('active', formType === 'login');
	document.getElementById('registerTab').classList.toggle('active', formType === 'register');

	// Toggle active class on the forms
	document.getElementById('loginForm').classList.toggle('active', formType === 'login');
	document.getElementById('registerForm').classList.toggle('active', formType === 'register');
}