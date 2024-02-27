<?php
    // Check if user is logged in.
    // if not, send to index. Else, let them go to the current page
    if(!isset($_SESSION["nome"])) {
        echo("<a href=\"unlogin.php\">End Session</a> |");
        echo("<a href=\"my_profile.php\">My Profile</a> |");
    }
    else {
        echo("<a href=\"login.php\">Login</a> |");
        echo("<a href=\"registration.php\">Register</a> |");
    }
?>