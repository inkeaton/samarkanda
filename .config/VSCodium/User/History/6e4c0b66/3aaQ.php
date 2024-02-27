<!DOCTYPE html>

<html lang="it">
    <head>
        <Title>Register!</Title>
        <!--<link rel="stylesheet" href="commons/style/style.css">-->
   </head>

    <body>
        <header class = "logo">
            <h1>Create an account!</h1>
        </header>

        <?php 
            if(isset($_COOKIE["rmbr_me"])) {
                echo ($_COOKIE["rmbr_me"]);
            }
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
                        // INPUT VALIDATION
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

                        // DATA MEMORIZATION

                        // get SQL credentials
                        require "commons/snippets/get_RW_SQL_credentials.php";

                        // create connection
                        $con = new mysqli($sql_cred[0],$sql_cred[1],$sql_cred[2],$sql_cred[3]);
                        
                        // insert data
                        $stmt = $con->prepare("INSERT INTO users (nome, cognome, email, password) VALUES (?, ?, ?, ?)");
                        $stmt->bind_param('ssss',$user_data["fname"], $user_data["lname"], $user_data["email"], $user_data["pass"]);
                        $stmt->execute();
                        
                        // check results 

                        if ($con->affected_rows === 0)
                            throw new Exception("<h1 class=\"error\"> Unexpected Error: Could not insert data</h1>");
                        elseif ($con->affected_rows === 1) {
                            echo("<h1 class=\"confirmation\"> Perfect! now you can login :) </h1>");
                        }

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
    </body>
</html>