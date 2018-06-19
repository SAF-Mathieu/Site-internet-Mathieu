    function checkPswd8() {
        var confirmPassword8 = "site";
        var password8 = document.getElementById("pswd8").value;
        if (password8 == confirmPassword8) {
             window.location="pr_nat.html";
        }
        else{
            alert("Mot de passe non valide.");
        }
    }