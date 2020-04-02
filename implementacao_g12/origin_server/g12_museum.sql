-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 02-Abr-2020 às 20:27
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
DECLARE temp int;
DECLARE temp2 varchar(50);



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
SELECT numero_entradas_novo, numero_entradas_total;
SET numero_entradas_total_novo = numero_entradas_novo + numero_entradas_total;
SELECT numero_entradas_total_novo;
SELECT numero_entradas_total_novo INTO temp;
SELECT 'logalerta',logalerta.idlogAlerta AS '',logalerta.IDAlerta,logalerta.TipoAlerta AS '',logalerta.DataHoraAlerta AS '',logalerta.IDMedicao  AS '',logalerta.ValorMedicao AS '',logalerta.TipoSensor AS '',logalerta.DataHoraMedicao AS '',logalerta.EmailUtilizadorConsultor AS '',logalerta.NomeUtilizadorConsultor AS '',logalerta.TipoUtilizadorConsultor AS '',logalerta.Data AS '',logalerta.Comando AS '',logalerta.Resultado AS '', ''  from logalerta WHERE data < logalerta.data UNION SELECT 'logcartao',logcartao.idlogCartao AS '', logcartao.idCartao AS '', logcartao.Ativo AS '', logcartao.EmailUtilizador AS '', logcartao.NomeUtilizador AS '', logcartao.TipoUtilizador AS '', logcartao.EmailUtilizadorConsultor AS '', logcartao.NomeUtilizadorConsultor AS '', logcartao.TipoUtilizadorConsultor AS '', logcartao.Data AS '',logcartao.Comando AS '',logcartao.Resultado AS '', '','','' FROM logcartao WHERE data < logcartao.data UNION SELECT 'logmedicaosensores',logmedicaosensores.idLogMedicao AS '', logmedicaosensores.IDmedicao AS '', logmedicaosensores.TipoSensor AS '',logmedicaosensores.DataHoraMedicao AS '',logmedicaosensores.EmailUtilizadorConsultor AS '',logmedicaosensores.NomeUtilizadorConsultor AS '',logmedicaosensores.TipoUtilizadorConsultor AS '',logmedicaosensores.Data AS '',logmedicaosensores.Comando AS '', logmedicaosensores.Resultado AS '', logmedicaosensores.PossivelAnomalia AS '', '', '', '', '' FROM logmedicaosensores  WHERE data < logmedicaosensores.data UNION SELECT 'logronda', logronda.idlogRonda AS '', logronda.DiaSemana AS '', logronda.HoraRonda AS '', logronda.Duracao AS '', logronda.EmailUtilizador AS '', logronda.NomeUtilizador AS '', logronda.TipoUtilizador AS '', logronda.EmailUtilizadorConsultor AS '', logronda.NomeUtilizadorConsultor AS '', logronda.TipoUtilizadorConsultor AS '', logronda.Data AS '', logronda.Comando AS '', logronda.Resultado, '', '' from logronda  WHERE data < logronda.data UNION SELECT 'logrondaextra',logrondaextra.idlogRondaExtra AS '', logrondaextra.DataHora AS '', logrondaextra.EmailUtilizador AS '', logrondaextra.NomeUtilizador AS '', logrondaextra.TipoUtilizador AS '', logrondaextra.EmailUtilizadorConsultor AS '', logrondaextra.NomeUtilizadorConsultor AS '', logrondaextra.TipoUtilizadorConsultor AS '', logrondaextra.Data AS '', logrondaextra.Comando AS '', logrondaextra.Resultado AS '','','','',''  from logrondaextra  WHERE data < logrondaextra.data UNION SELECT 'logsistema',logsistema.idlogSistema AS '', logsistema.IDSistema AS '', logsistema.LimiteTemperatura AS '', logsistema.LimiteHumidade AS '', logsistema.LimiteLuminosidade AS '', logsistema.LimiarTemperatura AS '', logsistema.LimiarHumidade AS '', logsistema.LimiarLuminosidade AS '', logsistema.DuracaoPadraoRonda AS '', logsistema.EmailUtilizadorConsultor AS '',logsistema.NomeUtilizadorConsultor AS '', logsistema.TipoUtilizadorConsultor AS '', logsistema.Data AS '', logsistema.Comando AS '', logsistema.Resultado AS '' from logsistema  WHERE data < logsistema.data UNION
SELECT 'logutilizador', logutilizador.idlogUtilizador AS '', logutilizador.EmailUtilizadorConsultado AS '', logutilizador.NomeUtilizadorConsultado AS '', logutilizador.TipoUtilizadorConsultado AS '', logutilizador.EmailUtilizadorConsultor AS '', logutilizador.NomeUtilizadorConsultor AS '', logutilizador.TipoUtilizadorConsultor AS '', logutilizador.Data AS '', logutilizador.Comando AS '', logutilizador.Resultado AS '', '' , '' ,'', '', ''  from logutilizador  WHERE data < logutilizador.data 
UNION SELECT id_novo ,agendada_extra,agora,ficheiro,numero_entradas_total_novo, '','','','','','','','','','','' 

