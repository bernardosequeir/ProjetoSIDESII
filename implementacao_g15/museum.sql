-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 03-Abr-2020 às 17:43
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

INTO OUTFILE "C:/Users/joaof/Documents/GitHub/ProjetoSIDESII/implementacao_g15/origin_server/origin_export/ficheiro_exportacao.csv"
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

WHEN 'EXTRA' THEN 
	IF data_inicio IS NULL AND data_fim IS NOT NULL THEN SET data_inicio_SP = '1970-00-00 00:00:01' ; SET data_fim_SP = data_fim; ELSEIF
     data_fim IS NULL AND data_inicio IS NOT NULL  THEN  SET data_fim_SP = CURRENT_TIMESTAMP; SET data_inicio_SP = data_inicio; 
     ELSE  SET data_inicio_SP = data_inicio ; SET data_fim_SP = data_fim; END IF;
     SET numero_entradas_novo = (SELECT COUNT(*) FROM (SELECT 'logalerta',logalerta.idlogAlerta,logalerta.IDAlerta,logalerta.TipoAlerta,logalerta.DataHoraAlerta,logalerta.IDMedicao,logalerta.ValorMedicao,logalerta.TipoSensor,logalerta.DataHoraMedicao,logalerta.EmailUtilizadorConsultor,logalerta.NomeUtilizadorConsultor,logalerta.TipoUtilizadorConsultor,logalerta.Data,logalerta.Comando,logalerta.Resultado, ''  from logalerta WHERE data_fim_SP > logalerta.data AND data_inicio_SP < logalerta.data UNION SELECT 'logcartao',logcartao.idlogCartao, logcartao.idCartao, logcartao.Ativo, logcartao.EmailUtilizador, logcartao.NomeUtilizador, logcartao.TipoUtilizador, logcartao.EmailUtilizadorConsultor, logcartao.NomeUtilizadorConsultor, logcartao.TipoUtilizadorConsultor, logcartao.Data,logcartao.Comando,logcartao.Resultado, '','','' FROM logcartao WHERE data_fim_SP > logcartao.data AND data_inicio_SP < logcartao.data UNION SELECT 'logmedicaosensores',logmedicaosensores.idLogMedicao, logmedicaosensores.IDmedicao, logmedicaosensores.TipoSensor,logmedicaosensores.DataHoraMedicao,logmedicaosensores.EmailUtilizadorConsultor,logmedicaosensores.NomeUtilizadorConsultor,logmedicaosensores.TipoUtilizadorConsultor,logmedicaosensores.Data,logmedicaosensores.Comando, logmedicaosensores.Resultado, logmedicaosensores.PossivelAnomalia, '', '', '', '' FROM logmedicaosensores  WHERE data_fim_SP > logmedicaosensores.data AND data_inicio_SP < logmedicaosensores.data  UNION SELECT 'logronda', logronda.idlogRonda, logronda.DiaSemana, logronda.HoraRonda, logronda.Duracao, logronda.EmailUtilizador, logronda.NomeUtilizador, logronda.TipoUtilizador, logronda.EmailUtilizadorConsultor, logronda.NomeUtilizadorConsultor, logronda.TipoUtilizadorConsultor, logronda.Data, logronda.Comando, logronda.Resultado, '', '' from logronda  where data_fim_SP > logronda.data AND data_inicio_SP < logronda.data UNION SELECT 'logrondaextra',logrondaextra.idlogRondaExtra, logrondaextra.DataHora, logrondaextra.EmailUtilizador, logrondaextra.NomeUtilizador, logrondaextra.TipoUtilizador, logrondaextra.EmailUtilizadorConsultor, logrondaextra.NomeUtilizadorConsultor, logrondaextra.TipoUtilizadorConsultor, logrondaextra.Data, logrondaextra.Comando, logrondaextra.Resultado,'','','','' from logrondaextra  WHERE data_fim_SP > logrondaextra.data AND data_inicio_SP < logrondaextra.data UNION SELECT 'logsistema',logsistema.idlogSistema, logsistema.IDSistema, logsistema.LimiteTemperatura, logsistema.LimiteHumidade, logsistema.LimiteLuminosidade, logsistema.LimiarTemperatura, logsistema.LimiarHumidade, logsistema.LimiarLuminosidade, logsistema.DuracaoPadraoRonda, logsistema.EmailUtilizadorConsultor,logsistema.NomeUtilizadorConsultor, logsistema.TipoUtilizadorConsultor, logsistema.Data, logsistema.Comando, logsistema.Resultado from logsistema  WHERE data_fim_SP > logsistema.data AND data_inicio_SP < logsismtema.data UNION
SELECT 'logutilizador', logutilizador.idlogUtilizador, logutilizador.EmailUtilizadorConsultado, logutilizador.NomeUtilizadorConsultado, logutilizador.TipoUtilizadorConsultado, logutilizador.EmailUtilizadorConsultor, logutilizador.NomeUtilizadorConsultor, logutilizador.TipoUtilizadorConsultor, logutilizador.Data, logutilizador.Comando, logutilizador.Resultado, '' , '' ,'', '', ''  from logutilizador  WHERE data_fim_SP > logutilizador.data AND data_inicio_SP < logutilizador.data) AS numero_entradas_novo);
SET numero_entradas_total_novo = numero_entradas_novo + numero_entradas_total;

     SELECT 'logalerta',logalerta.idlogAlerta AS '',logalerta.IDAlerta,logalerta.TipoAlerta AS '',logalerta.DataHoraAlerta AS '',logalerta.IDMedicao  AS '',logalerta.ValorMedicao AS '',logalerta.TipoSensor AS '',logalerta.DataHoraMedicao AS '',logalerta.EmailUtilizadorConsultor AS '',logalerta.NomeUtilizadorConsultor AS '',logalerta.TipoUtilizadorConsultor AS '',logalerta.Data AS '',logalerta.Comando AS '',logalerta.Resultado AS '', ''  from logalerta WHERE data_fim_SP > logalerta.data AND data_inicio_SP < logalerta.data UNION SELECT 'logcartao',logcartao.idlogCartao AS '', logcartao.idCartao AS '', logcartao.Ativo AS '', logcartao.EmailUtilizador AS '', logcartao.NomeUtilizador AS '', logcartao.TipoUtilizador AS '', logcartao.EmailUtilizadorConsultor AS '', logcartao.NomeUtilizadorConsultor AS '', logcartao.TipoUtilizadorConsultor AS '', logcartao.Data AS '',logcartao.Comando AS '',logcartao.Resultado AS '', '','','' FROM logcartao WHERE data_fim_SP > logcartao.data AND data_inicio_SP < logcartao.data UNION SELECT 'logmedicaosensores',logmedicaosensores.idLogMedicao AS '', logmedicaosensores.IDmedicao AS '', logmedicaosensores.TipoSensor AS '',logmedicaosensores.DataHoraMedicao AS '',logmedicaosensores.EmailUtilizadorConsultor AS '',logmedicaosensores.NomeUtilizadorConsultor AS '',logmedicaosensores.TipoUtilizadorConsultor AS '',logmedicaosensores.Data AS '',logmedicaosensores.Comando AS '', logmedicaosensores.Resultado AS '', logmedicaosensores.PossivelAnomalia AS '', '', '', '', '' FROM logmedicaosensores  WHERE data_fim_SP > logmedicaosensores.data AND data_inicio_SP < logmedicaosensores.data UNION SELECT 'logronda', logronda.idlogRonda AS '', logronda.DiaSemana AS '', logronda.HoraRonda AS '', logronda.Duracao AS '', logronda.EmailUtilizador AS '', logronda.NomeUtilizador AS '', logronda.TipoUtilizador AS '', logronda.EmailUtilizadorConsultor AS '', logronda.NomeUtilizadorConsultor AS '', logronda.TipoUtilizadorConsultor AS '', logronda.Data AS '', logronda.Comando AS '', logronda.Resultado, '', '' from logronda  WHERE data_fim_SP > logronda.data AND data_inicio_SP < logronda.data UNION SELECT 'logrondaextra',logrondaextra.idlogRondaExtra AS '', logrondaextra.DataHora AS '', logrondaextra.EmailUtilizador AS '', logrondaextra.NomeUtilizador AS '', logrondaextra.TipoUtilizador AS '', logrondaextra.EmailUtilizadorConsultor AS '', logrondaextra.NomeUtilizadorConsultor AS '', logrondaextra.TipoUtilizadorConsultor AS '', logrondaextra.Data AS '', logrondaextra.Comando AS '', logrondaextra.Resultado AS '','','','',''  from logrondaextra  WHERE data_fim_SP > logrondaextra.data AND data_inicio_SP < logrondaextra.data UNION SELECT 'logsistema',logsistema.idlogSistema AS '', logsistema.IDSistema AS '', logsistema.LimiteTemperatura AS '', logsistema.LimiteHumidade AS '', logsistema.LimiteLuminosidade AS '', logsistema.LimiarTemperatura AS '', logsistema.LimiarHumidade AS '', logsistema.LimiarLuminosidade AS '', logsistema.DuracaoPadraoRonda AS '', logsistema.EmailUtilizadorConsultor AS '',logsistema.NomeUtilizadorConsultor AS '', logsistema.TipoUtilizadorConsultor AS '', logsistema.Data AS '', logsistema.Comando AS '', logsistema.Resultado AS '' from logsistema  WHERE data_fim_SP > logsistema.data AND data_inicio_SP < logsismtema.data UNION
