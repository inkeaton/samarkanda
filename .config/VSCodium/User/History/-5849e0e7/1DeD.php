<!DOCTYPE html>

<html lang="it">
    <head>
        <Title>Reserved and misterious page...</Title>
        <!--<link rel="stylesheet" href="commons/style.css">-->
    </head>

    <body>
    
        <?php 
        /* 
            TO REFACTOR IN MULTIPLE FILES; 
            CREATE A RESERVED PAGE;
            CREATE NAVBAR AND FOOTER;
        */
            session_start();
            require "commons/snippets/rmbr_me/reserved_pages_check.php"; 
        ?>

        <header class = "logo">
            <h1>Reserved! Secret!</h1>
        </header>

        <main>
            <?php
                echo("<h1 class=\"confirmation\"> Aaah, but you're " .$_SESSION["nome"] ."</h1><br>");
                echo("<p class=\"confirmation\"> then it's ok :) </p><br>")
            ?>
        </main>
    </body>
</html>