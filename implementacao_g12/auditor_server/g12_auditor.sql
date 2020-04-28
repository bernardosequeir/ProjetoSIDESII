-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 27-Abr-2020 às 20:54
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
-- Estrutura da tabela `g12_logalerta`
--

CREATE TABLE `g12_logalerta` (
  `id` int(11) NOT NULL,
  `User` varchar(100) NOT NULL,
  `Operacao` varchar(10) NOT NULL,
  `Time` time DEFAULT NULL,
  `IDAlerta` int(11) NOT NULL,
  `DataHoraMedicaoAnterior` timestamp NULL DEFAULT NULL,
  `DataHoraMedicaoNovo` timestamp NULL DEFAULT NULL,
  `TipoSensorAnterior` varchar(3) NOT NULL,
  `TipoSensorNovo` varchar(3) NOT NULL,
  `ValorMedicaoAnterior` decimal(6,2) NOT NULL,
  `ValorMedicaoNovo` decimal(6,2) NOT NULL,
  `LimiteAnterior` decimal(6,2) NOT NULL,
  `LimiteNovo` decimal(6,2) NOT NULL,
  `DescricaoAnterior` varchar(1000) NOT NULL,
  `DescricaoNovo` varchar(1000) NOT NULL,
  `ControloAnterior` tinyint(1) NOT NULL,
  `ControloNovo` tinyint(1) NOT NULL,
  `ExtraAnterior` varchar(50) NOT NULL,
  `ExtraNovo` varchar(50) NOT NULL
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
  `DiaSemanaAnterior` varchar(20) NOT NULL,
  `DiaSemanaNovo` varchar(20) NOT NULL,
  `HoraRondaAnterior` time NOT NULL,
  `HoraRondaNovo` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `g12_logmedicaosensores`
--

CREATE TABLE `g12_logmedicaosensores` (
  `id` int(11) NOT NULL,
  `User` varchar(100) NOT NULL,
  `Operacao` varchar(10) NOT NULL,
  `Time` time NOT NULL,
  `ValorMedicaoAnterior` decimal(6,2) NOT NULL,
  `ValorMedicaoNovo` decimal(6,2) NOT NULL,
  `TipoDeSensorAnterior` varchar(3) NOT NULL,
  `TipoDeSensorNovo` varchar(3) NOT NULL,
  `DataHoraMedicaoAnterior` timestamp NOT NULL DEFAULT current_timestamp(),
  `DataHoraMedicaoNovo` timestamp NOT NULL DEFAULT current_timestamp(),
  `PossivelAnomaliaAnterior` varchar(45) NOT NULL,
  `PossivelAnomaliaNovo` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `g12_logrondaextra`
--

CREATE TABLE `g12_logrondaextra` (
  `id` int(11) NOT NULL,
  `User` varchar(100) NOT NULL,
  `Operacao` varchar(10) NOT NULL,
  `Time` time NOT NULL,
  `DataHoraAnterior` timestamp NOT NULL DEFAULT current_timestamp(),
  `EmailUtilizadorAnterior` varchar(100) NOT NULL,
  `EmailUtilizadorNovo` varchar(100) NOT NULL,
  `datahoraSaidaAnterior` timestamp NOT NULL DEFAULT current_timestamp(),
  `datahoraSaidaNovo` timestamp NOT NULL DEFAULT current_timestamp()
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
  `IDSistemaAnterior` int(11) NOT NULL,
  `LimiteTemperaturaAnterior` decimal(6,2) DEFAULT NULL,
  `LimiteTemperaturaNovo` decimal(6,2) DEFAULT NULL,
  `LimiteHumidadeAnterior` decimal(6,2) DEFAULT NULL,
  `LimiteHumidadeNovo` decimal(6,2) DEFAULT NULL,
  `LimiteLuminosidadeAnterior` decimal(6,2) DEFAULT NULL,
  `LimiteLuminosidadeNovo` decimal(6,2) DEFAULT NULL,
  `LimiarTemperaturaAnterior` decimal(6,2) DEFAULT NULL,
  `LimiarTemperaturaNovo` decimal(6,2) DEFAULT NULL,
  `LimiarHumidadeAnterior` decimal(6,2) DEFAULT NULL,
  `LimiarHumidadeNovo` decimal(6,2) DEFAULT NULL,
  `LimiarLuminosidadeAnterior` decimal(6,2) DEFAULT NULL,
  `LimiarLuminosidadeAnteriorNovo` decimal(6,2) DEFAULT NULL,
  `DuracaoPadraoRondaAnterior` int(11) DEFAULT NULL,
  `DuracaoPadraoRondaNovo` int(11) DEFAULT NULL,
  `PeriocidadeImportacaoExportacaoAnterior` int(11) DEFAULT NULL,
  `PeriocidadeImportacaoExportacaoNovo` int(11) DEFAULT NULL
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
  `NomeUtilizadorAnterior` varchar(200) NOT NULL,
  `NomeUtilizadorNovo` varchar(200) NOT NULL,
  `TipoUtilizadorAnterior` varchar(3) NOT NULL,
  `TipoUtilizadorNovo` varchar(3) NOT NULL,
  `MoradaAnterior` varchar(200) DEFAULT NULL,
  `MoradaNovo` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `g12_loguserhasdiasemana`
--

CREATE TABLE `g12_loguserhasdiasemana` (
  `id` int(11) NOT NULL,
  `User` varchar(100) NOT NULL,
  `Operacao` varchar(10) NOT NULL,
  `Time` time NOT NULL,
  `User_EmailAnterior` varchar(100) NOT NULL,
  `DiaSemana_DiaDaSemanaAnterior` varchar(20) NOT NULL,
  `DiaSemana_DiaDaSemanaNovo` varchar(20) NOT NULL,
  `DiaSemana_HoraRondaAnterior` varchar(45) NOT NULL,
  `DiaSemana_HoraRondaNovo` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `g12_logalerta`
--
ALTER TABLE `g12_logalerta`
  ADD PRIMARY KEY (`id`);

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
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `g12_logdiasemana`
--
ALTER TABLE `g12_logdiasemana`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `g12_logmedicaosensores`
--
ALTER TABLE `g12_logmedicaosensores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `g12_logrondaextra`
--
ALTER TABLE `g12_logrondaextra`
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
-- AUTO_INCREMENT de tabela `g12_loguserhasdiasemana`
--
ALTER TABLE `g12_loguserhasdiasemana`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
