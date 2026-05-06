document.addEventListener("DOMContentLoaded", function() {
    const langSelect = document.getElementById('langSelect');
    if (langSelect) {
        langSelect.addEventListener('change', function() {
            const selectedLang = this.value;
            const currentUrl = new URL(window.location.href);
            currentUrl.searchParams.set('lang', selectedLang);
            window.location.href = currentUrl.toString();
        });
    }

    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(alert => {
        setTimeout(() => {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        }, 5000);
    });
});