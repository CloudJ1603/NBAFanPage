<html>
    <head>
        <title>Award And Honors</title>
    </head>

    <form method="GET" action="main.php"> 
            <input type="submit" name="mainPage" value="Back to main page"></p>
    </form>

    <body>
        <h2>Awards and Honors</h2>
        <form method="POST" action="awardedPlayers.php"> <!--refresh page when submitted-->
            <input type="hidden" id="awardSearchRequest" name="awardSearchRequest">
            Season: <select name="season">
                <option value="">--Please choose a season--</option>
                <option value="'2018-2019'">2018-2019</option>
                <option value="'2019-2020'">2019-2020</option>
                <option value="'2020-2021'">2020-2021</option>
                </select>
            <input type="submit" name="searchAward" value="search"></p>
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

        function executeBoundSQL($cmdstr, $list) {
            /* Sometimes the same statement will be executed several times with different values for the variables involved in the query.
		In this case you don't need to create the statement several times. Bound variables cause a statement to only be
		parsed once and you can reuse the statement. This is also very useful in protecting against SQL injection.
		See the sample code below for how this function is used */

			global $db_conn, $success;
			$statement = OCIParse($db_conn, $cmdstr);

            if (!$statement) {
                echo "<br>Cannot parse the following command: " . $cmdstr . "<br>";
                $e = OCI_Error($db_conn);
                echo htmlentities($e['message']);
                $success = False;
            }

            foreach ($list as $tuple) {
                foreach ($tuple as $bind => $val) {
                    //echo $val;
                    //echo "<br>".$bind."<br>";
                    OCIBindByName($statement, $bind, $val);
                    unset ($val); //make sure you do not remove this. Otherwise $val will remain in an array object wrapper which will not be recognized by Oracle as a proper datatype
				}

                $r = OCIExecute($statement, OCI_DEFAULT);
                if (!$r) {
                    echo "<br>Cannot execute the following command: " . $cmdstr . "<br>";
                    $e = OCI_Error($statement); // For OCIExecute errors, pass the statementhandle
                    echo htmlentities($e['message']);
                    echo "<br>";
                    $success = False;
                }
            }
        }

        function printResult($result) { //prints results from a select statement
    
            // echo "<br>Retrieved data from table Player join table AwardsAndHonors:<br>";
            echo "<h4>Season:" .$_POST['season']. " <h4>";
            echo "<table>";
            echo "<tr><th>Player</th><th>Jersey Number </th><th>Team</th><th>Award</th></tr>";

            
            while (($row = OCI_Fetch_Array($result, OCI_BOTH)) != false) {
                echo "<tr><td>" . $row[0] . "</td><td>" . $row[1] . "</td><td>". $row[2] . "</td><td>" . $row[3] ."</td></tr>"; 
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

    
        function handleAwardSearchRequest() {
            global $db_conn;

            $season = $_POST['season'];

            $result = executePlainSQL("SELECT playerName,jerseyNum, teamName, awardName
            FROM Player p, AwardsAndHonors a, Team_Sponsors_Stadium t 
            WHERE p.playerID = a.playerID AND p.teamID = t.teamID AND a.season = $season");

            printResult($result);
        }

        // HANDLE ALL POST ROUTES
        function handlePOSTRequest() {
            if (connectToDB()) {
                if (array_key_exists('awardSearchRequest', $_POST)) {
                    handleAwardSearchRequest();
                } 
                disconnectFromDB();
            }
        }

        if (isset($_POST['searchAward'])) {
            handlePOSTRequest();
        }
		?>
	</body>
</html>
