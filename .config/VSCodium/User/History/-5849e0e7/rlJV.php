<!DOCTYPE html>

<html lang="it">
    <head>
        <Title>Reserved and misterious page...</Title>
        <link rel="stylesheet" href="commons/style/style.css">
    </head>

    <body>
    
        <?php 
            session_start();
        ?>

        <header class = "logo">
            <h1>Index</h1>
        </header>

        <?php
            // navigation bar
            include "commons/snippets/page_sections/navbar.php"; 
        ?>

        <main>
            <?php
                echo("<h1 class=\"confirmation\"> Aaah, but you're " .$_SESSION["nome"] ."</h1><br>");
                echo("<p class=\"confirmation\"> then it's ok :) </p><br>")
            ?>
        </main>
    </body>
</html>