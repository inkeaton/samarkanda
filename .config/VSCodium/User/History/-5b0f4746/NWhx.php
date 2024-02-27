<nav>
    <a href="index.php">Index</a> |
    <?php
        if(isset($_SESSION["nome"])) {
            echo("<a href=\"secret.php\">Secret Page</a> |");
            echo("<a href=\"unlogin.php\">End Session</a> |");
            echo("<a href=\"delete.php\">Delete Account</a> |");
        }
        else {
            echo("<a href=\"login.php\">Login</a> |");
            echo("<a href=\"registration.php\">Register</a> |");
        }
    ?>
</nav>