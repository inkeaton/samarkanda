// Get sql credentials
$filename = $_SERVER['DOCUMENT_ROOT'] . "/es14/data/sql_cred.txt";

if (empty($fp = fopen($filename, "r")))
    throw new Exception("<h1 class=\"error\"> Unexpected Error: Could not open file</h1>");
if (!flock($fp, LOCK_EX))
    throw new Exception("<h1 class=\"error\"> Unexpected Error: Could not acquire lock on file</h1>");

$file_lines = file($filename);
$sql_data = explode(" ", $file_lines[0]);

if (!flock($fp, LOCK_UN))
    throw new Exception("<h1 class=\"error\"> Unexpected Error: Could not release lock on file</h1>");
if (!fclose($fp))
    throw new Exception("<h1 class=\"error\"> Unexpected Error: Could not close file</h1>");