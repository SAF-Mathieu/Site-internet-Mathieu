    function checkPswd3() {
        var confirmPassword3 = "site";
        var password3 = document.getElementById("pswd3").value;
        if (password3 == confirmPassword3) {
             window.location="vt_doc.html";
        }
        else{
            alert("Mot de passe non valide.");
        }
    }