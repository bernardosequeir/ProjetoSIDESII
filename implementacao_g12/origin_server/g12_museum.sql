-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 29-Maio-2020 às 12:54
-- Versão do servidor: 10.4.10-MariaDB
-- versão do PHP: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `g12_museum`
--

DELIMITER $$
--
-- Procedimentos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AlterarUtilizador` (IN `Mail` VARCHAR(100), IN `nPass` VARCHAR(10), IN `nMorada` VARCHAR(200))  BEGIN
	SELECT user INTO @userId FROM (
		SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT default_role INTO @role FROM (
        SELECT default_role, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
    IF(CURRENT_ROLE = 'seguranca' OR @role= 'seguranca') THEN 
		IF(Mail = @userID) THEN
            IF(NOT(nPass = 'NULL')) THEN
SET @sql := CONCAT('ALTER USER ','''', Mail,'''','@localhost', ' IDENTIFIED BY ', '''', nPass,'''');
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
			END IF;
            IF(NOT(nMorada = 'NULL')) THEN
				UPDATE utilizador
SET Morada = nMorada WHERE EmailUtilizador = @userId;
			END IF;
        END IF;
    ELSEIF(CURRENT_ROLE = 'chefe_seguranca' OR @role= 'chefe_seguranca') THEN 
		IF(Mail = @userID) THEN
			IF(NOT(nMorada = 'NULL')) THEN
				UPDATE utilizador
SET Morada = nMorada WHERE EmailUtilizador = @userId;
			END IF;
            IF(NOT(nPass = 'NULL')) THEN
SET @sql := CONCAT('ALTER USER ','''', Mail,'''','@localhost', ' IDENTIFIED BY ', '''', nPass,'''');
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
			END IF;
        ELSE
			SELECT TipoUtilizador FROM utilizador WHERE EmailUtilizador = Mail INTO @Tipppo;
            IF (@Tipppo = 'SEG') THEN
				IF(NOT(nPass = 'NULL')) THEN
					SET @sql := CONCAT('ALTER USER ','''', Mail,'''','@localhost', ' IDENTIFIED BY ', '''', nPass,'''');
					PREPARE stmt FROM @sql;
					EXECUTE stmt;
				END IF;
				IF(NOT(nMorada = 'NULL')) THEN
					UPDATE utilizador
					SET Morada = nMorada WHERE EmailUtilizador = Mail;
				END IF;
			END IF;	
        END IF;
	ELSE 
		IF(NOT(nPass = 'NULL')) THEN
			SET @sql := CONCAT('ALTER USER ','''', Mail,'''','@localhost', ' IDENTIFIED BY ', '''', nPass,'''');
			PREPARE stmt FROM @sql;
			EXECUTE stmt;
		END IF;
		IF(NOT(nMorada = 'NULL')) THEN
				UPDATE utilizador
SET Morada = nMorada WHERE EmailUtilizador = Mail;
		END IF;
        
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarSistema` ()  BEGIN
	SELECT IntervaloImportacaoMongo,TempoLimiteMedicao,tamanhoDosBuffersAnomalia,tamanhoDosBuffersAlerta,variacaoAnomalaTemperatura,variacaoAnomalaHumidade,crescimentoInstantaneoTemperatura,crescimentoGradualTemperatura,crescimentoInstantaneoHumidade,crescimentoGradualHumidade,luminosidadeLuzesDesligadas,limiteTemperatura,limiteHumidade FROM sistema LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarUtilizador` (`Email` VARCHAR(100))  BEGIN
	SELECT user INTO @userId FROM (
		SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT default_role INTO @role FROM (
        SELECT default_role, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	 IF(CURRENT_ROLE = 'chefe_seguranca' OR @role= 'chefe_seguranca') THEN
		SELECT NomeUtilizador FROM utilizador WHERE EmailUtilizador = Email INTO @Nomee;
        SELECT TipoUtilizador FROM utilizador WHERE EmailUtilizador = Email INTO @Tipoo;
        SELECT Morada FROM utilizador WHERE EmailUtilizador = Email INTo @Morada;
        SELECT Morada FROM utilizador WHERE EmailUtilizador = Email INTo @cMorada;
        SELECT NomeUtilizador FROM utilizador WHERE EmailUtilizador = @userId INTO @cNomee;
        SELECT TipoUtilizador FROM utilizador WHERE EmailUtilizador = @userId INTO @cTipoo;
		IF (Email = 'NULL') Then
			SELECT * FROM utilizador where (TipoUtilizador = 'SEG' OR EmailUtilizador = @userId);
            INSERT INTO g12_loguser VALUES (DEFAULT, @UserID , 'SELECT',now(), "NULL", Email, NULL, @cNomee, NULL, @cTipoo, NULL, @cMorada);
		ELSEIF ( Email = @userId) THEN
			SELECT * FROM utilizador where (EmailUtilizador = @userId);
            INSERT INTO g12_loguser VALUES (DEFAULT, @UserID , 'SELECT',now(), "NULL", Email, NULL, @Nomee, NULL, @Tipoo, NULL, @Morada);
		ELSE 
			SELECT * FROM utilizador where (EmailUtilizador = Email AND TipoUtilizador = 'SEG');
            INSERT INTO g12_loguser VALUES (DEFAULT, @UserID , 'SELECT',now(), "NULL", Email, NULL, @Nomee, NULL, @Tipoo, NULL, @Morada);
        END IF;
	ELSEIF(CURRENT_ROLE = 'seguranca' OR @role= 'seguranca') THEN 
		SELECT NomeUtilizador FROM utilizador WHERE EmailUtilizador = Email INTO @Nomee;
        SELECT TipoUtilizador FROM utilizador WHERE EmailUtilizador = Email INTO @Tipoo;
        SELECT Morada FROM utilizador WHERE EmailUtilizador = Email INTo @Morada;
        SELECT NomeUtilizador FROM utilizador WHERE EmailUtilizador = @userId INTO @cNomee;
        SELECT TipoUtilizador FROM utilizador WHERE EmailUtilizador = @userId INTO @cTipoo;
		IF (Email = 'NULL') Then
			SELECT * FROM utilizador where (EmailUtilizador = @userId);
            INSERT INTO g12_loguser VALUES (DEFAULT, @UserID , 'SELECT',now(), "NULL", Email, NULL, @cNomee, NULL, @cTipoo, NULL, @cMorada);
		ELSEIF ( Email = @userId) THEN
			SELECT * FROM utilizador where (EmailUtilizador = @userId);
            INSERT INTO g12_loguser VALUES (DEFAULT, @UserID , 'SELECT',now(), "NULL", Email, NULL, @Nomee, NULL, @Tipoo, NULL, @Morada);
		ELSE
			SELECT * FROM utilizador where (EmailUtilizador = @userId AND EmailUtilizador = Email);
        END IF;
	ELSEIF(CURRENT_ROLE = 'diretor' OR @role= 'diretor' OR CURRENT_ROLE = 'admnistrador' OR @role= 'admnistrador') THEN
		SELECT NomeUtilizador FROM utilizador WHERE EmailUtilizador = Email INTO @Nomee;
        SELECT TipoUtilizador FROM utilizador WHERE EmailUtilizador = Email INTO @Tipoo;        
        SELECT Morada FROM utilizador WHERE EmailUtilizador = Email INTo @Morada;
        SELECT NomeUtilizador FROM utilizador WHERE EmailUtilizador = @userId INTO @cNomee;
        SELECT TipoUtilizador FROM utilizador WHERE EmailUtilizador = @userId INTO @cTipoo;
        IF (Email = 'NULL') Then
			SELECT * FROM utilizador;
             INSERT INTO g12_loguser VALUES (DEFAULT, @UserID , 'SELECT',now(), "NULL", Email, NULL, @cNomee, NULL, @cTipoo, NULL, @cMorada);
		ELSE
			SELECT * FROM utilizador where (EmailUtilizador = Email);
            INSERT INTO g12_loguser VALUES (DEFAULT, @UserID , 'SELECT',now(), "NULL", Email, NULL, @Nomee, NULL, @Tipoo, NULL, @Morada);
		END IF;
            
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsereTabelaSistemaValoresDefault` ()  BEGIN

