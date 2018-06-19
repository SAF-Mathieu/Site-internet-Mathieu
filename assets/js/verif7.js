    function checkPswd7() {
        var confirmPassword7 = "site";
        var password7 = document.getElementById("pswd7").value;
        if (password7 == confirmPassword7) {
             window.location="pr_dhcp.html";
        }
        else{
            alert("Mot de passe non valide.");
        }
    }