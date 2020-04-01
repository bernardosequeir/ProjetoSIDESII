
-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 19-Mar-2020 às 19:40
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


CREATE TABLE `alerta` (
    `idalerta` INT(11) NOT NULL,
    `IDMedicao` INT(11) DEFAULT NULL,
    `TipoAlerta` VARCHAR(3) NOT NULL,
    `DataHoraAlerta` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ()
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

-- --------------------------------------------------------

CREATE TABLE `cartao` (
    `idCartao` VARCHAR(20) NOT NULL,
    `EmailUtilizador` VARCHAR(100) NOT NULL,
    `Ativo` TINYINT(1) DEFAULT NULL
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

-- --------------------------------------------------------

CREATE TABLE `diasemana` (
    `DiaSemana` VARCHAR(20) NOT NULL,
    `HoraRonda` TIME NOT NULL
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

-- --------------------------------------------------------

CREATE TABLE `logalerta` (
    `idlogAlerta` INT(11) NOT NULL,
    `IDAlerta` INT(11) NOT NULL,
    `TipoAlerta` VARCHAR(3) NOT NULL,
    `DataHoraAlerta` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP () ON UPDATE CURRENT_TIMESTAMP (),
    `IDMedicao` INT(11) NOT NULL,
    `ValorMedicao` DECIMAL(6 , 2 ) NOT NULL,
    `TipoSensor` VARCHAR(3) NOT NULL,
    `DataHoraMedicao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP (),
    `EmailUtilizadorConsultor` VARCHAR(100) NOT NULL,
    `NomeUtilizadorConsultor` VARCHAR(200) NOT NULL,
    `TipoUtilizadorConsultor` VARCHAR(3) NOT NULL,
    `Data` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP (),
    `Comando` VARCHAR(200) NOT NULL,
    `Resultado` TEXT DEFAULT NULL
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

-- --------------------------------------------------------

CREATE TABLE `logcartao` (
    `idlogCartao` INT(11) NOT NULL,
    `idCartao` VARCHAR(20) NOT NULL,
    `Ativo` TINYINT(4) NOT NULL,
    `EmailUtilizador` VARCHAR(100) NOT NULL,
    `NomeUtilizador` VARCHAR(200) NOT NULL,
    `TipoUtilizador` VARCHAR(3) NOT NULL,
    `EmailUtilizadorConsultor` VARCHAR(100) NOT NULL,
    `NomeUtilizadorConsultor` VARCHAR(200) NOT NULL,
    `TipoUtilizadorConsultor` VARCHAR(3) NOT NULL,
    `Data` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP (),
    `Comando` VARCHAR(200) NOT NULL,
    `Resultado` TEXT DEFAULT NULL
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

-- --------------------------------------------------------

CREATE TABLE `logmedicaosensores` (
    `idLogMedicao` INT(11) NOT NULL,
    `IDmedicao` INT(11) NOT NULL,
    `TipoSensor` VARCHAR(3) NOT NULL,
    `DataHoraMedicao` DATETIME NOT NULL,
    `EmailUtilizadorConsultor` VARCHAR(100) NOT NULL,
    `NomeUtilizadorConsultor` VARCHAR(200) NOT NULL,
    `TipoUtilizadorConsultor` VARCHAR(3) NOT NULL,
    `Data` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP () ON UPDATE CURRENT_TIMESTAMP (),
    `Comando` VARCHAR(200) NOT NULL,
    `Resultado` TEXT DEFAULT NULL,
    `PossivelAnomalia` TINYINT(4) NOT NULL
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

-- --------------------------------------------------------

CREATE TABLE `logronda` (
    `idlogRonda` INT(11) NOT NULL,
    `DiaSemana` VARCHAR(20) NOT NULL,
    `HoraRonda` TIME NOT NULL,
    `Duracao` INT(11) NOT NULL,
    `EmailUtilizador` VARCHAR(100) NOT NULL,
    `NomeUtilizador` VARCHAR(200) NOT NULL,
    `TipoUtilizador` VARCHAR(3) NOT NULL,
    `EmailUtilizadorConsultor` VARCHAR(100) NOT NULL,
    `NomeUtilizadorConsultor` VARCHAR(200) NOT NULL,
    `TipoUtilizadorConsultor` VARCHAR(3) NOT NULL,
    `Data` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP (),
    `Comando` VARCHAR(200) NOT NULL,
    `Resultado` TEXT DEFAULT NULL
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

-- --------------------------------------------------------

CREATE TABLE `logrondaextra` (
    `idlogRondaExtra` INT(11) NOT NULL,
    `DataHora` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP (),
    `EmailUtilizador` VARCHAR(100) NOT NULL,
    `NomeUtilizador` VARCHAR(200) NOT NULL,
    `TipoUtilizador` VARCHAR(3) NOT NULL,
    `EmailUtilizadorConsultor` VARCHAR(100) NOT NULL,
    `NomeUtilizadorConsultor` VARCHAR(200) NOT NULL,
    `TipoUtilizadorConsultor` VARCHAR(3) NOT NULL,
    `Data` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP (),
    `Comando` VARCHAR(200) NOT NULL,
    `Resultado` TEXT DEFAULT NULL
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

-- --------------------------------------------------------

CREATE TABLE `logsistema` (
    `idlogSistema` INT(11) NOT NULL,
    `IDSistema` INT(11) NOT NULL,
    `LimiteTemperatura` DECIMAL(6 , 2 ) NOT NULL,
    `LimiteHumidade` DECIMAL(6 , 2 ) NOT NULL,
    `LimiteLuminosidade` DECIMAL(6 , 2 ) NOT NULL,
    `LimiarTemperatura` DECIMAL(6 , 2 ) NOT NULL,
    `LimiarHumidade` DECIMAL(6 , 2 ) NOT NULL,
    `LimiarLuminosidade` DECIMAL(6 , 2 ) NOT NULL,
    `DuracaoPadraoRonda` INT(11) NOT NULL,
    `EmailUtilizadorConsultor` VARCHAR(100) NOT NULL,
    `NomeUtilizadorConsultor` VARCHAR(200) NOT NULL,
    `TipoUtilizadorConsultor` VARCHAR(3) NOT NULL,
    `Data` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP (),
    `Comando` VARCHAR(200) NOT NULL,
    `Resultado` TEXT DEFAULT NULL
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

-- --------------------------------------------------------

CREATE TABLE `logutilizador` (
    `idlogUtilizador` INT(11) NOT NULL,
    `EmailUtilizadorConsultado` VARCHAR(100) NOT NULL,
    `NomeUtilizadorConsultado` VARCHAR(200) NOT NULL,
    `TipoUtilizadorConsultado` VARCHAR(3) NOT NULL,
    `EmailUtilizadorConsultor` VARCHAR(100) NOT NULL,
    `NomeUtilizadorConsultor` VARCHAR(200) NOT NULL,
    `TipoUtilizadorConsultor` VARCHAR(3) NOT NULL,
    `Data` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP () ON UPDATE CURRENT_TIMESTAMP (),
    `Comando` VARCHAR(200) NOT NULL,
    `Resultado` TEXT DEFAULT NULL
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

-- --------------------------------------------------------

CREATE TABLE `medicaosensores` (
    `idMedicao` INT(11) NOT NULL,
    `ValorMedicao` DECIMAL(6 , 2 ) NOT NULL,
    `TipoSensor` VARCHAR(3) NOT NULL,
    `DataHoraMedicao` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP () ON UPDATE CURRENT_TIMESTAMP (),
    `PossivelAnomalia` TINYINT(4) NOT NULL
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

-- --------------------------------------------------------

CREATE TABLE `rondaextra` (
    `dataHoraEntrada` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP () ON UPDATE CURRENT_TIMESTAMP (),
    `EmailUtilizador` VARCHAR(100) NOT NULL,
    `datahoraSaida` TIMESTAMP NULL DEFAULT NULL
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

-- --------------------------------------------------------

CREATE TABLE `sistema` (
    `IDSistema` INT(11) NOT NULL,
    `LimiteTemperatura` DECIMAL(6 , 2 ) NOT NULL,
    `LimiteHumidade` DECIMAL(6 , 2 ) NOT NULL,
    `LimiteLuminosidade` DECIMAL(6 , 2 ) NOT NULL,
    `LimiarTemperatura` DECIMAL(6 , 2 ) NOT NULL,
    `LimiarHumidade` DECIMAL(6 , 2 ) NOT NULL,
    `LimiarLuminosidade` DECIMAL(6 , 2 ) NOT NULL,
    `DuraçãoPadrãoRonda` INT(11) NOT NULL,
    `PeriocidadeImportacaoExportacao` INT(11) NOT NULL
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

-- --------------------------------------------------------

CREATE TABLE `utilizador` (
    `EmailUtilizador` VARCHAR(100) NOT NULL,
    `NomeUtilizador` VARCHAR(200) NOT NULL,
    `TipoUtilizador` VARCHAR(3) NOT NULL,
    `Password` VARCHAR(10) NOT NULL
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

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
  ADD PRIMARY KEY (`DiaSemana`,`HoraRonda`);

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
