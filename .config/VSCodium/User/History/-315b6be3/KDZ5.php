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

        <header class = "logo">
            <h1>Reserved! Secret!</h1>
        </header>

        <?php
            // navigation bar
            include "commons/snippets/page_sections/navbar.php"; 
        ?>

        <main>
            <?php
                echo("<h1 class=\"confirmation\"> Aaah, but you're " .$_SESSION["nome"] ."</h1><br>");
            ?>
            <p class="confirmation"> Then it's ok :). <br> Look at this </p>
            <img class="image" src="res/img/birb.jpg" />
            <p class="confirmation"> Cool, huh? </p>
        </main>

        <?php
            // footer
            include "commons/snippets/page_sections/footer.php"; 
        ?>
    </body>
</html>