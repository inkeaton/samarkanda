<!DOCTYPE html>

<html lang="it">
    <head>
        <Title>End Session</Title>
        <link rel="stylesheet" href="commons/style/style.css">
    </head>

    <body>
    
        <?php 
            // session/remember me check
            session_start();
            require "commons/snippets/rmbr_me/reserved_pages_check.php"; 
        ?>

        <header class = "logo">
            <h1>End Session</h1>
        </header>

        <?php
            // navigation bar
            include "commons/snippets/page_sections/navbar.php"; 
        ?>

        <main>
            <p class="confirmation"> You're sure that you wanna end your session? </p>

            <form type="submit" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>" method="post">
                <fieldset>
                    <label for="rmbr_me"> Remember me </label>
                    <input type="checkbox" id="rmbr_me" name="rmbr_me" value="remember"> <br>
                    
                    <input type="submit" value="End Session">
                </fieldset>
            </form> 
        </main>
    </body>
</html>