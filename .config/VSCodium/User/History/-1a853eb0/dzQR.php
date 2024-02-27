<!DOCTYPE html>

<html lang="it">
    <head>
        <Title>Accedi Subito!</Title>
        <link rel="stylesheet" href="commons/style.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">
    </head>

    <body>
        <header class = "logo">
            Accedi!
        </header>

        <form type="submit" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>" method="post">
            <fieldset>
                <legend>Accedi!</legend>
    
                <label for="email">Email: </label>
                <input type="email" id="email" name="email"><br>
    
                <label for="pass">Password: </label>
                <input type="password" id="pass" name="pass"><br>

                <input type="submit">
            </fieldset>
        </form>
        
        <?php
            if ($_SERVER["REQUEST_METHOD"] == "POST") {
                try {
                    $email = $pass = null;

                    $email = $_POST["email"];
                    $pass = $_POST["pass"];

                    // check input validity

                    if(empty($email) || empty($pass)) {
                        throw new Exception("<h1>Check input data, some are missing</h1>");
                    }

                    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
                        throw new Exception("<h1>The given email is not valid<\h1>", 3);
                    }

                    // check credentials validity

                    $filename = $_SERVER['DOCUMENT_ROOT'] . "/es5/data/users.txt";
                    
                    if(empty($fp = fopen($filename, "r"))) 
                        throw new Exception("<h1> Unexpected Error: Could not open file</h1>");
                    if(!flock($fp, LOCK_EX)) 
                        throw new Exception("<h1> Unexpected Error: Could not acquire lock on file</h1>");
                    
                    $file_lines = file($filename);

                    for($line = 0; $line < count($file_lines); $line++) { 

                        $user_data = explode( "\t", $file_lines[$line]);

                        if($email == $user_data[0] && password_verify($pass, $user_data[1])) {
                            if(!flock($fp, LOCK_UN)) 
                                throw new Exception("<h1> Unexpected Error: Could not release lock on file</h1>");
                            echo("<h1> Good to see you back, $user_data[2]</h1>");
                            exit(0);
                        }

                    }
                    if(!flock($fp, LOCK_UN)) 
                        throw new Exception("<h1> Unexpected Error: Could not release lock on file</h1>");
                    if(!fclose($fp)) 
                        throw new Exception("<h1> Unexpected Error: Could not close file</h1>");

                    throw new Exception("<h1>Invalid credentials, try again :(</h1>");

                } 
                catch(Exception $ex) {
                    // Print error messages
                    $message = $ex->getMessage();
                    echo ($message);
                }

            }
        ?>
    </body>
</html>