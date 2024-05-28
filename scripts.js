document.addEventListener('DOMContentLoaded', (event) => {
    // Función para animar el desplazamiento suave al hacer clic en los enlaces del menú
    const links = document.querySelectorAll('nav ul li a');
    for (const link of links) {
        link.addEventListener('click', smoothScroll);
    }

    function smoothScroll(event) {
        event.preventDefault();
        const targetId = event.currentTarget.getAttribute('href').substring(1);
        const targetElement = document.getElementById(targetId);
        window.scrollTo({
            top: targetElement.offsetTop,
            behavior: 'smooth'
        });
    }

    // Función para mostrar animaciones al desplazarse
    const sections = document.querySelectorAll('.section');
    const options = {
        threshold: 0.5
    };

    const observer = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.animationPlayState = 'running';
            }
        });
    }, options);

    sections.forEach(section => {
        section.style.animationPlayState = 'paused';
        observer.observe(section);
    });

    // Obtener el estado del servidor y el número de jugadores
    fetchServerStatus();

    function fetchServerStatus() {
        fetch('http://localhost:30120/info.json') // Reemplaza con la URL de tu API
            .then(response => response.json())
            .then(data => {
                document.getElementById('status').textContent = data.online ? 'Online' : 'Offline';
                document.getElementById('players').textContent = data.players;
            })
            .catch(error => {
                console.error('Error al obtener el estado del servidor:', error);
                document.getElementById('status').textContent = 'Error';
                document.getElementById('players').textContent = 'N/A';
            });
    }

    // Añadir animación de "hover" a los elementos de la galería
    const galleryItems = document.querySelectorAll('.gallery-item');
    galleryItems.forEach(item => {
        item.addEventListener('mouseover', function() {
            this.style.transform = 'scale(1.05)';
        });

        item.addEventListener('mouseout', function() {
            this.style.transform = 'scale(1)';
        });
    });
});
