<!DOCTYPE html>

<html lang="it">
    <head>
        <Title>End Session</Title>
        <!-- CSS is unfinished -->
        <!--<link rel="stylesheet" href="commons/style/style.css">-->
    </head>

    <body>

        <?php 
            // session/remember me check
            session_start();
            //require "commons/snippets/rmbr_me/login_registration_check.php"; 
        ?>
    

        <header class = "logo">
            <h1>End Session</h1>
        </header>

        <?php
            // navigation bar
            include "snippets/commons/navbar.php"; 
        ?>

        <main>
            <?php
            if (isset($_SESSION["nome"]))
                echo ("<p> You're sure that you wanna end your session " . $_SESSION["nome"]  ."? </p>");
            else 
                echo ("<p> You should not be here, stranger...</p>");
            ?>
            

            <form type="submit" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>" method="post">
                <fieldset>
                    <input type="checkbox" id="end" name="end" value="end"> 
                    <label for="end"> Yes, I'm Sure </label> <br>
                    
                    <input type="submit" value="End Session">
                </fieldset>
            </form> 
            <?php
                if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["end"])) { 
                    // end session
                    session_unset();
                    session_destroy();
                    // send to the index
                    header("Location: index.php");
                    exit();
                }
            ?>
        </main>

        <?php
            // footer
            include "snippets/commons/footer.php"; 
        ?>
        
    </body>
</html>