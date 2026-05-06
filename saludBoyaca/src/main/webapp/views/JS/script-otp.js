document.addEventListener("DOMContentLoaded", () => {
    const fields = document.querySelectorAll(".otp-field");

    fields.forEach((field, index) => {
        field.addEventListener("input", (e) => {
            if (e.target.value.length >= 1) {
                if (index < fields.length - 1) {
                    fields[index + 1].focus();
                }
            }
        });

        field.addEventListener("keydown", (e) => {
            if (e.key === "Backspace" && !e.target.value && index > 0) {
                fields[index - 1].focus();
            }
        });
    });

    const params = new URLSearchParams(window.location.search);
    if (params.get("error") === "incorrecto") {
        Swal.fire({
            icon: 'error',
            title: 'Acceso Denegado',
            text: 'El código de seguridad es incorrecto o ya venció.',
            background: '#fff',
            confirmButtonColor: '#0984e3'
        });
    }
});