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

        <p class="confirmation"> You're sure that you wanna end your session? </p>

        <main>
            
        </main>
    </body>
</html>