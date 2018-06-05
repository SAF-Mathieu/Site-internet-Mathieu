    function checkPswd() {
        var confirmPassword = "9Xd5rtYE";
        var password = document.getElementById("pswd").value;
        if (password == confirmPassword) {
             window.location="index.html";
        }
        else{
            alert("Mot de passe non valide.");
        }
    }