INTO OUTFILE "C:/Users/joaof/Documents/GitHub/ProjetoSIDESII/implementacao_g15/origin_server/origin_export/ficheiro_exportacao.csv"
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

WHEN 'EXTRA' THEN 
	IF data_inicio IS NULL AND data_fim IS NOT NULL THEN SET data_inicio_SP = '2013-07-22 12:50:05' ; SET data_fim_SP = data_fim; ELSEIF
     data_fim IS NULL AND data_inicio IS NOT NULL  THEN  SET data_fim_SP = CURRENT_TIMESTAMP; SET data_inicio_SP = data_inicio; 
     ELSE  SET data_inicio_SP = data_inicio ; SET data_fim_SP = data_fim; END IF;
     SELECT 'logalerta',logalerta.idlogAlerta AS '',logalerta.IDAlerta,logalerta.TipoAlerta AS '',logalerta.DataHoraAlerta AS '',logalerta.IDMedicao  AS '',logalerta.ValorMedicao AS '',logalerta.TipoSensor AS '',logalerta.DataHoraMedicao AS '',logalerta.EmailUtilizadorConsultor AS '',logalerta.NomeUtilizadorConsultor AS '',logalerta.TipoUtilizadorConsultor AS '',logalerta.Data AS '',logalerta.Comando AS '',logalerta.Resultado AS '', ''  from logalerta WHERE data_fim_SP > logalerta.data AND data_inicio_SP < logalerta.data UNION SELECT 'logcartao',logcartao.idlogCartao AS '', logcartao.idCartao AS '', logcartao.Ativo AS '', logcartao.EmailUtilizador AS '', logcartao.NomeUtilizador AS '', logcartao.TipoUtilizador AS '', logcartao.EmailUtilizadorConsultor AS '', logcartao.NomeUtilizadorConsultor AS '', logcartao.TipoUtilizadorConsultor AS '', logcartao.Data AS '',logcartao.Comando AS '',logcartao.Resultado AS '', '','','' FROM logcartao WHERE data_fim_SP > logcartao.data AND data_inicio_SP < logcartao.data UNION SELECT 'logmedicaosensores',logmedicaosensores.idLogMedicao AS '', logmedicaosensores.IDmedicao AS '', logmedicaosensores.TipoSensor AS '',logmedicaosensores.DataHoraMedicao AS '',logmedicaosensores.EmailUtilizadorConsultor AS '',logmedicaosensores.NomeUtilizadorConsultor AS '',logmedicaosensores.TipoUtilizadorConsultor AS '',logmedicaosensores.Data AS '',logmedicaosensores.Comando AS '', logmedicaosensores.Resultado AS '', logmedicaosensores.PossivelAnomalia AS '', '', '', '', '' FROM logmedicaosensores  WHERE data_fim_SP > logmedicaosensores.data AND data_inicio_SP < logmedicaosensores.data UNION SELECT 'logronda', logronda.idlogRonda AS '', logronda.DiaSemana AS '', logronda.HoraRonda AS '', logronda.Duracao AS '', logronda.EmailUtilizador AS '', logronda.NomeUtilizador AS '', logronda.TipoUtilizador AS '', logronda.EmailUtilizadorConsultor AS '', logronda.NomeUtilizadorConsultor AS '', logronda.TipoUtilizadorConsultor AS '', logronda.Data AS '', logronda.Comando AS '', logronda.Resultado, '', '' from logronda  WHERE data_fim_SP > logronda.data AND data_inicio_SP < logronda.data UNION SELECT 'logrondaextra',logrondaextra.idlogRondaExtra AS '', logrondaextra.DataHora AS '', logrondaextra.EmailUtilizador AS '', logrondaextra.NomeUtilizador AS '', logrondaextra.TipoUtilizador AS '', logrondaextra.EmailUtilizadorConsultor AS '', logrondaextra.NomeUtilizadorConsultor AS '', logrondaextra.TipoUtilizadorConsultor AS '', logrondaextra.Data AS '', logrondaextra.Comando AS '', logrondaextra.Resultado AS '','','','',''  from logrondaextra  WHERE data_fim_SP > logrondaextra.data AND data_inicio_SP < logrondaextra.data UNION SELECT 'logsistema',logsistema.idlogSistema AS '', logsistema.IDSistema AS '', logsistema.LimiteTemperatura AS '', logsistema.LimiteHumidade AS '', logsistema.LimiteLuminosidade AS '', logsistema.LimiarTemperatura AS '', logsistema.LimiarHumidade AS '', logsistema.LimiarLuminosidade AS '', logsistema.DuracaoPadraoRonda AS '', logsistema.EmailUtilizadorConsultor AS '',logsistema.NomeUtilizadorConsultor AS '', logsistema.TipoUtilizadorConsultor AS '', logsistema.Data AS '', logsistema.Comando AS '', logsistema.Resultado AS '' from logsistema  WHERE data_fim_SP > logsistema.data AND data_inicio_SP < logsismtema.data UNION
