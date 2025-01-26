function toggleEdit() {
    const fields = document.querySelectorAll('.editable');
    fields.forEach(field => {
        field.disabled = !field.disabled;
    });
    document.getElementById('editButton').style.display = 'none';
    document.getElementById('logoutButton').style.display = 'none';
    document.getElementById('saveButton').style.display = 'block';
    document.getElementById('changePasswordButton').style.display = 'block';
}

function toggleChangePassword() {
    const profileForm = document.getElementById('profileForm');
    const changePasswordForm = document.getElementById('changePasswordForm');
    if (profileForm.style.display === 'block') {
        profileForm.style.display = 'none';
        changePasswordForm.style.display = 'block';
    } else {
        profileForm.style.display = 'block';
        changePasswordForm.style.display = 'none';
    }
}