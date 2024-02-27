<!DOCTYPE html>

<html lang="it">
    <head>
        <Title>Index of Chiron</Title>
        <!-- CSS is unfinished -->
        <!--<link rel="stylesheet" href="commons/style/style.css">-->
    </head>

    <body>
    
        <?php 
            session_start();
        ?>

        <header class = "logo">
            <h1>Welcome to Chiron!</h1>
        </header>

        <?php
            // navigation bar
            include "snippets/commons/navbar.php"; 
        ?>

        <main>
            <p class="confirmation"> Quick, Go to the login! :D </p>
        </main>

        <?php
            // footer
            include "snippets/commons/footer.php"; 
        ?>
    </body>
</html>