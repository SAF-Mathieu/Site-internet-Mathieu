    function checkPswd9() {
        var confirmPassword9 = "site";
        var password9 = document.getElementById("pswd9").value;
        if (password9 == confirmPassword9) {
             window.location="ent_ftp.html";
        }
        else{
            alert("Mot de passe non valide.");
        }
    }