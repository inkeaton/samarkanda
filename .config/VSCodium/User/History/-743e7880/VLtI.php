<?php
    // Check if user is logged in.
    // if yes, send to index. Else, let them go to the current page
    if(isset($_SESSION["email"])) {
        header("Location: index.php"); 
        exit();
    }
?>