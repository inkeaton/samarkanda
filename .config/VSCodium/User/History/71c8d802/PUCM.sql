-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 28, 2023 at 12:18 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
--
-- Database: `Chiron`
--
CREATE DATABASE IF NOT EXISTS `Chiron` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `Chiron`;

-- --------------------------------------------------------

--
-- Table structure for table `Abbonamento`
--

DROP TABLE IF EXISTS `Abbonamento`;
CREATE TABLE `Abbonamento` (
  `idAbbonamento` int(11) NOT NULL,
  `fkUtente` int(11) NOT NULL,
  `nomeAbbonamento` varchar(100) NOT NULL,
  `dataInizio` date NOT NULL DEFAULT current_timestamp(),
  `durata` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `AbbonamentoStella`
--

DROP TABLE IF EXISTS `AbbonamentoStella`;
CREATE TABLE `AbbonamentoStella` (
  `idAbbonamentoStella` int(11) NOT NULL,
  `fkStella` int(11) NOT NULL,
  `fkAbbonamento` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Costellazione`
--

DROP TABLE IF EXISTS `Costellazione`;
CREATE TABLE `Costellazione` (
  `idCostellazione` int(11) NOT NULL,
  `nomeCostellazione` varchar(50) NOT NULL,
  `dataInizio` date NOT NULL,
  `dataFine` date NOT NULL,
  `descrizione` varchar(1000) NOT NULL,
  `immagine` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Recensione`
--

DROP TABLE IF EXISTS `Recensione`;
CREATE TABLE `Recensione` (
  `idRecensione` int(11) NOT NULL,
  `fkStella` int(11) NOT NULL,
  `fkUtente` int(11) NOT NULL,
  `valutazione` int(10) UNSIGNED NOT NULL,
  `commento` varchar(10000) NOT NULL,
  `dataRecensione` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Stella`
--

DROP TABLE IF EXISTS `Stella`;
CREATE TABLE `Stella` (
  `idStella` int(11) NOT NULL,
  `fkCostellazione` int(11) NOT NULL,
  `nomeStella` varchar(50) NOT NULL,
  `dLY` int(11) NOT NULL,
  `prezzo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Utente`
--

DROP TABLE IF EXISTS `Utente`;
CREATE TABLE `Utente` (
  `idUtente` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `cognome` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `pwd` varchar(50) NOT NULL,
  `pronome` varchar(5) NOT NULL,
  `img` varchar(30) NOT NULL,
  `amministratore` int(10) NOT NULL DEFAULT 0,
  `dataCreazione` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Abbonamento`
--
ALTER TABLE `Abbonamento`
  ADD PRIMARY KEY (`idAbbonamento`),
  ADD UNIQUE KEY `uqNomeAbbonamento` (`nomeAbbonamento`),
  ADD KEY `fkAbbonamentoUtente` (`fkUtente`);

--
-- Indexes for table `AbbonamentoStella`
--
ALTER TABLE `AbbonamentoStella`
  ADD PRIMARY KEY (`idAbbonamentoStella`),
  ADD UNIQUE KEY `fkStella_2` (`fkStella`,`fkAbbonamento`),
  ADD KEY `fkStella` (`fkStella`),
  ADD KEY `fkAbbonamento` (`fkAbbonamento`);

--
-- Indexes for table `Costellazione`
--
ALTER TABLE `Costellazione`
  ADD PRIMARY KEY (`idCostellazione`),
  ADD UNIQUE KEY `nomeCostellazione` (`nomeCostellazione`);

--
-- Indexes for table `Recensione`
--
ALTER TABLE `Recensione`
  ADD PRIMARY KEY (`idRecensione`),
  ADD KEY `fkRecensioneStella` (`fkStella`),
  ADD KEY `fkRecensioneUtente` (`fkUtente`);

--
-- Indexes for table `Stella`
--
ALTER TABLE `Stella`
  ADD PRIMARY KEY (`idStella`),
  ADD UNIQUE KEY `uqNomeStella` (`nomeStella`),
  ADD KEY `fkStellaCostellazione` (`fkCostellazione`);

--
-- Indexes for table `Utente`
--
ALTER TABLE `Utente`
  ADD PRIMARY KEY (`idUtente`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Abbonamento`
--
ALTER TABLE `Abbonamento`
  MODIFY `idAbbonamento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `AbbonamentoStella`
--
ALTER TABLE `AbbonamentoStella`
  MODIFY `idAbbonamentoStella` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Costellazione`
--
ALTER TABLE `Costellazione`
  MODIFY `idCostellazione` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Recensione`
--
ALTER TABLE `Recensione`
  MODIFY `idRecensione` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Stella`
--
ALTER TABLE `Stella`
  MODIFY `idStella` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Utente`
--
ALTER TABLE `Utente`
  MODIFY `idUtente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Abbonamento`
--
ALTER TABLE `Abbonamento`
  ADD CONSTRAINT `fkAbbonamentoUtente` FOREIGN KEY (`fkUtente`) REFERENCES `Utente` (`idUtente`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `AbbonamentoStella`
--
ALTER TABLE `AbbonamentoStella`
  ADD CONSTRAINT `fkASAbbonamento` FOREIGN KEY (`fkAbbonamento`) REFERENCES `Abbonamento` (`idAbbonamento`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fkASStella` FOREIGN KEY (`fkStella`) REFERENCES `Stella` (`idStella`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Recensione`
--
ALTER TABLE `Recensione`
  ADD CONSTRAINT `fkRecensioneStella` FOREIGN KEY (`fkStella`) REFERENCES `Stella` (`idStella`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fkRecensioneUtente` FOREIGN KEY (`fkUtente`) REFERENCES `Utente` (`idUtente`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Stella`
--
ALTER TABLE `Stella`
  ADD CONSTRAINT `fkStellaCostellazione` FOREIGN KEY (`fkCostellazione`) REFERENCES `Costellazione` (`idCostellazione`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