SELECT 'logutilizador', logutilizador.idlogUtilizador AS '', logutilizador.EmailUtilizadorConsultado AS '', logutilizador.NomeUtilizadorConsultado AS '', logutilizador.TipoUtilizadorConsultado AS '', logutilizador.EmailUtilizadorConsultor AS '', logutilizador.NomeUtilizadorConsultor AS '', logutilizador.TipoUtilizadorConsultor AS '', logutilizador.Data AS '', logutilizador.Comando AS '', logutilizador.Resultado AS '', '' , '' ,'', '', '' from logutilizador  WHERE data_fim_SP > logutilizador.data AND data_inicio_SP < logutilizador.data UNION SELECT id_novo ,agendada_extra,agora,ficheiro,numero_entradas_total_novo, numero_entradas_novo,'','','','','','','','','',''
INTO OUTFILE "C:/Users/joaof/Documents/GitHub/ProjetoSIDESII/implementacao_g15/origin_server/origin_export/ficheiro_exportacao.csv"
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

WHEN 'NOK' THEN 
		SET numero_entradas_novo = (SELECT COUNT(*) FROM (SELECT 'logalerta',logalerta.idlogAlerta,logalerta.IDAlerta,logalerta.TipoAlerta,logalerta.DataHoraAlerta,logalerta.IDMedicao,logalerta.ValorMedicao,logalerta.TipoSensor,logalerta.DataHoraMedicao,logalerta.EmailUtilizadorConsultor,logalerta.NomeUtilizadorConsultor,logalerta.TipoUtilizadorConsultor,logalerta.Data,logalerta.Comando,logalerta.Resultado, ''  from logalerta WHERE data_inicio < logalerta.data UNION SELECT 'logcartao',logcartao.idlogCartao, logcartao.idCartao, logcartao.Ativo, logcartao.EmailUtilizador, logcartao.NomeUtilizador, logcartao.TipoUtilizador, logcartao.EmailUtilizadorConsultor, logcartao.NomeUtilizadorConsultor, logcartao.TipoUtilizadorConsultor, logcartao.Data,logcartao.Comando,logcartao.Resultado, '','','' FROM logcartao WHERE data_inicio < logcartao.data UNION SELECT 'logmedicaosensores',logmedicaosensores.idLogMedicao, logmedicaosensores.IDmedicao, logmedicaosensores.TipoSensor,logmedicaosensores.DataHoraMedicao,logmedicaosensores.EmailUtilizadorConsultor,logmedicaosensores.NomeUtilizadorConsultor,logmedicaosensores.TipoUtilizadorConsultor,logmedicaosensores.Data,logmedicaosensores.Comando, logmedicaosensores.Resultado, logmedicaosensores.PossivelAnomalia, '', '', '', '' FROM logmedicaosensores  WHERE data_inicio < logmedicaosensores.data UNION SELECT 'logronda', logronda.idlogRonda, logronda.DiaSemana, logronda.HoraRonda, logronda.Duracao, logronda.EmailUtilizador, logronda.NomeUtilizador, logronda.TipoUtilizador, logronda.EmailUtilizadorConsultor, logronda.NomeUtilizadorConsultor, logronda.TipoUtilizadorConsultor, logronda.Data, logronda.Comando, logronda.Resultado, '', '' from logronda  WHERE data_inicio < logronda.data UNION SELECT 'logrondaextra',logrondaextra.idlogRondaExtra, logrondaextra.DataHora, logrondaextra.EmailUtilizador, logrondaextra.NomeUtilizador, logrondaextra.TipoUtilizador, logrondaextra.EmailUtilizadorConsultor, logrondaextra.NomeUtilizadorConsultor, logrondaextra.TipoUtilizadorConsultor, logrondaextra.Data, logrondaextra.Comando, logrondaextra.Resultado,'','','','' from logrondaextra  WHERE data_inicio < logrondaextra.data UNION SELECT 'logsistema',logsistema.idlogSistema, logsistema.IDSistema, logsistema.LimiteTemperatura, logsistema.LimiteHumidade, logsistema.LimiteLuminosidade, logsistema.LimiarTemperatura, logsistema.LimiarHumidade, logsistema.LimiarLuminosidade, logsistema.DuracaoPadraoRonda, logsistema.EmailUtilizadorConsultor,logsistema.NomeUtilizadorConsultor, logsistema.TipoUtilizadorConsultor, logsistema.Data, logsistema.Comando, logsistema.Resultado from logsistema  WHERE data_inicio < logsistema.data UNION
SELECT 'logutilizador', logutilizador.idlogUtilizador, logutilizador.EmailUtilizadorConsultado, logutilizador.NomeUtilizadorConsultado, logutilizador.TipoUtilizadorConsultado, logutilizador.EmailUtilizadorConsultor, logutilizador.NomeUtilizadorConsultor, logutilizador.TipoUtilizadorConsultor, logutilizador.Data, logutilizador.Comando, logutilizador.Resultado, '' , '' ,'', '', ''  from logutilizador  WHERE data_inicio < logutilizador.data) AS numero_entradas_novo);
SET numero_entradas_total_novo = numero_entradas_novo + numero_entradas_total;
     SELECT 'logalerta',logalerta.idlogAlerta AS '',logalerta.IDAlerta,logalerta.TipoAlerta AS '',logalerta.DataHoraAlerta AS '',logalerta.IDMedicao  AS '',logalerta.ValorMedicao AS '',logalerta.TipoSensor AS '',logalerta.DataHoraMedicao AS '',logalerta.EmailUtilizadorConsultor AS '',logalerta.NomeUtilizadorConsultor AS '',logalerta.TipoUtilizadorConsultor AS '',logalerta.Data AS '',logalerta.Comando AS '',logalerta.Resultado AS '', '' from logalerta  WHERE data_inicio < logalerta.data UNION SELECT 'logcartao',logcartao.idlogCartao AS '', logcartao.idCartao AS '', logcartao.Ativo AS '', logcartao.EmailUtilizador AS '', logcartao.NomeUtilizador AS '', logcartao.TipoUtilizador AS '', logcartao.EmailUtilizadorConsultor AS '', logcartao.NomeUtilizadorConsultor AS '', logcartao.TipoUtilizadorConsultor AS '', logcartao.Data AS '',logcartao.Comando AS '',logcartao.Resultado AS '', '','','' FROM logcartao WHERE data_inicio < logcartao.data UNION SELECT 'logmedicaosensores',logmedicaosensores.idLogMedicao AS '', logmedicaosensores.IDmedicao AS '', logmedicaosensores.TipoSensor AS '',logmedicaosensores.DataHoraMedicao AS '',logmedicaosensores.EmailUtilizadorConsultor AS '',logmedicaosensores.NomeUtilizadorConsultor AS '',logmedicaosensores.TipoUtilizadorConsultor AS '',logmedicaosensores.Data AS '',logmedicaosensores.Comando AS '', logmedicaosensores.Resultado AS '', logmedicaosensores.PossivelAnomalia AS '', '', '', '', '' FROM logmedicaosensores  WHERE data_inicio < logmedicaosensores.data UNION SELECT 'logronda', logronda.idlogRonda AS '', logronda.DiaSemana AS '', logronda.HoraRonda AS '', logronda.Duracao AS '', logronda.EmailUtilizador AS '', logronda.NomeUtilizador AS '', logronda.TipoUtilizador AS '', logronda.EmailUtilizadorConsultor AS '', logronda.NomeUtilizadorConsultor AS '', logronda.TipoUtilizadorConsultor AS '', logronda.Data AS '', logronda.Comando AS '', logronda.Resultado, '', '' from logronda  WHERE data_inicio < logronda.data UNION SELECT 'logrondaextra',logrondaextra.idlogRondaExtra AS '', logrondaextra.DataHora AS '', logrondaextra.EmailUtilizador AS '', logrondaextra.NomeUtilizador AS '', logrondaextra.TipoUtilizador AS '', logrondaextra.EmailUtilizadorConsultor AS '', logrondaextra.NomeUtilizadorConsultor AS '', logrondaextra.TipoUtilizadorConsultor AS '', logrondaextra.Data AS '', logrondaextra.Comando AS '', logrondaextra.Resultado AS '','','','',''  from logrondaextra  WHERE data_inicio < logrondaextra.data UNION SELECT 'logsistema',logsistema.idlogSistema AS '', logsistema.IDSistema AS '', logsistema.LimiteTemperatura AS '', logsistema.LimiteHumidade AS '', logsistema.LimiteLuminosidade AS '', logsistema.LimiarTemperatura AS '', logsistema.LimiarHumidade AS '', logsistema.LimiarLuminosidade AS '', logsistema.DuracaoPadraoRonda AS '', logsistema.EmailUtilizadorConsultor AS '',logsistema.NomeUtilizadorConsultor AS '', logsistema.TipoUtilizadorConsultor AS '', logsistema.Data AS '', logsistema.Comando AS '', logsistema.Resultado AS '' from logsistema  WHERE data_inicio < logsistema.data UNION
