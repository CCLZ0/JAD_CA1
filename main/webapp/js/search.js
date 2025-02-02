document.getElementById('serviceSearch').addEventListener('input', getSuggestions);
document.getElementById('serviceSearch').addEventListener('focus', showSuggestions);
document.getElementById('serviceSearch').addEventListener('blur', hideSuggestions);
document.querySelector('.book-now-btn').addEventListener('click', redirectToBooking);

function getSuggestions() {
  const query = document.getElementById('serviceSearch').value;
  console.log('Fetching suggestions for query:', query); // Debugging statement

  fetch(`${contextPath}/SearchServiceServlet?query=` + encodeURIComponent(query))
      .then(response => response.json())
      .then(data => {
        console.log('Received suggestions:', data); // Debugging statement
        const suggestionsDiv = document.getElementById('suggestions');
        suggestionsDiv.innerHTML = '';
        if (data.length === 0) {
          const noResultElement = document.createElement('p');
          noResultElement.textContent = "No matching results";
          noResultElement.classList.add('suggestion-item');
          noResultElement.classList.add('no-click');
          suggestionsDiv.appendChild(noResultElement);
        } else {
          data.forEach(suggestion => {
            const suggestionElement = document.createElement('p');
            suggestionElement.textContent = suggestion.service_name;
            suggestionElement.classList.add('suggestion-item');
            
            suggestionElement.addEventListener('click', function() {
              document.getElementById('serviceSearch').value = suggestion.service_name;
              document.getElementById('serviceSearch').dataset.serviceId = suggestion.id;
              suggestionsDiv.innerHTML = '';
            });

            suggestionsDiv.appendChild(suggestionElement);
          });
        }

        suggestionsDiv.classList.remove('d-none');
      })
      .catch(error => console.error('Error fetching suggestions:', error));
}

function showSuggestions() {
  const query = document.getElementById('serviceSearch').value;
  if (query) {
    getSuggestions();
  }
  document.getElementById("suggestions").classList.remove("d-none");
}

function hideSuggestions() {
  setTimeout(() => {
    document.getElementById("suggestions").classList.add("d-none");
  }, 100);
}

function redirectToBooking() {
  const serviceName = document.getElementById('serviceSearch').value;
  const serviceId = document.getElementById('serviceSearch').dataset.serviceId;
  if (serviceName && serviceId) {
    window.location.href = `${contextPath}/user/bookService.jsp?serviceId=` + serviceId + '&serviceName=' + encodeURIComponent(serviceName);
  } else {
    alert('Please enter a service name and select a valid service');
  }
}