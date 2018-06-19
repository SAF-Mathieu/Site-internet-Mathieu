    function checkPswd10() {
        var confirmPassword10 = "site";
        var password10 = document.getElementById("pswd10").value;
        if (password10 == confirmPassword10) {
             window.location="ent_msg.html";
        }
        else{
            alert("Mot de passe non valide.");
        }
    }