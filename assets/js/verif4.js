    function checkPswd4() {
        var confirmPassword4 = "site";
        var password4 = document.getElementById("pswd4").value;
        if (password4 == confirmPassword4) {
             window.location="cv.html";
        }
        else{
            alert("Mot de passe non valide.");
        }
    }