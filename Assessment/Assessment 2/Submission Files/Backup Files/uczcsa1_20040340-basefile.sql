-- phpMyAdmin SQL Dump
-- version 3.4.10.1
-- http://www.phpmyadmin.net
--
-- Host: mysql-server.ucl.ac.uk:3306
-- Generation Time: Mar 12, 2021 at 08:30 PM
-- Server version: 5.6.36
-- PHP Version: 5.3.3

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `uczcsa1_20040340`
--

-- --------------------------------------------------------

--
-- Table structure for table `CAR`
--

CREATE TABLE IF NOT EXISTS `CAR` (
  `REGISTRATION` char(7) NOT NULL,
  `BRAND` varchar(30) NOT NULL,
  `YEAR_OF_PURCHASE` year(4) NOT NULL,
  `COMPANY` char(6) NOT NULL,
  PRIMARY KEY (`REGISTRATION`),
  KEY `COMPANY` (`COMPANY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `DRIVING_INSTRUCTOR`
--

CREATE TABLE IF NOT EXISTS `DRIVING_INSTRUCTOR` (
  `SSN` char(6) NOT NULL,
  `NAME` varchar(30) NOT NULL,
  PRIMARY KEY (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `DRIVING_LICENSE_EXAM_APPLICANT`
--

CREATE TABLE IF NOT EXISTS `DRIVING_LICENSE_EXAM_APPLICANT` (
  `SSN` char(6) NOT NULL,
  `NAME` varchar(30) NOT NULL,
  `TAUGHT_BY` char(6) NOT NULL,
  PRIMARY KEY (`SSN`),
  KEY `TAUGHT_BY` (`TAUGHT_BY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `DRIVING_SCHOOL_COMPANY`
--

CREATE TABLE IF NOT EXISTS `DRIVING_SCHOOL_COMPANY` (
  `VAT_NUMBER` char(6) NOT NULL,
  `NAME` varchar(30) NOT NULL,
  PRIMARY KEY (`VAT_NUMBER`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `EXAMINATION_CENTRE`
--

CREATE TABLE IF NOT EXISTS `EXAMINATION_CENTRE` (
  `LOCATION` char(6) NOT NULL,
  PRIMARY KEY (`LOCATION`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `EXAMINER`
--

CREATE TABLE IF NOT EXISTS `EXAMINER` (
  `EMPLOYEE_ID` char(6) NOT NULL,
  `NAME` varchar(60) NOT NULL,
  `CENTRE` char(6) NOT NULL,
  PRIMARY KEY (`EMPLOYEE_ID`),
  KEY `CENTRE` (`CENTRE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `EXAM_DRIVING_ROUTE`
--

CREATE TABLE IF NOT EXISTS `EXAM_DRIVING_ROUTE` (
  `ROUTE_ID` char(6) NOT NULL,
  `POSSIBLE_IN_WINTER` tinyint(1) NOT NULL,
  `CENTRE` char(6) NOT NULL,
  PRIMARY KEY (`ROUTE_ID`),
  KEY `COMPANY` (`CENTRE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `EXAM_OPPORTUNITY`
--

CREATE TABLE IF NOT EXISTS `EXAM_OPPORTUNITY` (
  `ID` char(6) NOT NULL,
  `DATE` date NOT NULL,
  `TRIED_BY` char(6) NOT NULL,
  `ASSIGNEE` char(6) NOT NULL,
  `ROUTE` char(6) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `TRIED_BY` (`TRIED_BY`),
  KEY `ASSIGNEE` (`ASSIGNEE`),
  KEY `ROUTE` (`ROUTE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `FAMILY_MEMBER_DI`
--

CREATE TABLE IF NOT EXISTS `FAMILY_MEMBER_DI` (
  `FM_DI_SSN` char(6) NOT NULL,
  `RELATION_TO_PERSON` varchar(30) NOT NULL,
  PRIMARY KEY (`FM_DI_SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `IS_TAUGHT_BY`
--

CREATE TABLE IF NOT EXISTS `IS_TAUGHT_BY` (
  `DI_SSN` char(6) NOT NULL,
  `DLEA_SSN` char(6) NOT NULL,
  PRIMARY KEY (`DI_SSN`,`DLEA_SSN`),
  KEY `IS_TAUGHT_BY_ibfk_1` (`DLEA_SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `TRAINED_OFFICIAL_DRIVING_INSTRUCTOR_DI`
--

CREATE TABLE IF NOT EXISTS `TRAINED_OFFICIAL_DRIVING_INSTRUCTOR_DI` (
  `TODI_DI_SSN` char(6) NOT NULL,
  `YEARS_INSTRUCTED` smallint(60) NOT NULL,
  `COMPANY` char(6) NOT NULL,
  PRIMARY KEY (`TODI_DI_SSN`),
  KEY `COMPANY` (`COMPANY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `CAR`
--
ALTER TABLE `CAR`
  ADD CONSTRAINT `CAR_ibfk_1` FOREIGN KEY (`COMPANY`) REFERENCES `DRIVING_SCHOOL_COMPANY` (`VAT_NUMBER`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `DRIVING_LICENSE_EXAM_APPLICANT`
--
ALTER TABLE `DRIVING_LICENSE_EXAM_APPLICANT`
  ADD CONSTRAINT `DRIVING_LICENSE_EXAM_APPLICANT_ibfk_1` FOREIGN KEY (`TAUGHT_BY`) REFERENCES `DRIVING_INSTRUCTOR` (`SSN`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `EXAMINER`
--
ALTER TABLE `EXAMINER`
  ADD CONSTRAINT `EXAMINER_ibfk_1` FOREIGN KEY (`CENTRE`) REFERENCES `EXAMINATION_CENTRE` (`LOCATION`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `EXAM_DRIVING_ROUTE`
--
ALTER TABLE `EXAM_DRIVING_ROUTE`
  ADD CONSTRAINT `EXAM_DRIVING_ROUTE_ibfk_1` FOREIGN KEY (`CENTRE`) REFERENCES `EXAMINATION_CENTRE` (`LOCATION`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `EXAM_OPPORTUNITY`
--
ALTER TABLE `EXAM_OPPORTUNITY`
  ADD CONSTRAINT `EXAM_OPPORTUNITY_ibfk_1` FOREIGN KEY (`TRIED_BY`) REFERENCES `DRIVING_LICENSE_EXAM_APPLICANT` (`SSN`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `EXAM_OPPORTUNITY_ibfk_2` FOREIGN KEY (`ASSIGNEE`) REFERENCES `EXAMINER` (`EMPLOYEE_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `EXAM_OPPORTUNITY_ibfk_3` FOREIGN KEY (`ROUTE`) REFERENCES `EXAM_DRIVING_ROUTE` (`ROUTE_ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `FAMILY_MEMBER_DI`
--
ALTER TABLE `FAMILY_MEMBER_DI`
  ADD CONSTRAINT `FAMILY_MEMBER_DI_ibfk_1` FOREIGN KEY (`FM_DI_SSN`) REFERENCES `DRIVING_INSTRUCTOR` (`SSN`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `IS_TAUGHT_BY`
--
ALTER TABLE `IS_TAUGHT_BY`
  ADD CONSTRAINT `IS_TAUGHT_BY_ibfk_1` FOREIGN KEY (`DLEA_SSN`) REFERENCES `DRIVING_LICENSE_EXAM_APPLICANT` (`SSN`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `IS_TAUGHT_BY_ibfk_2` FOREIGN KEY (`DI_SSN`) REFERENCES `DRIVING_INSTRUCTOR` (`SSN`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `TRAINED_OFFICIAL_DRIVING_INSTRUCTOR_DI`
--
ALTER TABLE `TRAINED_OFFICIAL_DRIVING_INSTRUCTOR_DI`
  ADD CONSTRAINT `TRAINED_OFFICIAL_DRIVING_INSTRUCTOR_DI_ibfk_1` FOREIGN KEY (`TODI_DI_SSN`) REFERENCES `DRIVING_INSTRUCTOR` (`SSN`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `TRAINED_OFFICIAL_DRIVING_INSTRUCTOR_DI_ibfk_2` FOREIGN KEY (`COMPANY`) REFERENCES `DRIVING_SCHOOL_COMPANY` (`VAT_NUMBER`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
