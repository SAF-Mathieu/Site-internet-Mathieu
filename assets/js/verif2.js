    function checkPswd2() {
        var confirmPassword2 = "site";
        var password2 = document.getElementById("pswd2").value;
        if (password2 == confirmPassword2) {
             window.location="doc_tir.html";
        }
        else{
            alert("Mot de passe non valide.");
        }
    }