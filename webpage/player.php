<html>
    <head>
        <title>Search Player</title>
    </head>

    <form method="GET" action="main.php"> 
            <input type="submit" name="mainPage" value="Back to main page"></p>
    </form>

    <body>
        <h2>Search Player</h2>
        <form method="POST" action="player.php"> <!--refresh page when submitted-->
            <input type="hidden" id="playerSearchRequest" name="playerSearchRequest">
            Team Name: <select name="teamID">
                <option value="">--Please choose a team--</option>
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
            <input type="submit" name="searchPlayer" value="search"></p>
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
            // echo "<br>Retrieved data from table Player:<br>";
            // echo "<table>";
            // echo "<tr><th>ID</th><th>Name</th></tr>";

            // while ($row = OCI_Fetch_Array($result, OCI_BOTH)) {
            //     echo "<tr><td>" . $row["playerID"] . "</td><td>" . $row["playerName"] . "</td></tr>"; //or just use "echo $row[0]"
            // }

            // echo "</table>";
            // echo "<br>Retrieved data from table Player:<br>";
            echo "<table>";
            echo "<tr><th>Name</th><th>Jersey Number</th></tr>";

            
            while (($row = OCI_Fetch_Array($result, OCI_BOTH)) != false) {
                echo "<tr><td>" . $row[0] . "</td><td>" . $row[1] . "</td></tr>"; 
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

    
        function handleExpenseRequest() {
            global $db_conn;

            $teamID = $_POST['teamID'];

            $result = executePlainSQL("SELECT playerName, jerseyNum FROM Player WHERE teamID = $teamID");

            printResult($result);
        }

        // HANDLE ALL POST ROUTES
    function handlePOSTRequest() {
        if (connectToDB()) {
            if (array_key_exists('playerSearchRequest', $_POST)) {
                handleExpenseRequest();
            } 
            disconnectFromDB();
        }
    }

        if (isset($_POST['searchPlayer'])) {
            handlePOSTRequest();
        }
		?>
	</body>
</html>
