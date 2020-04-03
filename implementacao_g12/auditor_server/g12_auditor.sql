-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 03-Abr-2020 às 17:40
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
-- Banco de dados: `g12_auditor`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `g12_logdiasemana`
--

CREATE TABLE `g12_logdiasemana` (
  `id` int(11) NOT NULL,
  `EmailUtilizador` varchar(100) NOT NULL,
  `Operacao` varchar(10) NOT NULL,
  `Time` time NOT NULL,
  `DiaSemana` varchar(20) NOT NULL,
  `HoraRonda` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `g12_logmedicaosensores`
--

CREATE TABLE `g12_logmedicaosensores` (
  `id` int(11) NOT NULL,
  `EmailUtilizador` varchar(100) NOT NULL,
  `Operacao` varchar(10) NOT NULL,
  `Time` time NOT NULL,
  `ValorMedicao` decimal(6,2) NOT NULL,
  `TipoDeSensor` varchar(3) NOT NULL,
  `DataHoraMedicao` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `PossivelAnomalia` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `g12_logrondaextra`
--

CREATE TABLE `g12_logrondaextra` (
  `id` int(11) NOT NULL,
  `EmailUtilizador` varchar(100) NOT NULL,
  `Operacao` varchar(10) NOT NULL,
  `Time` time NOT NULL,
  `DataHora` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `g12_logsistema`
--

CREATE TABLE `g12_logsistema` (
  `id` int(11) NOT NULL,
  `EmailUtilizador` varchar(100) NOT NULL,
  `Operacao` varchar(10) NOT NULL,
  `Time` time NOT NULL,
  `LimiteTemperatura` decimal(6,2) DEFAULT NULL,
  `LimiteHumidade` decimal(6,2) DEFAULT NULL,
  `LimiteLuminosidade` decimal(6,2) DEFAULT NULL,
  `LimiarTemperatura` decimal(6,2) DEFAULT NULL,
  `LimiarHumidade` decimal(6,2) DEFAULT NULL,
  `LimiarLuminosidade` decimal(6,2) DEFAULT NULL,
  `DuracaoPadraoRonda` int(11) DEFAULT NULL,
  `PeriocidadeImportacaoExportacao` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `g12_loguser`
--

CREATE TABLE `g12_loguser` (
  `id` int(11) NOT NULL,
  `EmailUtilizador` varchar(100) NOT NULL,
  `Operacao` varchar(10) NOT NULL,
  `Time` time NOT NULL,
  `Email` varchar(100) NOT NULL,
  `NomeUtilizador` varchar(200) NOT NULL,
  `TipoUtilizador` varchar(3) NOT NULL,
  `Morada` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `g12_loguserhasdiasemana`
--

CREATE TABLE `g12_loguserhasdiasemana` (
  `id` int(11) NOT NULL,
  `EmailUtilizador` varchar(100) NOT NULL,
  `Operacao` varchar(10) NOT NULL,
  `Time` time NOT NULL,
  `User_Email` varchar(100) NOT NULL,
  `DiaSemana_DiaDaSemana` varchar(20) NOT NULL,
  `DiaSemana_HoraRonda` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices para tabelas despejadas
--

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
