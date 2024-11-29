-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: gestion_centre_apprentissage
-- ------------------------------------------------------
-- Server version	8.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `abonnements`
--

DROP TABLE IF EXISTS `abonnements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abonnements` (
  `id_abonnement` int NOT NULL AUTO_INCREMENT,
  `id_apprenant` int NOT NULL,
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL,
  PRIMARY KEY (`id_abonnement`),
  KEY `id_apprenant` (`id_apprenant`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abonnements`
--

LOCK TABLES `abonnements` WRITE;
/*!40000 ALTER TABLE `abonnements` DISABLE KEYS */;
INSERT INTO `abonnements` VALUES (1,1,'2024-02-02','2024-12-31'),(2,2,'2024-06-15','2025-06-15'),(3,3,'2023-09-01','2024-08-31'),(4,4,'2024-03-01','2024-08-31'),(5,5,'2024-10-01','2025-03-31'),(6,1,'2024-01-02','2024-12-31'),(8,5,'2024-10-01','2025-03-31'),(9,1,'2024-02-02','2024-12-31');
/*!40000 ALTER TABLE `abonnements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `apprenant`
--

DROP TABLE IF EXISTS `apprenant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `apprenant` (
  `id_apprenant` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `niveau_langue` varchar(50) DEFAULT NULL,
  `langue_cible` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_apprenant`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apprenant`
--

LOCK TABLES `apprenant` WRITE;
/*!40000 ALTER TABLE `apprenant` DISABLE KEYS */;
INSERT INTO `apprenant` VALUES (1,'Salomon','B2','Anglais'),(2,'Joyce','B1','Anglais'),(3,'Joyce','C1','Français'),(5,'Lee','C1','Français');
/*!40000 ALTER TABLE `apprenant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cours`
--

DROP TABLE IF EXISTS `cours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cours` (
  `id_cours` int NOT NULL AUTO_INCREMENT,
  `nom_cours` varchar(100) NOT NULL,
  `langue_dispensee` varchar(100) NOT NULL,
  `descriptions_cours` text,
  `type_cours` varchar(50) DEFAULT NULL,
  `id_salle` int DEFAULT NULL,
  `tarif_cours` float DEFAULT NULL,
  PRIMARY KEY (`id_cours`),
  KEY `id_salle` (`id_salle`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cours`
--

LOCK TABLES `cours` WRITE;
/*!40000 ALTER TABLE `cours` DISABLE KEYS */;
INSERT INTO `cours` VALUES (1,'Anglais Conversation','Anglais',NULL,'conversation',1,150),(2,'Atelier de Cuisine Française','Français','Apprenez à préparer des plats traditionnels français.','atelier',2,200),(3,'Introduction au Japonais','Japonais','Un cours pour apprendre les bases de la langue japonaise.','cours particulier',3,250),(4,'Espagnol pour Débutants','Espagnol','Cours pour maîtriser les bases de la langue espagnole.','conversation',1,180),(5,'Cours Intensif de Français','Français','Formation accélérée pour apprendre rapidement le français.','cours particulier',4,300),(6,'Atelier d\'Italien','Italien','Pratiquez l\'italien dans un cadre interactif.','atelier',5,220),(7,'Anglais des Affaires','Anglais','Développez vos compétences en anglais professionnel.','conversation',6,250),(8,'Atelier de Théâtre en Espagnol','Espagnol','Apprenez l\'espagnol à travers des jeux de rôle et du théâtre.','atelier',7,210),(9,'Cours Particulier de Chinois','Chinois','Cours privé pour apprendre à lire et écrire le chinois.','cours particulier',8,350),(10,'Initiation à l\'Allemand','Allemand','Les bases de la langue allemande pour débutants.','conversation',9,170);
/*!40000 ALTER TABLE `cours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `id_message` int NOT NULL AUTO_INCREMENT,
  `id_apprenant` int NOT NULL,
  `contenu` text NOT NULL,
  `langue_cible` varchar(50) NOT NULL,
  `date_publication` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_message`),
  KEY `id_apprenant` (`id_apprenant`),
  CONSTRAINT `message_ibfk_1` FOREIGN KEY (`id_apprenant`) REFERENCES `apprenant` (`id_apprenant`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (1,1,'Je cherche un partenaire pour pratiquer le français.','Français','2024-11-29 20:17:36'),(2,1,'Je voudrais échanger en espagnol.','Espagnol','2024-11-29 20:17:48'),(3,2,'Quelqu\'un pour pratiquer l\'anglais ?','Anglais','2024-11-29 20:17:48'),(4,3,'J\'aimerais apprendre le chinois.','Chinois','2024-11-29 20:17:48');
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salles`
--

DROP TABLE IF EXISTS `salles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salles` (
  `id_salle` int NOT NULL AUTO_INCREMENT,
  `nom_salle` varchar(50) NOT NULL,
  `equipements` text,
  PRIMARY KEY (`id_salle`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salles`
--

LOCK TABLES `salles` WRITE;
/*!40000 ALTER TABLE `salles` DISABLE KEYS */;
INSERT INTO `salles` VALUES (1,'Salle A','Tableaux interactifs, Casques'),(2,'Salle B','Tableaux interactifs, Manuels'),(3,'Salle C','Tableaux interactifs, Casques'),(4,'Salle D','Tableaux interactifs, Manuels'),(5,'Salle E','Tableaux interactifs, Systèmes audio'),(6,'Salle F','Ordinateurs, Casques, Manuels numériques'),(7,'Salle G','Projecteur, Tableaux blancs, Enregistreurs vocaux'),(8,'Salle H','Casques, Systèmes de visioconférence'),(9,'Salle I','Cabines de traduction, Micros, Casques'),(10,'Salle J','Tableaux interactifs, Logiciels d’apprentissage des langues'),(11,'Salle K','Tablettes numériques, Casques audio'),(12,'Salle L','Projecteur interactif, Manuels spécifiques pour le chinois'),(13,'Salle M','Logiciels d’évaluation, Systèmes de réponse interactive'),(14,'Salle N','Projecteur interactif, Supports audio-visuels spécifiques pour l’espagnol');
/*!40000 ALTER TABLE `salles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-29 21:44:25
