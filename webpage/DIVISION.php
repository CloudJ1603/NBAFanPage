<html>
    <head>
        <title>Player who have won all AwardsAndHonors</title>
    </head>
   <!-- add Html link -->

    <body>
        
    <form method="GET" action="main.php"> 
            <input type="submit" name="mainPage" value="Back to main page"></p>
    </form>

        <h2>Player who have won all AwardsAndHonors</h2>
        <form method="GET" action="DIVISION.php"> <!--refresh page when submitted-->
            <input type="hidden" id="DVRequest" name="DVRequest">
            <input type="submit" name="DV" value="get"></p>
        </form>

        <?php
		//this tells the system that it's no longer just parsing html; it's now parsing PHP

        $success = True; //keep track of errors so it redirects the page only if there are no errors
        $db_conn = NULL; // edit the login credentials in connectToDB()
        $show_debug_alert_messages = False; // set to True if you want alerts to show you which methods are being triggered (see how it is used in debugAlertMessage())

        function debugAlertMessage($message) {
            global $show_debug_alert_messages;

            if ($show_debug_alert_messages) {
                echo "<script type='text/javascript'>alert('" . $message . "');</script>";
            }
        }

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


        function printResult($result) { //prints results from a select statement
            echo "<table>";
            echo "<tr><th>Player Name</th><th>";

            
            while (($row = OCI_Fetch_Array($result, OCI_BOTH)) != false) {
                echo "<tr><td>" . $row[0] . "</td><td>"; 
                // echo "<br> The number of tuples in demoTable: " . $row[0] . "<br>";
            }

            echo "</table>";
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




        function handleDVRequest() {
            global $db_conn;

            $result = executePlainSQL("SELECT playerName
            FROM Player p
            WHERE NOT EXISTS
            (( SELECT a.awardName
               FROM AwardsAndHonors a
               GROUP BY a.awardName)
            MINUS
            ( SELECT b.awardName
              FROM AwardsAndHonors b
              WHERE b.playerID = p.playerID))");


            //echo "$result";
            printResult($result);
        }

    

        // HANDLE ALL GET ROUTES
	// A better coding practice is to have one method that reroutes your requests accordingly. It will make it easier to add/remove functionality.
        function handleGETRequest() {
            if (connectToDB()) {
                if (array_key_exists('DV', $_GET)) {
                    handleDVRequest();
                }

                disconnectFromDB();
            }
        }

	   if (isset($_GET['DVRequest'])) {
            handleGETRequest();
        }
		?>
	</body>
</html>
