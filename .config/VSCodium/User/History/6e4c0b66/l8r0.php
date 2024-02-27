<!DOCTYPE html>

<html lang="it">
    <head>
        <Title>Register!</Title>
        <!-- CSS is unfinished -->
        <!--<link rel="stylesheet" href="commons/style/style.css">-->
   </head>

    <body>
        <?php 
            // session/remember me check
            session_start();
            require "commons/snippets/rmbr_me/login_registration_check.php"; 
        ?>

        <header class = "logo">
            <h1>Create an account!</h1>
        </header>

        <?php
            // navigation bar
            include "commons/snippets/page_sections/navbar.php"; 
        ?>

        <main>
            <form type="submit" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>" method="post">
                <fieldset>
                    <legend>Insert your data to create your new account!</legend>

                    <label for="firstname">Name </label>
                    <input type="text" id="firstname" name="firstname" placeholder="Your name.." 
                           value="<?php if ($_SERVER["REQUEST_METHOD"] == "POST") echo htmlspecialchars($_POST["firstname"]);?>"><br>

                    <label for="lastname">Surname </label>
                    <input type="text" id="lastname" name="lastname" placeholder="Your surname.." 
                           value="<?php if ($_SERVER["REQUEST_METHOD"] == "POST") echo htmlspecialchars($_POST["lastname"]);?>"><br>
        
                    <label for="email">Email </label>
                    <input type="email" id="email" name="email" placeholder="Your email.." 
                           value="<?php if ($_SERVER["REQUEST_METHOD"] == "POST") echo htmlspecialchars($_POST["email"]);?>"><br>
        
                    <label for="pass">Password </label>
                    <input type="password" id="pass" name="pass" placeholder="Password" 
                           value="<?php if ($_SERVER["REQUEST_METHOD"] == "POST") echo htmlspecialchars($_POST["pass"]);?>"><br>
        
                    <label for="confirm">Confirm Password </label>
                    <input type="password" id="confirm" name="confirm"  placeholder="Confirm password"><br>

                    <input type="submit" value="Registrati">
                </fieldset>
            </form>
    <!------------------------------------------------------------------------------------>
            <?php
                function common_input_test($data) {
                    // check if void
                    // TO DO: make more meaningful tests
                    if (empty($data)) {
                        throw new Exception("<h1 class=\"error\">Check input data, some are missing</h1>");
                    }
                    // removes unnecessary characters
                    $data = trim($data);
                    // removes \ from text
                    $data = stripslashes($data);
                    return $data;
                }

                if ($_SERVER["REQUEST_METHOD"] == "POST") {
                    try {
                        /*
                            INPUT VALIDATION --------------------------------------------------------------------------
                        */

                        // common tests
                        $user_data["email"] = common_input_test($_POST["email"]);
                        $user_data["pass"]  = common_input_test($_POST["pass"]);
                        $user_data["fname"] = htmlspecialchars(common_input_test($_POST["firstname"]));
                        $user_data["lname"] = htmlspecialchars(common_input_test($_POST["lastname"]));
        
                        $confirm = common_input_test($_POST["confirm"]);
                        
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
                        require "commons/snippets/get_SQL_creds/get_RW_SQL_credentials.php";

                        // create connection
                        $con = new mysqli($sql_cred[0],$sql_cred[1],$sql_cred[2],$sql_cred[3]);
                        if ($con->connect_errno) 
                            throw new Exception("<h1 class=\"error\">Unexpected Error, could not connect to DB, errno " . $con->connect_error ."</h1>");
                    
                        // insert data
                        if(!$stmt = $con->prepare("INSERT INTO users (nome, cognome, email, password) VALUES (?, ?, ?, ?)"))
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
            include "commons/snippets/page_sections/footer.php"; 
        ?>
        
    </body>
</html>