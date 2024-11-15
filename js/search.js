document.getElementById('serviceSearch').addEventListener('input', getSuggestions);
document.getElementById('serviceSearch').addEventListener('focus', showSuggestions);
document.getElementById('serviceSearch').addEventListener('blur', hideSuggestions);

function getSuggestions() {
  const query = document.getElementById('serviceSearch').value;

  fetch('../user/searchService.jsp?query=' + encodeURIComponent(query))
      .then(response => response.text())
      .then(data => {
        const suggestionsDiv = document.getElementById('suggestions');
        suggestionsDiv.innerHTML = '';
        if (data.trim() === "No matching results") {
          const noResultElement = document.createElement('p');
          noResultElement.textContent = data;
		  noResultElement.classList.add('suggestion-item');
          noResultElement.classList.add('no-click');
          suggestionsDiv.appendChild(noResultElement);
		  console.log(noResultElement);
        } else {
          const suggestions = data.trim().split('\n');
          suggestions.forEach(suggestion => {
            const suggestionElement = document.createElement('p');
            suggestionElement.textContent = suggestion.trim();
            suggestionElement.classList.add('suggestion-item');
            
            suggestionElement.addEventListener('click', function() {
              document.getElementById('serviceSearch').value = suggestion;
              suggestionsDiv.innerHTML = '';
            });

            suggestionsDiv.appendChild(suggestionElement);
          });
        }

        suggestionsDiv.style.display = 'block';
      })
      .catch(error => console.error('Error fetching suggestions:', error));
  }

function showSuggestions() {
	document.getElementById("suggestions").classList.remove("d-none");
}

function hideSuggestions() {
  setTimeout(() => {
    document.getElementById("suggestions").classList.add("d-none");
  }, 100);
}