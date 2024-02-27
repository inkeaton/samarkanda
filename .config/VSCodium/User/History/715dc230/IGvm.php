<!DOCTYPE html>

<html lang="it">
    <head>
        <Title>Login Now!</Title>
        <!--<link rel="stylesheet" href="commons/style.css">-->
    </head>

    <body>
        <header class = "logo">
            <h1>Login!</h1>
        </header>

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

        <main>
            <form type="submit" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>" method="post">
                <fieldset>
                    <legend>Insert your credentials to login</legend>
        
                    <label for="email">Email </label>
                    <input type="email" id="email" name="email" placeholder="Your email.." 
                           value="<?php if ($_SERVER["REQUEST_METHOD"] == "POST") echo htmlspecialchars($_POST["email"]);?>"><br>
        
                    <label for="pass">Password </label>
                    <input type="password" id="pass" name="pass" placeholder="Your password" ><br>

                    <label for="rmbr_me"> Remember me </label>
                    <input type="checkbox" id="rmbr_me" name="rmbr_me" value="remember"> <br>


                    <input type="submit" value="Accedi">
                </fieldset>
            </form>
<!------------------------------------------------------------------------------------>
            <?php
                /*
                    LOGIN ----------------------------------------------------------------------------------------------
                */

                if ($_SERVER["REQUEST_METHOD"] == "POST") {
                    try {
                        // get input
                        // TO DO: Be sure those inputs are there
                        $email = $pass = $rmbr_me = null;

                        $email   = $_POST["email"];
                        $pass    = $_POST["pass"];
                        $rmbr_me = $_POST["rmbr_me"];

                        // check input validity
                        // TO DO: Add some other checks
                
                        if (empty($email) || empty($pass)) 
                            throw new Exception("<h1 class=\"error\">Check input data, some are missing</h1>");
                        
                        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) 
                            throw new Exception("<h1 class=\"error\">The given email is not valid<\h1>", 3);
                        
                        /*
                            CHECK CREDENTIALS VALIDITY -----------------------------------------------------------------
                        */

                        // get read and write SQL credentials in $sql_cred
                        require "commons/snippets/get_SQL_creds/get_RW_SQL_credentials.php";

                        // create connection
                        $con = new mysqli($sql_cred[0],$sql_cred[1],$sql_cred[2],$sql_cred[3]);
                        if ($con->connect_errno) 
                            throw new Exception("<h1 class=\"error\">Unexpected Error, could not connect to DB, errno " . $con->connect_error ."</h1>");

                        // prepare and execute query
                        if(!$stmt = $con->prepare("SELECT password, nome, cognome FROM users WHERE email = ?;"))
                            throw new Exception("<h1 class=\"error\">Unexpected Error, could not prepare query</h1>");
                        if(!$stmt->bind_param('s',$email))
                            throw new Exception("<h1 class=\"error\">Unexpected Error, could not bind query parameters</h1>");
                        if(!$stmt->execute())
                            throw new Exception("<h1 class=\"error\"> Unexpected Error: Could not get data</h1>");
                        if(!($res = $stmt->get_result()) && !$stmt->errno)
                            throw new Exception("<h1 class=\"error\"> Unexpected Error: Could not get query results</h1>");

                        // Email not found (or multiple found???)
                        if ($res->num_rows !== 1) 
                            throw new Exception("<h1 class=\"error\">Invalid credentials, try again :(</h1>");
                        
                        if(!$user_data = $res->fetch_object())
                            throw new Exception("<h1 class=\"error\">Unexpected SQL Error, Could not fetch results</h1>");
                        
                        // Wrong password
                        if (!password_verify($pass, $user_data->password)) 
                            throw new Exception("<h1 class=\"error\">Invalid credentials, try again :(</h1>");

                        // initiate session
                        $_SESSION["nome"] = $user_data->nome;
                        $_SESSION["cognome"] = $user_data->cognome;
                        echo ("<h1 class=\"confirmation\"> Good to see you again " . $_SESSION["nome"] . " :)</h1>");

                        /*
                            SET REMEMBER ME --------------------------------------------------------------------------
                        */

                        if($rmbr_me == "remember") {

                            // remember me data
                            $id = md5(rand());
                            if(!$expire_date = mktime(0, 0, 0, date("m"),   date("d"),   date("Y")+1))
                                throw new Exception("<h1 class=\"error\">Unexpected Error, could not generate expire date</h1>");
                            $expire_date_sql = date( 'Y-m-d H:i:s', $expire_date);

                            // add in database
                            $stmt->close();
                            
                            if(!$stmt = $con->prepare("UPDATE users SET uid = ?, data_scadenza = ?, remember_me = 1 WHERE email = ?;"))
                                throw new Exception("<h1 class=\"error\">Unexpected Error, could not prepare query</h1>");
                            if(!$stmt->bind_param("sss",$id, $expire_date_sql, $email))
                                throw new Exception("<h1 class=\"error\">Unexpected Error, could not bind query parameters</h1>");
                            if(!$stmt->execute())
                                throw new Exception("<h1 class=\"error\">Unexpected Error, could not execute query</h1>");
                
                            // check results 
                            if ($con->affected_rows !== 1)
                                // TO DO: there is a primary key contraint on uid, but it could be randomly generated equal
                                //        and not be inserted, can be improved by checking first?
                                throw new Exception("<h1 class=\"error\"> Unexpected Error: Could not insert data</h1>");
                            
                            // set cookie
                            if(!setcookie("rmbr_me", $id, $expire_date))
                                throw new Exception("<h1 class=\"error\">Unexpected Error, could not set remember me cookie</h1>");
                            
                            echo ("<h1 class=\"confirmation\"> We'll remember you :) </h1>");
                        }
                        // close connection with DB
                        $stmt->close();
                        $con->close();

                    } catch (Exception $ex) {
                        // Print error messages
                        $message = $ex->getMessage();
                        echo($message);
                    }
                }
            ?>
        </main>
    </body>
</html>