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
            if(isset($_SESSION["nome"])) {
                // It already has a session, does not need to login
                header("Location: index.php"); 
                exit();
            }
            elseif(isset($_COOKIE["rmbr_me"])) {
                // Has no session, but has remember_me
                // We need to verify it's correctness and create session
                
                // puts name, surname, expire_date in $user_data, 
                // if cookie value is found
                require "commons/snippets/rmbr_me/get_cookie_expire_date.php";
                
                // check expire date of cookie
                if($user_data->data_scadenza > date('Y-m-d H:i:s')) {
                    // the cookie is valid
                    // create session
                    $_SESSION["nome"] = $user_data->nome;
                    $_SESSION["cognome"] = $user_data->cognome;
                    echo("<h1 class=\"confirmation\"> TEST: Created session from cookie </h1>");
                    // send to the index
                    header("Location: index.php");
                }
                else {
                    // the cookie is not valid
                    // destroy it
                    if(!setcookie("rmbr_me", "", time()-3600))
                        throw new Exception("<h1 class=\"error\">Unexpected Error, could not destroy expired cookie</h1>");
                    // TO DO: Since it is no longer needed, we could delete that data from the user table
                    // proceed to login
                }
            }   
        ?>

        <header class = "logo">
            <h1>Reserved! Secret!</h1>
        </header>

        

        <main>
            <?php
                echo("<h1 class=\"confirmation\"> Aaah, but you're " .$_SESSION["nome"] ."</h1><br>")
            ?>
        </main>
    </body>
</html>