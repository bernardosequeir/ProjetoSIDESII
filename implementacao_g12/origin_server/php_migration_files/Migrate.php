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
      echo "<b>Starting Log Migration...</b> </br></br>";
      $new_logs = $conn1->query("SELECT * FROM log WHERE log.idLog > " .getOriginalID(). ";");

      if($new_logs->num_rows > 0) {
         echo "<i>Successfully imported data from origin.</i></br></br>";

         while($row = $new_logs->fetch_assoc()) {
            $insert_query = "INSERT INTO g12_log VALUES ('" .$row["idLog"]. "', '" .$row["tabela_chave"]. "', '" .$row["coluna_chave"]. "', '" .$row["id_chave"]. "', '" .$row["valor_antigo"]. "', '" .$row["valor_novo"]. "', '" .$row["Tempo"]. "', '" .$row["Op"]. "')";
            $insert_new_log = $conn2->query($insert_query);

            //Check if log export insertion went well
            if ($insert_new_log === TRUE) {
               echo "<i>Successfully exported Log with id: " . $row["idLog"]. "</i></br>";
            } else {
               echo "Error: INSERT INTO g12_log VALUES ('" .$row["idLog"]. "', '" .$row["tabela_chave"]. "', '" .$row["coluna_chave"]. "', '" .$row["id_chave"]. "', '" .$row["valor_antigo"]. "', '" .$row["valor_novo"]. "', '" .$row["Tempo"]. "', '" .$row["Op"]. "') <br>" . $conn2->error;
            }

            setOriginalID(intval($row["idLog"]));
         }
      }
      
      echo "</br>";
      echo "<i>Log Migration has finished</i>";
   }

   /********************************Loop in which the DB Migration logic will occur********************************/
   
   //Open DB Connections
   $auditor_conn = connectToDB("johnny.heliohost.org", "dctidata_g12", "senhag12", "dctidata_g12"); // Johnny [Auditor]
   $origin_conn = connectToDB("localhost", "root", "teste123", "museum"); // Localhost [Origin]

   //Log Migration
   migrateLogs($origin_conn, $auditor_conn);

   //Close DB Connections
   $auditor_conn->close();
   $origin_conn->close();
	
?>