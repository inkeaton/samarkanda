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
            require "scripts/commons/is_logged_in.php"; 
        ?>
        
        <header>
            <h1>Edit Your Profile!</h1>
        </header>

        

        <?php
            // navigation bar
            include "snippets/commons/navbar.php"; 
        ?>

        <?php
            // Get old informations

            // get read/write SQL credentials in $sql_cred
            require "scripts/commons/get_db_credentials/get_RW_db_credentials.php";

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
                           value="<?php if (isset($row['username'])) echo htmlspecialchars($row['username']);?>"><br>

                    <label for="firstname">Name </label>
                    <input type="text" id="firstname" name="firstname" placeholder="Your name.." 
                           value="<?php if (isset($row['nome'])) echo htmlspecialchars($row['nome']);?>"><br>

                    <label for="lastname">Surname </label>
                    <input type="text" id="lastname" name="lastname" placeholder="Your surname.." 
                           value="<?php if (isset($row['cognome'])) echo htmlspecialchars($row['cognome']);?>"><br>

                    <label for="pronouns">Pronouns </label>
                    <input type="text" id="pronouns" name="pronouns" placeholder="Your pronouns.." 
                           value="<?php if (isset($row['pronome'])) echo htmlspecialchars($row['pronome']);?>"><br>

                    <input type="submit" value="Registrati">
                </fieldset>
            </form>
    <!------------------------------------------------------------------------------------>
            <?php

                if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["email"])) {
                    try {
                        /*
                            INPUT VALIDATION --------------------------------------------------------------------------
                        */

                        // TO BE DONE: Add data sanitization

                        // common tests
                        $user_data["email"] = $_POST["email"];
                        $user_data["pass"]  = $_POST["pass"];
                        $user_data["fname"] = $_POST["firstname"];
                        $user_data["lname"] = $_POST["lastname"];

                        // TO IMPROVE: use capturing groups in js in the password checks
        
                        $confirm = $_POST["confirm"];
                        
                        // check email 
                        if (!filter_var($user_data["email"], FILTER_VALIDATE_EMAIL)) {
                            throw new Exception("<h1 class=\"error\">The given email is not valid<\h1>");
                        }
                        
                        // check password
                        if ($user_data["pass"] != $confirm) {
                            throw new Exception("<h1 class=\"error\">Passwords do not match</h1>");
                        }

                        // cipher password
                        $user_data["pass"] = password_hash($user_data["pass"], PASSWORD_DEFAULT);

                        /*
                            DATA MEMORIZATION --------------------------------------------------------------------------
                        */

                        // get read and write SQL credentials in $sql_cred
                        require "scripts/commons/get_db_credentials/get_RW_db_credentials.php";


                        
                        // create connection
                        $con = new mysqli($sql_cred[0],$sql_cred[1],$sql_cred[2],$sql_cred[3]);
                        if ($con->connect_errno) 
                            throw new Exception("<h1 class=\"error\">Unexpected Error, could not connect to DB, errno " . $con->connect_error ."</h1>");
                        
                        // insert data
                        if(!$stmt = $con->prepare("INSERT INTO Utente (nome, cognome, email, pwd) VALUES (?, ?, ?, ?)"))
                            throw new Exception("<h1 class=\"error\">Unexpected Error, could not prepare query</h1>");
                        if(!$stmt->bind_param('ssss',$user_data["fname"], $user_data["lname"], $user_data["email"], $user_data["pass"]))
                            throw new Exception("<h1 class=\"error\">Unexpected Error, could not bind query parameters</h1>");
                        if(!$stmt->execute())
                            throw new Exception("<h1 class=\"error\"> Unexpected Error: Could not insert data</h1>");
                        
                        // check results 
                        if ($con->affected_rows !== 1)
                            // TO IMPROVE: there is a primary key contraint on email, and as such, it's uniqueness is preserved,
                            //             but that kinda error must caught and specifically communicated to the user
                            throw new Exception("<h1 class=\"error\"> Unexpected Error: Could not insert data</h1>");

                        echo("<h1 class=\"confirmation\"> Perfect! now you can login :) </h1>");
                    
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
        </main>

        <?php
            // footer
            include "snippets/commons/footer.php"; 
        ?>
        
    </body>
</html>