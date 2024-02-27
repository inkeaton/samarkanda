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

            <p>  
                <ul>
            <?php
                try {
                    // get profile data

                    // get read SQL credentials in $sql_cred
                    require "scripts/commons/get_db_credentials/get_R_db_credentials.php";

                    $con = new mysqli($sql_cred[0],$sql_cred[1],$sql_cred[2],$sql_cred[3]);
                    if ($con->connect_errno) 
                        throw new Exception("<h1 class=\"error\">Unexpected Error, could not connect to DB, errno " . $con->connect_error ."</h1>");
                    
                    

                    // since data comes from session, we can use normal statements
                    $query = "SELECT username, nome, cognome, pronome, img, amministratore, datacreazione FROM utente WHERE email='" . $_SESSION["email"] ."'error";

                    if(!$res = $con->query($query))
                        throw new Exception("<h1 class=\"error\"> Unexpected Error: Could execute query results</h1>");

                        echo($query);

                    if(!$row = $res->fetch_assoc())
                        throw new Exception("<h1 class=\"error\"> Unexpected Error: Could not fetch query results</h1>");
                    
                    echo("<li>Username: " . $row['username'] . "</li>");
                    echo("<li>Nome: " . $row['nome'] . "</li>");
                    echo("<li>Cognome: " . $row['cognome'] . "</li>");
                    echo("<li>Pronomi: " . $row['pronome'] . "</li>");
                    echo("<li>Amministratore: " . $row['amministratore'] . "</li>");
                    echo("<li>Data Creazione Account: " . $row['datacreazione'] . "</li>");

                    $con->close();


                } catch (Exception $ex) {
                // Print error messages
                $message = $ex->getMessage();
                echo($message);
            }
            ?>
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