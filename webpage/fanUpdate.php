<?php
    if (!isset($_GET['fanID'])) {
        die('Invalid fanID');
    }
    $fanID = $_GET['fanID'];

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
    
    if (connectToDB()) {
        $result = executePlainSQL("SELECT fanID, fanName, email, f.teamID, teamName
            FROM Fan f, Team_Sponsors_Stadium t 
            WHERE f.teamID = t.teamID AND fanID = $fanID");
        disconnectFromDB();
    }

    $data = OCI_Fetch_Array($result, OCI_BOTH);
?>

<html>
    <head>
        <title>Fan Registration</title>
    </head>

    <body>

    <form method="GET" action="fanView.php"> 
            <input type="submit" name="fanView" value="Back fan list page"></p>
    </form>
        <h2>Fan Information Update</h2>
        <form method="POST"> <!--refresh page when submitted-->
            <input type="hidden" id="updateQueryRequest" name="updateQueryRequest">
            Name: <input type="text" name="name" value='<?= $data[1]?>'> <br /><br />
            Email: <input type="text" name="email" value='<?= $data[2]?>'> <br /><br />
            Favorite Team: <select name="teamID">
            <option value='<?= $data[3]?>'><?= $data[4]?></option>
                <option value="1">Boston Celtics</option>
                <option value="2">Brooklyn Nets</option>
                <option value="3">New York Knicks</option>
                <option value="4">Philadelphia 76ers</option>
                <option value="5">Toronto Raptors</option>
                <option value="6">Chicago Bulls</option>
                <option value="7">Cleveland Cavaliers</option>
                <option value="8">Detroit Pistons</option>
                <option value="9">Indiana Pacers</option>
                <option value="10">Milwaukee Bucks</option>
                <option value="11">Atlanta Hawks</option>
                <option value="12">Charlotte Hornets</option>
                <option value="13">Miami Heat</option>
                <option value="14">Orlando Magic</option>
                <option value="15">Washington Wizards</option>
                <option value="16">Denver Nuggets</option>
                <option value="17">Minnesota Timberwolves</option>
                <option value="18">Oklahoma City Thunder</option>
                <option value="19">Portland Trail Blazers</option>
                <option value="20">Utah Jazz</option>
                <option value="21">Golden State Warriors</option>
                <option value="22">Los Angeles Clippers</option>
                <option value="23">Los Angeles Lakers</option>
                <option value="24">Phoenix Suns</option>
                <option value="25">Sacramento Kings</option>
                <option value="26">Dallas Mavericks</option>
                <option value="27">Houston Rockets</option>
                <option value="28">Memphis Grizzlies</option>
                <option value="29">New Orleans Pelicans</option>
                <option value="30">San Antonio Spurs</option>
                </select>

            <input type="submit" value="Update" name="updateSubmit"></p>
        </form>

        <?php
            if (isset($_POST['updateSubmit'])) {
                global $db_conn;
        
                $name = trim($_POST['name']);
                $email = trim($_POST['email']);
                $teamID = trim($_POST['teamID']);
        
                // you need the wrap the old name and new name values with single quotations
                executePlainSQL("UPDATE Fan SET fanName='" . $name . "', email='" . $email . "', teamID = '" . $teamID . "' WHERE fanID='" . $fanID . "'");
                OCICommit($db_conn);
                if ($success) {
                    header("Location: fanView.php");
                }
            }
        ?>
    </body>
</html>