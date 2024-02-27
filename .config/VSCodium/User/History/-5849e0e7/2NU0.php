<!DOCTYPE html>

<html lang="it">
    <head>
        <Title>Reserved and misterious page...</Title>
        <link rel="stylesheet" href="commons/style/style.css">
    </head>

    <!--/*////////////////////////////////////////////////////////////////////////////
    
    + TO DO
        1 - implement all of eww samarbar functions 
            * brightness (slider bar)
            * audio (slider bar)
            * battery
            * network (slider bar)
            * updates
        2 - Refactor to reuse code
        3 - implement MORE functions!
            * notifications
            * to-do
            * dashboard
            
    ////////////////////////////////////////////////////////////////////////////*/-->

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

        <?php
            // footer
            include "commons/snippets/page_sections/footer.php"; 
        ?>
    </body>
</html>