<!DOCTYPE html>

<html lang="it">
    <head>
        <Title>My Profile</Title>
        <!-- CSS is unfinished -->
        <!--<link rel="stylesheet" href="commons/style/style.css">-->
    </head>

    <body>
    
        <?php 
            session_start();
            // check if the user is logged in
            require "scripts/commons/is_logged_in.php";
        ?>

        <header>
            <h1>Your Profile</h1>
        </header>

        <?php
            // navigation bar
            include "snippets/commons/navbar.php"; 
        ?>

        <main>
            <p> Hi! This is your profile </p>

            <?php
                // get profile data

                // get read SQL credentials in $sql_cred
                require "scripts/commons/get_db_credentials/get_R_db_credentials.php";

                
            ?>

            <p>  
                <ul>
                    <li>Nome: <?php echo ($_SESSION["nome"]); ?></li>
                    <li>Cognome: <?php echo ($_SESSION["cognome"]); ?></li>
                </ul> 

                <a href="edit_profile.php">Edit Profile</a>
            </p>

            
        </main>

        <?php
            // footer
            include "snippets/commons/footer.php"; 
        ?>
    </body>
</html>