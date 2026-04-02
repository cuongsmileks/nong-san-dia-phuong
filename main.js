document.addEventListener('DOMContentLoaded', () => {
    // Header scroll effect
    const header = document.getElementById('header');

    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
    });

    // Active nav link update
    const sections = document.querySelectorAll('section');
    const navLinks = document.querySelectorAll('.nav-link');

    window.addEventListener('scroll', () => {
        let current = '';
        sections.forEach(section => {
            const sectionTop = section.offsetTop;
            const sectionHeight = section.clientHeight;
            if (scrollY >= (sectionTop - 200)) {
                current = section.getAttribute('id');
            }
        });

        navLinks.forEach(link => {
            link.classList.remove('active');
            if (link.getAttribute('href').includes(current)) {
                link.classList.add('active');
            }
        });
    });

    // Cart functionality simple mock
    const cartCountEl = document.querySelector('.cart-count');
    const addToCartBtns = document.querySelectorAll('.add-to-cart');
    let cartCount = 0;

    addToCartBtns.forEach(btn => {
        btn.addEventListener('click', (e) => {
            cartCount++;
            cartCountEl.textContent = cartCount;

            // Get product name
            const card = e.target.closest('.product-card');
            const productName = card.querySelector('.product-name').textContent;

            showToast(`Đã thêm ${productName} vào giỏ hàng!`);
        });
    });

    // Toast Notification System
    function showToast(message) {
        const container = document.getElementById('toast-container');
        const toast = document.createElement('div');
        toast.className = 'toast';
        toast.textContent = message;

        container.appendChild(toast);

        // Trigger reflow & show
        setTimeout(() => toast.classList.add('show'), 10);

        // Remove after 3 seconds
        setTimeout(() => {
            toast.classList.remove('show');
            setTimeout(() => toast.remove(), 300);
        }, 3000);
    }
});
