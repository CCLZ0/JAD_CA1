document.addEventListener('DOMContentLoaded', function() {
    fetch(`${contextPath}/ProfileServlet`)
        .then(response => {
            if (!response.ok) {
                if (response.status === 401) {
                    alert('User not logged in');
                    window.location.href = `${contextPath}/login/login.jsp?error=notLoggedIn`;
                } else if (response.status === 404) {
                    alert('User not found');
                    window.location.href = `${contextPath}/login/login.jsp?error=userNotFound`;
                }
                throw new Error('Failed to load profile data');
            }
            return response.json();
        })
        .then(data => {
            document.getElementById('userName').value = data.name;
            document.getElementById('userEmail').value = data.email;
        })
        .catch(error => {
            console.error('Error:', error);
        });
});

function toggleEdit() {
    const editButton = document.getElementById('editButton');
    const saveButton = document.getElementById('saveButton');
    const changePasswordButton = document.getElementById('changePasswordButton');
    const inputs = document.querySelectorAll('.editable');

    inputs.forEach(input => {
        input.disabled = !input.disabled;
    });

    if (editButton.style.display === 'none') {
        editButton.style.display = 'block';
        saveButton.style.display = 'none';
        changePasswordButton.style.display = 'none';
    } else {
        editButton.style.display = 'none';
        saveButton.style.display = 'block';
        changePasswordButton.style.display = 'block';
    }
}

function toggleChangePassword() {
    const changePasswordForm = document.getElementById('changePasswordForm');
    if (changePasswordForm.style.display === 'none') {
        changePasswordForm.style.display = 'block';
    } else {
        changePasswordForm.style.display = 'none';
    }
}