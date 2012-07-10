-- MySQL dump 10.13  Distrib 5.5.24, for Linux (i686)
--
-- Host: localhost    Database: prep2012
-- ------------------------------------------------------
-- Server version	5.5.24-55

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `presidente`
--

DROP TABLE IF EXISTS `presidente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `presidente` (
  `estado` tinyint unsigned null DEFAULT NULL,
  `distrito` smallint unsigned null DEFAULT NULL,
  `seccion` smallint unsigned null DEFAULT NULL,
  `id_casilla` smallint unsigned null DEFAULT NULL,
  `tipo_casilla` char(1) null COLLATE utf8_general_ci DEFAULT NULL,
  `ext_contigua` tinyint unsigned null DEFAULT NULL,
  `ubicacion_casilla` tinyint unsigned null DEFAULT NULL,
  `tipo_acta` tinyint unsigned null DEFAULT NULL,
  `PAN` int unsigned null DEFAULT NULL,
  `PRI` int unsigned null DEFAULT NULL,
  `PRD` int unsigned null DEFAULT NULL,
  `PVEM` int unsigned null DEFAULT NULL,
  `PT` int unsigned null DEFAULT NULL,
  `MC` int unsigned null DEFAULT NULL,
  `PANAL` int unsigned null DEFAULT NULL,
  `C_PRI_PVEM` int unsigned null DEFAULT NULL,
  `C_PRD_PT_MC` int unsigned null DEFAULT NULL,
  `C_PRD_PT` int unsigned null DEFAULT NULL,
  `C_PRD_MC` int unsigned null DEFAULT NULL,
  `C_PT_MC` int unsigned null DEFAULT NULL,
  `no_registrados` int unsigned null DEFAULT NULL,
  `nulos` int unsigned null DEFAULT NULL,
  `total_votos` int unsigned null DEFAULT NULL,
  `lista_nominal` int unsigned null DEFAULT NULL,
  `observaciones` varchar(400) null COLLATE utf8_general_ci DEFAULT NULL,
  `contabilizada` tinyint unsigned null DEFAULT NULL,
  `CRYT` char(1) null COLLATE utf8_general_ci DEFAULT NULL,
  `hora_acopio` datetime null DEFAULT NULL,
  `hora_captura` datetime null DEFAULT NULL,
  `hora_registro` datetime null DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-07-03 15:37:34
