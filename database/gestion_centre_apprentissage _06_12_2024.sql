-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 06 déc. 2024 à 15:11
-- Version du serveur : 8.2.0
-- Version de PHP : 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `gestion_centre_apprentissage`
--

-- --------------------------------------------------------

--
-- Structure de la table `abonnements`
--

DROP TABLE IF EXISTS `abonnements`;
CREATE TABLE IF NOT EXISTS `abonnements` (
  `id_abonnement` int NOT NULL AUTO_INCREMENT,
  `id_apprenant` int NOT NULL,
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL,
  PRIMARY KEY (`id_abonnement`),
  KEY `id_apprenant` (`id_apprenant`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `abonnements`
--

INSERT INTO `abonnements` (`id_abonnement`, `id_apprenant`, `date_debut`, `date_fin`) VALUES
(1, 4, '2024-02-02', '2024-12-30'),
(2, 2, '2024-06-15', '2025-06-15'),
(3, 3, '2023-09-01', '2024-08-31'),
(4, 4, '2024-03-01', '2024-08-31'),
(5, 5, '2024-10-01', '2025-03-31'),
(6, 1, '2024-01-02', '2024-12-31'),
(8, 5, '2024-10-01', '2025-03-31'),
(9, 1, '2024-02-02', '2024-12-31'),
(10, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `apprenant`
--

DROP TABLE IF EXISTS `apprenant`;
CREATE TABLE IF NOT EXISTS `apprenant` (
  `id_apprenant` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `niveau_langue` varchar(50) DEFAULT NULL,
  `langue_cible` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_apprenant`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `apprenant`
--

INSERT INTO `apprenant` (`id_apprenant`, `nom`, `niveau_langue`, `langue_cible`) VALUES
(1, 'Salomon TSHAUKE ', 'B2', 'Anglais'),
(2, 'Snekha HARIKRISHNAN', 'B1', 'Anglais'),
(3, 'Lee-seing-darino HERINJANAHARY ', 'C1', 'Français'),
(4, 'Alexandros Ones', 'B1', 'Anglais'),
(5, 'Joyce Scrapy', 'C1', 'Français');

-- --------------------------------------------------------

--
-- Structure de la table `cours`
--

DROP TABLE IF EXISTS `cours`;
CREATE TABLE IF NOT EXISTS `cours` (
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

--
-- Déchargement des données de la table `cours`
--

INSERT INTO `cours` (`id_cours`, `nom_cours`, `langue_dispensee`, `descriptions_cours`, `type_cours`, `id_salle`, `tarif_cours`) VALUES
(1, 'Anglais Conversation', 'Anglais', NULL, 'conversation', 1, 150),
(2, 'Atelier de Cuisine Française', 'Français', 'Apprenez à préparer des plats traditionnels français.', 'atelier', 2, 200),
(3, 'Introduction au Japonais', 'Japonais', 'Un cours pour apprendre les bases de la langue japonaise.', 'cours particulier', 3, 250),
(4, 'Espagnol pour Débutants', 'Espagnol', 'Cours pour maîtriser les bases de la langue espagnole.', 'conversation', 1, 180),
(5, 'Cours Intensif de Français', 'Français', 'Formation accélérée pour apprendre rapidement le français.', 'cours particulier', 4, 300),
(6, 'Atelier d\'Italien', 'Italien', 'Pratiquez l\'italien dans un cadre interactif.', 'atelier', 5, 220),
(7, 'Anglais des Affaires', 'Anglais', 'Développez vos compétences en anglais professionnel.', 'conversation', 6, 250),
(8, 'Atelier de Théâtre en Espagnol', 'Espagnol', 'Apprenez l\'espagnol à travers des jeux de rôle et du théâtre.', 'atelier', 7, 210),
(9, 'Cours Particulier de Chinois', 'Chinois', 'Cours privé pour apprendre à lire et écrire le chinois.', 'cours particulier', 8, 350),
(10, 'Initiation à l\'Allemand', 'Allemand', 'Les bases de la langue allemande pour débutants.', 'conversation', 9, 170);

-- --------------------------------------------------------

--
-- Structure de la table `message`
--

DROP TABLE IF EXISTS `message`;
CREATE TABLE IF NOT EXISTS `message` (
  `id_message` int NOT NULL AUTO_INCREMENT,
  `id_apprenant` int NOT NULL,
  `contenu` text NOT NULL,
  `langue_cible` varchar(50) NOT NULL,
  `date_publication` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_message`),
  KEY `id_apprenant` (`id_apprenant`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `message`
--

INSERT INTO `message` (`id_message`, `id_apprenant`, `contenu`, `langue_cible`, `date_publication`) VALUES
(1, 1, 'Je cherche un partenaire pour pratiquer le français.', 'Français', '2024-11-29 20:17:36'),
(2, 1, 'Je voudrais échanger en espagnol.', 'Espagnol', '2024-11-29 20:17:49'),
(3, 2, 'Quelqu\'un pour pratiquer l\'anglais ?', 'Anglais', '2024-11-29 20:17:48'),
(4, 3, 'J\'aimerais apprendre le chinois.', 'Chinois', '2024-11-29 20:17:48'),
(6, 1, 'blabla', 'qdqdqs', '2024-11-29 20:17:49');

-- --------------------------------------------------------

--
-- Structure de la table `salles`
--

DROP TABLE IF EXISTS `salles`;
CREATE TABLE IF NOT EXISTS `salles` (
  `id_salle` int NOT NULL AUTO_INCREMENT,
  `nom_salle` varchar(50) NOT NULL,
  `equipements` text,
  PRIMARY KEY (`id_salle`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `salles`
--

INSERT INTO `salles` (`id_salle`, `nom_salle`, `equipements`) VALUES
(1, 'Salle A', 'Tableaux interactifs, Casques'),
(2, 'Salle B', 'Tableaux interactifs, Manuels'),
(3, 'Salle C', 'Tableaux interactifs, Casques'),
(4, 'Salle D', 'Tableaux interactifs, Manuels'),
(5, 'Salle E', 'Tableaux interactifs, Systèmes audio'),
(6, 'Salle F', 'Ordinateurs, Casques, Manuels numériques'),
(7, 'Salle G', 'Projecteur, Tableaux blancs, Enregistreurs vocaux'),
(8, 'Salle H', 'Casques, Systèmes de visioconférence'),
(9, 'Salle I', 'Cabines de traduction, Micros, Casques'),
(10, 'Salle J', 'Tableaux interactifs, Logiciels d’apprentissage des langues'),
(11, 'Salle K', 'Tablettes numériques, Casques audio'),
(12, 'Salle L', 'Projecteur interactif, Manuels spécifiques pour le chinois'),
(13, 'Salle M', 'Logiciels d’évaluation, Systèmes de réponse interactive'),
(14, 'Salle N', 'Projecteur interactif, Supports audio-visuels spécifiques pour l’espagnol');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `message`
--
ALTER TABLE `message`
  ADD CONSTRAINT `message_ibfk_1` FOREIGN KEY (`id_apprenant`) REFERENCES `apprenant` (`id_apprenant`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
