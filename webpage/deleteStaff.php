<?php
    $success = True; //keep track of errors so it redirects the page only if there are no errors
    $db_conn = NULL; // edit the login credentials in connectToDB()
    $show_debug_alert_messages = False; // set to True if you want alerts to show you which methods are being triggered (see how it is used in debugAlertMessage())
    $result = NULL;

    function executePlainSQL($cmdstr) { //takes a plain (no bound variables) SQL command and executes it
        //echo "<br>running ".$cmdstr."<br>";
        global $db_conn, $success;

        $statement = OCIParse($db_conn, $cmdstr);
        //There are a set of comments at the end of the file that describe some of the OCI specific functions and how they work

        if (!$statement) {
            echo "<br>Cannot parse the following command: " . $cmdstr . "<br>";
            $e = OCI_Error($db_conn); // For OCIParse errors pass the connection handle
            echo htmlentities($e['message']);
            $success = False;
        }

        $r = OCIExecute($statement, OCI_DEFAULT);
        if (!$r) {
            echo "<br>Cannot execute the following command: " . $cmdstr . "<br>";
            $e = oci_error($statement); // For OCIExecute errors pass the statementhandle
            echo htmlentities($e['message']);
            $success = False;
        }

        return $statement;
    }

    function debugAlertMessage($message) {
        global $show_debug_alert_messages;

        if ($show_debug_alert_messages) {
            echo "<script type='text/javascript'>alert('" . $message . "');</script>";
        }
    }

    function connectToDB() {
        global $db_conn;

        // Your username is ora_(CWL_ID) and the password is a(student number). For example,
        // ora_platypus is the username and a12345678 is the password.
        $db_conn = OCILogon("ora_zqy2002", "a87141024", "dbhost.students.cs.ubc.ca:1522/stu");

        if ($db_conn) {
            debugAlertMessage("Database is Connected");
            return true;
        } else {
            debugAlertMessage("Cannot connect to Database");
            $e = OCI_Error(); // For OCILogon errors pass no handle
            echo htmlentities($e['message']);
            return false;
        }
    }

    function disconnectFromDB() {
        global $db_conn;

        debugAlertMessage("Disconnect from Database");
        OCILogoff($db_conn);
    }

    if (isset($_POST['delete'])) {
        if (connectToDB()) {
            if (array_key_exists('id', $_POST)) {
                $value = intval($_POST['id']);
                $temp = executePlainSQL("DELETE FROM Staff 
                WHERE staffID = $value");
            }
            OCICommit($db_conn);
            disconnectFromDB();
        }
    }
    
    if (connectToDB()) {
        $result = executePlainSQL("SELECT staffID, staffName, teamName
            FROM Staff s, Team_Sponsors_Stadium t 
            WHERE s.teamID = t.teamID");
        disconnectFromDB();
    }
?>

<html>
    <head>
        <title>Staff Deletion</title>
    </head>

    <form method="GET" action="main.php"> 
            <input type="submit" name="mainPage" value="Back to main page"></p>
    </form>

    <body>
        <div class="container">
            <table class="table">
                <tr>
                    <th>Name</th>
                    <th>Team</th>
                    <th>Delete Button</th>
                </tr>

                <?php
                    if (is_null($result) != true) {
                        while (($row = OCI_Fetch_Array($result, OCI_BOTH)) != false) {
                            echo "<tr>";
                            echo "<td>" . $row[1] . "</td>";
                            echo "<td>" . $row[2] . "</td>";
                            echo 
                                "<td>
                                    <form method='POST'>
                                        <input type='hidden' name='id' value=".$row[0].">
                                        <input type='submit' name='delete' value='Delete'>
                                    </form>
                                </td>";
                            echo "</tr>";
                        }
                    }
                ?>
            </table>
         </div>
    </body>
    
</html>