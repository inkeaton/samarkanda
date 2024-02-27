<!DOCTYPE html>

<html lang="it">
    <head>
        <Title>Register!</Title>
        <!--<link rel="stylesheet" href="commons/style.css">-->
   </head>

    <body>
        <header class = "logo">
            <h1>Create an account!</h1>
        </header>

        <main>
            <form type="submit" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>" method="post">
                <fieldset>
                    <legend>Insert your data to create your new account!</legend>

                    <label for="firstname">Name </label>
                    <input type="text" id="firstname" name="firstname" placeholder="Your name.." value="<?php if ($_SERVER["REQUEST_METHOD"] == "POST") echo htmlspecialchars($_POST["firstname"]);?>"><br>

                    <label for="lastname">Surname </label>
                    <input type="text" id="lastname" name="lastname" placeholder="Your surname.." value="<?php if ($_SERVER["REQUEST_METHOD"] == "POST") echo htmlspecialchars($_POST["lastname"]);?>"><br>
        
                    <label for="email">Email </label>
                    <input type="email" id="email" name="email" placeholder="Your email.." value="<?php if ($_SERVER["REQUEST_METHOD"] == "POST") echo htmlspecialchars($_POST["email"]);?>"><br>
        
                    <label for="pass">Password </label>
                    <input type="password" id="pass" name="pass" placeholder="Password" value="<?php if ($_SERVER["REQUEST_METHOD"] == "POST") echo htmlspecialchars($_POST["pass"]);?>"><br>
        
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
                    // INPUT VALIDATION
                    try {
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
                        $user_data_string = implode("\t", $user_data);
                        $filename = $_SERVER['DOCUMENT_ROOT'] . "/es5/data/users.txt";
                        
                        if(empty($fp = fopen($filename, "a"))) 
                            throw new Exception("<h1 class=\"error\"> Unexpected Error: Could not open file</h1>");
                        if(!flock($fp, LOCK_EX)) 
                            throw new Exception("<h1 class=\"error\"> Unexpected Error: Could not acquire lock on file</h1>");
                        if(!fwrite($fp, "$user_data_string\n")) 
                            throw new Exception("<h1 class=\"error\"> Unexpected Error: Could not write on file</h1>");
                        if(!flock($fp, LOCK_UN)) 
                            throw new Exception("<h1 class=\"error\"> Unexpected Error: Could not release lock on file</h1>");
                        if(!fclose($fp)) 
                            throw new Exception("<h1 class=\"error\"> Unexpected Error: Could not close file</h1>");

                        echo("<h1 class=\"confirmation\"> Perfetto! puoi ora fare il login :) </h1>");

                    } catch(Exception $ex) {
                        // Print error messages
                        $message = $ex->getMessage();
                        echo ($message);
                    }
                }
            ?>
        </main>
        <!-- 
        background elements, used with css to make the backdrop, please ignore 
        <div class="backdrop">
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
        </div>
        --->
    </body>
</html>