SELECT 'logutilizador', logutilizador.idlogUtilizador AS '', logutilizador.EmailUtilizadorConsultado AS '', logutilizador.NomeUtilizadorConsultado AS '', logutilizador.TipoUtilizadorConsultado AS '', logutilizador.EmailUtilizadorConsultor AS '', logutilizador.NomeUtilizadorConsultor AS '', logutilizador.TipoUtilizadorConsultor AS '', logutilizador.Data AS '', logutilizador.Comando AS '', logutilizador.Resultado AS '', '' , '' ,'', '', '' from logutilizador  WHERE data_inicio < logutilizador.data UNION SELECT id_novo ,agendada_extra,agora,ficheiro,numero_entradas_total_novo, numero_entradas_novo,'','','','','','','','','',''
INTO OUTFILE "C:/Users/joaof/Documents/GitHub/ProjetoSIDESII/implementacao_g15/origin_server/origin_export/ficheiro_exportacao.csv"
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

END CASE;


	



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

-- --------------------------------------------------------

--
-- Estrutura da tabela `cartao`
--

CREATE TABLE `cartao` (
  `idCartao` varchar(20) NOT NULL,
  `EmailUtilizador` varchar(100) NOT NULL,
  `Ativo` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
(1, 'joaofran@go.com', 'Joao Pinto', 'cf', 'iscop@csjip.com', 'ijcios', 'wew', '2020-03-24 18:47:49', 'acad', 'huihui');

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

-- --------------------------------------------------------

--
-- Estrutura da tabela `rondaextra`
--

CREATE TABLE `rondaextra` (
  `dataHoraEntrada` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `EmailUtilizador` varchar(100) NOT NULL,
  `datahoraSaida` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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

-- --------------------------------------------------------

--
-- Estrutura da tabela `ultima_migracao`
--

CREATE TABLE `ultima_migracao` (
  `data` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  ADD PRIMARY KEY (`idlogUtilizador`),
  ADD UNIQUE KEY `Data` (`Data`);

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