SELECT 'logutilizador', logutilizador.idlogUtilizador AS '', logutilizador.EmailUtilizadorConsultado AS '', logutilizador.NomeUtilizadorConsultado AS '', logutilizador.TipoUtilizadorConsultado AS '', logutilizador.EmailUtilizadorConsultor AS '', logutilizador.NomeUtilizadorConsultor AS '', logutilizador.TipoUtilizadorConsultor AS '', logutilizador.Data AS '', logutilizador.Comando AS '', logutilizador.Resultado AS '', '' , '' ,'', '', '' from logutilizador  WHERE data_fim_SP > logutilizador.data AND data_inicio_SP < logutilizador.data UNION SELECT id_novo ,agendada_extra,agora,ficheiro,temp2, '','','','','','','','','','','' 
INTO OUTFILE "C:/Users/joaof/Documents/GitHub/ProjetoSIDESII/implementacao_g15/origin_server/origin_export/ficheiro_exportacao.csv"
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
WHEN 'NOK' THEN 
		
     SELECT 'logalerta',logalerta.idlogAlerta AS '',logalerta.IDAlerta,logalerta.TipoAlerta AS '',logalerta.DataHoraAlerta AS '',logalerta.IDMedicao  AS '',logalerta.ValorMedicao AS '',logalerta.TipoSensor AS '',logalerta.DataHoraMedicao AS '',logalerta.EmailUtilizadorConsultor AS '',logalerta.NomeUtilizadorConsultor AS '',logalerta.TipoUtilizadorConsultor AS '',logalerta.Data AS '',logalerta.Comando AS '',logalerta.Resultado AS '', '' from logalerta  WHERE data_inicio < logalerta.data UNION SELECT 'logcartao',logcartao.idlogCartao AS '', logcartao.idCartao AS '', logcartao.Ativo AS '', logcartao.EmailUtilizador AS '', logcartao.NomeUtilizador AS '', logcartao.TipoUtilizador AS '', logcartao.EmailUtilizadorConsultor AS '', logcartao.NomeUtilizadorConsultor AS '', logcartao.TipoUtilizadorConsultor AS '', logcartao.Data AS '',logcartao.Comando AS '',logcartao.Resultado AS '', '','','' FROM logcartao WHERE data_inicio < logcartao.data UNION SELECT 'logmedicaosensores',logmedicaosensores.idLogMedicao AS '', logmedicaosensores.IDmedicao AS '', logmedicaosensores.TipoSensor AS '',logmedicaosensores.DataHoraMedicao AS '',logmedicaosensores.EmailUtilizadorConsultor AS '',logmedicaosensores.NomeUtilizadorConsultor AS '',logmedicaosensores.TipoUtilizadorConsultor AS '',logmedicaosensores.Data AS '',logmedicaosensores.Comando AS '', logmedicaosensores.Resultado AS '', logmedicaosensores.PossivelAnomalia AS '', '', '', '', '' FROM logmedicaosensores  WHERE data_inicio < logmedicaosensores.data UNION SELECT 'logronda', logronda.idlogRonda AS '', logronda.DiaSemana AS '', logronda.HoraRonda AS '', logronda.Duracao AS '', logronda.EmailUtilizador AS '', logronda.NomeUtilizador AS '', logronda.TipoUtilizador AS '', logronda.EmailUtilizadorConsultor AS '', logronda.NomeUtilizadorConsultor AS '', logronda.TipoUtilizadorConsultor AS '', logronda.Data AS '', logronda.Comando AS '', logronda.Resultado, '', '' from logronda  WHERE data_inicio < logronda.data UNION SELECT 'logrondaextra',logrondaextra.idlogRondaExtra AS '', logrondaextra.DataHora AS '', logrondaextra.EmailUtilizador AS '', logrondaextra.NomeUtilizador AS '', logrondaextra.TipoUtilizador AS '', logrondaextra.EmailUtilizadorConsultor AS '', logrondaextra.NomeUtilizadorConsultor AS '', logrondaextra.TipoUtilizadorConsultor AS '', logrondaextra.Data AS '', logrondaextra.Comando AS '', logrondaextra.Resultado AS '','','','',''  from logrondaextra  WHERE data_inicio < logrondaextra.data UNION SELECT 'logsistema',logsistema.idlogSistema AS '', logsistema.IDSistema AS '', logsistema.LimiteTemperatura AS '', logsistema.LimiteHumidade AS '', logsistema.LimiteLuminosidade AS '', logsistema.LimiarTemperatura AS '', logsistema.LimiarHumidade AS '', logsistema.LimiarLuminosidade AS '', logsistema.DuracaoPadraoRonda AS '', logsistema.EmailUtilizadorConsultor AS '',logsistema.NomeUtilizadorConsultor AS '', logsistema.TipoUtilizadorConsultor AS '', logsistema.Data AS '', logsistema.Comando AS '', logsistema.Resultado AS '' from logsistema  WHERE data_inicio < logsistema.data UNION
