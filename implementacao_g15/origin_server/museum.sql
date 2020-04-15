-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 13-Abr-2020 às 17:48
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
-- Banco de dados: `museum`
--

DELIMITER $$
--
-- Procedimentos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AlterarUtilizador` (`Mail` VARCHAR(100), `nEmail` VARCHAR(100), `nNome` VARCHAR(200), `nTipo` VARCHAR(3), `nPass` VARCHAR(10))  BEGIN
	SELECT user INTO @userId FROM (
		SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT default_role INTO @role FROM (
        SELECT default_role, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
    IF(CURRENT_ROLE = 'seguranca' OR @role= 'seguranca') THEN 
		IF(Mail = @userID) THEN
			IF(NOT(nNome = 'NULL')) THEN
				UPDATE utilizador
                SET NomeUtilizador = nNome WHERE EmailUtilizador = @userId;
			END IF;
            IF(NOT(nPass = 'NULL')) THEN
				UPDATE utilizador
                SET utilizador.Password = nPass  WHERE EmailUtilizador = @userId;
                SET @sql := CONCAT('ALTER USER ','''', Mail,'''','@localhost', ' IDENTIFIED BY ', '''', nPass,'''');
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
			END IF;
            IF(NOT(nEmail = 'NULL')) THEN
				UPDATE utilizador
                SET EmailUtilizador = nEmail WHERE EmailUtilizador = @userId;
                SET @sql := CONCAT('FLUSH PRIVILEGES');
                PREPARE stmt FROM @sql;
				EXECUTE stmt;
                SET @sql := CONCAT('RENAME USER ', '''', Mail,'''', '@localhost',' TO ','''', nEmail,'''','@localhost');
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
			END IF;
        
        END IF;
		
    ELSEIF(CURRENT_ROLE = 'chefe_seguranca' OR @role= 'chefe_seguranca') THEN 
		IF(Mail = @userID) THEN
			IF(NOT(nNome = 'NULL')) THEN
				UPDATE utilizador
                SET NomeUtilizador = nNome WHERE EmailUtilizador = @userId;
			END IF;
            IF(NOT(nPass = 'NULL')) THEN
				UPDATE utilizador
                SET utilizador.Password = nPass  WHERE EmailUtilizador = @userId;
                SET @sql := CONCAT('ALTER USER ','''', Mail,'''','@localhost', ' IDENTIFIED BY ', '''', nPass,'''');
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
			END IF;
            IF(NOT(nEmail = 'NULL')) THEN
				UPDATE utilizador
                SET EmailUtilizador = nEmail WHERE EmailUtilizador = @userId;
                SET @sql := CONCAT('FLUSH PRIVILEGES');
                PREPARE stmt FROM @sql;
				EXECUTE stmt;
                SET @sql := CONCAT('RENAME USER ', '''', Mail,'''', '@localhost',' TO ','''', nEmail,'''','@localhost');
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
			END IF;
        ELSE
			SELECT TipoUtilizador FROM utilizador WHERE EmailUtilizador = Mail INTO @Tipppo;
            IF (@Tipppo = 'SEG') THEN
				IF(NOT(nNome = 'NULL')) THEN
					UPDATE utilizador
					SET NomeUtilizador = nNome WHERE EmailUtilizador = Mail;
				END IF;
				IF(NOT(nPass = 'NULL')) THEN
					UPDATE utilizador
					SET utilizador.Password = nPass  WHERE EmailUtilizador = Mail;
					SET @sql := CONCAT('ALTER USER ','''', Mail,'''','@localhost', ' IDENTIFIED BY ', '''', nPass,'''');
					PREPARE stmt FROM @sql;
					EXECUTE stmt;
				END IF;
				IF(NOT(nEmail = 'NULL')) THEN
					UPDATE utilizador
					SET EmailUtilizador = nEmail WHERE EmailUtilizador = Mail;
					SET @sql := CONCAT('FLUSH PRIVILEGES');
					PREPARE stmt FROM @sql;
					EXECUTE stmt;
					SET @sql := CONCAT('RENAME USER ', '''', Mail,'''', '@localhost',' TO ','''', nEmail,'''','@localhost');
					PREPARE stmt FROM @sql;
					EXECUTE stmt;
				END IF;
			END IF;	
        END IF;
	ELSE 
		IF(NOT(nNome = 'NULL')) THEN
				UPDATE utilizador
                SET NomeUtilizador = nNome WHERE EmailUtilizador = Mail;
		END IF;
		IF(NOT(nPass = 'NULL')) THEN
			UPDATE utilizador
			SET utilizador.Password = nPass  WHERE EmailUtilizador = Mail;
			SET @sql := CONCAT('ALTER USER ','''', Mail,'''','@localhost', ' IDENTIFIED BY ', '''', nPass,'''');
			PREPARE stmt FROM @sql;
			EXECUTE stmt;
		END IF;
        IF(NOT(nTipo = 'NULL')) THEN
			IF(nTipo = 'SEG') THEN
				UPDATE utilizador
				SET TipoUtilizador = nTipo WHERE EmailUtilizador = Mail;
				SET @sql := CONCAT('GRANT seguranca TO ', '''', Mail,'''', '@localhost');
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
				DEALLOCATE PREPARE stmt;
				SET @sql := CONCAT('SET DEFAULT ROLE seguranca FOR ', '''', Mail,'''', '@localhost');
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
				DEALLOCATE PREPARE stmt;
			ELSEIF(nTipo = 'CSG') THEN
				UPDATE utilizador
				SET TipoUtilizador = nTipo WHERE EmailUtilizador = Mail;
				SET @sql := CONCAT('GRANT chefe_seguranca TO ', '''', Mail,'''', '@localhost');
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
				DEALLOCATE PREPARE stmt;
				SET @sql := CONCAT('SET DEFAULT ROLE chefe_seguranca FOR ', '''', Mail,'''', '@localhost');
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
				DEALLOCATE PREPARE stmt;
			ELSEIF(nTipo = 'AUD') THEN
				UPDATE utilizador
				SET TipoUtilizador = nTipo WHERE EmailUtilizador = Mail;
				SET @sql := CONCAT('GRANT auditor TO ', '''', Mail,'''', '@localhost');
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
				DEALLOCATE PREPARE stmt;
				SET @sql := CONCAT('SET DEFAULT ROLE auditor FOR ', '''', Mail,'''', '@localhost');
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
				DEALLOCATE PREPARE stmt;
			ELSEIF(nTipo = 'ADM') THEN
				UPDATE utilizador
				SET TipoUtilizador = nTipo WHERE EmailUtilizador = Mail;
				SET @sql := CONCAT('GRANT admnistrador TO ', '''', Mail,'''', '@localhost');
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
				DEALLOCATE PREPARE stmt;
				SET @sql := CONCAT('SET DEFAULT ROLE admnistrador FOR ', '''', Mail,'''', '@localhost');
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
				DEALLOCATE PREPARE stmt;
			ELSEIF(nTipo = 'DIR') THEN
				UPDATE utilizador
				SET TipoUtilizador = nTipo WHERE EmailUtilizador = Mail;
				SET @sql := CONCAT('GRANT diretor TO ', '''', Mail,'''', '@localhost');
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
				DEALLOCATE PREPARE stmt;
				SET @sql := CONCAT('SET DEFAULT ROLE diretor FOR ', '''', Mail,'''', '@localhost');
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
				DEALLOCATE PREPARE stmt;
			END IF;
		END IF;
		IF(NOT(nEmail = 'NULL')) THEN
				UPDATE utilizador
                SET EmailUtilizador = nEmail WHERE EmailUtilizador = Mail;
                SET @sql := CONCAT('FLUSH PRIVILEGES');
                PREPARE stmt FROM @sql;
				EXECUTE stmt;
                SET @sql := CONCAT('RENAME USER ', '''', Mail,'''', '@localhost',' TO ','''', nEmail,'''','@localhost');
				PREPARE stmt FROM @sql;
				EXECUTE stmt;
		END IF;
        
    END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarAlertas` (`idAlertaCheck` INT)  BEGIN
	IF ( idAlertaCheck = 'NULL') THEN
		SELECT * FROM alerta;
	ELSE
		SELECT * FROM alerta WHERE idalerta = idAlertaCheck;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarCartao` (`mailUtilizador` VARCHAR(100))  BEGIN
	IF ( mailUtilizador = 'NULL') THEN
		SELECT * FROM cartao;
	ELSE
		SELECT * FROM cartao WHERE EmailUtilizador = mailUtilizador;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarMedicoesSensores` (`idMedicaoCheck` INT)  BEGIN
	IF ( idMedicaoCheck = 'NULL') THEN
		SELECT * FROM medicaosensores;
	ELSE
		SELECT * FROM medicaosensores WHERE idMedicao = idMedicaoCheck;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarRonda` (`DiaSemanaCheck` VARCHAR(20), `HoraRonda` TIME)  BEGIN
IF ( DiaSemanaCheck = 'NULL' AND HoraRonda = 'NULL') THEN
		SELECT * FROM ronda_planeada;
	ELSE
		SELECT * FROM ronda_planeada WHERE DiaSemana = DiaSemanaCheck AND HoraRondaInicio = HoraRonda;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarRondaExtra` (`mailUtilizador` VARCHAR(100))  BEGIN
	IF ( mailUtilizador = 'NULL') THEN
		SELECT * FROM rondaextra;
	ELSE
		SELECT * FROM rondaextra WHERE EmailUtilizador = mailUtilizador;
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarSistema` (`idSistemaCheck` INT)  BEGIN
	IF ( idSistemaCheck = 'NULL') THEN
		SELECT * FROM sistema;
	ELSE
		SELECT * FROM sistema WHERE IDSistema = idSistemaCheck;
	END IF;
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
        SELECT NomeUtilizador FROM utilizador WHERE EmailUtilizador = @userId INTO @cNomee;
        SELECT TipoUtilizador FROM utilizador WHERE EmailUtilizador = @userId INTO @cTipoo;
		IF (Email = 'NULL') Then
			SELECT * FROM utilizador where (TipoUtilizador = 'SEG' OR EmailUtilizador = @userId);
            INSERT INTO logutilizador VALUES ( DEFAULT, "NULL", "NULL", "NULL", @useriD ,@cNomee, @cTipoo, now(), 'CONSULTA',DEFAULT);
		ELSEIF ( Email = @userId) THEN
			SELECT * FROM utilizador where (EmailUtilizador = @userId);
            INSERT INTO logutilizador VALUES ( DEFAULT, Email, @Nomee, @Tipoo, @userId ,@cNomee, @cTipoo, now(), 'CONSULTA',DEFAULT);
		ELSE 
			SELECT * FROM utilizador where (EmailUtilizador = Email AND TipoUtilizador = 'SEG');
            INSERT INTO logutilizador VALUES ( DEFAULT, Email, @Nomee, @Tipoo, @userId ,@cNomee, @cTipoo, now(), 'CONSULTA',DEFAULT);
        END IF;
	ELSEIF(CURRENT_ROLE = 'seguranca' OR @role= 'seguranca') THEN 
		SELECT NomeUtilizador FROM utilizador WHERE EmailUtilizador = Email INTO @Nomee;
        SELECT TipoUtilizador FROM utilizador WHERE EmailUtilizador = Email INTO @Tipoo;
        SELECT NomeUtilizador FROM utilizador WHERE EmailUtilizador = @userId INTO @cNomee;
        SELECT TipoUtilizador FROM utilizador WHERE EmailUtilizador = @userId INTO @cTipoo;
		IF (Email = 'NULL') Then
			SELECT * FROM utilizador where (EmailUtilizador = @userId);
            INSERT INTO logutilizador VALUES ( DEFAULT, "NULL", "NULL", "NULL", @useriD ,@cNomee, @cTipoo, now(), 'CONSULTA',DEFAULT);
		ELSEIF ( Email = @userId) THEN
			SELECT * FROM utilizador where (EmailUtilizador = @userId);
            INSERT INTO logutilizador VALUES ( DEFAULT, Email, @Nomee, @Tipoo, @userId ,@cNomee, @cTipoo, now(), 'CONSULTA',DEFAULT);
		ELSE
			SELECT * FROM utilizador where (EmailUtilizador = @userId AND EmailUtilizador = Email);
        END IF;
	ELSEIF(CURRENT_ROLE = 'diretor' OR @role= 'diretor' OR CURRENT_ROLE = 'admnistrador' OR @role= 'admnistrador') THEN
		SELECT NomeUtilizador FROM utilizador WHERE EmailUtilizador = Email INTO @Nomee;
        SELECT TipoUtilizador FROM utilizador WHERE EmailUtilizador = Email INTO @Tipoo;
        SELECT NomeUtilizador FROM utilizador WHERE EmailUtilizador = @userId INTO @cNomee;
        SELECT TipoUtilizador FROM utilizador WHERE EmailUtilizador = @userId INTO @cTipoo;
        IF (Email = 'NULL') Then
			SELECT * FROM utilizador;
             INSERT INTO logutilizador VALUES ( DEFAULT, "NULL", "NULL", "NULL", @useriD ,@cNomee, @cTipoo, now(), 'CONSULTA',DEFAULT);
		ELSE
			SELECT * FROM utilizador where (EmailUtilizador = Email);
            INSERT INTO logutilizador VALUES ( DEFAULT, Email, @Nomee, @Tipoo, @userId ,@cNomee, @cTipoo, now(), 'CONSULTA',DEFAULT);
		END IF;
            
	END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `exportar` ()  BEGIN

DECLARE tipo_operacao varchar(50);
DECLARE estado varchar(50);
DECLARE data timestamp;
DECLARE ficheiro varchar(50);
DECLARE data_inicio timestamp;
DECLARE data_fim timestamp;
DECLARE numero_entradas int;
DECLARE numero_entradas_total int;
DECLARE data_inicio_SP timestamp;
DECLARE data_fim_SP TIMESTAMP;
DECLARE id_novo int;
DECLARE numero_entradas_novo int;
DECLARE numero_entradas_total_novo int;
DECLARE agendada_extra varchar(50) DEFAULT 'AGENDADA';
DECLARE agora TIMESTAMP DEFAULT CURRENT_TIMESTAMP;



SELECT test_export_result.tipo_operacao INTO tipo_operacao FROM test_export_result ORDER BY test_export_result.tipo_operacao DESC LIMIT 1;
SELECT test_export_result.estado INTO estado FROM test_export_result ORDER BY test_export_result.tipo_operacao DESC LIMIT 1;
SELECT test_export_result.data INTO data FROM test_export_result ORDER BY test_export_result.tipo_operacao DESC LIMIT 1;
SELECT test_export_result.ficheiro INTO ficheiro FROM test_export_result ORDER BY test_export_result.tipo_operacao DESC LIMIT 1;
SELECT test_export_result.data_inicio INTO data_inicio FROM test_export_result ORDER BY test_export_result.tipo_operacao DESC LIMIT 1;
SELECT test_export_result.data_fim INTO data_fim FROM test_export_result ORDER BY test_export_result.tipo_operacao DESC LIMIT 1;
SELECT test_export_result.numero_entradas INTO numero_entradas FROM test_export_result ORDER BY test_export_result.tipo_operacao DESC LIMIT 1;
SELECT test_export_result.numero_entradas_total INTO numero_entradas_total FROM test_export_result ORDER BY test_export_result.tipo_operacao DESC LIMIT 1;
SET id_novo = tipo_operacao + 1;

CASE estado
	WHEN 'OK' THEN 
	
SET numero_entradas_novo = (SELECT COUNT(*) FROM (SELECT 'logalerta',logalerta.idlogAlerta,logalerta.IDAlerta,logalerta.TipoAlerta,logalerta.DataHoraAlerta,logalerta.IDMedicao,logalerta.ValorMedicao,logalerta.TipoSensor,logalerta.DataHoraMedicao,logalerta.EmailUtilizadorConsultor,logalerta.NomeUtilizadorConsultor,logalerta.TipoUtilizadorConsultor,logalerta.Data,logalerta.Comando,logalerta.Resultado, ''  from logalerta WHERE data < logalerta.data UNION SELECT 'logcartao',logcartao.idlogCartao, logcartao.idCartao, logcartao.Ativo, logcartao.EmailUtilizador, logcartao.NomeUtilizador, logcartao.TipoUtilizador, logcartao.EmailUtilizadorConsultor, logcartao.NomeUtilizadorConsultor, logcartao.TipoUtilizadorConsultor, logcartao.Data,logcartao.Comando,logcartao.Resultado, '','','' FROM logcartao WHERE data < logcartao.data UNION SELECT 'logmedicaosensores',logmedicaosensores.idLogMedicao, logmedicaosensores.IDmedicao, logmedicaosensores.TipoSensor,logmedicaosensores.DataHoraMedicao,logmedicaosensores.EmailUtilizadorConsultor,logmedicaosensores.NomeUtilizadorConsultor,logmedicaosensores.TipoUtilizadorConsultor,logmedicaosensores.Data,logmedicaosensores.Comando, logmedicaosensores.Resultado, logmedicaosensores.PossivelAnomalia, '', '', '', '' FROM logmedicaosensores  WHERE data < logmedicaosensores.data UNION SELECT 'logronda', logronda.idlogRonda, logronda.DiaSemana, logronda.HoraRonda, logronda.Duracao, logronda.EmailUtilizador, logronda.NomeUtilizador, logronda.TipoUtilizador, logronda.EmailUtilizadorConsultor, logronda.NomeUtilizadorConsultor, logronda.TipoUtilizadorConsultor, logronda.Data, logronda.Comando, logronda.Resultado, '', '' from logronda  WHERE data < logronda.data UNION SELECT 'logrondaextra',logrondaextra.idlogRondaExtra, logrondaextra.DataHora, logrondaextra.EmailUtilizador, logrondaextra.NomeUtilizador, logrondaextra.TipoUtilizador, logrondaextra.EmailUtilizadorConsultor, logrondaextra.NomeUtilizadorConsultor, logrondaextra.TipoUtilizadorConsultor, logrondaextra.Data, logrondaextra.Comando, logrondaextra.Resultado,'','','','' from logrondaextra  WHERE data < logrondaextra.data UNION SELECT 'logsistema',logsistema.idlogSistema, logsistema.IDSistema, logsistema.LimiteTemperatura, logsistema.LimiteHumidade, logsistema.LimiteLuminosidade, logsistema.LimiarTemperatura, logsistema.LimiarHumidade, logsistema.LimiarLuminosidade, logsistema.DuracaoPadraoRonda, logsistema.EmailUtilizadorConsultor,logsistema.NomeUtilizadorConsultor, logsistema.TipoUtilizadorConsultor, logsistema.Data, logsistema.Comando, logsistema.Resultado from logsistema  WHERE data < logsistema.data UNION
SELECT 'logutilizador', logutilizador.idlogUtilizador, logutilizador.EmailUtilizadorConsultado, logutilizador.NomeUtilizadorConsultado, logutilizador.TipoUtilizadorConsultado, logutilizador.EmailUtilizadorConsultor, logutilizador.NomeUtilizadorConsultor, logutilizador.TipoUtilizadorConsultor, logutilizador.Data, logutilizador.Comando, logutilizador.Resultado, '' , '' ,'', '', ''  from logutilizador  WHERE data < logutilizador.data) AS numero_entradas_novo);
SET numero_entradas_total_novo = numero_entradas_novo + numero_entradas_total;

SELECT 'logalerta',logalerta.idlogAlerta AS '',logalerta.IDAlerta,logalerta.TipoAlerta AS '',logalerta.DataHoraAlerta AS '',logalerta.IDMedicao  AS '',logalerta.ValorMedicao AS '',logalerta.TipoSensor AS '',logalerta.DataHoraMedicao AS '',logalerta.EmailUtilizadorConsultor AS '',logalerta.NomeUtilizadorConsultor AS '',logalerta.TipoUtilizadorConsultor AS '',logalerta.Data AS '',logalerta.Comando AS '',logalerta.Resultado AS '', ''  from logalerta WHERE data < logalerta.data UNION SELECT 'logcartao',logcartao.idlogCartao AS '', logcartao.idCartao AS '', logcartao.Ativo AS '', logcartao.EmailUtilizador AS '', logcartao.NomeUtilizador AS '', logcartao.TipoUtilizador AS '', logcartao.EmailUtilizadorConsultor AS '', logcartao.NomeUtilizadorConsultor AS '', logcartao.TipoUtilizadorConsultor AS '', logcartao.Data AS '',logcartao.Comando AS '',logcartao.Resultado AS '', '','','' FROM logcartao WHERE data < logcartao.data UNION SELECT 'logmedicaosensores',logmedicaosensores.idLogMedicao AS '', logmedicaosensores.IDmedicao AS '', logmedicaosensores.TipoSensor AS '',logmedicaosensores.DataHoraMedicao AS '',logmedicaosensores.EmailUtilizadorConsultor AS '',logmedicaosensores.NomeUtilizadorConsultor AS '',logmedicaosensores.TipoUtilizadorConsultor AS '',logmedicaosensores.Data AS '',logmedicaosensores.Comando AS '', logmedicaosensores.Resultado AS '', logmedicaosensores.PossivelAnomalia AS '', '', '', '', '' FROM logmedicaosensores  WHERE data < logmedicaosensores.data UNION SELECT 'logronda', logronda.idlogRonda AS '', logronda.DiaSemana AS '', logronda.HoraRonda AS '', logronda.Duracao AS '', logronda.EmailUtilizador AS '', logronda.NomeUtilizador AS '', logronda.TipoUtilizador AS '', logronda.EmailUtilizadorConsultor AS '', logronda.NomeUtilizadorConsultor AS '', logronda.TipoUtilizadorConsultor AS '', logronda.Data AS '', logronda.Comando AS '', logronda.Resultado, '', '' from logronda  WHERE data < logronda.data UNION SELECT 'logrondaextra',logrondaextra.idlogRondaExtra AS '', logrondaextra.DataHora AS '', logrondaextra.EmailUtilizador AS '', logrondaextra.NomeUtilizador AS '', logrondaextra.TipoUtilizador AS '', logrondaextra.EmailUtilizadorConsultor AS '', logrondaextra.NomeUtilizadorConsultor AS '', logrondaextra.TipoUtilizadorConsultor AS '', logrondaextra.Data AS '', logrondaextra.Comando AS '', logrondaextra.Resultado AS '','','','',''  from logrondaextra  WHERE data < logrondaextra.data UNION SELECT 'logsistema',logsistema.idlogSistema AS '', logsistema.IDSistema AS '', logsistema.LimiteTemperatura AS '', logsistema.LimiteHumidade AS '', logsistema.LimiteLuminosidade AS '', logsistema.LimiarTemperatura AS '', logsistema.LimiarHumidade AS '', logsistema.LimiarLuminosidade AS '', logsistema.DuracaoPadraoRonda AS '', logsistema.EmailUtilizadorConsultor AS '',logsistema.NomeUtilizadorConsultor AS '', logsistema.TipoUtilizadorConsultor AS '', logsistema.Data AS '', logsistema.Comando AS '', logsistema.Resultado AS '' from logsistema  WHERE data < logsistema.data UNION
SELECT 'logutilizador', logutilizador.idlogUtilizador AS '', logutilizador.EmailUtilizadorConsultado AS '', logutilizador.NomeUtilizadorConsultado AS '', logutilizador.TipoUtilizadorConsultado AS '', logutilizador.EmailUtilizadorConsultor AS '', logutilizador.NomeUtilizadorConsultor AS '', logutilizador.TipoUtilizadorConsultor AS '', logutilizador.Data AS '', logutilizador.Comando AS '', logutilizador.Resultado AS '', '' , '' ,'', '', ''  from logutilizador  WHERE data < logutilizador.data 
UNION SELECT id_novo ,agendada_extra,agora,ficheiro,numero_entradas_total_novo, numero_entradas_novo,'','','','','','','','','','' 

INTO OUTFILE "C:/xampp/htdocs/ProjetoSIDESII/implementacao_g15/origin_server/log_export/ficheiro_exportacao.csv"
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

WHEN 'EXTRA' THEN 
 	SET agendada_extra = 'EXTRA';
	IF data_inicio IS NULL AND data_fim IS NOT NULL THEN SET data_inicio_SP = '1970-00-00 00:00:01' ; SET data_fim_SP = data_fim; ELSEIF
     data_fim IS NULL AND data_inicio IS NOT NULL  THEN  SET data_fim_SP = CURRENT_TIMESTAMP; SET data_inicio_SP = data_inicio; 
     ELSE  SET data_inicio_SP = data_inicio ; SET data_fim_SP = data_fim; END IF;
     SET numero_entradas_novo = (SELECT COUNT(*) FROM (SELECT 'logalerta',logalerta.idlogAlerta,logalerta.IDAlerta,logalerta.TipoAlerta,logalerta.DataHoraAlerta,logalerta.IDMedicao,logalerta.ValorMedicao,logalerta.TipoSensor,logalerta.DataHoraMedicao,logalerta.EmailUtilizadorConsultor,logalerta.NomeUtilizadorConsultor,logalerta.TipoUtilizadorConsultor,logalerta.Data,logalerta.Comando,logalerta.Resultado, ''  from logalerta WHERE data_fim_SP > logalerta.data AND data_inicio_SP < logalerta.data UNION SELECT 'logcartao',logcartao.idlogCartao, logcartao.idCartao, logcartao.Ativo, logcartao.EmailUtilizador, logcartao.NomeUtilizador, logcartao.TipoUtilizador, logcartao.EmailUtilizadorConsultor, logcartao.NomeUtilizadorConsultor, logcartao.TipoUtilizadorConsultor, logcartao.Data,logcartao.Comando,logcartao.Resultado, '','','' FROM logcartao WHERE data_fim_SP > logcartao.data AND data_inicio_SP < logcartao.data UNION SELECT 'logmedicaosensores',logmedicaosensores.idLogMedicao, logmedicaosensores.IDmedicao, logmedicaosensores.TipoSensor,logmedicaosensores.DataHoraMedicao,logmedicaosensores.EmailUtilizadorConsultor,logmedicaosensores.NomeUtilizadorConsultor,logmedicaosensores.TipoUtilizadorConsultor,logmedicaosensores.Data,logmedicaosensores.Comando, logmedicaosensores.Resultado, logmedicaosensores.PossivelAnomalia, '', '', '', '' FROM logmedicaosensores  WHERE data_fim_SP > logmedicaosensores.data AND data_inicio_SP < logmedicaosensores.data  UNION SELECT 'logronda', logronda.idlogRonda, logronda.DiaSemana, logronda.HoraRonda, logronda.Duracao, logronda.EmailUtilizador, logronda.NomeUtilizador, logronda.TipoUtilizador, logronda.EmailUtilizadorConsultor, logronda.NomeUtilizadorConsultor, logronda.TipoUtilizadorConsultor, logronda.Data, logronda.Comando, logronda.Resultado, '', '' from logronda  where data_fim_SP > logronda.data AND data_inicio_SP < logronda.data UNION SELECT 'logrondaextra',logrondaextra.idlogRondaExtra, logrondaextra.DataHora, logrondaextra.EmailUtilizador, logrondaextra.NomeUtilizador, logrondaextra.TipoUtilizador, logrondaextra.EmailUtilizadorConsultor, logrondaextra.NomeUtilizadorConsultor, logrondaextra.TipoUtilizadorConsultor, logrondaextra.Data, logrondaextra.Comando, logrondaextra.Resultado,'','','','' from logrondaextra  WHERE data_fim_SP > logrondaextra.data AND data_inicio_SP < logrondaextra.data UNION SELECT 'logsistema',logsistema.idlogSistema, logsistema.IDSistema, logsistema.LimiteTemperatura, logsistema.LimiteHumidade, logsistema.LimiteLuminosidade, logsistema.LimiarTemperatura, logsistema.LimiarHumidade, logsistema.LimiarLuminosidade, logsistema.DuracaoPadraoRonda, logsistema.EmailUtilizadorConsultor,logsistema.NomeUtilizadorConsultor, logsistema.TipoUtilizadorConsultor, logsistema.Data, logsistema.Comando, logsistema.Resultado from logsistema  WHERE data_fim_SP > logsistema.data AND data_inicio_SP < logsistema.data UNION
SELECT 'logutilizador', logutilizador.idlogUtilizador, logutilizador.EmailUtilizadorConsultado, logutilizador.NomeUtilizadorConsultado, logutilizador.TipoUtilizadorConsultado, logutilizador.EmailUtilizadorConsultor, logutilizador.NomeUtilizadorConsultor, logutilizador.TipoUtilizadorConsultor, logutilizador.Data, logutilizador.Comando, logutilizador.Resultado, '' , '' ,'', '', ''  from logutilizador  WHERE data_fim_SP > logutilizador.data AND data_inicio_SP < logutilizador.data) AS numero_entradas_novo);
SET numero_entradas_total_novo = numero_entradas_novo + numero_entradas_total;

     SELECT 'logalerta',logalerta.idlogAlerta AS '',logalerta.IDAlerta,logalerta.TipoAlerta AS '',logalerta.DataHoraAlerta AS '',logalerta.IDMedicao  AS '',logalerta.ValorMedicao AS '',logalerta.TipoSensor AS '',logalerta.DataHoraMedicao AS '',logalerta.EmailUtilizadorConsultor AS '',logalerta.NomeUtilizadorConsultor AS '',logalerta.TipoUtilizadorConsultor AS '',logalerta.Data AS '',logalerta.Comando AS '',logalerta.Resultado AS '', ''  from logalerta WHERE data_fim_SP > logalerta.data AND data_inicio_SP < logalerta.data UNION SELECT 'logcartao',logcartao.idlogCartao AS '', logcartao.idCartao AS '', logcartao.Ativo AS '', logcartao.EmailUtilizador AS '', logcartao.NomeUtilizador AS '', logcartao.TipoUtilizador AS '', logcartao.EmailUtilizadorConsultor AS '', logcartao.NomeUtilizadorConsultor AS '', logcartao.TipoUtilizadorConsultor AS '', logcartao.Data AS '',logcartao.Comando AS '',logcartao.Resultado AS '', '','','' FROM logcartao WHERE data_fim_SP > logcartao.data AND data_inicio_SP < logcartao.data UNION SELECT 'logmedicaosensores',logmedicaosensores.idLogMedicao AS '', logmedicaosensores.IDmedicao AS '', logmedicaosensores.TipoSensor AS '',logmedicaosensores.DataHoraMedicao AS '',logmedicaosensores.EmailUtilizadorConsultor AS '',logmedicaosensores.NomeUtilizadorConsultor AS '',logmedicaosensores.TipoUtilizadorConsultor AS '',logmedicaosensores.Data AS '',logmedicaosensores.Comando AS '', logmedicaosensores.Resultado AS '', logmedicaosensores.PossivelAnomalia AS '', '', '', '', '' FROM logmedicaosensores  WHERE data_fim_SP > logmedicaosensores.data AND data_inicio_SP < logmedicaosensores.data UNION SELECT 'logronda', logronda.idlogRonda AS '', logronda.DiaSemana AS '', logronda.HoraRonda AS '', logronda.Duracao AS '', logronda.EmailUtilizador AS '', logronda.NomeUtilizador AS '', logronda.TipoUtilizador AS '', logronda.EmailUtilizadorConsultor AS '', logronda.NomeUtilizadorConsultor AS '', logronda.TipoUtilizadorConsultor AS '', logronda.Data AS '', logronda.Comando AS '', logronda.Resultado, '', '' from logronda  WHERE data_fim_SP > logronda.data AND data_inicio_SP < logronda.data UNION SELECT 'logrondaextra',logrondaextra.idlogRondaExtra AS '', logrondaextra.DataHora AS '', logrondaextra.EmailUtilizador AS '', logrondaextra.NomeUtilizador AS '', logrondaextra.TipoUtilizador AS '', logrondaextra.EmailUtilizadorConsultor AS '', logrondaextra.NomeUtilizadorConsultor AS '', logrondaextra.TipoUtilizadorConsultor AS '', logrondaextra.Data AS '', logrondaextra.Comando AS '', logrondaextra.Resultado AS '','','','',''  from logrondaextra  WHERE data_fim_SP > logrondaextra.data AND data_inicio_SP < logrondaextra.data UNION SELECT 'logsistema',logsistema.idlogSistema AS '', logsistema.IDSistema AS '', logsistema.LimiteTemperatura AS '', logsistema.LimiteHumidade AS '', logsistema.LimiteLuminosidade AS '', logsistema.LimiarTemperatura AS '', logsistema.LimiarHumidade AS '', logsistema.LimiarLuminosidade AS '', logsistema.DuracaoPadraoRonda AS '', logsistema.EmailUtilizadorConsultor AS '',logsistema.NomeUtilizadorConsultor AS '', logsistema.TipoUtilizadorConsultor AS '', logsistema.Data AS '', logsistema.Comando AS '', logsistema.Resultado AS '' from logsistema  WHERE data_fim_SP > logsistema.data AND data_inicio_SP < logsistema.data UNION
SELECT 'logutilizador', logutilizador.idlogUtilizador AS '', logutilizador.EmailUtilizadorConsultado AS '', logutilizador.NomeUtilizadorConsultado AS '', logutilizador.TipoUtilizadorConsultado AS '', logutilizador.EmailUtilizadorConsultor AS '', logutilizador.NomeUtilizadorConsultor AS '', logutilizador.TipoUtilizadorConsultor AS '', logutilizador.Data AS '', logutilizador.Comando AS '', logutilizador.Resultado AS '', '' , '' ,'', '', '' from logutilizador  WHERE data_fim_SP > logutilizador.data AND data_inicio_SP < logutilizador.data UNION SELECT id_novo ,agendada_extra,agora,ficheiro,numero_entradas_total_novo, numero_entradas_novo,'','','','','','','','','',''
INTO OUTFILE "C:/xampp/htdocs/ProjetoSIDESII/implementacao_g15/origin_server/log_export/ficheiro_exportacao.csv"
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

WHEN 'NOK' THEN 
		SET numero_entradas_novo = (SELECT COUNT(*) FROM (SELECT 'logalerta',logalerta.idlogAlerta,logalerta.IDAlerta,logalerta.TipoAlerta,logalerta.DataHoraAlerta,logalerta.IDMedicao,logalerta.ValorMedicao,logalerta.TipoSensor,logalerta.DataHoraMedicao,logalerta.EmailUtilizadorConsultor,logalerta.NomeUtilizadorConsultor,logalerta.TipoUtilizadorConsultor,logalerta.Data,logalerta.Comando,logalerta.Resultado, ''  from logalerta WHERE data_inicio < logalerta.data UNION SELECT 'logcartao',logcartao.idlogCartao, logcartao.idCartao, logcartao.Ativo, logcartao.EmailUtilizador, logcartao.NomeUtilizador, logcartao.TipoUtilizador, logcartao.EmailUtilizadorConsultor, logcartao.NomeUtilizadorConsultor, logcartao.TipoUtilizadorConsultor, logcartao.Data,logcartao.Comando,logcartao.Resultado, '','','' FROM logcartao WHERE data_inicio < logcartao.data UNION SELECT 'logmedicaosensores',logmedicaosensores.idLogMedicao, logmedicaosensores.IDmedicao, logmedicaosensores.TipoSensor,logmedicaosensores.DataHoraMedicao,logmedicaosensores.EmailUtilizadorConsultor,logmedicaosensores.NomeUtilizadorConsultor,logmedicaosensores.TipoUtilizadorConsultor,logmedicaosensores.Data,logmedicaosensores.Comando, logmedicaosensores.Resultado, logmedicaosensores.PossivelAnomalia, '', '', '', '' FROM logmedicaosensores  WHERE data_inicio < logmedicaosensores.data UNION SELECT 'logronda', logronda.idlogRonda, logronda.DiaSemana, logronda.HoraRonda, logronda.Duracao, logronda.EmailUtilizador, logronda.NomeUtilizador, logronda.TipoUtilizador, logronda.EmailUtilizadorConsultor, logronda.NomeUtilizadorConsultor, logronda.TipoUtilizadorConsultor, logronda.Data, logronda.Comando, logronda.Resultado, '', '' from logronda  WHERE data_inicio < logronda.data UNION SELECT 'logrondaextra',logrondaextra.idlogRondaExtra, logrondaextra.DataHora, logrondaextra.EmailUtilizador, logrondaextra.NomeUtilizador, logrondaextra.TipoUtilizador, logrondaextra.EmailUtilizadorConsultor, logrondaextra.NomeUtilizadorConsultor, logrondaextra.TipoUtilizadorConsultor, logrondaextra.Data, logrondaextra.Comando, logrondaextra.Resultado,'','','','' from logrondaextra  WHERE data_inicio < logrondaextra.data UNION SELECT 'logsistema',logsistema.idlogSistema, logsistema.IDSistema, logsistema.LimiteTemperatura, logsistema.LimiteHumidade, logsistema.LimiteLuminosidade, logsistema.LimiarTemperatura, logsistema.LimiarHumidade, logsistema.LimiarLuminosidade, logsistema.DuracaoPadraoRonda, logsistema.EmailUtilizadorConsultor,logsistema.NomeUtilizadorConsultor, logsistema.TipoUtilizadorConsultor, logsistema.Data, logsistema.Comando, logsistema.Resultado from logsistema  WHERE data_inicio < logsistema.data UNION
SELECT 'logutilizador', logutilizador.idlogUtilizador, logutilizador.EmailUtilizadorConsultado, logutilizador.NomeUtilizadorConsultado, logutilizador.TipoUtilizadorConsultado, logutilizador.EmailUtilizadorConsultor, logutilizador.NomeUtilizadorConsultor, logutilizador.TipoUtilizadorConsultor, logutilizador.Data, logutilizador.Comando, logutilizador.Resultado, '' , '' ,'', '', ''  from logutilizador  WHERE data_inicio < logutilizador.data) AS numero_entradas_novo);
SET numero_entradas_total_novo = numero_entradas_novo + numero_entradas_total;
     SELECT 'logalerta',logalerta.idlogAlerta AS '',logalerta.IDAlerta,logalerta.TipoAlerta AS '',logalerta.DataHoraAlerta AS '',logalerta.IDMedicao  AS '',logalerta.ValorMedicao AS '',logalerta.TipoSensor AS '',logalerta.DataHoraMedicao AS '',logalerta.EmailUtilizadorConsultor AS '',logalerta.NomeUtilizadorConsultor AS '',logalerta.TipoUtilizadorConsultor AS '',logalerta.Data AS '',logalerta.Comando AS '',logalerta.Resultado AS '', '' from logalerta  WHERE data_inicio < logalerta.data UNION SELECT 'logcartao',logcartao.idlogCartao AS '', logcartao.idCartao AS '', logcartao.Ativo AS '', logcartao.EmailUtilizador AS '', logcartao.NomeUtilizador AS '', logcartao.TipoUtilizador AS '', logcartao.EmailUtilizadorConsultor AS '', logcartao.NomeUtilizadorConsultor AS '', logcartao.TipoUtilizadorConsultor AS '', logcartao.Data AS '',logcartao.Comando AS '',logcartao.Resultado AS '', '','','' FROM logcartao WHERE data_inicio < logcartao.data UNION SELECT 'logmedicaosensores',logmedicaosensores.idLogMedicao AS '', logmedicaosensores.IDmedicao AS '', logmedicaosensores.TipoSensor AS '',logmedicaosensores.DataHoraMedicao AS '',logmedicaosensores.EmailUtilizadorConsultor AS '',logmedicaosensores.NomeUtilizadorConsultor AS '',logmedicaosensores.TipoUtilizadorConsultor AS '',logmedicaosensores.Data AS '',logmedicaosensores.Comando AS '', logmedicaosensores.Resultado AS '', logmedicaosensores.PossivelAnomalia AS '', '', '', '', '' FROM logmedicaosensores  WHERE data_inicio < logmedicaosensores.data UNION SELECT 'logronda', logronda.idlogRonda AS '', logronda.DiaSemana AS '', logronda.HoraRonda AS '', logronda.Duracao AS '', logronda.EmailUtilizador AS '', logronda.NomeUtilizador AS '', logronda.TipoUtilizador AS '', logronda.EmailUtilizadorConsultor AS '', logronda.NomeUtilizadorConsultor AS '', logronda.TipoUtilizadorConsultor AS '', logronda.Data AS '', logronda.Comando AS '', logronda.Resultado, '', '' from logronda  WHERE data_inicio < logronda.data UNION SELECT 'logrondaextra',logrondaextra.idlogRondaExtra AS '', logrondaextra.DataHora AS '', logrondaextra.EmailUtilizador AS '', logrondaextra.NomeUtilizador AS '', logrondaextra.TipoUtilizador AS '', logrondaextra.EmailUtilizadorConsultor AS '', logrondaextra.NomeUtilizadorConsultor AS '', logrondaextra.TipoUtilizadorConsultor AS '', logrondaextra.Data AS '', logrondaextra.Comando AS '', logrondaextra.Resultado AS '','','','',''  from logrondaextra  WHERE data_inicio < logrondaextra.data UNION SELECT 'logsistema',logsistema.idlogSistema AS '', logsistema.IDSistema AS '', logsistema.LimiteTemperatura AS '', logsistema.LimiteHumidade AS '', logsistema.LimiteLuminosidade AS '', logsistema.LimiarTemperatura AS '', logsistema.LimiarHumidade AS '', logsistema.LimiarLuminosidade AS '', logsistema.DuracaoPadraoRonda AS '', logsistema.EmailUtilizadorConsultor AS '',logsistema.NomeUtilizadorConsultor AS '', logsistema.TipoUtilizadorConsultor AS '', logsistema.Data AS '', logsistema.Comando AS '', logsistema.Resultado AS '' from logsistema  WHERE data_inicio < logsistema.data UNION
SELECT 'logutilizador', logutilizador.idlogUtilizador AS '', logutilizador.EmailUtilizadorConsultado AS '', logutilizador.NomeUtilizadorConsultado AS '', logutilizador.TipoUtilizadorConsultado AS '', logutilizador.EmailUtilizadorConsultor AS '', logutilizador.NomeUtilizadorConsultor AS '', logutilizador.TipoUtilizadorConsultor AS '', logutilizador.Data AS '', logutilizador.Comando AS '', logutilizador.Resultado AS '', '' , '' ,'', '', '' from logutilizador  WHERE data_inicio < logutilizador.data UNION SELECT id_novo ,agendada_extra,agora,ficheiro,numero_entradas_total_novo, numero_entradas_novo,'','','','','','','','','',''
INTO OUTFILE "C:/xampp/htdocs/ProjetoSIDESII/implementacao_g15/origin_server/log_export/ficheiro_exportacao.csv"
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

END CASE;


	



END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InserirUtilizador` (`Email` VARCHAR(100), `Nome` VARCHAR(200), `Tipo` VARCHAR(3), `Pass` VARCHAR(10))  BEGIN
	SELECT user INTO @userId FROM (
		SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT default_role INTO @role FROM (
        SELECT default_role, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	 IF(CURRENT_ROLE = 'chefe_seguranca' OR @role= 'chefe_seguranca') THEN
		IF(Tipo = 'SEG') THEN
			INSERT INTO utilizador VALUES (
				Email,
				Nome,
				Tipo,
				Pass);
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
			INSERT INTO utilizador VALUES (
				Email,
				Nome,
				Tipo,
				Pass);
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
			INSERT INTO utilizador VALUES (
				Email,
				Nome,
				Tipo,
				Pass);
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
			INSERT INTO utilizador VALUES (
				Email,
				Nome,
				Tipo,
				Pass);
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
			INSERT INTO utilizador VALUES (
				Email,
				Nome,
				Tipo,
				Pass);
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
			INSERT INTO utilizador VALUES (
				Email,
				Nome,
				Tipo,
				Pass);
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

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `alerta`
--

CREATE TABLE `alerta` (
  `idalerta` int(11) NOT NULL,
  `IDMedicao` int(11) DEFAULT NULL,
  `TipoAlerta` varchar(3) NOT NULL,
  `DataHoraAlerta` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Acionadores `alerta`
--
DELIMITER $$
CREATE TRIGGER `Atualizar_Alerta` AFTER UPDATE ON `alerta` FOR EACH ROW BEGIN
	## Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
    IF(@UserMail ='root') THEN 
        SELECT 'root' INTO @UserTipoC;
        SELECT 'root' INTO @UserNomeC;
    END IF;
	SELECT ValorMedicao, TipoSensor, DataHoraMedicao from medicaosensores where new.IDMedicao = IDMedicao INTO @ValorMedicao, @TipoSensor, @DataHoraMedicao;
    INSERT INTO logalerta VALUES ( DEFAULT, new.idalerta, new.TipoAlerta, new.DataHoraAlerta, new.IDMedicao, @ValorMedicao, @TipoSensor, @DataHoraMedicao, @UserMail , @UserNomeC, @UserTipoC, now(), 'INSERT',DEFAULT);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Eliminar_Alerta` AFTER DELETE ON `alerta` FOR EACH ROW BEGIN
	## Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
    IF(@UserMail ='root') THEN 
        SELECT 'root' INTO @UserTipoC;
        SELECT 'root' INTO @UserNomeC;
    END IF;
	SELECT ValorMedicao, TipoSensor, DataHoraMedicao from medicaosensores where old.IDMedicao = IDMedicao INTO @ValorMedicao, @TipoSensor, @DataHoraMedicao;
    INSERT INTO logalerta VALUES ( DEFAULT, old.idalerta, old.TipoAlerta, old.DataHoraAlerta, old.IDMedicao, @ValorMedicao, @TipoSensor, @DataHoraMedicao, @UserMail , @UserNomeC, @UserTipoC, now(), 'INSERT',DEFAULT);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Inserir_Alerta` AFTER INSERT ON `alerta` FOR EACH ROW BEGIN
	## Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
    IF(@UserMail ='root') THEN 
        SELECT 'root' INTO @UserTipoC;
        SELECT 'root' INTO @UserNomeC;
    END IF;
	SELECT ValorMedicao, TipoSensor, DataHoraMedicao from medicaosensores where new.IDMedicao = IDMedicao INTO @ValorMedicao, @TipoSensor, @DataHoraMedicao;
    INSERT INTO logalerta VALUES ( DEFAULT, new.idalerta, new.TipoAlerta, new.DataHoraAlerta, new.IDMedicao, @ValorMedicao, @TipoSensor, @DataHoraMedicao, @UserMail , @UserNomeC, @UserTipoC, now(), 'INSERT',DEFAULT);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `cartao`
--

CREATE TABLE `cartao` (
  `idCartao` varchar(20) NOT NULL,
  `EmailUtilizador` varchar(100) NOT NULL,
  `Ativo` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Acionadores `cartao`
--
DELIMITER $$
CREATE TRIGGER `Atualizar_Cartao` AFTER UPDATE ON `cartao` FOR EACH ROW BEGIN
	## Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
    SELECT TipoUtilizador from utilizador where EmailUtilizador = new.EmailUtilizador INTO @UserTipo;
	SELECT NomeUtilizador from utilizador where EmailUtilizador = new.EmailUtilizador INTO @UserNome;
    IF(@UserMail ='root') THEN 
        SELECT 'root' INTO @UserTipoC;
        SELECT 'root' INTO @UserNomeC;
    END IF;
	INSERT INTO logcartao VALUES ( DEFAULT, new.idCartao, new.Ativo,new.EmailUtilizador, @UserNome, @UserTipo, @UserMail ,@UserNomeC, @UserTipoC, now(), 'UPDATE',DEFAULT);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Eliminar_Cartao` AFTER DELETE ON `cartao` FOR EACH ROW BEGIN
	## Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
    SELECT TipoUtilizador from utilizador where EmailUtilizador = old.EmailUtilizador INTO @UserTipo;
	SELECT NomeUtilizador from utilizador where EmailUtilizador = old.EmailUtilizador INTO @UserNome;
    IF(@UserMail ='root') THEN 
        SELECT 'root' INTO @UserTipoC;
        SELECT 'root' INTO @UserNomeC;
    END IF;
	INSERT INTO logcartao VALUES ( DEFAULT, old.idCartao, old.Ativo, old.EmailUtilizador, @UserNome, @UserTipo, @UserMail ,@UserNomeC, @UserTipoC, now(), 'DELETE',DEFAULT);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Inserir_Cartao` AFTER INSERT ON `cartao` FOR EACH ROW BEGIN
	## Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
    SELECT TipoUtilizador from utilizador where EmailUtilizador = new.EmailUtilizador INTO @UserTipo;
	SELECT NomeUtilizador from utilizador where EmailUtilizador = new.EmailUtilizador INTO @UserNome;
    IF(@UserMail ='root') THEN 
        SELECT 'root' INTO @UserTipoC;
        SELECT 'root' INTO @UserNomeC;
    END IF;
	INSERT INTO logcartao VALUES ( DEFAULT, new.idCartao, new.Ativo, new.EmailUtilizador, @UserNome, @UserTipo, @UserMail ,@UserNomeC, @UserTipoC, now(), 'INSERT',DEFAULT);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `diasemana`
--

CREATE TABLE `diasemana` (
  `DiaSemana` varchar(20) NOT NULL,
  `HoraRonda` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `logalerta`
--

CREATE TABLE `logalerta` (
  `idlogAlerta` int(11) NOT NULL,
  `IDAlerta` int(11) NOT NULL,
  `TipoAlerta` varchar(3) NOT NULL,
  `DataHoraAlerta` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `IDMedicao` int(11) NOT NULL,
  `ValorMedicao` decimal(6,2) NOT NULL,
  `TipoSensor` varchar(3) NOT NULL,
  `DataHoraMedicao` timestamp NOT NULL DEFAULT current_timestamp(),
  `EmailUtilizadorConsultor` varchar(100) NOT NULL,
  `NomeUtilizadorConsultor` varchar(200) NOT NULL,
  `TipoUtilizadorConsultor` varchar(3) NOT NULL,
  `Data` timestamp NOT NULL DEFAULT current_timestamp(),
  `Comando` varchar(200) NOT NULL,
  `Resultado` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `logalerta`
--

INSERT INTO `logalerta` (`idlogAlerta`, `IDAlerta`, `TipoAlerta`, `DataHoraAlerta`, `IDMedicao`, `ValorMedicao`, `TipoSensor`, `DataHoraMedicao`, `EmailUtilizadorConsultor`, `NomeUtilizadorConsultor`, `TipoUtilizadorConsultor`, `Data`, `Comando`, `Resultado`) VALUES
(1, 1, '2', '2020-03-24 18:38:54', 0, '0.00', '', '2020-03-24 18:38:54', 'cecr', '', '', '2020-03-24 18:38:54', '', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `logcartao`
--

CREATE TABLE `logcartao` (
  `idlogCartao` int(11) NOT NULL,
  `idCartao` varchar(20) NOT NULL,
  `Ativo` tinyint(4) NOT NULL,
  `EmailUtilizador` varchar(100) NOT NULL,
  `NomeUtilizador` varchar(200) NOT NULL,
  `TipoUtilizador` varchar(3) NOT NULL,
  `EmailUtilizadorConsultor` varchar(100) NOT NULL,
  `NomeUtilizadorConsultor` varchar(200) NOT NULL,
  `TipoUtilizadorConsultor` varchar(3) NOT NULL,
  `Data` timestamp NOT NULL DEFAULT current_timestamp(),
  `Comando` varchar(200) NOT NULL,
  `Resultado` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `logcartao`
--

INSERT INTO `logcartao` (`idlogCartao`, `idCartao`, `Ativo`, `EmailUtilizador`, `NomeUtilizador`, `TipoUtilizador`, `EmailUtilizadorConsultor`, `NomeUtilizadorConsultor`, `TipoUtilizadorConsultor`, `Data`, `Comando`, `Resultado`) VALUES
(1, 'user_teste@email.pt', 0, 'user_teste@email.pt', 'user_teste', 'r', 'user_teste@email.pt', 'user_teste@email.pt', 'n', '1998-12-02 00:00:01', 'teste', 'teste'),
(2, 'user_teste@email.pt', 1, 'user_teste@email.pt', 'user_teste', 'd', 'user_teste@email.pt', 'user_teste@email.pt', 'u', '1998-12-02 00:00:00', 'teste', 'teste'),
(3, 'user_teste@email.pt', 0, 'user_teste@email.pt', 'user_teste', 'g', 'user_teste@email.pt', 'user_teste@email.pt', 'r', '1998-12-02 00:00:00', 'teste', 'teste'),
(4, 'user_teste@email.pt', 0, 'user_teste@email.pt', 'user_teste', 'i', 'user_teste@email.pt', 'user_teste@email.pt', 's', '1998-12-02 00:00:00', 'teste', 'teste'),
(5, 'user_teste@email.pt', 0, 'user_teste@email.pt', 'user_teste', 'n', 'user_teste@email.pt', 'user_teste@email.pt', 'k', '1998-12-02 00:00:00', 'teste', 'teste'),
(6, 'user_teste@email.pt', 0, 'user_teste@email.pt', 'user_teste', 'x', 'user_teste@email.pt', 'user_teste@email.pt', 't', '1998-12-02 00:00:00', 'teste', 'teste'),
(7, 'user_teste@email.pt', 0, 'user_teste@email.pt', 'user_teste', 'y', 'user_teste@email.pt', 'user_teste@email.pt', 'u', '1998-12-02 00:00:00', 'teste', 'teste'),
(8, 'user_teste@email.pt', 0, 'user_teste@email.pt', 'user_teste', 'm', 'user_teste@email.pt', 'user_teste@email.pt', 'w', '1998-12-02 00:00:00', 'teste', 'teste'),
(9, 'user_teste@email.pt', 1, 'user_teste@email.pt', 'user_teste', 'w', 'user_teste@email.pt', 'user_teste@email.pt', 'i', '1998-12-02 00:00:00', 'teste', 'teste');

-- --------------------------------------------------------

--
-- Estrutura da tabela `logmedicaosensores`
--

CREATE TABLE `logmedicaosensores` (
  `idLogMedicao` int(11) NOT NULL,
  `IDmedicao` int(11) NOT NULL,
  `TipoSensor` varchar(3) NOT NULL,
  `DataHoraMedicao` datetime NOT NULL,
  `EmailUtilizadorConsultor` varchar(100) NOT NULL,
  `NomeUtilizadorConsultor` varchar(200) NOT NULL,
  `TipoUtilizadorConsultor` varchar(3) NOT NULL,
  `Data` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Comando` varchar(200) NOT NULL,
  `Resultado` text DEFAULT NULL,
  `PossivelAnomalia` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `logronda`
--

CREATE TABLE `logronda` (
  `idlogRonda` int(11) NOT NULL,
  `DiaSemana` varchar(20) NOT NULL,
  `HoraRonda` time NOT NULL,
  `Duracao` int(11) NOT NULL,
  `EmailUtilizador` varchar(100) NOT NULL,
  `NomeUtilizador` varchar(200) NOT NULL,
  `TipoUtilizador` varchar(3) NOT NULL,
  `EmailUtilizadorConsultor` varchar(100) NOT NULL,
  `NomeUtilizadorConsultor` varchar(200) NOT NULL,
  `TipoUtilizadorConsultor` varchar(3) NOT NULL,
  `Data` timestamp NOT NULL DEFAULT current_timestamp(),
  `Comando` varchar(200) NOT NULL,
  `Resultado` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `logronda`
--

INSERT INTO `logronda` (`idlogRonda`, `DiaSemana`, `HoraRonda`, `Duracao`, `EmailUtilizador`, `NomeUtilizador`, `TipoUtilizador`, `EmailUtilizadorConsultor`, `NomeUtilizadorConsultor`, `TipoUtilizadorConsultor`, `Data`, `Comando`, `Resultado`) VALUES
(1, 'vsdd', '00:00:01', 1, 'jipsefrj', 'svfdfdsv', 'cs', 'svrsdv', 'vsfvsdfv', 'vf', '2020-03-24 18:34:35', 'vsdfvsdf', 'vsvdsrvesvss');

-- --------------------------------------------------------

--
-- Estrutura da tabela `logrondaextra`
--

CREATE TABLE `logrondaextra` (
  `idlogRondaExtra` int(11) NOT NULL,
  `DataHora` timestamp NOT NULL DEFAULT current_timestamp(),
  `EmailUtilizador` varchar(100) NOT NULL,
  `NomeUtilizador` varchar(200) NOT NULL,
  `TipoUtilizador` varchar(3) NOT NULL,
  `EmailUtilizadorConsultor` varchar(100) NOT NULL,
  `NomeUtilizadorConsultor` varchar(200) NOT NULL,
  `TipoUtilizadorConsultor` varchar(3) NOT NULL,
  `Data` timestamp NOT NULL DEFAULT current_timestamp(),
  `Comando` varchar(200) NOT NULL,
  `Resultado` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `logsistema`
--

CREATE TABLE `logsistema` (
  `idlogSistema` int(11) NOT NULL,
  `IDSistema` int(11) NOT NULL,
  `LimiteTemperatura` decimal(6,2) NOT NULL,
  `LimiteHumidade` decimal(6,2) NOT NULL,
  `LimiteLuminosidade` decimal(6,2) NOT NULL,
  `LimiarTemperatura` decimal(6,2) NOT NULL,
  `LimiarHumidade` decimal(6,2) NOT NULL,
  `LimiarLuminosidade` decimal(6,2) NOT NULL,
  `DuracaoPadraoRonda` int(11) NOT NULL,
  `EmailUtilizadorConsultor` varchar(100) NOT NULL,
  `NomeUtilizadorConsultor` varchar(200) NOT NULL,
  `TipoUtilizadorConsultor` varchar(3) NOT NULL,
  `Data` timestamp NOT NULL DEFAULT current_timestamp(),
  `Comando` varchar(200) NOT NULL,
  `Resultado` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `logutilizador`
--

CREATE TABLE `logutilizador` (
  `idlogUtilizador` int(11) NOT NULL,
  `EmailUtilizadorConsultado` varchar(100) NOT NULL,
  `NomeUtilizadorConsultado` varchar(200) NOT NULL,
  `TipoUtilizadorConsultado` varchar(3) NOT NULL,
  `EmailUtilizadorConsultor` varchar(100) NOT NULL,
  `NomeUtilizadorConsultor` varchar(200) NOT NULL,
  `TipoUtilizadorConsultor` varchar(3) NOT NULL,
  `Data` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Comando` varchar(200) NOT NULL,
  `Resultado` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `logutilizador`
--

INSERT INTO `logutilizador` (`idlogUtilizador`, `EmailUtilizadorConsultado`, `NomeUtilizadorConsultado`, `TipoUtilizadorConsultado`, `EmailUtilizadorConsultor`, `NomeUtilizadorConsultor`, `TipoUtilizadorConsultor`, `Data`, `Comando`, `Resultado`) VALUES
(1, 'joao@joao.com', 'joao', 'SEG', 'joao@joao.com', 'joao', 'SEG', '2020-04-13 15:44:54', 'CONSULTA', NULL),
(2, 'joao@joao.com', 'joao', 'SEG', 'joao@joao.com', 'joao', 'SEG', '2020-04-13 15:44:55', 'CONSULTA', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `medicaosensores`
--

CREATE TABLE `medicaosensores` (
  `idMedicao` int(11) NOT NULL,
  `ValorMedicao` decimal(6,2) NOT NULL,
  `TipoSensor` varchar(3) NOT NULL,
  `DataHoraMedicao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `PossivelAnomalia` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Acionadores `medicaosensores`
--
DELIMITER $$
CREATE TRIGGER `Atualizar_Medicoes` AFTER UPDATE ON `medicaosensores` FOR EACH ROW BEGIN
	## Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
    IF(@UserMail ='root') THEN 
        SELECT 'root' INTO @UserTipoC;
        SELECT 'root' INTO @UserNomeC;
    END IF;
	INSERT INTO logmedicaosensores VALUES ( DEFAULT, new.idMedicao, new.TipoSensor, new.DataHoraMedicao, @UserMail ,@UserNomeC, @UserTipoC, now(), 'UPDATE',DEFAULT,new.PossivelAnomalia);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Eliminar_Medicoes` AFTER DELETE ON `medicaosensores` FOR EACH ROW BEGIN
	## Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
    IF(@UserMail ='root') THEN 
        SELECT 'root' INTO @UserTipoC;
        SELECT 'root' INTO @UserNomeC;
    END IF;
	INSERT INTO logmedicaosensores VALUES ( DEFAULT, old.idMedicao, old.TipoSensor, old.DataHoraMedicao, @UserMail ,@UserNomeC, @UserTipoC, now(), 'DELETE',DEFAULT,old.PossivelAnomalia);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Inserir_Medicoes` AFTER INSERT ON `medicaosensores` FOR EACH ROW BEGIN
	## Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
    IF(@UserMail ='root') THEN 
        SELECT 'root' INTO @UserTipoC;
        SELECT 'root' INTO @UserNomeC;
    END IF;
	INSERT INTO logmedicaosensores VALUES ( DEFAULT, new.idMedicao, new.TipoSensor, new.DataHoraMedicao, @UserMail ,@UserNomeC, @UserTipoC, now(), 'INSERT',DEFAULT,new.PossivelAnomalia);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `rondaextra`
--

CREATE TABLE `rondaextra` (
  `dataHoraEntrada` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `EmailUtilizador` varchar(100) NOT NULL,
  `datahoraSaida` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Acionadores `rondaextra`
--
DELIMITER $$
CREATE TRIGGER `Atualizar_RondaExtra` AFTER UPDATE ON `rondaextra` FOR EACH ROW BEGIN
	## Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
    SELECT TipoUtilizador from utilizador where EmailUtilizador = new.EmailUtilizador INTO @UserTipo;
	SELECT NomeUtilizador from utilizador where EmailUtilizador = new.EmailUtilizador INTO @UserNome;
    IF(@UserMail ='root') THEN 
        SELECT 'root' INTO @UserTipoC;
        SELECT 'root' INTO @UserNomeC;
    END IF;
	INSERT INTO logrondaextra VALUES ( DEFAULT, new.DataHoraEntrada, new.EmailUtilizador, @UserNome, @UserTipo, @UserMail ,@UserNomeC, @UserTipoC, now(), 'UPDATE',DEFAULT);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Eliminar_RondaExtra` AFTER DELETE ON `rondaextra` FOR EACH ROW BEGIN
	## Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
    SELECT TipoUtilizador from utilizador where EmailUtilizador = old.EmailUtilizador INTO @UserTipo;
	SELECT NomeUtilizador from utilizador where EmailUtilizador = old.EmailUtilizador INTO @UserNome;
    IF(@UserMail ='root') THEN 
        SELECT 'root' INTO @UserTipoC;
        SELECT 'root' INTO @UserNomeC;
    END IF;
	INSERT INTO logrondaextra VALUES ( DEFAULT, old.DataHoraEntrada, old.EmailUtilizador, @UserNome, @UserTipo, @UserMail ,@UserNomeC, @UserTipoC, now(), 'DELETE',DEFAULT);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Inserir_RondaExtra` AFTER INSERT ON `rondaextra` FOR EACH ROW BEGIN
	## Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
    SELECT TipoUtilizador from utilizador where EmailUtilizador = new.EmailUtilizador INTO @UserTipo;
	SELECT NomeUtilizador from utilizador where EmailUtilizador = new.EmailUtilizador INTO @UserNome;
    IF(@UserMail ='root') THEN 
        SELECT 'root' INTO @UserTipoC;
        SELECT 'root' INTO @UserNomeC;
    END IF;
	INSERT INTO logrondaextra VALUES ( DEFAULT, new.DataHoraEntrada, new.EmailUtilizador, @UserNome, @UserTipo, @UserMail ,@UserNomeC, @UserTipoC, now(), 'INSERT',DEFAULT);
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
  `HoraRondaInicio` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `sistema`
--

CREATE TABLE `sistema` (
  `IDSistema` int(11) NOT NULL,
  `LimiteTemperatura` decimal(6,2) NOT NULL,
  `LimiteHumidade` decimal(6,2) NOT NULL,
  `LimiteLuminosidade` decimal(6,2) NOT NULL,
  `LimiarTemperatura` decimal(6,2) NOT NULL,
  `LimiarHumidade` decimal(6,2) NOT NULL,
  `LimiarLuminosidade` decimal(6,2) NOT NULL,
  `DuraçãoPadrãoRonda` int(11) NOT NULL,
  `PeriocidadeImportacaoExportacao` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Acionadores `sistema`
--
DELIMITER $$
CREATE TRIGGER `Atualizar_Sistema` AFTER UPDATE ON `sistema` FOR EACH ROW BEGIN
	## Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
    IF(@UserMail ='root') THEN 
        SELECT 'root' INTO @UserTipoC;
        SELECT 'root' INTO @UserNomeC;
    END IF;
	INSERT INTO logsistema VALUES ( DEFAULT, new.IDSistema, new.LimiteTemperatura, new.LimiteHumidade, new.LimiteLuminosidade, new.LimiarTemperatura, new.LimiarHumidade, new.LimiarLuminosidade, new.DuraçãoPadrãoRonda, @UserMail ,@UserNomeC, @UserTipoC, now(), 'INSERT',DEFAULT);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Eliminar_Sistema` AFTER DELETE ON `sistema` FOR EACH ROW BEGIN
	## Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
    IF(@UserMail ='root') THEN 
        SELECT 'root' INTO @UserTipoC;
        SELECT 'root' INTO @UserNomeC;
    END IF;
	INSERT INTO logsistema VALUES ( DEFAULT, old.IDSistema, old.LimiteTemperatura, old.LimiteHumidade, old.LimiteLuminosidade, old.LimiarTemperatura, old.LimiarHumidade, old.LimiarLuminosidade, old.DuraçãoPadrãoRonda, @UserMail ,@UserNomeC, @UserTipoC, now(), 'INSERT',DEFAULT);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Inserir_Sistema` AFTER INSERT ON `sistema` FOR EACH ROW BEGIN
	## Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserTipoC;
	SELECT NomeUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserNomeC;
    IF(@UserMail ='root') THEN 
        SELECT 'root' INTO @UserTipoC;
        SELECT 'root' INTO @UserNomeC;
    END IF;
	INSERT INTO logsistema VALUES ( DEFAULT, new.IDSistema, new.LimiteTemperatura, new.LimiteHumidade, new.LimiteLuminosidade, new.LimiarTemperatura, new.LimiarHumidade, new.LimiarLuminosidade, new.DuraçãoPadrãoRonda, @UserMail ,@UserNomeC, @UserTipoC, now(), 'INSERT',DEFAULT);
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
  `Password` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Extraindo dados da tabela `utilizador`
--

INSERT INTO `utilizador` (`EmailUtilizador`, `NomeUtilizador`, `TipoUtilizador`, `Password`) VALUES
('joao@joao.com', 'joao', 'SEG', 'password');

--
-- Acionadores `utilizador`
--
DELIMITER $$
CREATE TRIGGER `Atualizar_Utilizador` AFTER UPDATE ON `utilizador` FOR EACH ROW BEGIN
	## Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserTipo;
	SELECT NomeUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserNome;
    IF(@UserMail ='root') THEN 
        SELECT 'root' INTO @UserTipo;
        SELECT 'root' INTO @UserNome;
    END IF;
	INSERT INTO logutilizador VALUES ( DEFAULT, new.EmailUtilizador, new.NomeUtilizador, new.TipoUtilizador, @UserMail ,@UserNome, @UserTipo, now(), 'UPDATE',DEFAULT);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Eliminar_Utilizador` AFTER DELETE ON `utilizador` FOR EACH ROW BEGIN
	## Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserTipo;
	SELECT NomeUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserNome;
    IF(@UserMail ='root') THEN 
        SELECT 'root' INTO @UserTipo;
        SELECT 'root' INTO @UserNome;
    END IF;
	INSERT INTO logutilizador VALUES ( DEFAULT, old.EmailUtilizador, old.NomeUtilizador, old.TipoUtilizador, @UserMail ,@UserNome, @UserTipo, now(), 'DELETE',DEFAULT);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Inserir_Utilizador` AFTER INSERT ON `utilizador` FOR EACH ROW BEGIN
	## Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	SELECT TipoUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserTipo;
	SELECT NomeUtilizador from utilizador where EmailUtilizador = @UserMail INTO @UserNome;
    IF(@UserMail ='root') THEN 
        SELECT 'root' INTO @UserTipo;
        SELECT 'root' INTO @UserNome;
    END IF;
	INSERT INTO logutilizador VALUES ( DEFAULT, new.EmailUtilizador, new.NomeUtilizador, new.TipoUtilizador, @UserMail ,@UserNome, @UserTipo, now(), 'INSERT',DEFAULT);
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
  ADD PRIMARY KEY (`idalerta`),
  ADD KEY `IDMedicao` (`IDMedicao`);

--
-- Índices para tabela `cartao`
--
ALTER TABLE `cartao`
  ADD PRIMARY KEY (`idCartao`),
  ADD KEY `EmailUtilizador` (`EmailUtilizador`);

--
-- Índices para tabela `diasemana`
--
ALTER TABLE `diasemana`
  ADD PRIMARY KEY (`DiaSemana`,`HoraRonda`),
  ADD KEY `HoraRonda` (`HoraRonda`);

--
-- Índices para tabela `logalerta`
--
ALTER TABLE `logalerta`
  ADD PRIMARY KEY (`idlogAlerta`),
  ADD UNIQUE KEY `IDAlerta` (`IDAlerta`,`DataHoraAlerta`,`IDMedicao`,`DataHoraMedicao`,`Data`),
  ADD UNIQUE KEY `IDAlerta_2` (`IDAlerta`,`DataHoraAlerta`,`IDMedicao`,`DataHoraMedicao`,`Data`);

--
-- Índices para tabela `logcartao`
--
ALTER TABLE `logcartao`
  ADD PRIMARY KEY (`idlogCartao`);

--
-- Índices para tabela `logmedicaosensores`
--
ALTER TABLE `logmedicaosensores`
  ADD PRIMARY KEY (`idLogMedicao`),
  ADD UNIQUE KEY `IDmedicao` (`IDmedicao`,`Data`);

--
-- Índices para tabela `logronda`
--
ALTER TABLE `logronda`
  ADD PRIMARY KEY (`idlogRonda`),
  ADD UNIQUE KEY `Data` (`Data`);

--
-- Índices para tabela `logrondaextra`
--
ALTER TABLE `logrondaextra`
  ADD PRIMARY KEY (`idlogRondaExtra`),
  ADD UNIQUE KEY `DataHora` (`DataHora`,`Data`);

--
-- Índices para tabela `logsistema`
--
ALTER TABLE `logsistema`
  ADD PRIMARY KEY (`idlogSistema`),
  ADD UNIQUE KEY `IDSistema` (`IDSistema`,`Data`);

--
-- Índices para tabela `logutilizador`
--
ALTER TABLE `logutilizador`
  ADD PRIMARY KEY (`idlogUtilizador`);

--
-- Índices para tabela `medicaosensores`
--
ALTER TABLE `medicaosensores`
  ADD PRIMARY KEY (`idMedicao`);

--
-- Índices para tabela `rondaextra`
--
ALTER TABLE `rondaextra`
  ADD PRIMARY KEY (`dataHoraEntrada`),
  ADD KEY `EmailUtilizador` (`EmailUtilizador`);

--
-- Índices para tabela `ronda_planeada`
--
ALTER TABLE `ronda_planeada`
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
-- AUTO_INCREMENT de tabela `logalerta`
--
ALTER TABLE `logalerta`
  MODIFY `idlogAlerta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `logcartao`
--
ALTER TABLE `logcartao`
  MODIFY `idlogCartao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `logmedicaosensores`
--
ALTER TABLE `logmedicaosensores`
  MODIFY `idLogMedicao` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `logronda`
--
ALTER TABLE `logronda`
  MODIFY `idlogRonda` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `logrondaextra`
--
ALTER TABLE `logrondaextra`
  MODIFY `idlogRondaExtra` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `logsistema`
--
ALTER TABLE `logsistema`
  MODIFY `idlogSistema` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `logutilizador`
--
ALTER TABLE `logutilizador`
  MODIFY `idlogUtilizador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `alerta`
--
ALTER TABLE `alerta`
  ADD CONSTRAINT `alerta_ibfk_1` FOREIGN KEY (`IDMedicao`) REFERENCES `medicaosensores` (`idMedicao`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `cartao`
--
ALTER TABLE `cartao`
  ADD CONSTRAINT `cartao_ibfk_1` FOREIGN KEY (`EmailUtilizador`) REFERENCES `utilizador` (`EmailUtilizador`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `rondaextra`
--
ALTER TABLE `rondaextra`
  ADD CONSTRAINT `rondaextra_ibfk_1` FOREIGN KEY (`EmailUtilizador`) REFERENCES `utilizador` (`EmailUtilizador`);

--
-- Limitadores para a tabela `ronda_planeada`
--
ALTER TABLE `ronda_planeada`
  ADD CONSTRAINT `ronda_planeada_ibfk_1` FOREIGN KEY (`DiaSemana`) REFERENCES `diasemana` (`DiaSemana`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ronda_planeada_ibfk_2` FOREIGN KEY (`EmailUtilizador`) REFERENCES `utilizador` (`EmailUtilizador`) ON DELETE CASCADE,
  ADD CONSTRAINT `ronda_planeada_ibfk_3` FOREIGN KEY (`HoraRondaInicio`) REFERENCES `diasemana` (`HoraRonda`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
