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

function showChangePassword() {
    document.getElementById('changePasswordDiv').style.display = 'block';
}