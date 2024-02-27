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
    if(!$stmt = $con->prepare("UPDATE users SET uid = NULL, data_scadenza = NULL, remember_me = 0 WHERE uid = ?;"))
        throw new Exception("<h1 class=\"error\">Unexpected Error, could not prepare query</h1>");
    if (!$stmt->bind_param("s", $_COOKIE["rmbr_me"]))
        throw new Exception("<h1 class=\"error\">Unexpected Error, could not bind query parameters</h1>");
    if (!$stmt->execute())
        throw new Exception("<h1 class=\"error\">Unexpected Error, could not execute query</h1>");

    // check results 
    if ($con->affected_rows !== 1)
        // UID not found
        throw new Exception("<h1 class=\"error\"> Unexpected Error: Could not remove expired cookie</h1>");
    
    // close connection with DB
    $stmt->close();
    $con->close();
?>