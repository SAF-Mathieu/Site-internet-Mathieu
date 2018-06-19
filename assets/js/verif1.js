    function checkPswd() {
        var confirmPassword = "site";
        var password = document.getElementById("pswd").value;
        if (password == confirmPassword) {
             window.location="index.html";
        }
        else{
            alert("Mot de passe non valide.");
        }
    }