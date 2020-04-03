<?php

   set_time_limit(60*30);

   /*********************************************Auxiliar Functions************************************************/

   //Auxiliar Function to Handle DB connections
   function connectToDB($server, $user, $pass, $db) {
      $conn = new mysqli($server, $user, $pass, $db);

      if ($conn->connect_error) {
         die("Connection failed: " . $conn->connect_error);
      }
      
      return $conn;
   }

   function getLastID($conn, $table) {
      $last_id = 0;
      $last_id_migrated = $conn->query("SELECT * FROM ". $table ." ORDER BY id DESC LIMIT 1");
      
      if ($last_id_migrated->num_rows > 0) {
         // output data of each row
         while($row = $last_id_migrated->fetch_assoc()) {
             echo "<i>[".$table."] Last Log migrated was: " . $row["id"] . "</i></br>";
             $last_id = $row["id"];
         }
      } else {
         echo "<i>[".$table."] This is the first migration </i></br>";
      }

      return $last_id;
   }

   function migrateLogData_man($conn1, $conn2) {
      echo "<b>Starting Log Migration...</b> </br><hr>";

      //Number of rows migrated
      $rows_migrated = 0;
      
      //Migrate logDiaSemana
      $new_logs = $conn1->query("SELECT * FROM g12_logDiaSemana WHERE id > " .getLastID($conn2, "g12_logDiaSemana"). ";");

      if($new_logs->num_rows > 0) {
         echo "<i>[g12_logDiaSemana] Successfully imported data from origin.</i></br></br>";

         while($row = $new_logs->fetch_assoc()) {
            $insert_query = "INSERT INTO g12_logDiaSemana VALUES ('" .$row["id"]. "', '" .$row["User"]. "', '" .$row["Operacao"]. "', '" .$row["Time"]. "', '" .$row["DiaSemana"]. "', '" .$row["HoraRonda"]. "')";
            $insert_new_log = $conn2->query($insert_query);

            //Check if log export insertion went well
            if ($insert_new_log === TRUE) {
               echo "<i>[g12_logDiaSemana] Successfully exported Log with id: " . $row["id"]. "</i></br>";
               $rows_migrated += 1;
            } else {
               echo "<i>[g12_logDiaSemana] Error exporting Log with id: " . $row["id"]. "</i></br>" . $conn2->error;
            }
         }
      } else {
         echo "<i>[g12_logDiaSemana] No logs to migrate.</i>";
      }

      echo "<hr>";
      //Migrate logMedicaoSensores
      $new_logs = $conn1->query("SELECT * FROM g12_logMedicaoSensores WHERE id > " .getLastID($conn2, "g12_logMedicaoSensores"). ";");

      if($new_logs->num_rows > 0) {
         echo "<i>[g12_logMedicaoSensores] Successfully imported data from origin.</i></br></br>";

         while($row = $new_logs->fetch_assoc()) {
            $insert_query = "INSERT INTO g12_logMedicaoSensores VALUES ('" .$row["id"]. "', '" .$row["User"]. "', '" .$row["Operacao"]. "', '" .$row["Time"]. "', '" .$row["ValorMedicao"]. "', '" .$row["TipoDeSensor"]. "', '" .$row["DataHoraMedicao"]. "', '" .$row["PossivelAnomalia"]. "')";
            $insert_new_log = $conn2->query($insert_query);

            //Check if log export insertion went well
            if ($insert_new_log === TRUE) {
               echo "<i>[g12_logMedicaoSensores] Successfully exported Log with id: " . $row["id"]. "</i></br>";
               $rows_migrated += 1;
            } else {
               echo "<i>[g12_logMedicaoSensores] Error exporting Log with id: " . $row["id"]. "</i></br>" . $conn2->error;
            }
         }
      } else {
         echo "<i>[g12_logMedicaoSensores] No logs to migrate.</i>";
      }

      echo "<hr>";
      //Migrate logRondaExtra
      $new_logs = $conn1->query("SELECT * FROM g12_logRondaExtra WHERE id > " .getLastID($conn2, "g12_logRondaExtra"). ";");

      if($new_logs->num_rows > 0) {
         echo "<i>[g12_logRondaExtra] Successfully imported data from origin.</i></br></br>";

         while($row = $new_logs->fetch_assoc()) {
            $insert_query = "INSERT INTO g12_logRondaExtra VALUES ('" .$row["id"]. "', '" .$row["User"]. "', '" .$row["Operacao"]. "', '" .$row["Time"]. "', '" .$row["DataHora"]. "', '" .$row["EmailUtilizador"]. "')";
            $insert_new_log = $conn2->query($insert_query);

            //Check if log export insertion went well
            if ($insert_new_log === TRUE) {
               echo "<i>[g12_logRondaExtra] Successfully exported Log with id: " . $row["id"]. "</i></br>";
               $rows_migrated += 1;
            } else {
               echo "<i>[g12_logRondaExtra] Error exporting Log with id: " . $row["id"]. "</i></br>" . $conn2->error;
            }
         }
      } else {
         echo "<i>[g12_logRondaExtra] No logs to migrate.</i>";
      }

      echo "<hr>";
      //Migrate logSistema
      $new_logs = $conn1->query("SELECT * FROM g12_logSistema WHERE id > " .getLastID($conn2, "g12_logSistema"). ";");

      if($new_logs->num_rows > 0) {
         echo "<i>[g12_logSistema] Successfully imported data from origin.</i></br></br>";

         while($row = $new_logs->fetch_assoc()) {
            $insert_query = "INSERT INTO g12_logSistema VALUES ('" .$row["id"]. "', '" .$row["User"]. "', '" .$row["Operacao"]. "', '" .$row["Time"]. "', '" .$row["LimiteTemperatura"]. "', '" .$row["LimiteHumidade"]. "', '" .$row["LimiteLuminosidade"]. "', '" .$row["LimiarTemperatura"]. "', '" .$row["LimiarHumidade"]. "', '" .$row["LimiarLuminosidade"]. "', '" .$row["DuracaoPadraoRonda"]. "', '" .$row["PeriocidadeImportacaoExportacao"]. "')";
            $insert_new_log = $conn2->query($insert_query);

            //Check if log export insertion went well
            if ($insert_new_log === TRUE) {
               echo "<i>[g12_logSistema] Successfully exported Log with id: " . $row["id"]. "</i></br>";
               $rows_migrated += 1;
            } else {
               echo "<i>[g12_logSistema] Error exporting Log with id: " . $row["id"]. "</i></br>" . $conn2->error;
            }
         }
      } else {
         echo "<i>[g12_logSistema] No logs to migrate.</i>";
      }

      echo "<hr>";
      //Migrate logUser
      $new_logs = $conn1->query("SELECT * FROM g12_logUser WHERE id > " .getLastID($conn2, "g12_logUser"). ";");

      if($new_logs->num_rows > 0) {
         echo "<i>[g12_logUser] Successfully imported data from origin.</i></br></br>";

         while($row = $new_logs->fetch_assoc()) {
            $insert_query = "INSERT INTO g12_logUser VALUES ('" .$row["id"]. "', '" .$row["User"]. "', '" .$row["Operacao"]. "', '" .$row["Time"]. "', '" .$row["Email"]. "', '" .$row["NomeUtilizador"]. "', '" .$row["TipoUtilizador"]. "', '" .$row["Morada"]. "')";
            $insert_new_log = $conn2->query($insert_query);

            //Check if log export insertion went well
            if ($insert_new_log === TRUE) {
               echo "<i>[g12_logUser] Successfully exported Log with id: " . $row["id"]. "</i></br>";
               $rows_migrated += 1;
            } else {
               echo "<i>[g12_logUser] Error exporting Log with id: " . $row["id"]. "</i></br>" . $conn2->error;
            }
         }
      } else {
         echo "<i>[g12_logUser] No logs to migrate.</i>";
      }

      echo "<hr>";
      //Migrate logUserHasDiaSemana
      $new_logs = $conn1->query("SELECT * FROM g12_logUserHasDiaSemana WHERE id > " .getLastID($conn2, "g12_logUserHasDiaSemana"). ";");

      if($new_logs->num_rows > 0) {
         echo "<i>[g12_logUserHasDiaSemana] Successfully imported data from origin.</i></br></br>";

         while($row = $new_logs->fetch_assoc()) {
            $insert_query = "INSERT INTO g12_logUserHasDiaSemana VALUES ('" .$row["id"]. "', '" .$row["User"]. "', '" .$row["Operacao"]. "', '" .$row["Time"]. "', '" .$row["User_Email"]. "', '" .$row["DiaSemana_DiaDaSemana"]. "', '" .$row["DiaSemana_HoraRonda"]. "')";
            $insert_new_log = $conn2->query($insert_query);

            //Check if log export insertion went well
            if ($insert_new_log === TRUE) {
               echo "<i>[g12_logUserHasDiaSemana] Successfully exported Log with id: " . $row["id"]. "</i></br>";
               $rows_migrated += 1;
            } else {
               echo "<i>[g12_logUserHasDiaSemana] Error exporting Log with id: " . $row["id"]. "</i></br>" . $conn2->error;
            }
         }
      } else {
         echo "<i>[g12_logUserHasDiaSemana] No logs to migrate.</i>";
      }
      
      echo "<hr>";
      echo "<i>Log Migration has finished.</i>";
      echo "</br></br><i>Number of rows migrated: ".$rows_migrated.".</i></br>";
   }

   /*********************************************** DB Migration logic ***********************************************/
   
   $starttime = microtime(true);

   //Open DB Connections
   //$auditor_conn = connectToDB("johnny.heliohost.org", "dctidata_g12", "senhag12", "dctidata_g12"); // Johnny [Auditor]
   $auditor_conn = connectToDB("192.168.1.114", "root", "teste123", "dctidata_g12"); // Other local DB for faster connection [Auditor_local]
   $origin_conn = connectToDB("localhost", "root", "teste123", "g12_museum"); // Localhost [Origin]

   //Log Migration
   migrateLogData_man($origin_conn, $auditor_conn);

   //Close DB Connections
   $auditor_conn->close();
   $origin_conn->close();
   
   $endtime = microtime(true);

   echo "<i>Elapsed time: ".number_format(($endtime - $starttime), 0)." seconds.</i></br>";
?>