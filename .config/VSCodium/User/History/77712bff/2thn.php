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

?>