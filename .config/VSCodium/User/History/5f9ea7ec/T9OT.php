<?php
    // Check if user is logged in.
    // if not, send to index. Else, let them go to the current page
    if(!isset($_SESSION["nome"])) {
        header("Location: index.php"); 
        exit();
    }
    else {
        echo("<a href=\"login.php\">Login</a> |");
        echo("<a href=\"registration.php\">Register</a> |");
    }
?>