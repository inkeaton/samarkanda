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
            <h1>Welcome to the Index!</h1>
        </header>

        <?php
            // navigation bar
            include "commons/snippets/page_sections/navbar.php"; 
        ?>

        <main>
            <p class="confirmation"> Some say that, if you login, you can see a secret thing... :) </p>
        </main>
    </body>
</html>