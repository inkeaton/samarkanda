<nav>
    <?php
        if(isset($_SESSION["nome"])) {
            echo("<a href=\"secret.php\">Secret Page</a> |");
        }
        else {
            
        }
    ?>
    <a href="login.php">Login</a> |
    <a href="registration.php">Register</a> |
    <a href="index.php">Index</a> |
</nav>