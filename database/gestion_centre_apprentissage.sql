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
  `nom` varchar(100) NOT NULL,
  `description` text,
  `prix` decimal(10,2) NOT NULL,
  `duree` int NOT NULL,
  `unite_duree` enum('jour','mois','an') DEFAULT 'mois',
  PRIMARY KEY (`id_abonnement`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abonnements`
--

LOCK TABLES `abonnements` WRITE;
/*!40000 ALTER TABLE `abonnements` DISABLE KEYS */;
INSERT INTO `abonnements` VALUES (2,'Abonnement1','Forfait',100.00,20,'jour'),(3,'abonnement 2','Forfait 2',89.01,6,'mois');
/*!40000 ALTER TABLE `abonnements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `abonnementss`
--

DROP TABLE IF EXISTS `abonnementss`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `abonnementss` (
  `id_abonnement` int NOT NULL AUTO_INCREMENT,
  `id_apprenant` int NOT NULL,
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL,
  PRIMARY KEY (`id_abonnement`),
  KEY `id_apprenant` (`id_apprenant`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abonnementss`
--

LOCK TABLES `abonnementss` WRITE;
/*!40000 ALTER TABLE `abonnementss` DISABLE KEYS */;
INSERT INTO `abonnementss` VALUES (1,1,'2024-02-02','2024-12-31'),(2,2,'2024-06-15','2025-06-15'),(3,3,'2023-09-01','2024-08-31'),(4,4,'2024-03-01','2024-08-31'),(5,5,'2024-10-01','2025-03-31'),(6,1,'2024-01-02','2024-12-31'),(8,5,'2024-10-01','2025-03-31'),(9,1,'2024-02-02','2024-12-31'),(10,1,'2024-12-18','2024-12-31'),(11,2,'2024-12-30','2024-12-31'),(18,3,'2024-12-24','2024-12-31'),(19,10,'2024-12-04','2024-12-18'),(17,10,'2024-12-04','2024-12-31');
/*!40000 ALTER TABLE `abonnementss` ENABLE KEYS */;
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
  `id_user` int DEFAULT NULL,
  PRIMARY KEY (`id_apprenant`),
  UNIQUE KEY `id_user` (`id_user`),
  CONSTRAINT `fk_user_apprenant` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `apprenant`
--

LOCK TABLES `apprenant` WRITE;
/*!40000 ALTER TABLE `apprenant` DISABLE KEYS */;
INSERT INTO `apprenant` VALUES (1,'Salomon','A2','Anglais',NULL),(2,'Joyce','B1','Anglas',NULL),(3,'Joyce','C1','Français',NULL),(7,'Salomon TSHAUKE','B2','Anglais',2),(8,'Joyce Scrapy','C1','Français',3),(9,'est','B2','Espagnol',6),(10,'Sana','A2','Anglais',8),(11,'test1','B1','Anglais',9);
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
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cours`
--

LOCK TABLES `cours` WRITE;
/*!40000 ALTER TABLE `cours` DISABLE KEYS */;
INSERT INTO `cours` VALUES (1,'Anglais Conversation','Anglais',NULL,'conversation',3,150),(2,'Atelier de Cuisine Française','Français',NULL,'atelier',2,299),(3,'Introduction au Japonais','Japonais','Un cours pour apprendre les bases de la langue japonaise.','cours particulier',3,250),(4,'Espagnol pour Débutants','Espagnol','Cours pour maîtriser les bases de la langue espagnole.','conversation',1,180),(5,'Cours Intensif de Français','Français','Formation accélérée pour apprendre rapidement le français.','cours particulier',4,300),(6,'Atelier d\'Italien','Italien','Pratiquez l\'italien dans un cadre interactif.','atelier',5,220),(7,'Anglais des Affaires','Anglais','Développez vos compétences en anglais professionnel.','conversation',6,250),(8,'Atelier de Théâtre en Espagnol','Espagnol','Apprenez l\'espagnol à travers des jeux de rôle et du théâtre.','atelier',7,210),(11,'test','Français',NULL,'oral et écrit',1,2299),(10,'Initiation à l\'Allemand','Allemand','Les bases de la langue allemande pour débutants.','conversation',9,170);
/*!40000 ALTER TABLE `cours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credits`
--

DROP TABLE IF EXISTS `credits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `credits` (
  `id_credit` int NOT NULL AUTO_INCREMENT,
  `id_apprenant` int NOT NULL,
  `id_abonnement` int DEFAULT NULL,
  `montant` decimal(10,2) NOT NULL,
  `date_acquisition` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_credit`),
  KEY `fk_apprenant` (`id_apprenant`),
  KEY `fk_abonnement` (`id_abonnement`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credits`
--

LOCK TABLES `credits` WRITE;
/*!40000 ALTER TABLE `credits` DISABLE KEYS */;
INSERT INTO `credits` VALUES (1,8,2,100.00,'2025-01-09 22:35:00'),(2,8,3,89.01,'2025-01-09 22:44:50'),(3,8,2,100.00,'2025-01-09 22:45:07'),(4,8,2,100.00,'2025-01-09 22:45:33'),(5,8,2,100.00,'2025-01-09 22:45:45'),(6,8,2,100.00,'2025-01-09 22:47:28'),(7,8,2,100.00,'2025-01-09 22:49:36'),(8,8,3,89.01,'2025-01-10 19:35:48'),(9,8,3,89.01,'2025-01-10 21:16:01'),(10,8,3,89.01,'2025-01-10 21:24:15'),(11,8,2,100.00,'2025-01-10 21:28:48'),(12,8,2,100.00,'2025-01-10 21:33:39'),(13,8,2,100.00,'2025-01-10 21:34:49'),(14,8,2,100.00,'2025-01-10 21:35:33'),(15,8,2,100.00,'2025-01-10 21:43:55'),(16,8,3,89.01,'2025-01-10 21:46:41'),(17,8,2,100.00,'2025-01-10 21:50:27'),(18,8,2,100.00,'2025-01-10 21:53:11'),(19,8,3,89.01,'2025-01-10 21:53:30'),(20,8,2,100.00,'2025-01-10 22:01:37'),(21,8,2,100.00,'2025-01-10 22:03:33'),(22,8,2,100.00,'2025-01-10 22:03:44'),(23,8,3,89.01,'2025-01-10 22:05:55'),(24,8,3,89.01,'2025-01-10 22:07:10'),(25,8,2,100.00,'2025-01-10 22:16:17'),(26,8,3,89.01,'2025-01-10 22:17:29'),(27,8,2,100.00,'2025-01-10 22:21:46'),(28,8,2,100.00,'2025-01-10 22:23:35');
/*!40000 ALTER TABLE `credits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factures`
--

DROP TABLE IF EXISTS `factures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `factures` (
  `id_facture` int NOT NULL AUTO_INCREMENT,
  `id_credit` int NOT NULL,
  `pdf_path` varchar(255) DEFAULT NULL,
  `date_facture` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_facture`),
  KEY `id_credit` (`id_credit`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factures`
--

LOCK TABLES `factures` WRITE;
/*!40000 ALTER TABLE `factures` DISABLE KEYS */;
INSERT INTO `factures` VALUES (12,20,'/factures/facture_20.pdf','2025-01-10 22:01:37'),(13,21,'c:/temp/facture_21.pdf','2025-01-10 22:03:34'),(14,22,'c:/temp/facture_22.pdf','2025-01-10 22:03:44'),(15,23,'c:/temp/facture_23.pdf','2025-01-10 22:05:56'),(16,24,'c:/temp/facture_24.pdf','2025-01-10 22:07:10'),(17,25,'c:/temp/facture_25.pdf','2025-01-10 22:16:18'),(18,26,'c:/temp/facture_26.pdf','2025-01-10 22:17:29'),(19,27,'c:/temp/facture_27.pdf','2025-01-10 22:21:47'),(20,28,'c:/temp/facture_28.pdf','2025-01-10 22:23:36');
/*!40000 ALTER TABLE `factures` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (1,1,'Je cherche un partenaire pour pratiquer le français.','Français','2024-11-29 19:17:36'),(2,1,'Je voudrais échanger en espagnol.','Espagnol','2024-11-29 19:17:48'),(3,2,'Quelqu\'un pour pratiquer l\'anglais ?','Anglais','2024-11-29 19:17:48'),(4,3,'J\'aimerais apprendre le chinois.','Anglais','2024-12-08 23:00:00');
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salles`
--

LOCK TABLES `salles` WRITE;
/*!40000 ALTER TABLE `salles` DISABLE KEYS */;
INSERT INTO `salles` VALUES (1,'Salle A','Tableaux interactifs'),(2,'Salle B','Tableaux interactifs, Manuels'),(3,'Salle C','Tableaux interactifs, Casques'),(4,'Salle D','Tableaux interactifs, Manuels'),(5,'Salle E','Tableaux interactifs, Systèmes audio'),(6,'Salle F','Ordinateurs, Casques, Manuels numériques'),(7,'Salle G','Projecteur, Tableaux blancs, Enregistreurs vocaux'),(8,'Salle H','Casques, Systèmes de visioconférence'),(9,'Salle I','Cabines de traduction, Micros, Casques'),(10,'Salle J','Tableaux interactifs, Logiciels d’apprentissage des langues'),(11,'Salle K','Tablettes numériques, Casques audio'),(12,'Salle L','Projecteur interactif, Manuels spécifiques pour le chinois'),(13,'Salle M','Logiciels d’évaluation, Systèmes de réponse interactive'),(14,'Salle N','Projecteur interactif, Supports audio-visuels spécifiques pour l’espagnol');
/*!40000 ALTER TABLE `salles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','apprenant') NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin@example.com','test','admin'),(2,'salomon@example.com','test','apprenant'),(3,'joyce@example.com','test','apprenant'),(4,'snekha@mail.com','1234','admin'),(5,'az@maim.xom','1234','apprenant'),(6,'testtt@maj.com','1222','apprenant'),(7,'meyer@mail.com','1111','apprenant'),(8,'apprenant@mail.com','test','apprenant'),(9,'test1@mail.com','1234','apprenant');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-11  0:33:23
