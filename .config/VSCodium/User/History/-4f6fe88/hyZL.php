<?php
    // get read and write SQL credentials in $sql_cred
    require "../get_SQL_creds/get_RW_SQL_credentials.php";

    // create connection
    $con = new mysqli($sql_cred[0], $sql_cred[1], $sql_cred[2], $sql_cred[3]);
    if ($con->connect_errno)
        throw new Exception("<h1 class=\"error\">Unexpected Error, could not connect to DB, errno " . $con->connect_error . "</h1>");

    // prepare and execute query
    if (!$stmt = $con->prepare("SELECT nome, cognome, data_scadenza FROM users WHERE uid = ?;"))
        throw new Exception("<h1 class=\"error\">Unexpected Error, could not prepare query</h1>");
    if (!$stmt->bind_param('s', $_COOKIE["rmbr_me"]))
        throw new Exception("<h1 class=\"error\">Unexpected Error, could not bind query parameters</h1>");
    if (!$stmt->execute())
        throw new Exception("<h1 class=\"error\"> Unexpected Error: Could not get data</h1>");
    if (!($res = $stmt->get_result()) && !$stmt->errno)
        throw new Exception("<h1 class=\"error\"> Unexpected Error: Could not get query results</h1>");

    if ($res->num_rows !== 1)
        // UID not found
        throw new Exception("<h1 class=\"error\">Invalid cookie value</h1>");

    if (!$user_data = $res->fetch_object())
        throw new Exception("<h1 class=\"error\">Unexpected SQL Error, Could not fetch results</h1>");

    // close connection with DB
    $stmt->close();
    $con->close();
?>