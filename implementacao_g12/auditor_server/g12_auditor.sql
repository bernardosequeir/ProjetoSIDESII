-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 11-Maio-2020 às 00:47
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
-- Banco de dados: `g12_auditor`
--

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

--
-- Índices para tabelas despejadas
--

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
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
