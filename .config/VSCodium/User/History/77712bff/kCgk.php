<?php
    // WARNING: INCOMPLETE SNIPPET  
    // $_COOKIE["rmbr_me"] = uid of remember me to delete

    // get read and write SQL credentials in $sql_cred
    // strangely, "../" did not seem to work
    require dirname(__DIR__) . "/get_SQL_creds/get_RW_SQL_credentials.php";

    // create connection
    $con = new mysqli($sql_cred[0],$sql_cred[1],$sql_cred[2],$sql_cred[3]);
    if ($con->connect_errno) 
        throw new Exception("<h1 class=\"error\">Unexpected Error, could not connect to DB, errno " . $con->connect_error ."</h1>");

    // remove data
    if(!$stmt = $con->prepare("INSERT INTO users (nome, cognome, email, password) VALUES (?, ?, ?, ?)"))
        throw new Exception("<h1 class=\"error\">Unexpected Error, could not prepare query</h1>");
    if(!$stmt->bind_param('ssss',$user_data["fname"], $user_data["lname"], $user_data["email"], $user_data["pass"]))
        throw new Exception("<h1 class=\"error\">Unexpected Error, could not bind query parameters</h1>");
    if(!$stmt->execute())
        throw new Exception("<h1 class=\"error\"> Unexpected Error: Could not insert data</h1>");
    
    // check results 
    if ($con->affected_rows !== 1)
        // TO DO: there is a primary key contraint on email, and as such, it's uniqueness is preserved,
        //        but that kinda error must caught and specifically communicated to the user
        throw new Exception("<h1 class=\"error\"> Unexpected Error: Could not insert data</h1>");

    echo("<h1 class=\"confirmation\"> Perfect! now you can login :) </h1>");
?>