<!DOCTYPE html>

<html lang="it">
    <head>
        <Title>End Session</Title>
        <!--<link rel="stylesheet" href="commons/style/style.css">-->
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
                    <input type="checkbox" id="end" name="end" value="end"> 
                    <label for="end"> Yes, I'm Sure </label> <br>
                    
                    <input type="submit" value="End Session">
                </fieldset>
            </form> 
            <?php
                if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["end"])) { 
                    // if remember me is set
                    if(isset($_COOKIE["rmbr_me"])) {
                        // remove cookie uid from databse
                        require "commons/snippets/rmbr_me/remove_rmbr_me_from_table.php";
                        // destroy it
                        if (!setcookie("rmbr_me", "", time() - 3600))
                            throw new Exception("<h1 class=\"error\">Unexpected Error, could not destroy remember me cookie</h1>");
                    }
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
            include "commons/snippets/page_sections/footer.php"; 
        ?>
        
    </body>
</html>