-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 11-Maio-2020 às 00:46
-- Versão do servidor: 10.4.10-MariaDB
-- versão do PHP: 7.1.33

SET FOREIGN_KEY_CHECKS=0;
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

-- --------------------------------------------------------

--
-- Estrutura da tabela `alerta`
--

CREATE TABLE `alerta` (
  `ID` int(11) NOT NULL,
  `DataHoraMedicao` timestamp NULL DEFAULT NULL,
  `TipoSensor` varchar(3) NOT NULL,
  `ValorMedicao` decimal(6,2) NOT NULL,
  `Limite` decimal(6,2) NOT NULL,
  `Descricao` varchar(1000) NOT NULL,
  `Controlo` tinyint(1) NOT NULL,
  `Extra` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
  `IDMedicaoAntigo` int(11) DEFAULT NULL,
  `IDMedicalNovo` int(11) DEFAULT NULL,
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
  `IDMedicaoAntigo` int(11) DEFAULT NULL,
  `IDMedicalNovo` int(11) DEFAULT NULL,
  `ValorMedicaoAnterior` decimal(6,2) DEFAULT NULL,
  `ValorMedicaoNovo` decimal(6,2) DEFAULT NULL,
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
  `idMedicao` int(11) NOT NULL,
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
	INSERT INTO g12_logmedicaosensores VALUES (DEFAULT, @UserMail ,'UPDATE', now(),new.ValorMedicao, new.TipoSensor, new.DataHoraMedicao, new.PossivelAnomalia);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Eliminar_Medicoes` AFTER DELETE ON `medicao_sensores` FOR EACH ROW BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	INSERT INTO g12_logmedicaosensores VALUES (DEFAULT, @UserMail ,'DELETE', now(),old.ValorMedicao, old.TipoSensor, old.DataHoraMedicao, old.PossivelAnomalia);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Inserir_Medicoes` AFTER INSERT ON `medicao_sensores` FOR EACH ROW BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	INSERT INTO g12_logmedicaosensores VALUES ( DEFAULT, @UserMail ,'INSERT', now(),new.ValorMedicao, new.TipoSensor, new.DataHoraMedicao, new.PossivelAnomalia);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `medicao_sensores_anomalos`
--

CREATE TABLE `medicao_sensores_anomalos` (
  `idMedicao` int(11) NOT NULL,
  `ValorMedicao` decimal(6,2) NOT NULL,
  `TipoSensor` varchar(3) NOT NULL,
  `DataHoraMedicao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
	INSERT INTO g12_logrondaextra VALUES (DEFAULT,  @UserMail , 'UPDATE', now(),new.dataHoraEntrada,new.EmailUtilizador, new.datahoraSaida);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Eliminar_RondaExtra` AFTER DELETE ON `ronda_extra` FOR EACH ROW BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	INSERT INTO g12_logrondaextra VALUES ( DEFAULT,  @UserMail , 'DELETE', now(),old.dataHoraEntrada,old.EmailUtilizador, old.datahoraSaida);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Inserir_RondaExtra` AFTER INSERT ON `ronda_extra` FOR EACH ROW BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	INSERT INTO g12_logrondaextra VALUES ( DEFAULT,  @UserMail , 'INSERT', now(),new.dataHoraEntrada, new.EmailUtilizador, new.datahoraSaida);
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
  `IntervaloImportacaoMongo` decimal(6,2) DEFAULT NULL,
  `TempoLimiteMedicao` int(11) DEFAULT NULL,
  `tamanhoDosBuffersAnomalia` int(11) DEFAULT NULL,
  `tamanhoDosBuffersAlerta` int(11) DEFAULT NULL,
  `variacaoAnomalaTemperatura` decimal(3,2) DEFAULT NULL,
  `variacaoAnomalaHumidade` decimal(3,2) DEFAULT NULL,
  `crescimentoInstantaneoTemperatura` decimal(3,2) DEFAULT NULL,
  `crescimentoGradualTemperatura` decimal(3,2) DEFAULT NULL,
  `crescimentoInstantaneoHumidade` decimal(3,2) DEFAULT NULL,
  `crescimentoGradualHumidade` decimal(3,2) DEFAULT NULL,
  `luminosidadeLuzesDesligadas` int(11) DEFAULT NULL,
  `limiteTemperatura` int(11) DEFAULT NULL,
  `limiteHumidade` int(11) DEFAULT NULL,
  `periocidadeImportacaoExportacaoAuditor` int(11) DEFAULT NULL
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
	INSERT INTO g12_logsistema VALUES ( DEFAULT, @UserMail, 'UPDATE', now(), new.IDSistema, new.LimiteTemperatura, new.LimiteHumidade, new.LimiteLuminosidade, new.LimiarTemperatura, new.LimiarHumidade, new.LimiarLuminosidade, new.DuraçãoPadrãoRonda, new.PeriocidadeImportacaoExportacao);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Eliminar_Sistema` AFTER DELETE ON `sistema` FOR EACH ROW BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	INSERT INTO g12_logsistema VALUES ( DEFAULT, @UserMail, 'DELETE', now(), old.IDSistema, old.LimiteTemperatura, old.LimiteHumidade, old.LimiteLuminosidade, old.LimiarTemperatura, old.LimiarHumidade, old.LimiarLuminosidade, old.DuraçãoPadrãoRonda, old.PeriocidadeImportacaoExportacao);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Inserir_Sistema` AFTER INSERT ON `sistema` FOR EACH ROW BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	INSERT INTO g12_logsistema VALUES ( DEFAULT, @UserMail, 'INSERT', now(), new.IDSistema, new.LimiteTemperatura, new.LimiteHumidade, new.LimiteLuminosidade, new.LimiarTemperatura, new.LimiarHumidade, new.LimiarLuminosidade, new.DuraçãoPadrãoRonda, new.PeriocidadeImportacaoExportacao);
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
	INSERT INTO g12_loguser VALUES ( DEFAULT, @UserMail , 'UPDATE',now(), new.EmailUtilizador, new.NomeUtilizador, new.TipoUtilizador, new.Morada);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Eliminar_Utilizador` AFTER DELETE ON `utilizador` FOR EACH ROW BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	INSERT INTO g12_loguser VALUES (DEFAULT, @UserMail , 'DELETE',now(), old.EmailUtilizador, old.NomeUtilizador, old.TipoUtilizador, old.Morada);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Inserir_Utilizador` AFTER INSERT ON `utilizador` FOR EACH ROW BEGIN
	-- Find username of person performing the INSERT into table
	SELECT user INTO @UserMail FROM (
        SELECT user, CONCAT(user, '@', host) as userhost FROM mysql.user) base
    WHERE userhost = USER();
	INSERT INTO g12_loguser VALUES ( DEFAULT, @UserMail , 'INSERT',now(), new.EmailUtilizador, new.NomeUtilizador, new.TipoUtilizador, new.Morada);
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
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `ronda_planeada`
--
ALTER TABLE `ronda_planeada`
  ADD CONSTRAINT `ronda_planeada_ibfk_1` FOREIGN KEY (`DiaSemana`) REFERENCES `dia_semana` (`DiaSemana`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ronda_planeada_ibfk_2` FOREIGN KEY (`EmailUtilizador`) REFERENCES `utilizador` (`EmailUtilizador`) ON DELETE CASCADE,
  ADD CONSTRAINT `ronda_planeada_ibfk_3` FOREIGN KEY (`HoraRondaInicio`) REFERENCES `dia_semana` (`HoraRondaInicio`) ON DELETE CASCADE ON UPDATE CASCADE;
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