INSERT INTO sistema VALUES (DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InserirAlerta` (IN `DataHoraMedicao` TIMESTAMP, IN `TipoSensor` VARCHAR(3), IN `ValorMedicao` DECIMAL(6,2), IN `Limite` VARCHAR(7), IN `Descricao` VARCHAR(1000), IN `Controlo` TINYINT, IN `Extra` VARCHAR(50))  BEGIN

INSERT INTO alerta VALUES (NULL,DataHoraMedicao,TipoSensor,ValorMedicao,Limite,Descricao,Controlo,Extra);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InserirMedicao` (IN `ValorMedicao` DECIMAL(6,2), IN `TipoSensor` VARCHAR(3), IN `DataHoraMedicao` TIMESTAMP)  BEGIN
	INSERT INTO medicao_sensores VALUES (NULL,ValorMedicao,TipoSensor,DataHoraMedicao);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InserirMedicaoAnomala` (IN `ValorMedicao` VARCHAR(10), IN `TipoSensor` VARCHAR(3), IN `DataHoraMedicao` TIMESTAMP)  BEGIN
	INSERT INTO medicao_sensores_anomalos VALUES (NULL,ValorMedicao,TipoSensor,DataHoraMedicao);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InserirUtilizador` (`Email` VARCHAR(100), `Nome` VARCHAR(200), `Tipo` VARCHAR(3), `Pass` VARCHAR(10), `Morada` VARCHAR(200))  BEGIN
	SELECT user INTO @userId FROM (
		SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT default_role INTO @role FROM (
        SELECT default_role, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	 IF(CURRENT_ROLE = 'chefe_seguranca' OR @role= 'chefe_seguranca') THEN
		IF(Tipo = 'SEG') THEN
			INSERT INTO utilizador (
				`EmailUtilizador`, `NomeUtilizador`, `TipoUtilizador`, `Morada`) VALUES (
				Email,
				Nome,
				Tipo,
Morada);
				SET Email := CONCAT('''', Email, '''', '@', 'localhost'),
					Pass := CONCAT('''', Pass, '''');
				SET @sql := CONCAT('CREATE USER ', Email, ' IDENTIFIED BY ', Pass);
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
				SET @sql := CONCAT('GRANT seguranca TO ', Email);
PREPARE stmt FROM @sql;
				EXECUTE stmt;
				DEALLOCATE PREPARE stmt;
				SET @sql := CONCAT('SET DEFAULT ROLE seguranca FOR ', Email);
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
				DEALLOCATE PREPARE stmt;
		END IF;
    ELSEIF (CURRENT_ROLE = 'diretor' OR @role = 'diretor' OR CURRENT_ROLE = 'admnistrador' OR @role='admnistrador') THEN
		IF(Tipo = 'SEG') THEN
			INSERT INTO utilizador (
				`EmailUtilizador`, `NomeUtilizador`, `TipoUtilizador`, `Morada`) VALUES (
				Email,
				Nome,
				Tipo,
Morada);
				SET Email := CONCAT('''', Email, '''', '@', 'localhost'),
					Pass := CONCAT('''', Pass, '''');
				SET @sql := CONCAT('CREATE USER ', Email, ' IDENTIFIED BY ', Pass);
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
				SET @sql := CONCAT('GRANT seguranca TO ', Email);
PREPARE stmt FROM @sql;
				EXECUTE stmt;
				DEALLOCATE PREPARE stmt;
				SET @sql := CONCAT('SET DEFAULT ROLE seguranca FOR ', Email);
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
				DEALLOCATE PREPARE stmt;
		ELSEIF(Tipo = 'CSG') THEN
			INSERT INTO utilizador (
				`EmailUtilizador`, `NomeUtilizador`, `TipoUtilizador`, `Morada`) VALUES (
				Email,
				Nome,
				Tipo,
Morada);
				SET Email := CONCAT('''', Email, '''', '@', 'localhost'),
					Pass := CONCAT('''', Pass, '''');
				SET @sql := CONCAT('CREATE USER ', Email, ' IDENTIFIED BY ', Pass);
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
				SET @sql := CONCAT('GRANT chefe_seguranca TO ', Email);
PREPARE stmt FROM @sql;
				EXECUTE stmt;
				DEALLOCATE PREPARE stmt;
				SET @sql := CONCAT('SET DEFAULT ROLE chefe_seguranca FOR ', Email);
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
				DEALLOCATE PREPARE stmt;
		ELSEIF(Tipo = 'DIR') THEN
			INSERT INTO utilizador (
				`EmailUtilizador`, `NomeUtilizador`, `TipoUtilizador`, `Morada`) VALUES (
				Email,
				Nome,
				Tipo,
Morada);
				SET Email := CONCAT('''', Email, '''', '@', 'localhost'),
					Pass := CONCAT('''', Pass, '''');
				SET @sql := CONCAT('CREATE USER ', Email, ' IDENTIFIED BY ', Pass);
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
				SET @sql := CONCAT('GRANT diretor TO ', Email);
PREPARE stmt FROM @sql;
				EXECUTE stmt;
				DEALLOCATE PREPARE stmt;
				SET @sql := CONCAT('SET DEFAULT ROLE diretor FOR ', Email);
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
				DEALLOCATE PREPARE stmt;
        ELSEIF(Tipo = 'AUD') THEN
			INSERT INTO utilizador (
				`EmailUtilizador`, `NomeUtilizador`, `TipoUtilizador`, `Morada`) VALUES (
				Email,
				Nome,
				Tipo,
Morada);
				SET Email := CONCAT('''', Email, '''', '@', 'localhost'),
					Pass := CONCAT('''', Pass, '''');
				SET @sql := CONCAT('CREATE USER ', Email, ' IDENTIFIED BY ', Pass);
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
				SET @sql := CONCAT('GRANT auditor TO ', Email);
PREPARE stmt FROM @sql;
				EXECUTE stmt;
				DEALLOCATE PREPARE stmt;
				SET @sql := CONCAT('SET DEFAULT ROLE auditor FOR ', Email);
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
				DEALLOCATE PREPARE stmt; 
		ELSEIF(Tipo = 'ADM') THEN
			INSERT INTO utilizador (
				`EmailUtilizador`, `NomeUtilizador`, `TipoUtilizador`, `Morada`) VALUES (
				Email,
				Nome,
				Tipo,
Morada);
				SET Email := CONCAT('''', Email, '''', '@', 'localhost'),
					Pass := CONCAT('''', Pass, '''');
				SET @sql := CONCAT('CREATE USER ', Email, ' IDENTIFIED BY ', Pass);
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
				SET @sql := CONCAT('GRANT admnistrador TO ', Email);
PREPARE stmt FROM @sql;
				EXECUTE stmt;
				DEALLOCATE PREPARE stmt;
				SET @sql := CONCAT('SET DEFAULT ROLE admnistrador FOR ', Email);
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
				DEALLOCATE PREPARE stmt;
		END IF;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `VerificaSeExisteRonda` (IN `tempodata` DATETIME)  BEGIN DECLARE diasemana VARCHAR(45);
 DECLARE existeronda TIME;
  DECLARE tempo TIME; 
  DECLARE fimRondaActual TIME; 
  SET diasemana = DAYNAME(DATE(tempodata)); 
  SET tempo = TIME(tempodata); SET existeronda = NULL; 
  SET fimRondaActual = '00:00:00';
  
CREATE TEMPORARY TABLE armazenafimRondas(horaSaida TIME);

INSERT INTO armazenafimRondas SELECT TIME(ronda_planeada.HoraRondaSaida) FROM ronda_planeada WHERE diasemana LIKE ronda_planeada.DiaSemana 
AND ronda_planeada.HoraRondaInicio <= tempo AND ronda_planeada.HoraRondaSaida >= tempo 
AND ronda_planeada.HoraRondaSaida > fimRondaActual 
UNION ALL
SELECT TIME(ronda_extra.datahoraSaida)FROM ronda_extra WHERE ronda_extra.dataHoraEntrada <= tempodata AND ronda_extra.datahoraSaida >= tempodata 
AND TIME(ronda_extra.datahoraSaida) > fimRondaActual ;


	SELECT MAX(horaSaida) FROM armazenafimRondas AS fimRondaActual;


DROP TABLE armazenafimRondas;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `alerta`
--

CREATE TABLE `alerta` (
  `ID` int(11) NOT NULL,
  `DataHoraMedicao` timestamp NULL DEFAULT NULL,
  `TipoSensor` varchar(3) NOT NULL,
  `ValorMedicao` decimal(6,2) NOT NULL,
  `Limite` varchar(7) NOT NULL,
  `Descricao` varchar(1000) NOT NULL,
  `Controlo` tinyint(1) NOT NULL,
  `Extra` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Acionadores `alerta`
--
DELIMITER $$
CREATE TRIGGER `alerta_AFTER_DELETE` AFTER DELETE ON `alerta` FOR EACH ROW BEGIN
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	INSERT INTO g12_logalerta VALUES (NULL, @UserMail ,'UPDATE', now(), old.ID, NULL, old.DataHoraMedicao, NULL, old.TipoSensor, NULL, old.ValorMedicao, NULL, old.Limite, NULL, old.Descricao, NULL, old.Controlo, NULL, old.Extra, NULL);

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `alerta_AFTER_INSERT` AFTER INSERT ON `alerta` FOR EACH ROW BEGIN
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	INSERT INTO g12_logalerta VALUES (NULL, @UserMail ,'INSERT', now(), NULL, new.ID, NULL, new.DataHoraMedicao, NULL, new.TipoSensor, NULL, new.ValorMedicao, NULL, new.Limite, NULL, new.Descricao, NULL, new.Controlo, NULL, new.Extra);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `alerta_AFTER_UPDATE` AFTER UPDATE ON `alerta` FOR EACH ROW BEGIN
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	INSERT INTO g12_logalerta VALUES (NULL, @UserMail ,'UPDATE', now(), old.ID, new.ID, old.DataHoraMedicao, new.DataHoraMedicao, old.TipoSensor, new.TipoSensor, old.ValorMedicao, new.ValorMedicao, old.Limite, new.Limite, old.Descricao, new.Descricao, old.Controlo, new.Controlo, old.Extra, new.Extra);

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `g12_logalerta`
--

CREATE TABLE `g12_logalerta` (
  `id` int(11) NOT NULL,
  `User` varchar(100) NOT NULL,
  `Operacao` varchar(10) NOT NULL,
  `Time` time NOT NULL,
  `IDAlertaAntigo` int(11) DEFAULT NULL,
  `IDAlertaNovo` varchar(45) DEFAULT NULL,
  `DataHoraMedicaoAntigo` timestamp NULL DEFAULT NULL,
  `DataHoraMedicaoNovo` timestamp NULL DEFAULT NULL,
  `TipoSensorAntigo` varchar(3) DEFAULT NULL,
  `TipoSensorNovo` varchar(3) DEFAULT NULL,
  `ValorMedicaoAntigo` decimal(6,2) DEFAULT NULL,
  `ValorMedicaoNovo` decimal(6,2) DEFAULT NULL,
  `LimiteAntigo` decimal(6,2) DEFAULT NULL,
  `LimiteNovo` decimal(6,2) DEFAULT NULL,
  `DescricaoAntigo` varchar(1000) DEFAULT NULL,
  `DescricaoNovo` varchar(1000) DEFAULT NULL,
  `ControloAntigo` tinyint(1) DEFAULT NULL,
  `ControloNovo` tinyint(1) DEFAULT NULL,
  `ExtraAntigo` varchar(50) DEFAULT NULL,
  `ExtraNovo` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `g12_logmedicao_sensores`
--

CREATE TABLE `g12_logmedicao_sensores` (
  `id` int(11) NOT NULL,
  `User` varchar(100) NOT NULL,
  `Operacao` varchar(10) NOT NULL,
  `Time` time NOT NULL,
  `IDMedicaoAntigo` bigint(20) DEFAULT NULL,
  `IDMedicalNovo` bigint(20) DEFAULT NULL,
  `ValorMedicaoAnterior` decimal(6,2) DEFAULT NULL,
  `ValorMedicaoNovo` decimal(6,2) DEFAULT NULL,
  `TipoDeSensorAnterior` varchar(3) DEFAULT NULL,
  `TipoDeSensorNovo` varchar(3) DEFAULT NULL,
  `DataHoraMedicaoAnterior` timestamp NULL DEFAULT current_timestamp(),
  `DataHoraMedicaoNovo` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `g12_logmedicao_sensores_anomalos`
--

CREATE TABLE `g12_logmedicao_sensores_anomalos` (
  `id` int(11) NOT NULL,
  `User` varchar(100) NOT NULL,
  `Operacao` varchar(10) NOT NULL,
  `Time` time NOT NULL,
  `IDMedicaoAntigo` bigint(20) DEFAULT NULL,
  `IDMedicalNovo` bigint(20) DEFAULT NULL,
  `ValorMedicaoAnterior` varchar(10) DEFAULT NULL,
  `ValorMedicaoNovo` varchar(10) DEFAULT NULL,
  `TipoDeSensorAnterior` varchar(3) DEFAULT NULL,
  `TipoDeSensorNovo` varchar(3) DEFAULT NULL,
  `DataHoraMedicaoAnterior` timestamp NULL DEFAULT current_timestamp(),
  `DataHoraMedicaoNovo` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `g12_logronda_extra`
--

CREATE TABLE `g12_logronda_extra` (
  `id` int(11) NOT NULL,
  `User` varchar(100) NOT NULL,
  `Operacao` varchar(10) NOT NULL,
  `Time` time NOT NULL,
  `dataHoraEntradaAntigo` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `dataHoraEntradaNovo` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `dataHoraSaidaAntigo` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `dataHoraSaidaNovo` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `EmailUtilizadorAntigo` varchar(100) DEFAULT NULL,
  `EmailUtilizadorNovo` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `g12_logsistema`
--

CREATE TABLE `g12_logsistema` (
  `id` int(11) NOT NULL,
  `User` varchar(100) NOT NULL,
  `Operacao` varchar(10) NOT NULL,
  `Time` time NOT NULL,
  `IDSistemaAntigo` int(11) DEFAULT NULL,
  `IDSistemaNovo` int(11) DEFAULT NULL,
  `IntervaloImportacaoMongoAntigo` decimal(6,2) DEFAULT NULL,
  `IntervaloImportacaoMongoNovo` decimal(6,2) DEFAULT NULL,
  `TempoLimiteMedicaoAntigo` int(11) DEFAULT NULL,
  `TempoLimiteMedicaoNovo` int(11) DEFAULT NULL,
  `tamanhoDosBuffersAnomaliaAntigo` int(11) DEFAULT NULL,
  `tamanhoDosBuffersAnomaliaNovo` int(11) DEFAULT NULL,
  `tamanhoDosBuffersAlertaAntigo` int(11) DEFAULT NULL,
  `tamanhoDosBuffersAlertaNovo` int(11) DEFAULT NULL,
  `variacaoAnomalaTemperaturaAntigo` decimal(3,2) DEFAULT NULL,
  `variacaoAnomalaTemperaturaNovo` decimal(3,2) DEFAULT NULL,
  `variacaoAnomalaHumidadeAntigo` decimal(3,2) DEFAULT NULL,
  `variacaoAnomalaHumidadeNovo` decimal(3,2) DEFAULT NULL,
  `crescimentoInstantaneoTemperaturaAntigo` decimal(3,2) DEFAULT NULL,
  `crescimentoInstantaneoTemperaturaNovo` decimal(3,2) DEFAULT NULL,
  `crescimentoGradualTemperaturaAntigo` decimal(3,2) DEFAULT NULL,
  `crescimentoGradualTemperaturaNovo` decimal(3,2) DEFAULT NULL,
  `crescimentoInstantaneoHumidadeAntigo` decimal(3,2) DEFAULT NULL,
  `crescimentoInstantaneoHumidadeNovo` decimal(3,2) DEFAULT NULL,
  `crescimentoGradualHumidadeAntigo` decimal(3,2) DEFAULT NULL,
  `crescimentoGradualHumidadeNovo` decimal(3,2) DEFAULT NULL,
  `luminosidadeLuzesDesligadasAntigo` int(11) DEFAULT NULL,
  `luminosidadeLuzesDesligadasNovo` int(11) DEFAULT NULL,
  `limiteTemperaturaAntigo` int(11) DEFAULT NULL,
  `limiteTemperaturaNovo` int(11) DEFAULT NULL,
  `limiteHumidadeAntigo` int(11) DEFAULT NULL,
  `limiteHumidadeNovo` int(11) DEFAULT NULL,
  `periocidadeImportacaoExportacaoAuditorAntigo` int(11) DEFAULT NULL,
  `periocidadeImportacaoExportacaoAuditorNovo` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `g12_loguser`
--

CREATE TABLE `g12_loguser` (
  `id` int(11) NOT NULL,
  `User` varchar(100) NOT NULL,
  `Operacao` varchar(10) NOT NULL,
  `Time` time NOT NULL,
  `EmailAnterior` varchar(100) NOT NULL,
  `EmailNovo` varchar(100) DEFAULT NULL,
  `NomeUtilizadorAnterior` varchar(200) DEFAULT NULL,
  `NomeUtilizadorNovo` varchar(200) DEFAULT NULL,
  `TipoUtilizadorAnterior` varchar(3) DEFAULT NULL,
  `TipoUtilizadorNovo` varchar(3) DEFAULT NULL,
  `MoradaAnterior` varchar(200) DEFAULT NULL,
  `MoradaNovo` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `medicao_sensores`
--

CREATE TABLE `medicao_sensores` (
  `idMedicao` bigint(20) NOT NULL,
  `ValorMedicao` decimal(6,2) NOT NULL,
  `TipoSensor` varchar(3) NOT NULL,
  `DataHoraMedicao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Acionadores `medicao_sensores`
--
DELIMITER $$
CREATE TRIGGER `Atualizar_Medicoes` AFTER UPDATE ON `medicao_sensores` FOR EACH ROW BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	INSERT INTO g12_logmedicao_sensores VALUES (DEFAULT, @UserMail ,'UPDATE', now(), old.idMedicao, new.idMedicao, old.ValorMedicao, new.ValorMedicao, old.TipoSensor, new.TipoSensor, old.DataHoraMedicao, new.DataHoraMedicao);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `medicao_sensores_AFTER_DELETE` AFTER DELETE ON `medicao_sensores` FOR EACH ROW BEGIN
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	INSERT INTO g12_logmedicao_sensores VALUES (DEFAULT, @UserMail ,'DELETE', now(), old.idMedicao, NULL, old.ValorMedicao, NULL, old.TipoSensor, NULL, old.DataHoraMedicao, NULL);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `medicao_sensores_AFTER_INSERT` AFTER INSERT ON `medicao_sensores` FOR EACH ROW BEGIN
	SELECT user INTO @UserMail FROM (
		SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	INSERT INTO g12_logmedicao_sensores VALUES (NULL, @UserMail ,'INSERT', now(), NULL, new.idMedicao, NULL, new.ValorMedicao, NULL, new.TipoSensor, NULL, new.DataHoraMedicao);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `medicao_sensores_anomalos`
--

CREATE TABLE `medicao_sensores_anomalos` (
  `idMedicao` bigint(20) NOT NULL,
  `ValorMedicao` varchar(10) NOT NULL,
  `TipoSensor` varchar(3) NOT NULL,
  `DataHoraMedicao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Acionadores `medicao_sensores_anomalos`
--
DELIMITER $$
CREATE TRIGGER `Atualizar_Medicoes_Anomalos` AFTER UPDATE ON `medicao_sensores_anomalos` FOR EACH ROW BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	INSERT INTO g12_logmedicao_sensores_anomalos VALUES (DEFAULT, @UserMail ,'UPDATE', now(), old.idMedicao, new.idMedicao, old.ValorMedicao, new.ValorMedicao, old.TipoSensor, new.TipoSensor, old.DataHoraMedicao, new.DataHoraMedicao);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `medicao_sensores_anomalos_AFTER_DELETE` AFTER DELETE ON `medicao_sensores_anomalos` FOR EACH ROW BEGIN
SELECT user INTO @UserMail FROM (
	SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	INSERT INTO g12_logmedicao_sensores_anomalos VALUES (NULL, @UserMail ,'DELETE', now(), old.idMedicao, NULL, old.ValorMedicao, NULL, old.TipoSensor, NULL, old.DataHoraMedicao, NULL);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `medicao_sensores_anomalos_AFTER_INSERT` AFTER INSERT ON `medicao_sensores_anomalos` FOR EACH ROW BEGIN
SELECT user INTO @UserMail FROM (
	SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	INSERT INTO g12_logmedicao_sensores_anomalos VALUES (NULL, @UserMail ,'INSERT', now(), NULL, new.idMedicao, NULL, new.ValorMedicao, NULL, new.TipoSensor, NULL, new.DataHoraMedicao);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `ronda_extra`
--

CREATE TABLE `ronda_extra` (
  `dataHoraEntrada` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `datahoraSaida` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `EmailUtilizador` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Acionadores `ronda_extra`
--
DELIMITER $$
CREATE TRIGGER `Atualizar_RondaExtra` AFTER UPDATE ON `ronda_extra` FOR EACH ROW BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	INSERT INTO g12_logronda_extra VALUES (NULL, @UserMail, 'UPDATE', now(), old.dataHoraEntrada, new.dataHoraEntrada, old.datahoraSaida, new.datahoraSaida, old.EmailUtilizador, new.EmailUtilizador);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Eliminar_RondaExtra` AFTER DELETE ON `ronda_extra` FOR EACH ROW BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	INSERT INTO g12_logronda_extra VALUES (NULL, @UserMail, 'DELETE', now(), old.dataHoraEntrada, NULL, old.datahoraSaida, NULL, old.EmailUtilizador, NULL);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Inserir_RondaExtra` AFTER INSERT ON `ronda_extra` FOR EACH ROW BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	INSERT INTO g12_logronda_extra VALUES (NULL, @UserMail, 'INSERT', now(), NULL, new.dataHoraEntrada, NULL, new.datahoraSaida, NULL, new.EmailUtilizador);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `ronda_planeada`
--

CREATE TABLE `ronda_planeada` (
  `EmailUtilizador` varchar(100) NOT NULL,
  `DiaSemana` varchar(20) NOT NULL,
  `HoraRondaInicio` time NOT NULL,
  `HoraRondaSaida` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `sistema`
--

CREATE TABLE `sistema` (
  `IDSistema` int(11) NOT NULL,
  `IntervaloImportacaoMongo` decimal(6,2) NOT NULL DEFAULT 2.00,
  `TempoLimiteMedicao` decimal(6,2) NOT NULL DEFAULT 4.00,
  `TempoEntreAlertas` decimal(6,2) NOT NULL DEFAULT 0.14,
  `tamanhoDosBuffersAnomalia` int(11) NOT NULL DEFAULT 5,
  `tamanhoDosBuffersAlerta` int(11) NOT NULL DEFAULT 5,
  `variacaoAnomalaTemperatura` decimal(3,2) NOT NULL DEFAULT 0.20,
  `variacaoAnomalaHumidade` decimal(3,2) NOT NULL DEFAULT 0.20,
  `crescimentoInstantaneoTemperatura` decimal(3,2) NOT NULL DEFAULT 0.15,
  `crescimentoGradualTemperatura` decimal(3,2) NOT NULL DEFAULT 0.15,
  `crescimentoInstantaneoHumidade` decimal(3,2) NOT NULL DEFAULT 0.15,
  `crescimentoGradualHumidade` decimal(3,2) NOT NULL DEFAULT 0.15,
  `luminosidadeLuzesDesligadas` int(11) NOT NULL DEFAULT 1000,
  `limiteTemperatura` int(11) NOT NULL DEFAULT 50,
  `limiteHumidade` int(11) NOT NULL DEFAULT 50,
  `periocidadeImportacaoExportacaoAuditor` decimal(6,2) NOT NULL DEFAULT 5.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Acionadores `sistema`
--
DELIMITER $$
CREATE TRIGGER `Atualizar_Sistema` AFTER UPDATE ON `sistema` FOR EACH ROW BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	INSERT INTO g12_logsistema VALUES (NULL, @UserMail, 'UPDATE', now(), old.IDSistema, new.IDSistema, old.IntervaloImportacaoMongo, new.IntervaloImportacaoMongo, old.TempoLimiteMedicao, new.TempoLimiteMedicao, old.tamanhoDosBuffersAnomalia, new.tamanhoDosBuffersAnomalia, old.tamanhoDosBuffersAlerta, new.tamanhoDosBuffersAlerta, old.variacaoAnomalaTemperatura, new.variacaoAnomalaTemperatura, old.variacaoAnomalaHumidade, new.variacaoAnomalaHumidade, old.crescimentoInstantaneoTemperatura, new.crescimentoInstantaneoTemperatura, old.crescimentoGradualTemperatura, new.crescimentoGradualTemperatura, old.crescimentoInstantaneoHumidade, new.crescimentoInstantaneoHumidade, old.crescimentoGradualHumidade, new.crescimentoGradualHumidade, old.luminosidadeLuzesDesligadas, new.luminosidadeLuzesDesligadas, old.limiteTemperatura, new.limiteTemperatura, old.limiteHumidade, new.limiteHumidade, old.periocidadeImportacaoExportacaoAuditor, new.periocidadeImportacaoExportacaoAuditor);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `sistema_AFTER_DELETE` AFTER DELETE ON `sistema` FOR EACH ROW BEGIN
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	INSERT INTO g12_logsistema VALUES (NULL, @UserMail, 'UPDATE', now(), old.IDSistema, NULL, old.IntervaloImportacaoMongo, NULL, old.TempoLimiteMedicao, NULL, old.tamanhoDosBuffersAnomalia, NULL, old.tamanhoDosBuffersAlerta, NULL, old.variacaoAnomalaTemperatura, NULL, old.variacaoAnomalaHumidade, NULL, old.crescimentoInstantaneoTemperatura, NULL, old.crescimentoGradualTemperatura, NULL, old.crescimentoInstantaneoHumidade, NULL, old.crescimentoGradualHumidade, NULL, old.luminosidadeLuzesDesligadas, NULL, old.limiteTemperatura, NULL, old.limiteHumidade, NULL, old.periocidadeImportacaoExportacaoAuditor, NULL);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `sistema_AFTER_INSERT` AFTER INSERT ON `sistema` FOR EACH ROW BEGIN
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	INSERT INTO g12_logsistema VALUES (NULL, @UserMail, 'INSERT', now(), NULL, new.IDSistema, NULL, new.IntervaloImportacaoMongo, NULL, new.TempoLimiteMedicao, NULL, new.tamanhoDosBuffersAnomalia, NULL, new.tamanhoDosBuffersAlerta, NULL, new.variacaoAnomalaTemperatura, NULL, new.variacaoAnomalaHumidade, NULL, new.crescimentoInstantaneoTemperatura, NULL, new.crescimentoGradualTemperatura, NULL, new.crescimentoInstantaneoHumidade, NULL, new.crescimentoGradualHumidade, NULL, new.luminosidadeLuzesDesligadas, NULL, new.limiteTemperatura, NULL, new.limiteHumidade, NULL, new.periocidadeImportacaoExportacaoAuditor);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `sistema_before_insert` BEFORE INSERT ON `sistema` FOR EACH ROW BEGIN
    if(new.IntervaloImportacaoMongo < 0 ) THEN
        set new.IntervaloImportacaoMongo = NULL;
    end if;
    if(new.TempoLimiteMedicao < 0 ) THEN
        set new.TempoLimiteMedicao = NULL;
    end if;
    if(new.tamanhoDosBuffersAnomalia < 0 ) THEN
        set new.tamanhoDosBuffersAnomalia = NULL;
    end if;
    if(new.tamanhoDosBuffersAlerta < 0 ) THEN
        set new.tamanhoDosBuffersAlerta = NULL;
    end if;
    if(new.variacaoAnomalaTemperatura < 0 ) THEN
        set new.variacaoAnomalaTemperatura = NULL;
    end if;
    if(new.variacaoAnomalaHumidade < 0 ) THEN
        set new.variacaoAnomalaHumidade = NULL;
    end if;
    if(new.crescimentoInstantaneoTemperatura < 0 ) THEN
        set new.crescimentoInstantaneoTemperatura = NULL;
    end if;
    if(new.crescimentoGradualTemperatura < 0 ) THEN
        set new.crescimentoGradualTemperatura = NULL;
    end if;
    if(new.crescimentoInstantaneoHumidade < 0 ) THEN
        set new.crescimentoInstantaneoHumidade =  NULL;
    end if;
    if(new.crescimentoGradualHumidade < 0 ) THEN
        set new.crescimentoGradualHumidade = NULL;
    end if;
    if(new.luminosidadeLuzesDesligadas < 0 ) THEN
        set new.luminosidadeLuzesDesligadas = NULL;
    end if;
    if(new.limiteHumidade < 0 ) THEN
        set new.limiteHumidade = NULL;
    end if;
    if(new.periocidadeImportacaoExportacaoAuditor < 0 ) THEN
        set new.periocidadeImportacaoExportacaoAuditor = NULL;
    end if;
    
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `utilizador`
--

CREATE TABLE `utilizador` (
  `EmailUtilizador` varchar(100) NOT NULL,
  `NomeUtilizador` varchar(200) NOT NULL,
  `TipoUtilizador` varchar(3) NOT NULL,
  `Morada` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Acionadores `utilizador`
--
DELIMITER $$
CREATE TRIGGER `Atualizar_Utilizador` AFTER UPDATE ON `utilizador` FOR EACH ROW BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	INSERT INTO g12_loguser VALUES (DEFAULT, @UserMail , 'UPDATE',now(), old.EmailUtilizador,new.EmailUtilizador,old.NomeUtilizador, new.NomeUtilizador, old.TipoUtilizador,new.TipoUtilizador,old.Morada, new.Morada);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Eliminar_Utilizador` AFTER DELETE ON `utilizador` FOR EACH ROW BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	INSERT INTO g12_loguser VALUES (DEFAULT, @UserMail , 'DELETE',now(), old.EmailUtilizador, NULL, old.NomeUtilizador, NULL, old.TipoUtilizador, NULL,  old.Morada, NULL);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Inserir_Utilizador` AFTER INSERT ON `utilizador` FOR EACH ROW BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	INSERT INTO g12_loguser VALUES (NULL, @UserMail , 'INSERT',now(), "NULL", new.EmailUtilizador, NULL, new.NomeUtilizador, NULL, new.TipoUtilizador, NULL, new.Morada);
END
$$
DELIMITER ;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `alerta`
--
ALTER TABLE `alerta`
  ADD PRIMARY KEY (`ID`);

--
-- Índices para tabela `g12_logalerta`
--
ALTER TABLE `g12_logalerta`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `g12_logmedicao_sensores`
--
ALTER TABLE `g12_logmedicao_sensores`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `g12_logmedicao_sensores_anomalos`
--
ALTER TABLE `g12_logmedicao_sensores_anomalos`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `g12_logronda_extra`
--
ALTER TABLE `g12_logronda_extra`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `g12_logsistema`
--
ALTER TABLE `g12_logsistema`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `g12_loguser`
--
ALTER TABLE `g12_loguser`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `medicao_sensores`
--
ALTER TABLE `medicao_sensores`
  ADD PRIMARY KEY (`idMedicao`);

--
-- Índices para tabela `medicao_sensores_anomalos`
--
ALTER TABLE `medicao_sensores_anomalos`
  ADD PRIMARY KEY (`idMedicao`);

--
-- Índices para tabela `ronda_extra`
--
ALTER TABLE `ronda_extra`
  ADD PRIMARY KEY (`dataHoraEntrada`),
  ADD KEY `EmailUtilizador` (`EmailUtilizador`);

--
-- Índices para tabela `ronda_planeada`
--
ALTER TABLE `ronda_planeada`
  ADD PRIMARY KEY (`EmailUtilizador`,`HoraRondaInicio`),
  ADD KEY `DiaSemana` (`DiaSemana`),
  ADD KEY `EmailUtilizador` (`EmailUtilizador`),
  ADD KEY `HoraRondaInicio` (`HoraRondaInicio`);

--
-- Índices para tabela `sistema`
--
ALTER TABLE `sistema`
  ADD PRIMARY KEY (`IDSistema`);

--
-- Índices para tabela `utilizador`
--
ALTER TABLE `utilizador`
  ADD PRIMARY KEY (`EmailUtilizador`),
  ADD KEY `EmailUtilizador` (`EmailUtilizador`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `alerta`
--
ALTER TABLE `alerta`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `g12_logalerta`
--
ALTER TABLE `g12_logalerta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `g12_logmedicao_sensores`
--
ALTER TABLE `g12_logmedicao_sensores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `g12_logmedicao_sensores_anomalos`
--
ALTER TABLE `g12_logmedicao_sensores_anomalos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `g12_logronda_extra`
--
ALTER TABLE `g12_logronda_extra`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `g12_logsistema`
--
ALTER TABLE `g12_logsistema`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `g12_loguser`
--
ALTER TABLE `g12_loguser`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `medicao_sensores`
--
ALTER TABLE `medicao_sensores`
  MODIFY `idMedicao` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `medicao_sensores_anomalos`
--
ALTER TABLE `medicao_sensores_anomalos`
  MODIFY `idMedicao` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `sistema`
--
ALTER TABLE `sistema`
  MODIFY `IDSistema` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `ronda_planeada`
--
ALTER TABLE `ronda_planeada`
  ADD CONSTRAINT `ronda_planeada_ibfk_2` FOREIGN KEY (`EmailUtilizador`) REFERENCES `utilizador` (`EmailUtilizador`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
