<!DOCTYPE html>

<html lang="it">
    <head>
        <Title>Edit Profile</Title>
        <!-- CSS is unfinished -->
        <!--<link rel="stylesheet" href="commons/style/style.css">-->
   </head>

    <body>

        <?php
            // session
            session_start();
            // check is not logged 
            require "commons/scripts/is_logged_in.php"; 
        ?>
        
        <header>
            <h1>Edit Your Profile!</h1>
        </header>

        

        <?php
            // navigation bar
            include "commons/snippets/navbar.php"; 
        ?>

        <?php
            // Get old informations

            // get read/write SQL credentials in $sql_cred
            require "commons/scripts/get_db_credentials/get_RW_db_credentials.php";
            $con = new mysqli($sql_cred[0],$sql_cred[1],$sql_cred[2],$sql_cred[3]);
            if ($con->connect_errno) 
                throw new Exception("<h1 class=\"error\">Unexpected Error, could not connect to DB, errno " . $con->connect_error ."</h1>");
            
            // since data comes from session, we should be able to use normal statements
            // TO BE DONE: Add data sanitization
            $query = "SELECT username, nome, cognome, pronome, img, amministratore, datacreazione FROM Utente WHERE email='" . $_SESSION["email"] ."'";

            if(!$res = $con->query($query))
                throw new Exception("<h1 class=\"error\"> Unexpected Error: Could execute query results</h1>");

            if(!$row = $res->fetch_assoc())
                throw new Exception("<h1 class=\"error\"> Unexpected Error: Could not fetch query results</h1>");
        ?>

        <main>
            <form type="submit" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>" method="post">
                <fieldset>
                    <legend>Insert your new informations</legend>

                    <label for="username">Username </label>
                    <input type="text" id="username" name="username" placeholder="Your username.." 
                           value="<?php if ($_SERVER["REQUEST_METHOD"] == "POST") 
                                            // print what was written in the form
                                            echo htmlspecialchars($_POST["username"]); 
                                        elseif (isset($row['username'])) 
                                            // print what is in the db
                                            echo htmlspecialchars($row['username']);?>"><br>

                    <label for="firstname">Name </label>
                    <input type="text" id="firstname" name="firstname" placeholder="Your name.." 
                           value="<?php if ($_SERVER["REQUEST_METHOD"] == "POST") 
                                            echo htmlspecialchars($_POST["firstname"]); 
                                        elseif (isset($row['nome'])) 
                                            echo htmlspecialchars($row['nome']);?>"><br>

                    <label for="lastname">Surname </label>
                    <input type="text" id="lastname" name="lastname" placeholder="Your surname.." 
                           value="<?php if ($_SERVER["REQUEST_METHOD"] == "POST") 
                                            echo htmlspecialchars($_POST["lastname"]); 
                                        elseif (isset($row['cognome'])) 
                                            echo htmlspecialchars($row['cognome']);?>"><br>

                    <label for="pronouns">Pronouns </label>
                    <input type="text" id="pronouns" name="pronouns" placeholder="Your pronouns.." 
                           value="<?php if ($_SERVER["REQUEST_METHOD"] == "POST") 
                                            echo htmlspecialchars($_POST["pronouns"]); 
                                        elseif (isset($row['pronome'])) 
                                            echo htmlspecialchars($row['pronome']);?>"><br>

                    <input type="submit" value="Registrati">
                </fieldset>
            </form>
    <!------------------------------------------------------------------------------------>
            <?php

                if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["firstname"])) {
                    try {
                        /*
                            INPUT VALIDATION --------------------------------------------------------------------------
                        */

                        // TO BE DONE: Add data sanitization
                        
                        /*
                            DATA MEMORIZATION --------------------------------------------------------------------------
                        */

                        // insert data
                        if(!$stmt = $con->prepare("UPDATE Utente SET username = ?, nome = ?, cognome = ?, pronome = ? WHERE email = ?"))
                            throw new Exception("<h1 class=\"error\">Unexpected Error, could not prepare query</h1>");

                        if(!$stmt->bind_param('sssss',$_POST["username"], $_POST["firstname"], $_POST["lastname"], $_POST["pronouns"], $_SESSION["email"]))
                            throw new Exception("<h1 class=\"error\">Unexpected Error, could not bind query parameters</h1>");

                        if(!$stmt->execute())
                            throw new Exception("<h1 class=\"error\"> Unexpected Error: Could not insert data</h1>");
                        
                        // check results 
                        if ($con->affected_rows !== 1)
                            throw new Exception("<h1 class=\"error\"> Unexpected Error: Could not insert data</h1>");

                        echo("<h1 class=\"confirmation\"> The data has been updated :) </h1>");
                    
                        // Close connection
                        $stmt->close();
                        $con->close();
                        


                    } catch(Exception $ex) {
                        // Print error messages
                        $message = $ex->getMessage();
                        echo ($message);
                    }
                }
            ?>
        
        <a href="change_password.php">Change Password</a>
        </main>

        <?php
            // footer
            include "commons/snippets/footer.php"; 
        ?>
        
    </body>
</html>