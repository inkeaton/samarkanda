<!DOCTYPE html>

<html lang="it">
    <head>
        <Title>Reserved and misterious page...</Title>
        <link rel="stylesheet" href="commons/style/style.css">
    </head>

    <body>
    
        <?php 
            // session/remember me check
            session_start();
            require "commons/snippets/rmbr_me/reserved_pages_check.php"; 
        ?>

        <?php
            // navigation bar
            include "commons/snippets/page_sections/navbar.php"; 
        ?>

        <header class = "logo">
            <h1>Reserved! Secret!</h1>
        </header>

        <main>
            <?php
                echo("<h1 class=\"confirmation\"> Aaah, but you're " .$_SESSION["nome"] ."</h1><br>");
            ?>
            <p class="confirmation"> then it's ok :) </p><br>
            <p class="confirmation"> look at this :) </p><br>
        </main>
    </body>
</html>