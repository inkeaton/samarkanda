<!DOCTYPE html>

<html lang="it">
    <head>
        <Title>Login Now!</Title>
        <!-- CSS is unfinished -->
        <!--<link rel="stylesheet" href="commons/style/style.css">-->
    </head>

    <body>

        <?php 
            // session/remember me check
            //session_start();
            //require "commons/snippets/rmbr_me/login_registration_check.php"; 
        ?>

        <header class = "logo">
            <h1>Login!</h1>
        </header>

        <?php
            // navigation bar
            include "snippets/commons/navbar.php"; 
        ?>

        <main>
            <form type="submit" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>" method="post">
                <fieldset>
                    <legend>Insert your credentials to login</legend>
        
                    <label for="email">Email </label>
                    <input type="email" id="email" name="email" placeholder="Your email.." 
                           value="<?php if ($_SERVER["REQUEST_METHOD"] == "POST") echo htmlspecialchars($_POST["email"]);?>"><br>
        
                    <label for="pass">Password </label>
                    <input type="password" id="pass" name="pass" placeholder="Your password" ><br>

                    <label for="rmbr_me"> Remember me </label>
                    <input type="checkbox" id="rmbr_me" name="rmbr_me" value="remember"> <br>


                    <input type="submit" value="Accedi">
                </fieldset>
            </form>
<!------------------------------------------------------------------------------------>
            <?php
                /*
                    LOGIN ----------------------------------------------------------------------------------------------
                */

                if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["email"])) {
                    try {

                        // get input
                        $email = $pass = $rmbr_me = null;

                        $email   = $_POST["email"];
                        $pass    = $_POST["pass"];
                        $rmbr_me = $_POST["rmbr_me"];

                        
                    
                        $stmt->close();
                        $con->close();

                    } catch (Exception $ex) {
                        // Print error messages
                        $message = $ex->getMessage();
                        echo($message);
                    }
                }
            ?>
        </main>
        
        <?php
            // footer
            include "snippets/commons/footer.php"; 
        ?>

    </body>
</html>