<?php
   /*********************************************Auxiliar Functions************************************************/
   //Auxiliar Functions that read and write to the configuration files [$u_param must be "id" or "time" and $u_data must be an int]
   function readConfig($u_param) {
      try {
         if(($u_param == "id" || $u_param == "time")) {
            $p = "migration_" .$u_param. ".config";
            $fn = fopen($p,"r");
            $r = fgets($fn);
            fclose($fn);
            echo $r;
            return $r;
            
         } else {
            throw new InvalidArgumentException("Problem in the parameter: " . $u_param);
         }
      } catch(InvalidArgumentException $e) {
         echo $e;
         exit();
      }
   }

   function writeConfig($u_param, $u_data) {
      try {
         if(($u_param == "id" || $u_param == "time") && is_int($u_data)) {
            file_put_contents("migration_" . $u_param .".config", $u_data);
         } else {
            throw new InvalidArgumentException("Problem in the arguments: " . $u_param . ":" . $u_data);
         }
      } catch(InvalidArgumentException $e) {
         echo $e;
         exit();
      }
   }

   //Auxiliar Function: gets migration periodicity.
   function getTimePeriod() {
      $t = readConfig("time") ;
      return $t == "" ? 2 * 60 * 60 : intVal($t) * 60 * 60;
   }

   //Auxiliar Functions and variable to aid in migrating the new logs with the last ID migrated.
   function getOriginalID() {
      $id = intval(readConfig("id"));
      return $id == "" ? 0 : $id;
   }
   
   function setOriginalID($n) {
      writeConfig("id", $n);
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
            $insert_query = "INSERT INTO Log VALUES (" .$row["idLog"]. ", " .$row["tabela_chave"]. ", " .$row["coluna_chave"]. ", " .$row["id_chave"]. ", " .$row["valor_antigo"]. ", " .$row["valor_novo"]. ", " .$row["Tempo"]. ", " .$row["Op"]. ")";
            $insert_new_log = $conn2->query($insert_query);
         }
         setOriginalID($row["idLog"]);
      }
   }

   /********************************Loop in which the DB Migration logic will occur********************************/
   
   //Open DB Connections
   $auditor_conn = connectToDB("", "", "", ""); // Johnny [Auditor]
   $origin_conn = connectToDB("", "", "", ""); // Localhost [Origin]

   //Log Migration
   migrateLogs($origin_conn, $auditor_conn);

   //Close DB Connections
   $auditor_conn->close();
   $origin_conn->close();
	
?>