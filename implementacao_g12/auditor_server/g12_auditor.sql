-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 03-Abr-2020 às 16:52
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

--
-- Extraindo dados da tabela `g12_logdiasemana`
--

INSERT INTO `g12_logdiasemana` (`id`, `EmailUtilizador`, `Operacao`, `Time`, `DiaSemana`, `HoraRonda`) VALUES
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
  `EmailUtilizador` varchar(100) NOT NULL,
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

INSERT INTO `g12_logmedicaosensores` (`id`, `EmailUtilizador`, `Operacao`, `Time`, `ValorMedicao`, `TipoDeSensor`, `DataHoraMedicao`, `PossivelAnomalia`) VALUES
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
  `EmailUtilizador` varchar(100) NOT NULL,
  `Operacao` varchar(10) NOT NULL,
  `Time` time NOT NULL,
  `DataHora` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `g12_logrondaextra`
--

INSERT INTO `g12_logrondaextra` (`id`, `EmailUtilizador`, `Operacao`, `Time`, `DataHora`) VALUES
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
  `EmailUtilizador` varchar(100) NOT NULL,
  `Operacao` varchar(10) NOT NULL,
  `Time` time NOT NULL,
  `LimiteTemperatura` decimal(6,2) DEFAULT NULL,
  `LimiteHumidade` decimal(6,2) DEFAULT NULL,
  `LimiteLuminosidade` decimal(6,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `g12_logsistema`
--

INSERT INTO `g12_logsistema` (`id`, `EmailUtilizador`, `Operacao`, `Time`, `LimiteTemperatura`, `LimiteHumidade`, `LimiteLuminosidade`) VALUES
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
  `EmailUtilizador` varchar(100) NOT NULL,
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

INSERT INTO `g12_loguser` (`id`, `EmailUtilizador`, `Operacao`, `Time`, `Email`, `NomeUtilizador`, `TipoUtilizador`, `Morada`) VALUES
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
  `EmailUtilizador` varchar(100) NOT NULL,
  `Operacao` varchar(10) NOT NULL,
  `Time` time NOT NULL,
  `User_Email` varchar(100) NOT NULL,
  `DiaSemana_DiaDaSemana` varchar(20) NOT NULL,
  `DiaSemana_HoraRonda` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `g12_loguserhasdiasemana`
--

INSERT INTO `g12_loguserhasdiasemana` (`id`, `EmailUtilizador`, `Operacao`, `Time`, `User_Email`, `DiaSemana_DiaDaSemana`, `DiaSemana_HoraRonda`) VALUES
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
