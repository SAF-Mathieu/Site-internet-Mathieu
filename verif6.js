    function checkPswd6() {
        var confirmPassword6 = "9Xd5rjHytD";
        var password6 = document.getElementById("pswd6").value;
        if (password6 == confirmPassword6) {
             window.location="pr_ntfs.html";
        }
        else{
            alert("Mot de passe non valide.");
        }
    }