<?php
   //Constants
   const EXECUTION_TIME = 5; //Execution time (in seconds).
   
   /*********************************************Auxiliar Functions************************************************/
   //Time limite of execution.
   set_time_limit(self::EXECUTION_TIME);   

   //Auxiliar Function to read the .ini file.
   function readIni() {
      $fn = fopen("tempo.ini","r");
      $result = fgets($fn, 20);
      fclose($fn);
      return $result;
   }

   //Auxiliar Function to determine the periodicity with which the migration should happen (in hours).
   function getTimePeriod() {
      $t = readIni() ;
      return $t == "" ? 2 * 60 * 60: intVal($t) * 60 * 60;
   }

   //Auxiliar Functions and variable to aid in migrating only the new logs.
   $originalID = 0;
   function setOriginalID(int $newValue) {
      $originalID = $newValue;
   }
   function getOriginalID() {
      return $originalID
   }

   //Auxiliar Function to Handle DB connections
   function connectToDB($server, $user, $pass, $db) {
      $conn = new mysqli($server, $user, $pass, $db);

      if ($conn->connect_error) {
         die("Connection failed: " . $conn->connect_error);
      }
      
      return $conn;
   }

   /*    Migration Queries
    *    1. Select from Original DB Logs with id > $originalId.
    *    2. Iterate through results and Insert them into the Auditor DB.
    *    3. Set ID of the last inserted log to the $originalId variable.
   */
   function migrateLogs($conn1, $conn2) {
      $new_logs = $conn1->query("SELECT * FROM Log WHERE Log.idLog > " . getOriginalID());
      if($new_logs->num_rows > 0) {
         while($row = $new_logs->fetch_assoc()) {
            $insert_query = "INSERT INTO Log VALUES (" .$row["idLog"]. ", " .$row["tabela_chave"]. ", " .$row["id_chave"]. ", " .$row["valor_antigo"]. ", " .$row["valor_novo"]. ", " .$row["Tempo"]. ", " .$row["Op"]. ")";
            $insert_new_log = $conn2->query($insert_query);
         }
         setOriginalID($row["idLog"]);
      }
   }

   /********************************Loop in which the DB Migration logic will occur********************************/
   while(1) {
      //Open DB Connections
      $origin_conn = connectToDB("", "", "", ""); // Johnny [Origin]
      $auditor_conn = connectToDB("", "", "", ""); // Localhost [Auditor]

      //Log Migration
      migrateLogs($origin_conn, $auditor_conn);

      //Close DB Connections
      $auditor_conn->close();
      $origin_conn->close();

      //Sleep the program.
      sleep(getTimePeriod());
	}
	

?>