SELECT 'logutilizador', logutilizador.idlogUtilizador AS '', logutilizador.EmailUtilizadorConsultado AS '', logutilizador.NomeUtilizadorConsultado AS '', logutilizador.TipoUtilizadorConsultado AS '', logutilizador.EmailUtilizadorConsultor AS '', logutilizador.NomeUtilizadorConsultor AS '', logutilizador.TipoUtilizadorConsultor AS '', logutilizador.Data AS '', logutilizador.Comando AS '', logutilizador.Resultado AS '', '' , '' ,'', '', '' from logutilizador  WHERE data_inicio < logutilizador.data UNION SELECT id_novo ,agendada_extra,agora,ficheiro,temp2, '','','','','','','','','','','' 
INTO OUTFILE "C:/Users/joaof/Documents/GitHub/ProjetoSIDESII/implementacao_g15/origin_server/origin_export/ficheiro_exportacao.csv"
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';

ELSE SELECT 'ERROR'
INTO OUTFILE "C:/Users/joaof/Documents/GitHub/ProjetoSIDESII/implementacao_g15/origin_server/origin_export/ficheiro_exportacao.csv"
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';
END CASE;


	



END$$

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
-- Estrutura da tabela `g12_logdiasemana`
--

CREATE TABLE `g12_logdiasemana` (
  `id` int(11) NOT NULL,
  `User` varchar(100) NOT NULL,
  `Operacao` varchar(10) NOT NULL,
  `Time` time NOT NULL,
  `DiaSemana` varchar(20) NOT NULL,
  `HoraRonda` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `g12_logdiasemana`
--

INSERT INTO `g12_logdiasemana` (`id`, `User`, `Operacao`, `Time`, `DiaSemana`, `HoraRonda`) VALUES
(1, 'user_teste', 'DELETE', '00:00:00', 'terca', '12:00:00'),
(2, 'user_teste', 'UPDATE', '00:00:00', 'terca', '13:00:00'),
(3, 'user_teste', 'INSER', '00:00:00', 'terca', '14:00:00'),
(4, 'user_teste', 'DELETE', '00:00:00', 'terca', '15:00:00'),
(5, 'user_teste', 'UPDATE', '00:00:00', 'terca', '16:00:00'),
(6, 'user_teste', 'INSER', '00:00:00', 'terca', '17:00:00'),
(7, 'user_teste', 'DELETE', '00:00:00', 'terca', '18:00:00'),
(8, 'user_teste', 'UPDATE', '00:00:00', 'terca', '19:00:00'),
(9, 'user_teste', 'INSER', '00:00:00', 'terca', '20:00:00'),
(10, 'user_teste', 'DELETE', '00:00:00', 'terca', '21:00:00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `g12_logmedicaosensores`
--

CREATE TABLE `g12_logmedicaosensores` (
  `id` int(11) NOT NULL,
  `User` varchar(100) NOT NULL,
  `Operacao` varchar(10) NOT NULL,
  `Time` time NOT NULL,
  `ValorMedicao` decimal(6,2) NOT NULL,
  `TipoDeSensor` varchar(3) NOT NULL,
  `DataHoraMedicao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `PossivelAnomalia` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `g12_logmedicaosensores`
--

INSERT INTO `g12_logmedicaosensores` (`id`, `User`, `Operacao`, `Time`, `ValorMedicao`, `TipoDeSensor`, `DataHoraMedicao`, `PossivelAnomalia`) VALUES
(1, 'user_teste', 'DELETE', '00:00:00', '1.00', 'tip', '0000-00-00 00:00:00', 'no'),
(2, 'user_teste', 'UPDATE', '00:00:00', '2.00', 'tip', '0000-00-00 00:00:00', 'no'),
(3, 'user_teste', 'INSERT', '00:00:00', '3.00', 'tip', '0000-00-00 00:00:00', 'no'),
(4, 'user_teste', 'DELETE', '00:00:00', '4.00', 'tip', '0000-00-00 00:00:00', 'no'),
(5, 'user_teste', 'UPDATE', '00:00:00', '5.00', 'tip', '0000-00-00 00:00:00', 'no'),
(6, 'user_teste', 'INSERT', '00:00:00', '6.00', 'tip', '0000-00-00 00:00:00', 'no'),
(7, 'user_teste', 'DELETE', '00:00:00', '7.00', 'tip', '0000-00-00 00:00:00', 'no'),
(8, 'user_teste', 'UPDATE', '00:00:00', '8.00', 'tip', '0000-00-00 00:00:00', 'no'),
(9, 'user_teste', 'INSERT', '00:00:00', '9.00', 'tip', '0000-00-00 00:00:00', 'no'),
(10, 'user_teste', 'DELETE', '00:00:00', '10.00', 'tip', '0000-00-00 00:00:00', 'no');

-- --------------------------------------------------------

--
-- Estrutura da tabela `g12_logrondaextra`
--

CREATE TABLE `g12_logrondaextra` (
  `id` int(11) NOT NULL,
  `User` varchar(100) NOT NULL,
  `Operacao` varchar(10) NOT NULL,
  `Time` time NOT NULL,
  `DataHora` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `g12_logrondaextra`
--

INSERT INTO `g12_logrondaextra` (`id`, `User`, `Operacao`, `Time`, `DataHora`) VALUES
(1, 'user_teste', 'DELETE', '00:00:00', '0000-00-00 00:00:00'),
(2, 'user_teste', 'UPDATE', '00:00:00', '0000-00-00 00:00:00'),
(3, 'user_teste', 'INSERT', '00:00:00', '0000-00-00 00:00:00'),
(4, 'user_teste', 'DELETE', '00:00:00', '0000-00-00 00:00:00'),
(5, 'user_teste', 'UPDATE', '00:00:00', '0000-00-00 00:00:00'),
(6, 'user_teste', 'INSERT', '00:00:00', '0000-00-00 00:00:00'),
(7, 'user_teste', 'DELETE', '00:00:00', '0000-00-00 00:00:00'),
(8, 'user_teste', 'UPDATE', '00:00:00', '0000-00-00 00:00:00'),
(9, 'user_teste', 'INSERT', '00:00:00', '0000-00-00 00:00:00'),
(10, 'user_teste', 'DELETE', '00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `g12_logsistema`
--

CREATE TABLE `g12_logsistema` (
  `id` int(11) NOT NULL,
  `User` varchar(100) NOT NULL,
  `Operacao` varchar(10) NOT NULL,
  `Time` time NOT NULL,
  `LimiteTemperatura` decimal(6,2) DEFAULT NULL,
  `LimiteHumidade` decimal(6,2) DEFAULT NULL,
  `LimiteLuminosidade` decimal(6,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `g12_logsistema`
--

INSERT INTO `g12_logsistema` (`id`, `User`, `Operacao`, `Time`, `LimiteTemperatura`, `LimiteHumidade`, `LimiteLuminosidade`) VALUES
(1, 'user_teste', 'DELETE', '00:00:00', '40.00', '20.00', '100.00'),
(2, 'user_teste', 'UPDATE', '00:00:00', '40.00', '20.00', '100.00'),
(3, 'user_teste', 'INSERT', '00:00:00', '40.00', '20.00', '100.00'),
(4, 'user_teste', 'DELETE', '00:00:00', '40.00', '20.00', '100.00'),
(5, 'user_teste', 'UPDATE', '00:00:00', '40.00', '20.00', '100.00'),
(6, 'user_teste', 'INSERT', '00:00:00', '40.00', '20.00', '100.00'),
(7, 'user_teste', 'DELETE', '00:00:00', '40.00', '20.00', '100.00'),
(8, 'user_teste', 'UPDATE', '00:00:00', '40.00', '20.00', '100.00'),
(9, 'user_teste', 'INSERT', '00:00:00', '40.00', '20.00', '100.00'),
(10, 'user_teste', 'DELETE', '00:00:00', '40.00', '20.00', '100.00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `g12_loguser`
--

CREATE TABLE `g12_loguser` (
  `id` int(11) NOT NULL,
  `User` varchar(100) NOT NULL,
  `Operacao` varchar(10) NOT NULL,
  `Time` time NOT NULL,
  `Email` varchar(100) NOT NULL,
  `NomeUtilizador` varchar(200) NOT NULL,
  `TipoUtilizador` varchar(3) NOT NULL,
  `Morada` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `g12_loguser`
--

INSERT INTO `g12_loguser` (`id`, `User`, `Operacao`, `Time`, `Email`, `NomeUtilizador`, `TipoUtilizador`, `Morada`) VALUES
(1, 'user_teste', 'DELETE', '00:00:00', 'user_teste@email.pt', 'nome', 'tip', 'morada'),
(2, 'user_teste', 'UPDATE', '00:00:00', 'user_teste@email.pt', 'nome', 'tip', 'morada'),
(3, 'user_teste', 'INSERT', '00:00:00', 'user_teste@email.pt', 'nome', 'tip', 'morada'),
(4, 'user_teste', 'DELETE', '00:00:00', 'user_teste@email.pt', 'nome', 'tip', 'morada'),
(5, 'user_teste', 'UPDATE', '00:00:00', 'user_teste@email.pt', 'nome', 'tip', 'morada'),
(6, 'user_teste', 'INSERT', '00:00:00', 'user_teste@email.pt', 'nome', 'tip', 'morada'),
(7, 'user_teste', 'DELETE', '00:00:00', 'user_teste@email.pt', 'nome', 'tip', 'morada'),
(8, 'user_teste', 'UPDATE', '00:00:00', 'user_teste@email.pt', 'nome', 'tip', 'morada'),
(9, 'user_teste', 'INSERT', '00:00:00', 'user_teste@email.pt', 'nome', 'tip', 'morada'),
(10, 'user_teste', 'DELETE', '00:00:00', 'user_teste@email.pt', 'nome', 'tip', 'morada');

-- --------------------------------------------------------

--
-- Estrutura da tabela `g12_loguserhasdiasemana`
--

CREATE TABLE `g12_loguserhasdiasemana` (
  `id` int(11) NOT NULL,
  `User` varchar(100) NOT NULL,
  `Operacao` varchar(10) NOT NULL,
  `Time` time NOT NULL,
  `User_Email` varchar(100) NOT NULL,
  `DiaSemana_DiaDaSemana` varchar(20) NOT NULL,
  `DiaSemana_HoraRonda` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `g12_loguserhasdiasemana`
--

INSERT INTO `g12_loguserhasdiasemana` (`id`, `User`, `Operacao`, `Time`, `User_Email`, `DiaSemana_DiaDaSemana`, `DiaSemana_HoraRonda`) VALUES
(1, 'user_teste', 'DELETE', '00:00:00', 'user_teste@email.pt', 'terca', '12:00'),
(2, 'user_teste', 'UPDATE', '00:00:00', 'user_teste@email.pt', 'terca', '13:00'),
(3, 'user_teste', 'INSERT', '00:00:00', 'user_teste@email.pt', 'terca', '14:00'),
(4, 'user_teste', 'DELETE', '00:00:00', 'user_teste@email.pt', 'terca', '15:00'),
(5, 'user_teste', 'UPDATE', '00:00:00', 'user_teste@email.pt', 'terca', '16:00'),
(6, 'user_teste', 'INSERT', '00:00:00', 'user_teste@email.pt', 'terca', '17:00'),
(7, 'user_teste', 'DELETE', '00:00:00', 'user_teste@email.pt', 'terca', '18:00'),
(8, 'user_teste', 'UPDATE', '00:00:00', 'user_teste@email.pt', 'terca', '19:00'),
(9, 'user_teste', 'INSERT', '00:00:00', 'user_teste@email.pt', 'terca', '20:00'),
(10, 'user_teste', 'DELETE', '00:00:00', 'user_teste@email.pt', 'terca', '21:00');

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
-- Estrutura da tabela `utilizador`
--

CREATE TABLE `utilizador` (
  `EmailUtilizador` varchar(100) NOT NULL,
  `NomeUtilizador` varchar(200) NOT NULL,
  `TipoUtilizador` varchar(3) NOT NULL,
  `Morada` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `diasemana`
--
ALTER TABLE `diasemana`
  ADD PRIMARY KEY (`DiaSemana`,`HoraRonda`),
  ADD KEY `HoraRonda` (`HoraRonda`);

--
-- Índices para tabela `g12_logdiasemana`
--
ALTER TABLE `g12_logdiasemana`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `g12_logmedicaosensores`
--
ALTER TABLE `g12_logmedicaosensores`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `g12_logrondaextra`
--
ALTER TABLE `g12_logrondaextra`
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
-- Índices para tabela `g12_loguserhasdiasemana`
--
ALTER TABLE `g12_loguserhasdiasemana`
  ADD PRIMARY KEY (`id`);

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
