-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : Dim 20 juin 2021 à 12:55
-- Version du serveur :  10.4.17-MariaDB
-- Version de PHP : 7.3.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `offline`
--

-- --------------------------------------------------------

--
-- Structure de la table `addon_account`
--

CREATE TABLE `addon_account` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `addon_account`
--

INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('organisation_20th', '20Th', 1),
('organisation_Arkan', 'Arkan', 1),
('organisation_aztecas', 'Aztecas', 1),
('organisation_ballas', 'ballas', 1),
('organisation_biker', 'Sons of Anarchy', 1),
('organisation_blackdemon', 'blackdemon', 1),
('organisation_blackos', 'Blackos', 1),
('organisation_bonelli', 'Bonelli', 1),
('organisation_bratiskaia', 'Bratiskaia', 1),
('organisation_cjng', 'CJNG', 1),
('organisation_comorra', 'Comorra', 1),
('organisation_dystopia', 'Dystopia', 1),
('organisation_families', 'families', 1),
('organisation_fields', 'Fields', 1),
('organisation_irish', 'Irish', 1),
('organisation_lost', 'Lost', 1),
('organisation_Madrazo', 'Madrazo', 1),
('organisation_Marabunta', 'Marabunta', 1),
('organisation_oneil', 'Oneil', 1),
('organisation_pcc', 'PCC', 1),
('organisation_reyes', 'Reyes', 1),
('organisation_sacra', 'sacra', 1),
('organisation_sanstreet', 'Sanstreet', 1),
('organisation_sinaloa', 'Sinaloa', 1),
('organisation_triade', 'Triade', 1),
('organisation_vagos', 'vagos', 1),
('organisation_yb16', 'yb16', 1),
('property_black_money', 'Argent Sale Propriété', 0),
('society_abatteur', 'Abatteur', 1),
('society_abatteur_black', 'Abatteur Argent Sale', 1),
('society_altruiste', 'Altruiste', 1),
('society_ambulance', 'Ambulance', 1),
('society_armenien', 'Armenien', 1),
('society_atrax', 'Atrax', 1),
('society_atrax_black', 'Atrax Argent Sale', 1),
('society_avocat', 'Avocat', 1),
('society_avocat_black', 'Avocat Argent Sale', 1),
('society_aztecas', 'aztecas', 1),
('society_bacars', 'Bacars', 1),
('society_bacars_black', 'Bacars Argent Sale', 1),
('society_ballas', 'Ballas', 1),
('society_ballas_black', 'Ballas Argent Sale', 1),
('society_baron', 'baron', 1),
('society_bcfuel', 'bcfuel', 1),
('society_bcfuel_black', 'bcfuel Argent Sale', 1),
('society_beekers', 'Beekers', 1),
('society_bennys', 'Bennys', 1),
('society_bikedealer', 'Concessionnaire Moto', 1),
('society_bkc', 'Bkc', 1),
('society_bkc_black', 'Bkc Argent Sale', 1),
('society_bloodz', 'bloodz', 1),
('society_bucheron', 'Bucheron', 1),
('society_bucheron_black', 'Bucheron Argent Sale', 1),
('society_burgershot', 'BurgerShot', 1),
('society_burgershot_black', 'Burgershot Argent Sale', 1),
('society_cardealer', 'Concessionnaire', 1),
('society_cartel', 'cartel', 1),
('society_cripz', 'cripz', 1),
('society_daymson', 'Daymson', 1),
('society_daymson_black', 'Daymson Argent Sale', 1),
('society_duggan', 'Famille Duggan', 1),
('society_families', 'White', 1),
('society_families_black', 'Families Argent Sale', 1),
('society_famillies', 'famillies', 1),
('society_farm', 'Fermier', 1),
('society_favelas', 'Favelas', 1),
('society_fishing', 'poissonerie', 1),
('society_flash', 'Flash', 1),
('society_flash_black', 'Flash Argent Sale', 1),
('society_fueler', 'Raffineur', 1),
('society_garbage', 'Éboueur', 1),
('society_gardien', 'gardien', 1),
('society_gouv', 'Gouvernement', 1),
('society_guerini', 'guerini', 1),
('society_hippies', 'Hippies', 1),
('society_journalist', 'FlashNews', 1),
('society_journalist_black', 'FlashNews Argent Sale', 1),
('society_lopez', 'lopez', 1),
('society_lost', 'lost', 1),
('society_lostmc', 'LostMc', 1),
('society_lscustoms', 'Ls Customs', 1),
('society_ltds', 'LTD LS', 1),
('society_madrazo', 'Madrazo', 1),
('society_mafia', 'Mafia', 1),
('society_mafia_black', 'Mafia Argent Sale', 1),
('society_marabunta', 'marabunta', 1),
('society_mechanic', 'Mécano', 1),
('society_medeline', 'medeline', 1),
('society_mesa', 'mesa', 1),
('society_militaire', 'Militaire', 1),
('society_nudistes', 'nudistes', 1),
('society_oneil', 'oneil', 1),
('society_palace', 'Palace', 1),
('society_palace_black', 'Palace Argent Sale', 1),
('society_peaky', 'peaky', 1),
('society_peaky_black', 'peaky Argent Sale', 1),
('society_pecheur', 'Pecheur', 1),
('society_pecheur_black', 'Pecheur Argent Sale', 1),
('society_police', 'Police', 1),
('society_police_black', 'Police Argent Sale', 1),
('society_police_black_money', 'Police Black Money', 1),
('society_realestateagent', 'Realestateagent', 1),
('society_rednecks', 'Rednecks', 1),
('society_security', 'Gruppe6', 1),
('society_sheriff', 'Sheriff', 1),
('society_soa', 'Soa', 1),
('society_tabac', 'Tabac', 1),
('society_tabac_black', 'Tabac Argent Sale', 1),
('society_taxi', 'Taxi', 1),
('society_taxi_black', 'Taxi Argent Sale', 1),
('society_Test', 'Test', 1),
('society_triades', 'Triades', 1),
('society_unicorn', 'Unicorn', 1),
('society_unicorn_black', 'Unicorn Argent Sale', 1),
('society_vagos', 'Vagos', 1),
('society_vagos_black', 'Vagos Argent Sale', 1),
('society_vigneron', 'Vigneron', 1),
('society_vigneron_black', 'Vigneron Argent Sale', 1),
('society_weapondealer', 'Trafiquant d\'armes', 1),
('society_weapondealer_black', 'Trafiquant d\'armes Argent Sale', 1),
('society_weed', 'weed', 1),
('vault_black_money', 'Money Vault', 0);

-- --------------------------------------------------------

--
-- Structure de la table `addon_account_data`
--

CREATE TABLE `addon_account_data` (
  `id` int(11) NOT NULL,
  `account_name` varchar(100) DEFAULT NULL,
  `money` int(11) NOT NULL,
  `owner` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `addon_account_data`
--

INSERT INTO `addon_account_data` (`id`, `account_name`, `money`, `owner`) VALUES
(1, 'organisation_20th', 0, NULL),
(2, 'organisation_Arkan', 0, NULL),
(3, 'organisation_aztecas', 0, NULL),
(4, 'organisation_ballas', 0, NULL),
(5, 'organisation_biker', 0, NULL),
(6, 'organisation_blackdemon', 0, NULL),
(7, 'organisation_blackos', 0, NULL),
(8, 'organisation_bonelli', 0, NULL),
(9, 'organisation_bratiskaia', 0, NULL),
(10, 'organisation_cjng', 0, NULL),
(11, 'organisation_comorra', 0, NULL),
(12, 'organisation_dystopia', 0, NULL),
(13, 'organisation_families', 0, NULL),
(14, 'organisation_fields', 0, NULL),
(15, 'organisation_irish', 0, NULL),
(16, 'organisation_lost', 0, NULL),
(17, 'organisation_Madrazo', 0, NULL),
(18, 'organisation_Marabunta', 0, NULL),
(19, 'organisation_oneil', 0, NULL),
(20, 'organisation_pcc', 0, NULL),
(21, 'organisation_reyes', 0, NULL),
(22, 'organisation_sacra', 0, NULL),
(23, 'organisation_sanstreet', 0, NULL),
(24, 'organisation_sinaloa', 0, NULL),
(25, 'organisation_triade', 0, NULL),
(26, 'organisation_vagos', 0, NULL),
(27, 'organisation_yb16', 0, NULL),
(28, 'society_abatteur', 0, NULL),
(29, 'society_abatteur_black', 0, NULL),
(30, 'society_altruiste', 0, NULL),
(31, 'society_ambulance', 325, NULL),
(32, 'society_armenien', 0, NULL),
(33, 'society_atrax', 0, NULL),
(34, 'society_atrax_black', 0, NULL),
(35, 'society_avocat', 0, NULL),
(36, 'society_avocat_black', 0, NULL),
(37, 'society_aztecas', 0, NULL),
(38, 'society_bacars', 0, NULL),
(39, 'society_bacars_black', 0, NULL),
(40, 'society_ballas', 0, NULL),
(41, 'society_ballas_black', 0, NULL),
(42, 'society_baron', 0, NULL),
(43, 'society_bcfuel', 0, NULL),
(44, 'society_bcfuel_black', 0, NULL),
(45, 'society_beekers', 0, NULL),
(46, 'society_bennys', 0, NULL),
(47, 'society_bikedealer', 0, NULL),
(48, 'society_bkc', 0, NULL),
(49, 'society_bkc_black', 0, NULL),
(50, 'society_bloodz', 0, NULL),
(51, 'society_bucheron', 0, NULL),
(52, 'society_bucheron_black', 0, NULL),
(53, 'society_burgershot', 0, NULL),
(54, 'society_burgershot_black', 0, NULL),
(55, 'society_cardealer', 0, NULL),
(56, 'society_cartel', 0, NULL),
(57, 'society_cripz', 0, NULL),
(58, 'society_daymson', 0, NULL),
(59, 'society_daymson_black', 0, NULL),
(60, 'society_duggan', 0, NULL),
(61, 'society_families', 0, NULL),
(62, 'society_families_black', 0, NULL),
(63, 'society_famillies', 0, NULL),
(64, 'society_farm', 0, NULL),
(65, 'society_favelas', 0, NULL),
(66, 'society_fishing', 0, NULL),
(67, 'society_flash', 0, NULL),
(68, 'society_flash_black', 0, NULL),
(69, 'society_fueler', 0, NULL),
(70, 'society_garbage', 0, NULL),
(71, 'society_gardien', 0, NULL),
(72, 'society_gouv', 0, NULL),
(73, 'society_guerini', 0, NULL),
(74, 'society_hippies', 0, NULL),
(75, 'society_journalist', 0, NULL),
(76, 'society_journalist_black', 0, NULL),
(77, 'society_lopez', 0, NULL),
(78, 'society_lost', 0, NULL),
(79, 'society_lostmc', 0, NULL),
(80, 'society_lscustoms', 26980, NULL),
(81, 'society_ltds', 0, NULL),
(82, 'society_madrazo', 0, NULL),
(83, 'society_mafia', 0, NULL),
(84, 'society_mafia_black', 0, NULL),
(85, 'society_marabunta', 0, NULL),
(86, 'society_mechanic', 0, NULL),
(87, 'society_medeline', 0, NULL),
(88, 'society_mesa', 0, NULL),
(89, 'society_militaire', 0, NULL),
(90, 'society_nudistes', 0, NULL),
(91, 'society_oneil', 0, NULL),
(92, 'society_palace', 0, NULL),
(93, 'society_palace_black', 0, NULL),
(94, 'society_peaky', 0, NULL),
(95, 'society_peaky_black', 0, NULL),
(96, 'society_pecheur', 0, NULL),
(97, 'society_pecheur_black', 0, NULL),
(98, 'society_police', 0, NULL),
(99, 'society_police_black', 0, NULL),
(100, 'society_police_black_money', 0, NULL),
(101, 'society_realestateagent', 47315, NULL),
(102, 'society_rednecks', 0, NULL),
(103, 'society_security', 0, NULL),
(104, 'society_sheriff', 0, NULL),
(105, 'society_soa', 0, NULL),
(106, 'society_tabac', 0, NULL),
(107, 'society_tabac_black', 0, NULL),
(108, 'society_taxi', 0, NULL),
(109, 'society_taxi_black', 0, NULL),
(110, 'society_Test', 0, NULL),
(111, 'society_triades', 0, NULL),
(112, 'society_unicorn', 0, NULL),
(113, 'society_unicorn_black', 0, NULL),
(114, 'society_vagos', 0, NULL),
(115, 'society_vagos_black', 0, NULL),
(116, 'society_vigneron', 0, NULL),
(117, 'society_vigneron_black', 0, NULL),
(118, 'society_weapondealer', 0, NULL),
(119, 'society_weapondealer_black', 0, NULL),
(120, 'society_weed', 0, NULL),
(121, 'property_black_money', 0, 'discord:659921990190235650'),
(122, 'vault_black_money', 0, 'discord:659921990190235650'),
(123, 'property_black_money', 0, 'discord:722766829881131038'),
(124, 'vault_black_money', 0, 'discord:722766829881131038');

-- --------------------------------------------------------

--
-- Structure de la table `addon_inventory`
--

CREATE TABLE `addon_inventory` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `addon_inventory`
--

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
('organisation_20th', '20Th', 1),
('organisation_Arkan', 'Arkan', 1),
('organisation_aztecas', 'Aztecas', 1),
('organisation_ballas', 'ballas', 1),
('organisation_biker', 'Sons of Anarchy', 1),
('organisation_blackdemon', 'blackdemon', 1),
('organisation_blackos', 'Blackos', 1),
('organisation_bonelli', 'Bonelli', 1),
('organisation_bratiskaia', 'Bratiskaia', 1),
('organisation_cjng', 'CJNG', 1),
('organisation_comorra', 'Comorra', 1),
('organisation_dystopia', 'Dystopia', 1),
('organisation_families', 'Families', 1),
('organisation_fields', 'Fields', 1),
('organisation_irish', 'Irish', 1),
('organisation_lost', 'Lost', 1),
('organisation_Madrazo', 'Madrazo', 1),
('organisation_Marabunta', 'Marabunta', 1),
('organisation_oneil', 'Oneil', 1),
('organisation_pcc', 'PCC', 1),
('organisation_reyes', 'Reyes', 1),
('organisation_sacra', 'sacra', 1),
('organisation_sanstreet', 'Sanstreet', 1),
('organisation_sinaloa', 'Sinaloa', 1),
('organisation_triade', 'Triade', 1),
('organisation_vagos', 'vagos', 1),
('organisation_yb16', 'yb16', 1),
('property', 'Propriété', 0),
('society_abatteur', 'Abatteur', 1),
('society_altruiste', 'Altruiste', 1),
('society_ambulance', 'Ambulance', 1),
('society_armenien', 'Armenien', 1),
('society_atrax', 'Atrax', 1),
('society_avocat', 'Avocat', 1),
('society_aztecas', 'aztecas', 1),
('society_bacars', 'Bacars', 1),
('society_ballas', 'Ballas', 1),
('society_baron', 'baron', 1),
('society_bcfuel', 'bcfuel', 1),
('society_beekers', 'Beekers', 1),
('society_bennys', 'Bennys', 1),
('society_bikedealer', 'Concesionnaire Moto', 1),
('society_bkc', 'Bkc', 1),
('society_bloods', 'Bloods', 1),
('society_bloodz', 'bloodz', 1),
('society_bucheron', 'Bucheron', 1),
('society_burgershot', 'BurgerShot', 1),
('society_cardealer', 'Concesionnaire', 1),
('society_cartel', 'cartel', 1),
('society_cripz', 'cripz', 1),
('society_daymson', 'Daymson', 1),
('society_duggan', 'Famille Duggan', 1),
('society_families', 'Families', 1),
('society_famillies', 'famillies', 1),
('society_farm', 'Fermier', 1),
('society_favelas', 'Favelas', 1),
('society_fishing', 'Poissonnerie', 1),
('society_flash', 'Flash', 1),
('society_fueler', 'Raffineur', 1),
('society_gardien', 'gardien', 1),
('society_gouv', 'Gouvernement', 1),
('society_guerini', 'guerini', 1),
('society_hippies', 'Hippies', 1),
('society_journalist', 'FlashNews', 1),
('society_lopez', 'lopez', 1),
('society_lost', 'lost', 1),
('society_lostmc', 'LostMc', 1),
('society_lscustoms', 'Ls Customs', 1),
('society_ltds', 'LTD LS', 1),
('society_madrazo', 'Madrazo', 1),
('society_mafia', 'Mafia', 1),
('society_marabunta', 'marabunta', 1),
('society_mechanic', 'Mécano', 1),
('society_medeline', 'medeline', 1),
('society_mesa', 'mesa', 1),
('society_militaire', 'Militaire', 1),
('society_nudistes', 'nudistes', 1),
('society_oneil', 'oneil', 1),
('society_palace', 'Palace', 1),
('society_peaky', 'peaky', 1),
('society_pecheur', 'Pecheur', 1),
('society_police', 'Police', 1),
('society_realestateagent', 'Realestateagent', 1),
('society_rednecks', 'Rednecks', 1),
('society_security', 'Gruppe6', 1),
('society_sheriff', 'Sheriff', 1),
('society_soa', 'Soa', 1),
('society_tabac', 'Tabac', 1),
('society_taxi', 'Taxi', 1),
('society_Test', 'Test', 1),
('society_triades', 'Triades', 1),
('society_unicorn', 'Unicorn', 1),
('society_vagos', 'Vagos', 1),
('society_vigneron', 'Vigneron', 1),
('society_weapondealer', 'trafiquant d\'armes', 1),
('society_weed', 'weed', 1),
('vault', 'Vault', 0);

-- --------------------------------------------------------

--
-- Structure de la table `addon_inventory_items`
--

CREATE TABLE `addon_inventory_items` (
  `id` int(11) NOT NULL,
  `inventory_name` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `count` int(11) NOT NULL,
  `owner` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `addon_inventory_items`
--

INSERT INTO `addon_inventory_items` (`id`, `inventory_name`, `name`, `count`, `owner`) VALUES
(1, 'property', 'gps', 0, 'discord:722766829881131038'),
(2, 'property', 'weapon_ball', 0, 'discord:722766829881131038');

-- --------------------------------------------------------

--
-- Structure de la table `arrests_list`
--

CREATE TABLE `arrests_list` (
  `id` int(11) NOT NULL,
  `json_data` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `baninfo`
--

CREATE TABLE `baninfo` (
  `id` int(11) NOT NULL,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `identifier` varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  `liveid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `xblid` varchar(21) COLLATE utf8mb4_bin DEFAULT NULL,
  `discord` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
  `playerip` varchar(25) COLLATE utf8mb4_bin DEFAULT NULL,
  `playername` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL,
  `Token` longtext COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Déchargement des données de la table `baninfo`
--

INSERT INTO `baninfo` (`id`, `license`, `identifier`, `liveid`, `xblid`, `discord`, `playerip`, `playername`, `Token`) VALUES
(711, 'license:f8a242105b5f668f68232e1d0a919b7287da8d36', 'steam:11000013e993a14', NULL, NULL, 'discord:722766829881131038', 'ip:127.0.0.1', 'TLRR trop ma pute', '[\"1:da664e4830346fd35b08550946fabb7f0faa06db21509642dd93a48974e9fdde\",\"4:6ba35719f0d2d4714245e58226567362eacda0daf67b2af91ba2266362e1bf91\",\"4:4b8cbaf22a665bd09b6596808f7958634262a38547465b29e384b0447a6770e6\",\"4:65b43857e2b69ab19817bcb7f7ca1bc6de3216ecfc7ca1bf0f04eb07d0bccee2\",\"4:79425930b4a743fe95c40ca36dcd38f4b2f765f8ca352dd676e05afd03b05892\",\"4:eaed4478492f820f4b485f3b1a4ba2ad35369c6fe2ffa72edd90f04a503cb0ca\",\"4:496fa05d9ac1a8424b07c150734f2ed9db0f565a3d1fb47a63ca4c89278956cb\",\"4:ba4be31e07e59e345626719f8ba862b7f8fcb8ea0eaf8479ccf9364e02dbdfb8\",\"4:2cee10d06411d3f98dfcbcc6bb93f2e88f22aa2197593f134e5c440edfabffb7\",\"4:f648086e1e51ac9ac8fb96bfc0ce363f23958f22bd032b0553f2c1cdbee8b987\",\"4:abb90062697c977efebd21b6ff1c5139db3e01cc59425a631b8fb1835bd8a60a\",\"4:74d05971641f4fda6fb30b59677b8387b6caa1697b1b4056c452e345243b282e\",\"4:25ce674a6b22a613a5232927dd1ddccac3a4d018851b652eccbcc684df143eab\"]'),
(712, 'license:f8a242105b5f668f68232e1d0a919b7287da8d36', 'steam:11000013e993a14', NULL, NULL, 'discord:722766829881131038', 'ip:127.0.0.1', 'TLRR trop ma pute', '[\"1:da664e4830346fd35b08550946fabb7f0faa06db21509642dd93a48974e9fdde\",\"4:6ba35719f0d2d4714245e58226567362eacda0daf67b2af91ba2266362e1bf91\",\"4:4b8cbaf22a665bd09b6596808f7958634262a38547465b29e384b0447a6770e6\",\"4:65b43857e2b69ab19817bcb7f7ca1bc6de3216ecfc7ca1bf0f04eb07d0bccee2\",\"4:79425930b4a743fe95c40ca36dcd38f4b2f765f8ca352dd676e05afd03b05892\",\"4:eaed4478492f820f4b485f3b1a4ba2ad35369c6fe2ffa72edd90f04a503cb0ca\",\"4:496fa05d9ac1a8424b07c150734f2ed9db0f565a3d1fb47a63ca4c89278956cb\",\"4:ba4be31e07e59e345626719f8ba862b7f8fcb8ea0eaf8479ccf9364e02dbdfb8\",\"4:2cee10d06411d3f98dfcbcc6bb93f2e88f22aa2197593f134e5c440edfabffb7\",\"4:f648086e1e51ac9ac8fb96bfc0ce363f23958f22bd032b0553f2c1cdbee8b987\",\"4:abb90062697c977efebd21b6ff1c5139db3e01cc59425a631b8fb1835bd8a60a\",\"4:74d05971641f4fda6fb30b59677b8387b6caa1697b1b4056c452e345243b282e\",\"4:25ce674a6b22a613a5232927dd1ddccac3a4d018851b652eccbcc684df143eab\"]');

-- --------------------------------------------------------

--
-- Structure de la table `bank_transfer`
--

CREATE TABLE `bank_transfer` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `price` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `bikedealer_vehicles`
--

CREATE TABLE `bikedealer_vehicles` (
  `id` int(11) NOT NULL,
  `vehicle` varchar(255) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `bikes`
--

CREATE TABLE `bikes` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `bike_categories`
--

CREATE TABLE `bike_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `bike_sold`
--

CREATE TABLE `bike_sold` (
  `client` varchar(50) NOT NULL,
  `model` varchar(50) NOT NULL,
  `plate` varchar(50) NOT NULL,
  `soldby` varchar(50) NOT NULL,
  `date` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `billing`
--

CREATE TABLE `billing` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `sender` varchar(255) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `blacklist`
--

CREATE TABLE `blacklist` (
  `id` int(11) NOT NULL,
  `Steam` varchar(255) CHARACTER SET latin1 NOT NULL,
  `SteamLink` text CHARACTER SET latin1 DEFAULT NULL,
  `SteamName` text CHARACTER SET latin1 DEFAULT NULL,
  `DiscordUID` text CHARACTER SET latin1 DEFAULT NULL,
  `DiscordTag` text CHARACTER SET latin1 DEFAULT NULL,
  `GameLicense` text CHARACTER SET latin1 DEFAULT NULL,
  `ip` text CHARACTER SET latin1 DEFAULT NULL,
  `xbl` text CHARACTER SET latin1 DEFAULT NULL,
  `live` text CHARACTER SET latin1 DEFAULT NULL,
  `BanType` text CHARACTER SET latin1 DEFAULT NULL,
  `Other` text CHARACTER SET latin1 DEFAULT NULL,
  `Date` text CHARACTER SET latin1 DEFAULT NULL,
  `Banner` text CHARACTER SET latin1 DEFAULT NULL,
  `Token` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `blacklist`
--

INSERT INTO `blacklist` (`id`, `Steam`, `SteamLink`, `SteamName`, `DiscordUID`, `DiscordTag`, `GameLicense`, `ip`, `xbl`, `live`, `BanType`, `Other`, `Date`, `Banner`, `Token`) VALUES
(1, 'Default', 'Default', 'Default', 'Default', 'Default', 'Default', 'Default', 'Default', 'Default', 'Default', 'Default', 'Default', 'Default', '[\"4:400423cff244c62ba608afcd\",\"4:a602bf2a8924fb0a0aa2bbf8\",\"1:88ac322ede187a4e5a3e\",\"4:52caf4d1cbf74644027a\",\"4:977779c330b6e2d1\",\"4:c7c9b5edb0496\",\"3:5cdbfecf14603956222deae\",\"4:d9a5db096cb4cb8e\",\"4:9f81247074b53bce190eb\"]');

-- --------------------------------------------------------

--
-- Structure de la table `boatdealer_boats`
--

CREATE TABLE `boatdealer_boats` (
  `id` int(11) NOT NULL,
  `vehicle` varchar(255) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `boats`
--

CREATE TABLE `boats` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `boat_categories`
--

CREATE TABLE `boat_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `bolos_list`
--

CREATE TABLE `bolos_list` (
  `id` int(11) NOT NULL,
  `json_data` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `cardealer_vehicles`
--

CREATE TABLE `cardealer_vehicles` (
  `id` int(11) NOT NULL,
  `vehicle` varchar(255) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `cardealer_vehicles`
--

INSERT INTO `cardealer_vehicles` (`id`, `vehicle`, `price`) VALUES
(3, 'sanchez2', 5300),
(7, 'sanchez2', 5300),
(13, 'sanchez2', 5300),
(25, 'nero', 136000),
(34, 'oracle2', 32400),
(45, 'buccaneer2', 17000),
(49, 'coquette4', 125000),
(50, 'coquette4', 125000),
(51, 'coquette4', 125000);

-- --------------------------------------------------------

--
-- Structure de la table `characters`
--

CREATE TABLE `characters` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `dateofbirth` varchar(255) NOT NULL,
  `sex` varchar(1) NOT NULL DEFAULT 'M',
  `height` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `character_current`
--

CREATE TABLE `character_current` (
  `cid` varchar(255) NOT NULL,
  `model` longtext NOT NULL,
  `drawables` longtext NOT NULL,
  `props` longtext NOT NULL,
  `drawtextures` longtext NOT NULL,
  `proptextures` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `clothes`
--

CREATE TABLE `clothes` (
  `id` int(11) NOT NULL,
  `identifier` varchar(100) NOT NULL,
  `skin` longtext NOT NULL,
  `type` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `clothes`
--

INSERT INTO `clothes` (`id`, `identifier`, `skin`, `type`, `name`) VALUES
(1, 'f8a242105b5f668f68232e1d0a919b7287da8d36', '{\"nose_6\":0,\"complexion_2\":10,\"arms_1\":12,\"nose_5\":0,\"sourcils_1\":0,\"bags_2\":0,\"sun_2\":0,\"complexion_1\":0,\"chain_2\":0,\"bproof_2\":0,\"makeup_1\":0,\"bproof_1\":0,\"pants_2\":0,\"makeup_2\":0,\"tshirt_1\":15,\"yeux\":0,\"hair_color_1\":0,\"helmet_1\":-1,\"pants_1\":46,\"bags_1\":0,\"cou\":0,\"ped_2\":0,\"eyebrows_4\":0,\"arms_2\":0,\"blemishes_1\":0,\"nose_1\":0,\"decals_2\":0,\"machoire\":0,\"hair_2\":0,\"bodyb_1\":0,\"eyebrows_3\":0,\"moles_1\":0,\"menton_1\":0,\"blush_1\":0,\"chest_2\":0,\"hair_1\":24,\"ears_2\":0,\"nose_2\":0,\"blush_3\":0,\"face\":0,\"age_1\":0,\"bracelets_1\":-1,\"eyebrows_2\":0,\"nose_4\":0,\"beard_4\":0,\"sun_1\":0,\"age_2\":0,\"hair_color_2\":0,\"nose_3\":0,\"beard_2\":0,\"moles_2\":0,\"ears_1\":-1,\"tshirt_2\":0,\"menton_2\":0,\"menton_3\":0,\"blemishes_2\":0,\"chest_1\":0,\"joues\":0,\"beard_3\":0,\"ped_1\":0,\"bracelets_2\":0,\"beard_1\":0,\"pommettes_2\":0,\"mask_2\":0,\"chain_1\":16,\"blush_2\":0,\"mask_1\":-1,\"makeup_4\":0,\"shoes_1\":19,\"lipstick_3\":0,\"skin\":15,\"glasses_2\":0,\"watches_2\":0,\"torso_1\":14,\"sex\":0,\"decals_1\":0,\"eye_color\":8,\"sourcils_2\":0,\"bodyb_2\":0,\"watches_1\":-1,\"chest_3\":0,\"levres\":0,\"shoes_2\":1,\"eyebrows_1\":0,\"torso_2\":0,\"pommettes_1\":0,\"lipstick_1\":0,\"lipstick_2\":0,\"lipstick_4\":0,\"makeup_3\":0,\"helmet_2\":0,\"glasses_1\":18,\"arms\":12}', 'torso', 'Haut #14'),
(2, 'f8a242105b5f668f68232e1d0a919b7287da8d36', '{\"nose_6\":0,\"complexion_2\":10,\"arms_1\":12,\"nose_5\":0,\"sourcils_1\":0,\"bags_2\":0,\"sun_2\":0,\"complexion_1\":0,\"chain_2\":0,\"bproof_2\":0,\"makeup_1\":0,\"bproof_1\":0,\"pants_2\":0,\"makeup_2\":0,\"tshirt_1\":15,\"yeux\":0,\"hair_color_1\":0,\"helmet_1\":14,\"pants_1\":46,\"bags_1\":0,\"cou\":0,\"ped_2\":0,\"eyebrows_4\":0,\"arms_2\":0,\"blemishes_1\":0,\"nose_1\":0,\"decals_2\":0,\"machoire\":0,\"hair_2\":0,\"bodyb_1\":0,\"eyebrows_3\":0,\"moles_1\":0,\"menton_1\":0,\"blush_1\":0,\"chest_2\":0,\"hair_1\":24,\"ears_2\":0,\"nose_2\":0,\"blush_3\":0,\"face\":0,\"age_1\":0,\"bracelets_1\":-1,\"eyebrows_2\":0,\"nose_4\":0,\"beard_4\":0,\"sun_1\":0,\"age_2\":0,\"hair_color_2\":0,\"nose_3\":0,\"beard_2\":0,\"moles_2\":0,\"ears_1\":-1,\"tshirt_2\":0,\"menton_2\":0,\"menton_3\":0,\"blemishes_2\":0,\"chest_1\":0,\"joues\":0,\"beard_3\":0,\"ped_1\":0,\"bracelets_2\":0,\"beard_1\":0,\"pommettes_2\":0,\"mask_2\":0,\"chain_1\":16,\"blush_2\":0,\"mask_1\":-1,\"makeup_4\":0,\"shoes_1\":19,\"lipstick_3\":0,\"skin\":15,\"glasses_2\":0,\"watches_2\":0,\"torso_1\":14,\"sex\":0,\"decals_1\":0,\"eye_color\":8,\"sourcils_2\":0,\"bodyb_2\":0,\"watches_1\":-1,\"chest_3\":0,\"levres\":0,\"shoes_2\":1,\"eyebrows_1\":0,\"torso_2\":0,\"pommettes_1\":0,\"lipstick_1\":0,\"lipstick_2\":0,\"lipstick_4\":0,\"makeup_3\":0,\"helmet_2\":0,\"glasses_1\":18,\"arms\":12}', 'helmet', 'Chapeau #15'),
(3, 'f8a242105b5f668f68232e1d0a919b7287da8d36', '{\"nose_6\":0,\"complexion_2\":10,\"arms_1\":12,\"nose_5\":0,\"sourcils_1\":0,\"bags_2\":0,\"sun_2\":0,\"complexion_1\":0,\"chain_2\":0,\"bproof_2\":0,\"makeup_1\":0,\"bproof_1\":0,\"pants_2\":0,\"makeup_2\":0,\"tshirt_1\":15,\"yeux\":0,\"hair_color_1\":0,\"helmet_1\":14,\"pants_1\":46,\"bags_1\":0,\"cou\":0,\"ped_2\":0,\"eyebrows_4\":0,\"arms_2\":0,\"blemishes_1\":0,\"nose_1\":0,\"decals_2\":0,\"machoire\":0,\"hair_2\":0,\"bodyb_1\":0,\"eyebrows_3\":0,\"moles_1\":0,\"menton_1\":0,\"blush_1\":0,\"chest_2\":0,\"hair_1\":24,\"ears_2\":0,\"nose_2\":0,\"blush_3\":0,\"face\":0,\"age_1\":0,\"bracelets_1\":-1,\"eyebrows_2\":0,\"nose_4\":0,\"beard_4\":0,\"sun_1\":0,\"age_2\":0,\"hair_color_2\":0,\"nose_3\":0,\"beard_2\":0,\"moles_2\":0,\"ears_1\":-1,\"tshirt_2\":0,\"menton_2\":0,\"menton_3\":0,\"blemishes_2\":0,\"chest_1\":0,\"joues\":0,\"beard_3\":0,\"ped_1\":0,\"bracelets_2\":0,\"beard_1\":0,\"pommettes_2\":0,\"mask_2\":0,\"chain_1\":16,\"blush_2\":0,\"mask_1\":-1,\"makeup_4\":0,\"shoes_1\":19,\"lipstick_3\":0,\"skin\":15,\"glasses_2\":0,\"watches_2\":0,\"torso_1\":14,\"sex\":0,\"decals_1\":0,\"eye_color\":8,\"sourcils_2\":0,\"bodyb_2\":0,\"watches_1\":-1,\"chest_3\":0,\"levres\":0,\"shoes_2\":1,\"eyebrows_1\":0,\"torso_2\":0,\"pommettes_1\":0,\"lipstick_1\":0,\"lipstick_2\":0,\"lipstick_4\":0,\"makeup_3\":0,\"helmet_2\":1,\"glasses_1\":18,\"arms\":12}', 'helmet', 'Chapeau #15'),
(4, 'f8a242105b5f668f68232e1d0a919b7287da8d36', '{\"nose_6\":0,\"complexion_2\":10,\"arms_1\":12,\"nose_5\":0,\"sourcils_1\":0,\"bags_2\":0,\"sun_2\":0,\"complexion_1\":0,\"chain_2\":0,\"bproof_2\":0,\"makeup_1\":0,\"bproof_1\":0,\"pants_2\":0,\"makeup_2\":0,\"tshirt_1\":15,\"yeux\":0,\"hair_color_1\":0,\"helmet_1\":14,\"pants_1\":46,\"bags_1\":0,\"cou\":0,\"ped_2\":0,\"eyebrows_4\":0,\"arms_2\":0,\"blemishes_1\":0,\"nose_1\":0,\"decals_2\":0,\"machoire\":0,\"hair_2\":0,\"bodyb_1\":0,\"eyebrows_3\":0,\"moles_1\":0,\"menton_1\":0,\"blush_1\":0,\"chest_2\":0,\"hair_1\":24,\"ears_2\":0,\"nose_2\":0,\"blush_3\":0,\"face\":0,\"age_1\":0,\"bracelets_1\":-1,\"eyebrows_2\":0,\"nose_4\":0,\"beard_4\":0,\"sun_1\":0,\"age_2\":0,\"hair_color_2\":0,\"nose_3\":0,\"beard_2\":0,\"moles_2\":0,\"ears_1\":-1,\"tshirt_2\":0,\"menton_2\":0,\"menton_3\":0,\"blemishes_2\":0,\"chest_1\":0,\"joues\":0,\"beard_3\":0,\"ped_1\":0,\"bracelets_2\":0,\"beard_1\":0,\"pommettes_2\":0,\"mask_2\":0,\"chain_1\":16,\"blush_2\":0,\"mask_1\":-1,\"makeup_4\":0,\"shoes_1\":19,\"lipstick_3\":0,\"skin\":15,\"glasses_2\":0,\"watches_2\":0,\"torso_1\":14,\"sex\":0,\"decals_1\":0,\"eye_color\":8,\"sourcils_2\":0,\"bodyb_2\":0,\"watches_1\":-1,\"chest_3\":0,\"levres\":0,\"shoes_2\":1,\"eyebrows_1\":0,\"torso_2\":0,\"pommettes_1\":0,\"lipstick_1\":0,\"lipstick_2\":0,\"lipstick_4\":0,\"makeup_3\":0,\"helmet_2\":1,\"glasses_1\":7,\"arms\":12}', 'glasses', 'Lunettes #7'),
(5, 'f8a242105b5f668f68232e1d0a919b7287da8d36', '{\"nose_6\":0,\"complexion_2\":10,\"arms_1\":12,\"nose_5\":0,\"sourcils_1\":0,\"bags_2\":0,\"sun_2\":0,\"complexion_1\":0,\"chain_2\":0,\"bproof_2\":0,\"makeup_1\":0,\"bproof_1\":0,\"pants_2\":0,\"makeup_2\":0,\"tshirt_1\":15,\"yeux\":0,\"hair_color_1\":0,\"helmet_1\":14,\"pants_1\":46,\"bags_1\":45,\"cou\":0,\"ped_2\":0,\"eyebrows_4\":0,\"arms_2\":0,\"blemishes_1\":0,\"nose_1\":0,\"decals_2\":0,\"machoire\":0,\"hair_2\":0,\"bodyb_1\":0,\"eyebrows_3\":0,\"moles_1\":0,\"menton_1\":0,\"blush_1\":0,\"chest_2\":0,\"hair_1\":24,\"ears_2\":0,\"nose_2\":0,\"blush_3\":0,\"face\":0,\"age_1\":0,\"bracelets_1\":-1,\"eyebrows_2\":0,\"nose_4\":0,\"beard_4\":0,\"sun_1\":0,\"age_2\":0,\"hair_color_2\":0,\"nose_3\":0,\"beard_2\":0,\"moles_2\":0,\"ears_1\":-1,\"tshirt_2\":0,\"menton_2\":0,\"menton_3\":0,\"blemishes_2\":0,\"chest_1\":0,\"joues\":0,\"beard_3\":0,\"ped_1\":0,\"bracelets_2\":0,\"beard_1\":0,\"pommettes_2\":0,\"mask_2\":0,\"chain_1\":16,\"blush_2\":0,\"mask_1\":-1,\"makeup_4\":0,\"shoes_1\":19,\"lipstick_3\":0,\"skin\":15,\"glasses_2\":0,\"watches_2\":0,\"torso_1\":14,\"sex\":0,\"decals_1\":0,\"eye_color\":8,\"sourcils_2\":0,\"bodyb_2\":0,\"watches_1\":-1,\"chest_3\":0,\"levres\":0,\"shoes_2\":1,\"eyebrows_1\":0,\"torso_2\":0,\"pommettes_1\":0,\"lipstick_1\":0,\"lipstick_2\":0,\"lipstick_4\":0,\"makeup_3\":0,\"helmet_2\":1,\"glasses_1\":7,\"arms\":12}', 'bags', 'Sac #45'),
(6, 'f8a242105b5f668f68232e1d0a919b7287da8d36', '{\"nose_6\":0,\"complexion_2\":10,\"arms_1\":12,\"nose_5\":0,\"sourcils_1\":0,\"bags_2\":0,\"sun_2\":0,\"complexion_1\":0,\"chain_2\":0,\"bproof_2\":0,\"makeup_1\":0,\"bproof_1\":0,\"pants_2\":0,\"makeup_2\":0,\"tshirt_1\":15,\"yeux\":0,\"hair_color_1\":0,\"helmet_1\":14,\"pants_1\":46,\"bags_1\":45,\"cou\":0,\"ped_2\":0,\"eyebrows_4\":0,\"arms_2\":0,\"blemishes_1\":0,\"nose_1\":0,\"decals_2\":0,\"machoire\":0,\"hair_2\":0,\"bodyb_1\":0,\"eyebrows_3\":0,\"moles_1\":0,\"menton_1\":0,\"blush_1\":0,\"chest_2\":0,\"hair_1\":24,\"ears_2\":0,\"nose_2\":0,\"blush_3\":0,\"face\":0,\"age_1\":0,\"bracelets_1\":-1,\"eyebrows_2\":0,\"nose_4\":0,\"beard_4\":0,\"sun_1\":0,\"age_2\":0,\"hair_color_2\":0,\"nose_3\":0,\"beard_2\":0,\"moles_2\":0,\"ears_1\":-1,\"tshirt_2\":0,\"menton_2\":0,\"menton_3\":0,\"blemishes_2\":0,\"chest_1\":0,\"joues\":0,\"beard_3\":0,\"ped_1\":0,\"bracelets_2\":0,\"beard_1\":0,\"pommettes_2\":0,\"mask_2\":0,\"chain_1\":16,\"blush_2\":0,\"mask_1\":-1,\"makeup_4\":0,\"shoes_1\":19,\"lipstick_3\":0,\"skin\":15,\"glasses_2\":0,\"watches_2\":0,\"torso_1\":14,\"sex\":0,\"decals_1\":0,\"eye_color\":8,\"sourcils_2\":0,\"bodyb_2\":0,\"watches_1\":-1,\"chest_3\":0,\"levres\":0,\"shoes_2\":1,\"eyebrows_1\":0,\"torso_2\":0,\"pommettes_1\":0,\"lipstick_1\":0,\"lipstick_2\":0,\"lipstick_4\":0,\"makeup_3\":0,\"helmet_2\":1,\"glasses_1\":7,\"arms\":12}', 'tenue', 'Test zk'),
(7, 'f8a242105b5f668f68232e1d0a919b7287da8d36', '{\"nose_6\":0,\"bproof_2\":0,\"arms_2\":0,\"machoire\":0,\"tshirt_2\":0,\"ped_2\":0,\"eyebrows_1\":0,\"hair_color_1\":10,\"tshirt_1\":15,\"glasses_1\":7,\"age_1\":0,\"pants_2\":0,\"helmet_1\":14,\"chain_2\":0,\"makeup_4\":0,\"menton_1\":0,\"nose_3\":0,\"skin\":15,\"shoes_2\":1,\"yeux\":0,\"beard_2\":0,\"nose_4\":0,\"makeup_1\":0,\"makeup_2\":0,\"complexion_2\":10,\"levres\":0,\"bodyb_2\":0,\"lipstick_3\":0,\"chest_2\":0,\"pommettes_2\":0,\"mask_2\":0,\"face\":0,\"complexion_1\":0,\"sourcils_1\":0,\"blemishes_1\":0,\"nose_1\":0,\"sourcils_2\":0,\"menton_2\":0,\"eye_color\":8,\"ears_1\":-1,\"ears_2\":0,\"bproof_1\":0,\"hair_1\":57,\"beard_1\":0,\"nose_2\":0,\"pants_1\":46,\"sun_1\":0,\"moles_1\":0,\"hair_color_2\":0,\"decals_2\":0,\"lipstick_2\":0,\"sun_2\":0,\"torso_2\":0,\"decals_1\":0,\"shoes_1\":19,\"nose_5\":0,\"beard_3\":0,\"menton_3\":0,\"cou\":0,\"beard_4\":0,\"bags_1\":45,\"bracelets_1\":-1,\"bags_2\":0,\"eyebrows_2\":0,\"mask_1\":-1,\"blush_2\":0,\"blush_3\":0,\"torso_1\":14,\"helmet_2\":1,\"joues\":0,\"blush_1\":0,\"bodyb_1\":0,\"eyebrows_3\":0,\"watches_1\":-1,\"blemishes_2\":0,\"moles_2\":0,\"lipstick_1\":0,\"chest_3\":0,\"makeup_3\":0,\"arms\":0,\"eyebrows_4\":0,\"sex\":0,\"hair_2\":0,\"pommettes_1\":0,\"chain_1\":16,\"glasses_2\":0,\"ped_1\":0,\"arms_1\":0,\"chest_1\":0,\"watches_2\":0,\"age_2\":0,\"lipstick_4\":0,\"bracelets_2\":0}', 'torso', 'Haut #350'),
(8, 'f8a242105b5f668f68232e1d0a919b7287da8d36', '{\"nose_6\":0,\"bproof_2\":0,\"arms_2\":0,\"machoire\":0,\"tshirt_2\":0,\"ped_2\":0,\"eyebrows_1\":0,\"hair_color_1\":10,\"tshirt_1\":15,\"glasses_1\":7,\"age_1\":0,\"pants_2\":0,\"helmet_1\":14,\"chain_2\":0,\"makeup_4\":0,\"menton_1\":0,\"nose_3\":0,\"skin\":15,\"shoes_2\":1,\"yeux\":0,\"beard_2\":0,\"nose_4\":0,\"makeup_1\":0,\"makeup_2\":0,\"complexion_2\":10,\"levres\":0,\"bodyb_2\":0,\"lipstick_3\":0,\"chest_2\":0,\"pommettes_2\":0,\"mask_2\":0,\"face\":0,\"complexion_1\":0,\"sourcils_1\":0,\"blemishes_1\":0,\"nose_1\":0,\"sourcils_2\":0,\"menton_2\":0,\"eye_color\":8,\"ears_1\":-1,\"ears_2\":0,\"bproof_1\":0,\"hair_1\":57,\"beard_1\":0,\"nose_2\":0,\"pants_1\":46,\"sun_1\":0,\"moles_1\":0,\"hair_color_2\":0,\"decals_2\":0,\"lipstick_2\":0,\"sun_2\":0,\"torso_2\":0,\"decals_1\":0,\"shoes_1\":19,\"nose_5\":0,\"beard_3\":0,\"menton_3\":0,\"cou\":0,\"beard_4\":0,\"bags_1\":45,\"bracelets_1\":-1,\"bags_2\":0,\"eyebrows_2\":0,\"mask_1\":-1,\"blush_2\":0,\"blush_3\":0,\"torso_1\":14,\"helmet_2\":1,\"joues\":0,\"blush_1\":0,\"bodyb_1\":0,\"eyebrows_3\":0,\"watches_1\":-1,\"blemishes_2\":0,\"moles_2\":0,\"lipstick_1\":0,\"chest_3\":0,\"makeup_3\":0,\"arms\":12,\"eyebrows_4\":0,\"sex\":0,\"hair_2\":0,\"pommettes_1\":0,\"chain_1\":16,\"glasses_2\":0,\"ped_1\":0,\"arms_1\":12,\"chest_1\":0,\"watches_2\":0,\"age_2\":0,\"lipstick_4\":0,\"bracelets_2\":0}', 'tenue', 'ETTTSYS');

-- --------------------------------------------------------

--
-- Structure de la table `datastore`
--

CREATE TABLE `datastore` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `datastore`
--

INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
('organisation_20th', '20Th', 1),
('organisation_Arkan', 'Arkan', 1),
('organisation_aztecas', 'Aztecas', 1),
('organisation_ballas', 'ballas', 1),
('organisation_biker', 'Sons of Anarchy', 1),
('organisation_blackdemon', 'blackdemon', 1),
('organisation_blackos', 'Blackos', 1),
('organisation_bonelli', 'Bonelli', 1),
('organisation_bratiskaia', 'Bratiskaia', 1),
('organisation_cjng', 'CJNG', 1),
('organisation_comorra', 'Comorra', 1),
('organisation_dystopia', 'Dystopia', 1),
('organisation_families', 'families', 1),
('organisation_fields', 'Fields', 1),
('organisation_irish', 'Irish', 1),
('organisation_lost', 'Lost', 1),
('organisation_Madrazo', 'Madrazo', 1),
('organisation_Marabunta', 'Marabunta', 1),
('organisation_oneil', 'Oneil', 1),
('organisation_pcc', 'PCC', 1),
('organisation_reyes', 'Reyes', 1),
('organisation_sacra', 'sacra', 1),
('organisation_sanstreet', 'Sanstreet', 1),
('organisation_sinaloa', 'Sinaloa', 1),
('organisation_triade', 'Triade', 1),
('organisation_vagos', 'vagos', 1),
('organisation_yb16', 'yb16', 1),
('property', 'Propriété', 0),
('society_abatteur', 'Abatteur', 1),
('society_altruiste', 'Altruiste', 1),
('society_ambulance', 'Ambulance', 1),
('society_armenien', 'Armenien', 1),
('society_atrax', 'Atrax', 1),
('society_avocat', 'Avocat', 1),
('society_aztecas', 'aztecas', 1),
('society_bacars', 'Bacars', 1),
('society_ballas', 'Ballas', 1),
('society_baron', 'baron', 1),
('society_bcfuel', 'bcfuel', 1),
('society_bkc', 'Bkc', 1),
('society_bloodz', 'bloodz', 1),
('society_bucheron', 'Bucheron', 1),
('society_burgershot', 'BurgerShot', 1),
('society_cartel', 'cartel', 1),
('society_cripz', 'cripz', 1),
('society_daymson', 'Daymson', 1),
('society_duggan', 'Famille Duggan', 1),
('society_families', 'Families', 1),
('society_famillies', 'famillies', 1),
('society_farm', 'Fermier', 1),
('society_favelas', 'Favelas', 1),
('society_fishing', 'Poissonnerie', 1),
('society_flash', 'Flash', 1),
('society_fueler', 'Raffineur', 1),
('society_gardien', 'gardien', 1),
('society_gouv', 'Gouvernement', 1),
('society_guerini', 'guerini', 1),
('society_hippies', 'Hippies', 1),
('society_journalist', 'FlashNews', 1),
('society_lopez', 'lopez', 1),
('society_lost', 'lost', 1),
('society_lostmc', 'LostMc', 1),
('society_madrazo', 'Madrazo', 1),
('society_mafia', 'Mafia', 1),
('society_marabunta', 'marabunta', 1),
('society_medeline', 'medeline', 1),
('society_mesa', 'mesa', 1),
('society_militaire', 'Militaire', 1),
('society_nudistes', 'nudistes', 1),
('society_oneil', 'oneil', 1),
('society_palace', 'Palace', 1),
('society_peaky', 'peaky', 1),
('society_pecheur', 'Pecheur', 1),
('society_police', 'Police', 1),
('society_realestateagent', 'Realestateagent', 1),
('society_rednecks', 'Rednecks', 1),
('society_security', 'Gruppe6', 1),
('society_sheriff', 'Sheriff', 1),
('society_soa', 'Soa', 1),
('society_tabac', 'Tabac', 1),
('society_taxi', 'Taxi', 1),
('society_Test', 'Test', 1),
('society_triades', 'Triades', 1),
('society_unicorn', 'Unicorn', 1),
('society_vagos', 'Vagos', 1),
('society_vigneron', 'Vigneron', 1),
('society_weapondealer', 'trafiquant d\'armes', 1),
('society_weapons_atrax', 'Weapons Atrax', 1),
('society_weapons_aztecas', 'Weapons aztecas', 1),
('society_weapons_ballas', 'Weapons Ballas', 1),
('society_weapons_baron', 'Weapons baron', 1),
('society_weapons_bkc', 'Weapons BKC', 1),
('society_weapons_bloodz', 'Weapons bloodz', 1),
('society_weapons_cartel', 'Weapons cartel', 1),
('society_weapons_cripz', 'Weapons cripz', 1),
('society_weapons_families', 'Weapons Families', 1),
('society_weapons_flash', 'Weapons Flash', 1),
('society_weapons_guerini', 'Weapons guerini', 1),
('society_weapons_lopez', 'Weapons lopez', 1),
('society_weapons_lost', 'Weapons lost', 1),
('society_weapons_mafia', 'Weapons Mafia', 1),
('society_weapons_marabunta', 'Weapons marabunta', 1),
('society_weapons_medeline', 'Weapons medeline', 1),
('society_weapons_mesa', 'Weapons mesa', 1),
('society_weapons_nudistes', 'Weapons nudistes', 1),
('society_weapons_oneil', 'Weapons oneil', 1),
('society_weapons_peaky', 'Weapons peaky', 1),
('society_weapons_vagos', 'Weapons Vagos', 1),
('society_weapons_weapondealer', 'Weapons trafiquant d\'armes', 1),
('society_weapons_weed', 'Weapons weed', 1),
('society_weed', 'weed', 1),
('society_white', 'White', 1),
('user_ears', 'Ears', 0),
('user_garages', 'Garage', 0),
('user_glasses', 'Glasses', 0),
('user_helmet', 'Helmet', 0),
('user_mask', 'Mask', 0),
('vault', 'Vault', 0);

-- --------------------------------------------------------

--
-- Structure de la table `datastore_data`
--

CREATE TABLE `datastore_data` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `owner` varchar(60) DEFAULT NULL,
  `data` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `datastore_data`
--

INSERT INTO `datastore_data` (`id`, `name`, `owner`, `data`) VALUES
(1, 'organisation_20th', NULL, '{}'),
(2, 'organisation_Arkan', NULL, '{}'),
(3, 'organisation_aztecas', NULL, '{}'),
(4, 'organisation_ballas', NULL, '{}'),
(5, 'organisation_biker', NULL, '{}'),
(6, 'organisation_blackdemon', NULL, '{}'),
(7, 'organisation_blackos', NULL, '{}'),
(8, 'organisation_bonelli', NULL, '{}'),
(9, 'organisation_bratiskaia', NULL, '{}'),
(10, 'organisation_cjng', NULL, '{}'),
(11, 'organisation_comorra', NULL, '{}'),
(12, 'organisation_dystopia', NULL, '{}'),
(13, 'organisation_families', NULL, '{}'),
(14, 'organisation_fields', NULL, '{}'),
(15, 'organisation_irish', NULL, '{}'),
(16, 'organisation_lost', NULL, '{}'),
(17, 'organisation_Madrazo', NULL, '{}'),
(18, 'organisation_Marabunta', NULL, '{}'),
(19, 'organisation_oneil', NULL, '{}'),
(20, 'organisation_pcc', NULL, '{}'),
(21, 'organisation_reyes', NULL, '{}'),
(22, 'organisation_sacra', NULL, '{}'),
(23, 'organisation_sanstreet', NULL, '{}'),
(24, 'organisation_sinaloa', NULL, '{}'),
(25, 'organisation_triade', NULL, '{}'),
(26, 'organisation_vagos', NULL, '{}'),
(27, 'organisation_yb16', NULL, '{}'),
(28, 'society_abatteur', NULL, '{}'),
(29, 'society_altruiste', NULL, '{}'),
(30, 'society_ambulance', NULL, '{}'),
(31, 'society_armenien', NULL, '{}'),
(32, 'society_atrax', NULL, '{}'),
(33, 'society_avocat', NULL, '{}'),
(34, 'society_aztecas', NULL, '{}'),
(35, 'society_bacars', NULL, '{}'),
(36, 'society_ballas', NULL, '{}'),
(37, 'society_baron', NULL, '{}'),
(38, 'society_bcfuel', NULL, '{}'),
(39, 'society_bkc', NULL, '{}'),
(40, 'society_bloodz', NULL, '{}'),
(41, 'society_bucheron', NULL, '{}'),
(42, 'society_burgershot', NULL, '{}'),
(43, 'society_cartel', NULL, '{}'),
(44, 'society_cripz', NULL, '{}'),
(45, 'society_daymson', NULL, '{}'),
(46, 'society_duggan', NULL, '{}'),
(47, 'society_families', NULL, '{}'),
(48, 'society_famillies', NULL, '{}'),
(49, 'society_farm', NULL, '{}'),
(50, 'society_favelas', NULL, '{}'),
(51, 'society_fishing', NULL, '{}'),
(52, 'society_flash', NULL, '{}'),
(53, 'society_fueler', NULL, '{}'),
(54, 'society_gardien', NULL, '{}'),
(55, 'society_gouv', NULL, '{}'),
(56, 'society_guerini', NULL, '{}'),
(57, 'society_hippies', NULL, '{}'),
(58, 'society_journalist', NULL, '{}'),
(59, 'society_lopez', NULL, '{}'),
(60, 'society_lost', NULL, '{}'),
(61, 'society_lostmc', NULL, '{}'),
(62, 'society_madrazo', NULL, '{}'),
(63, 'society_mafia', NULL, '{}'),
(64, 'society_marabunta', NULL, '{}'),
(65, 'society_medeline', NULL, '{}'),
(66, 'society_mesa', NULL, '{}'),
(67, 'society_militaire', NULL, '{}'),
(68, 'society_nudistes', NULL, '{}'),
(69, 'society_oneil', NULL, '{}'),
(70, 'society_palace', NULL, '{}'),
(71, 'society_peaky', NULL, '{}'),
(72, 'society_pecheur', NULL, '{}'),
(73, 'society_police', NULL, '{}'),
(74, 'society_realestateagent', NULL, '{}'),
(75, 'society_rednecks', NULL, '{}'),
(76, 'society_security', NULL, '{}'),
(77, 'society_sheriff', NULL, '{}'),
(78, 'society_soa', NULL, '{}'),
(79, 'society_tabac', NULL, '{}'),
(80, 'society_taxi', NULL, '{}'),
(81, 'society_Test', NULL, '{}'),
(82, 'society_triades', NULL, '{}'),
(83, 'society_unicorn', NULL, '{}'),
(84, 'society_vagos', NULL, '{}'),
(85, 'society_vigneron', NULL, '{}'),
(86, 'society_weapondealer', NULL, '{}'),
(87, 'society_weapons_atrax', NULL, '{}'),
(88, 'society_weapons_aztecas', NULL, '{}'),
(89, 'society_weapons_ballas', NULL, '{}'),
(90, 'society_weapons_baron', NULL, '{}'),
(91, 'society_weapons_bkc', NULL, '{}'),
(92, 'society_weapons_bloodz', NULL, '{}'),
(93, 'society_weapons_cartel', NULL, '{}'),
(94, 'society_weapons_cripz', NULL, '{}'),
(95, 'society_weapons_families', NULL, '{}'),
(96, 'society_weapons_flash', NULL, '{}'),
(97, 'society_weapons_guerini', NULL, '{}'),
(98, 'society_weapons_lopez', NULL, '{}'),
(99, 'society_weapons_lost', NULL, '{}'),
(100, 'society_weapons_mafia', NULL, '{}'),
(101, 'society_weapons_marabunta', NULL, '{}'),
(102, 'society_weapons_medeline', NULL, '{}'),
(103, 'society_weapons_mesa', NULL, '{}'),
(104, 'society_weapons_nudistes', NULL, '{}'),
(105, 'society_weapons_oneil', NULL, '{}'),
(106, 'society_weapons_peaky', NULL, '{}'),
(107, 'society_weapons_vagos', NULL, '{}'),
(108, 'society_weapons_weapondealer', NULL, '{}'),
(109, 'society_weapons_weed', NULL, '{}'),
(110, 'society_weed', NULL, '{}'),
(111, 'society_white', NULL, '{}'),
(112, 'user_ears', 'discord:659921990190235650', '{\"hasEars\":true,\"skin\":{\"ears_1\":-1,\"ears_2\":0}}'),
(113, 'user_garages', 'discord:659921990190235650', '{}'),
(114, 'user_helmet', 'discord:659921990190235650', '{\"skin\":{\"helmet_1\":-1,\"helmet_2\":0},\"hasHelmet\":true}'),
(115, 'user_mask', 'discord:659921990190235650', '{\"hasMask\":true,\"skin\":{\"mask_1\":0,\"mask_2\":0}}'),
(116, 'user_glasses', 'discord:659921990190235650', '{\"skin\":{\"glasses_1\":0,\"glasses_2\":0},\"hasGlasses\":true}'),
(117, 'vault', 'discord:659921990190235650', '{}'),
(118, 'property', 'discord:659921990190235650', '{}'),
(119, 'property', 'discord:722766829881131038', '{\"dressing\":[{\"label\":\"Test\",\"skin\":{\"bproof_1\":0,\"lipstick_1\":0,\"bags_2\":0,\"Abaissementdumenton\":0,\"pants_1\":1,\"sun_2\":0,\"Epaisseurdeslevres\":0,\"hair_color_1\":0,\"beard_2\":0,\"complexion_1\":0,\"Hauteurdespommettes\":0,\"Largeurdumenton\":0,\"torso_1\":80,\"eyebrows_2\":0,\"Abaissementpicdunez\":20,\"ears_2\":0,\"sun_1\":0,\"Torsiondunez\":20,\"bodyb_1\":0,\"eyebrows_3\":0,\"lipstick_4\":0,\"hair_color_2\":0,\"bproof_2\":0,\"blush_2\":0,\"chest_1\":0,\"watches_2\":0,\"moles_1\":0,\"Largeurdelamachoire\":0,\"lipstick_3\":0,\"facepeds2\":0,\"hair_1\":0,\"chest_3\":0,\"skin\":2,\"blush_1\":0,\"blemishes_2\":0,\"arms\":15,\"Longueurdudosdelamachoire\":0,\"Epaisseurducou\":0,\"shoes_2\":0,\"pants_2\":0,\"Hauteurnez\":20,\"age_2\":0,\"beard_1\":0,\"blush_3\":0,\"blemishes_1\":0,\"Profondeursourcils\":0,\"bodyb_2\":0,\"shoes_1\":1,\"mask_1\":0,\"Ouverturedesyeux\":0,\"complexion_2\":0,\"moles_2\":0,\"lipstick_2\":0,\"bracelets_1\":-1,\"Largeurdesjoues\":0,\"chain_2\":0,\"decals_1\":0,\"Troudumenton\":0,\"makeup_4\":0,\"bags_1\":0,\"glasses_2\":0,\"tshirt_2\":0,\"chest_2\":0,\"mask_2\":0,\"torso_2\":1,\"makeup_3\":0,\"watches_1\":-1,\"bracelets_2\":0,\"eyebrows_4\":0,\"Largeurdespommettes\":0,\"eyebrows_1\":0,\"sex\":0,\"helmet_1\":120,\"age_1\":0,\"glasses_1\":2,\"arms_2\":0,\"makeup_2\":0,\"chain_1\":0,\"Largeurnez\":20,\"eye_color\":0,\"Abaissementdunez\":20,\"Longueurdelosdumenton\":0,\"hair_2\":0,\"makeup_1\":0,\"face\":0,\"facepeds\":0,\"beard_3\":0,\"Longueurnez\":20,\"tshirt_1\":15,\"beard_4\":0,\"ears_1\":-1,\"helmet_2\":0,\"decals_2\":0,\"Hauteursourcils\":0}}]}'),
(120, 'user_garages', 'discord:722766829881131038', '{}'),
(121, 'user_ears', 'discord:722766829881131038', '{\"hasEars\":true,\"skin\":{\"ears_2\":0,\"ears_1\":-1}}'),
(122, 'user_glasses', 'discord:722766829881131038', '{\"hasGlasses\":true,\"skin\":{\"glasses_1\":2,\"glasses_2\":0}}'),
(123, 'vault', 'discord:722766829881131038', '{}'),
(124, 'user_mask', 'discord:722766829881131038', '{\"hasMask\":true,\"skin\":{\"mask_1\":0,\"mask_2\":0}}'),
(125, 'user_helmet', 'discord:722766829881131038', '{\"skin\":{\"helmet_2\":0,\"helmet_1\":120},\"hasHelmet\":true}');

-- --------------------------------------------------------

--
-- Structure de la table `data_inventory`
--

CREATE TABLE `data_inventory` (
  `id` int(11) NOT NULL,
  `plate` varchar(50) NOT NULL,
  `data` text NOT NULL,
  `owned` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `data_inventory`
--

INSERT INTO `data_inventory` (`id`, `plate`, `data`, `owned`) VALUES
(1, 'property_10', '{\"coffre\":[]}', 1),
(2, 'property_12', '{\"coffre\":[]}', 1),
(3, 'property_13', '{\"coffre\":[]}', 1),
(4, 'property_14', '{\"coffre\":[]}', 1),
(5, 'property_15', '{\"coffre\":[]}', 1);

-- --------------------------------------------------------

--
-- Structure de la table `dpkeybinds`
--

CREATE TABLE `dpkeybinds` (
  `id` varchar(50) NOT NULL,
  `keybind1` varchar(50) DEFAULT 'num4',
  `emote1` varchar(255) DEFAULT '',
  `keybind2` varchar(50) DEFAULT 'num5',
  `emote2` varchar(255) DEFAULT '',
  `keybind3` varchar(50) DEFAULT 'num6',
  `emote3` varchar(255) DEFAULT '',
  `keybind4` varchar(50) DEFAULT 'num7',
  `emote4` varchar(255) DEFAULT '',
  `keybind5` varchar(50) DEFAULT 'num8',
  `emote5` varchar(255) DEFAULT '',
  `keybind6` varchar(50) DEFAULT 'num9',
  `emote6` varchar(255) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `glovebox_inventory`
--

CREATE TABLE `glovebox_inventory` (
  `id` int(11) NOT NULL,
  `plate` varchar(8) NOT NULL,
  `data` text NOT NULL,
  `owned` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `items`
--

CREATE TABLE `items` (
  `name` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `limit` int(11) NOT NULL DEFAULT -1,
  `rare` int(11) NOT NULL DEFAULT 0,
  `can_remove` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--
-- Déchargement des données de la table `items`
--

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
('GADGET_HAZMAT1', 'Combinaison hermétique', 10, 0, 1),
('LittlePricks', 'Tenue Little Pricks', -1, 0, 1),
('LsCustoms', 'Tenue LsCustoms', -1, 0, 1),
('Nokia', 'darkshop', -1, 0, 1),
('access_key', 'Access Key', 1, 0, 1),
('acetone', 'Acetone', -1, 0, 1),
('acid', 'AcidTripe', 10, 0, 1),
('acidesulfurique', 'Acide sulfurique', 100, 0, 1),
('advancedlockpick', 'Outil de serrure', 50, 0, 1),
('antifreeze', 'Antifreeze', -1, 0, 1),
('antigel', 'Sodium benzoate', 100, 0, 1),
('apa_mp_h_bed_double_08', 'Lit 01', -1, 0, 1),
('apa_mp_h_bed_double_09', 'Lit 02', -1, 0, 1),
('apa_mp_h_bed_wide_05', 'Lit 03', -1, 0, 1),
('apa_mp_h_bed_with_table_02', 'Lit 05', -1, 0, 1),
('apa_mp_h_din_chair_04', 'Chaise 12', -1, 0, 1),
('apa_mp_h_din_chair_08', 'Chaise 13', -1, 0, 1),
('apa_mp_h_din_chair_09', 'Chaise 14', -1, 0, 1),
('apa_mp_h_din_chair_12', 'Chaise 15', -1, 0, 1),
('apa_mp_h_stn_chairarm_01', 'Chaise 16', -1, 0, 1),
('apa_mp_h_stn_chairarm_02', 'Chaise 17', -1, 0, 1),
('apa_mp_h_stn_chairarm_09', 'Chaise 18', -1, 0, 1),
('apa_mp_h_stn_chairarm_11', 'Chaise 19', -1, 0, 1),
('apa_mp_h_stn_chairarm_12', 'Chaise 20', -1, 0, 1),
('apa_mp_h_stn_chairarm_13', 'Chaise 21', -1, 0, 1),
('apa_mp_h_stn_chairarm_23', 'Chaise 22', -1, 0, 1),
('apa_mp_h_stn_chairarm_24', 'Chaise 23', -1, 0, 1),
('apa_mp_h_stn_chairarm_25', 'Chaise 24', -1, 0, 1),
('apa_mp_h_stn_chairarm_26', 'Chaise 25', -1, 0, 1),
('apa_mp_h_stn_chairstrip_04', 'Chaise 27', -1, 0, 1),
('apa_mp_h_stn_chairstrip_05', 'Chaise 28', -1, 0, 1),
('apa_mp_h_stn_chairstrip_06', 'Chaise 29', -1, 0, 1),
('apa_mp_h_stn_chairstrip_08', 'Chaise 26', -1, 0, 1),
('apa_mp_h_yacht_armchair_03', 'Chaise 30', -1, 0, 1),
('apa_mp_h_yacht_armchair_04', 'Chaise 31', -1, 0, 1),
('apa_mp_h_yacht_bed_01', 'Lit 06', -1, 0, 1),
('apa_mp_h_yacht_bed_02', 'Lit 07', -1, 0, 1),
('apa_mp_h_yacht_strip_chair_01', 'Chaise 33', -1, 0, 1),
('apple_cleaver', '??????????????????', 5000, 0, 1),
('apple_p', '????????', 5000, 0, 1),
('apple_pack', '???????????', 5000, 0, 1),
('armbrace', 'Arm Brace', 5, 0, 1),
('ba_prop_battle_club_chair_01', 'Chaise 34', -1, 0, 1),
('ba_prop_battle_club_chair_02', 'Chaise 32', -1, 0, 1),
('ba_prop_battle_club_chair_03', 'Chaise 35', -1, 0, 1),
('ba_prop_int_trad_table', 'Table 23', -1, 0, 1),
('badgelspd', 'Badge LSPD', 10, 0, 1),
('bag', 'Sac à dos', 10, 0, 1),
('bagofdope', 'Bullet Casing', -1, 0, 1),
('bait', 'Appât', 100, 0, 1),
('banane', 'Banane', 20, 0, 1),
('bandage', 'Bandage', 50, 0, 1),
('bankidcard', 'Bank ID', -1, 0, 1),
('beer', 'Bière', 10, 0, 1),
('biere', 'Bière', 20, 0, 1),
('billets', 'Plaque de billets', 10, 0, 1),
('bka_prop_biker_boardchair01', 'Chaise 36', -1, 0, 1),
('bka_prop_biker_chairstrip_01', 'Chaise 37', -1, 0, 1),
('bka_prop_biker_chairstrip_02', 'Chaise 38', -1, 0, 1),
('bkr_prop_duffel_bag_01a', 'Sac EMS', -1, 0, 1),
('blowpipe', 'Kit de crochetage', 10, 0, 1),
('blowtorch', 'Chalumeau', 10, 0, 1),
('bmx', 'Bmx', 2, 0, 1),
('bodybandage', 'Body Bandage', 5, 0, 1),
('bois', 'Rondin', 50, 0, 1),
('boitierarmesdepoing', 'Boitier d\'armes de poing', 3, 0, 1),
('boitierarmeslourdes', 'Boitier d\'armes lourdes', 3, 0, 1),
('bong', 'Pipe a eau', 10, 0, 1),
('bouteilleessence', 'Bouteille d\'essence', 50, 0, 1),
('bread', 'Sandwich', 50, 0, 1),
('brique', 'Brique', 50, 0, 1),
('briquet', 'Briquet', 50, 0, 1),
('brolly', 'Parapluie', 10, 0, 1),
('bronzemedal', 'Médaille de bronze rallye', 5, 0, 1),
('bullet1', 'Protection ultralégère', 3, 0, 1),
('bullet2', 'Protection légère', 3, 0, 1),
('bullet3', 'Protection standard', 3, 0, 1),
('bullet4', 'Protection lourde', 3, 0, 1),
('bulletproof', 'Kevlar', -1, 0, 1),
('bulletproofpolice', 'GPB lspd', 5, 0, 1),
('bulletproofsheriff', 'GPB Sheriff', 5, 0, 1),
('burger', 'Hamburger', 20, 0, 1),
('c4_bank', '4kg de C4', 10, 0, 1),
('cafe', 'Café', -1, 0, 1),
('camera', 'Caméra', -1, 0, 1),
('carokit', 'Kit carosserie', 10, 0, 1),
('carosskit', 'Kit carrosserie', -1, 0, 1),
('carotool', 'Outils carosserie', 10, 0, 1),
('carpecuir', 'Carpe cuir', 50, 0, 1),
('cartebleu', 'Carte bancaire', 10, 0, 1),
('carteidentite', 'Carte d\'identité', -1, 0, 1),
('casapapel', 'Tenue - Casapapel', 5, 0, 1),
('casserole', 'Casserole', 5, 0, 1),
('cddaym', 'CD scellé', 50, 0, 1),
('cdvierge', 'CD vierge', 50, 0, 1),
('champagne', 'Champagne', -1, 0, 1),
('chanvre', 'Chanvre', 500, 0, 1),
('char', 'Char', 50, 0, 1),
('cheese', 'Fromage', 20, 0, 1),
('chinook', 'Chinook', -1, 0, 1),
('chocolat', 'Chocolat', -1, 0, 1),
('cigar', 'Cigar cubain', -1, 0, 1),
('cigarette', 'Cigarette', -1, 0, 1),
('ciseau', 'Ciseaux', -1, 0, 1),
('citron', 'Citron', 20, 0, 1),
('clip', 'Chargeur', 50, 0, 1),
('clipdrum', 'Chargeur tambour', 2, 0, 1),
('clipextended', 'Grand chargeur', 5, 0, 1),
('clous', 'Boîte de clous', -1, 0, 1),
('coca', 'Coca-Cola', 20, 0, 1),
('cocaine', 'Cocaine', -1, 0, 1),
('cocaine_cut', 'Cocaïne coupée', 50, 0, 1),
('cocaine_packaged', 'Figurine Super Hero', -1, 0, 1),
('cocktail', 'Cocktail', 20, 0, 1),
('coffee', 'Café', 20, 0, 1),
('coke', 'Figurine Super Hero', 100, 0, 1),
('coke10g', 'Cocaïne (10G)', 50, 0, 1),
('coke1g', 'Cocaïne', 100, 0, 1),
('coke_pooch', 'Pochon de coke', 50, 0, 1),
('cokebrick', 'Paquet(s) de coke', 5, 0, 1),
('cokebrut', 'Cocaïne', 100, 0, 1),
('cokeburn', 'Clé USB Coke', 2, 0, 1),
('colis', 'Colis', -1, 0, 1),
('condom', 'Préservatif souillé', 20, 0, 1),
('contract', 'Contrat de vente', 5, 0, 1),
('copper', 'Cuivre', 50, 0, 1),
('coyote', 'Coyote', 10, 0, 1),
('craftingtable', 'Crafting Table', -1, 0, 1),
('crawfish', 'Écrevisse', 20, 0, 1),
('croquettes', 'Croquettes', 50, 0, 1),
('crystaldemeth', 'Crystal de meth', 100, 0, 1),
('cuff_keys', 'Clés de menottes', 10, 0, 1),
('cuffs', 'Menottes', 10, 0, 1),
('cut_money', 'Argent couper', -1, 0, 1),
('cutting_pliers', 'Pince coupante', 10, 0, 1),
('darkshop', 'Nokia', -1, 0, 1),
('diamond', 'Diamonds', -1, 0, 1),
('diamondring', 'Diamond Ring', -1, 0, 1),
('disc_ammo_pistol', '9mm', 50, 0, 1),
('disc_ammo_pistol_large', '9mm', 50, 0, 1),
('disc_ammo_rifle', '5.56mm', 50, 0, 1),
('disc_ammo_rifle_large', '7.62mm', 50, 0, 1),
('disc_ammo_shotgun', 'Calibre 12', 50, 0, 1),
('disc_ammo_shotgun_large', 'Calibre 12', 50, 0, 1),
('disc_ammo_smg', '19mm', 50, 0, 1),
('disc_ammo_smg_large', '28mm', 50, 0, 1),
('disc_ammo_snp', '300 Magnum', 10, 0, 1),
('disc_ammo_snp_large', '300 Magnum', 10, 0, 1),
('donut', 'Donut', -1, 0, 1),
('dopebag', 'Blood Sample', -1, 0, 1),
('drill', 'Perceuse', 2, 0, 1),
('drugbags', 'Pochtar(s)', 1000, 0, 1),
('drugscales', 'Ammo Analyzer', -1, 0, 1),
('energy', 'RedBull', 20, 0, 1),
('essence', 'Bidon d\'essence', -1, 0, 1),
('ex_mp_h_din_table_05', 'Table 27', -1, 0, 1),
('fanta', 'Fanta', 20, 0, 1),
('feijao', 'Haricots bio', 50, 0, 1),
('ferraille', 'Ferraille', 50, 0, 1),
('feuilledecoca', 'Coca', 100, 0, 1),
('feuilles', 'Feuilles', -1, 0, 1),
('feuilletabac', 'Feuilles de tabac', 100, 0, 1),
('fichepaye', 'Fiche de paye', -1, 0, 1),
('fish', 'Poisson', 20, 0, 1),
('fishandchips', 'Fish And Chips', 20, 0, 1),
('fishburger', 'Hamburger au poisson', 20, 0, 1),
('fishd', 'Poisson abattu', 20, 0, 1),
('fishingpermit', 'Permis de Pêche', 5, 0, 1),
('fishingrod', 'Canne à pêche', 2, 0, 1),
('fixkit', 'Kit réparation', 10, 0, 1),
('fixter', 'fixter', -1, 0, 1),
('fixtool', 'Outils réparation', 10, 0, 1),
('flashlight', 'Lampe', 5, 0, 1),
('fly-ticket', 'Ticket Journalier North Yankton', 5, 0, 1),
('fricadelle', 'Fricadelle', -1, 0, 1),
('frites', 'Frites', 20, 0, 1),
('gadget_nightvision', 'Vision nocturne (Schéma)', -1, 0, 1),
('gadget_parachute', 'Parachute (Schéma)', -1, 0, 1),
('gantbox', 'Gants de boxe', -1, 0, 1),
('gazbottle', 'Bouteille de gaz', 10, 0, 1),
('ghb', 'GHB', 100, 0, 1),
('ghb_pooch', 'Pochon de GHB', 50, 0, 1),
('glacon', 'Glaçon', 50, 0, 1),
('gold', 'Or', 50, 0, 1),
('goldNecklace', 'Collier en Or', -1, 0, 1),
('goldbar', 'Barre en Or', 20, 0, 1),
('goldbull', 'Gold Bullion', -1, 0, 1),
('goldfish', 'Poisson rouge', 50, 0, 1),
('goldmedal', 'Médaille d\'or du rallye', 5, 0, 1),
('goldwatch', 'Montre en Or', 20, 0, 1),
('goodbread', 'Bon Pain', 50, 0, 1),
('gpbl', 'GPB Ultra léger', 5, 0, 1),
('gpblo', 'GPB Ultra lourd', 5, 0, 1),
('gpbm', 'GPB Léger', 5, 0, 1),
('gpbml', 'GPB Lourd', 5, 0, 1),
('gps', 'GPS', 20, 0, 1),
('gr_prop_gr_tool_chest_01a', 'Petite trousse à outils', -1, 0, 1),
('gr_prop_gr_tool_draw_01a', 'Etabli carré', -1, 0, 1),
('grain', 'Céréale bio', 50, 0, 1),
('graineweed', 'Graîne de cannabis', 100, 0, 1),
('grip', 'Poignée', 5, 0, 1),
('gym_membership', 'Carte membre - GYM', 5, 0, 1),
('hackerDevice', 'Hacking Device', 10, 0, 1),
('hamburger', 'Hamburger', 20, 0, 1),
('handcuff', 'Menottes', 10, 0, 1),
('handcuffs', 'Menottes', 10, 0, 1),
('hazmat1', 'Combinaison Noir', 5, 0, 1),
('hazmat2', 'Combinaison Bleu', 5, 0, 1),
('hazmat3', 'Combinaison Jaune', 5, 0, 1),
('hazmat4', 'Combinaison Blanche', 5, 0, 1),
('hei_prop_yah_lounger', 'Canapé 01', -1, 0, 1),
('hei_prop_yah_seat_01', 'Canapé 02', -1, 0, 1),
('hei_prop_yah_seat_02', 'Canapé 03', -1, 0, 1),
('hei_prop_yah_seat_03', 'Canapé 04', -1, 0, 1),
('hei_prop_yah_table_01', 'Table 01', -1, 0, 1),
('hei_prop_yah_table_02', 'Table 28', -1, 0, 1),
('hei_prop_yah_table_03', 'Table 02', -1, 0, 1),
('hotdog', 'HotDog', 20, 0, 1),
('houblon', 'Houblon', 50, 0, 1),
('hqscale', 'High Quality Scale', 5000, 0, 1),
('icetea', 'icetea', 20, 0, 1),
('idcard', 'Carte d\'Identité', 5, 0, 1),
('imp_prop_engine_hoist_02a', 'Poulie 1', -1, 0, 1),
('imp_prop_impexp_sofabed_01a', 'Lit 04', -1, 0, 1),
('ingredients', 'Ingredients of Methamphetamine', -1, 0, 1),
('ipad', 'iPad', -1, 0, 1),
('iphone', 'iPhone', -1, 0, 1),
('iron', 'Fer', 50, 0, 1),
('james_fish', 'Poisson cru', 20, 0, 1),
('james_fishingbait', 'Appât', 100, 0, 1),
('jbl', 'Enceinte JBL', 5, 0, 1),
('jewels', 'Bijoux', 50, 0, 1),
('joint', 'Joint', 50, 0, 1),
('joint2g', 'Joint(s)', 1500, 0, 1),
('jumelles', 'Jumelles', 10, 0, 1),
('jupiler', 'Jupiler', -1, 0, 1),
('juscanne', 'Jus de canne', 50, 0, 1),
('jusfruit', 'Jus de fruit', 20, 0, 1),
('jusraisin', 'Jus de Raisin', 50, 0, 1),
('kalilinux', 'Kali Linux', 10, 0, 1),
('karting1', 'Tenue - Karting', 5, 0, 1),
('karting2', 'Tenue - Karting 2', 5, 0, 1),
('kebab', 'Kebab', -1, 0, 1),
('keycard', 'System X', 50, 0, 1),
('kitcarro', 'Kit Carrosserie', -1, 0, 1),
('kitpic', 'Campement', 5, 0, 1),
('laptop', 'Ordinateur', -1, 0, 1),
('legbrace', 'Leg Brace', 5, 0, 1),
('levure', 'Levure', 50, 0, 1),
('lobster', 'Lobster', 50, 0, 1),
('lockpick', 'Outil de crochetage', 50, 0, 1),
('lokalizator', 'GPS Véhicules', 5000, 0, 1),
('mackerel', 'Mackerel', 50, 0, 1),
('madera', 'Sapin', 50, 0, 1),
('maderaf', 'Pin', 50, 0, 1),
('maderag', 'Épicéa', 50, 0, 1),
('maderam', 'Cedre', 50, 0, 1),
('magazine', 'Magasine Playboy', 20, 0, 1),
('magnum', 'magnum', -1, 0, 1),
('malbora', 'Cigarette', 50, 0, 1),
('malette', 'Malette', -1, 0, 1),
('malt', 'Malt', 50, 0, 1),
('mask', 'mask', -1, 0, 1),
('mask_swim', 'Bouteille de plongée', 10, 0, 1),
('mclon', 'Carbon', 50, 0, 1),
('medikit', 'Kit de soin', 50, 0, 1),
('menthe', 'Feuille de Menthe', 50, 0, 1),
('meth', 'Méthamphétamine', 100, 0, 1),
('meth100g', 'Methamphetamine [100g]', -1, 0, 1),
('meth10g', 'Meth (10G)', 50, 0, 1),
('meth1g', 'Méthamphétamine', 100, 0, 1),
('meth_packaged', 'Meth emballé', 50, 0, 1),
('meth_pooch', 'Pochon de meth', 50, 0, 1),
('meth_raw', 'Meth brute', 20, 0, 1),
('methbrick', 'Paquet(s) de meth', 5, 0, 1),
('methburn', 'Clé USB Meth', 5000, 0, 1),
('mg_ammo', 'MG Ammo', -1, 0, 1),
('micro', 'Micro', -1, 0, 1),
('milho', 'Maïs bio', 50, 0, 1),
('milk', 'Lait', 20, 0, 1),
('milkbottle', 'Bouteille de Lait', 20, 0, 1),
('milkshake', 'Milkshake', 20, 0, 1),
('miss_rub_couch_01', 'Canapé 05', -1, 0, 1),
('mleko', 'lait', 20, 0, 1),
('mojito', 'Mojito', 20, 0, 1),
('morphine', 'Morphine', -1, 0, 1),
('moteur', 'Moteur', -1, 0, 1),
('moukate', 'Algue Toxique', 100, 0, 1),
('moukate_pooch', 'Pochon de Moukate', 50, 0, 1),
('neckbrace', 'Neck Brace', 5, 0, 1),
('nightvision', 'Night vision', 10, 0, 1),
('notepad', 'Bloc-notes', 10, 0, 1),
('odznaka', 'Carte de Police', 5, 0, 1),
('opal', 'Opal', -1, 0, 1),
('opium', 'Opium', 100, 0, 1),
('opium_pooch', 'Pochon de opium', 50, 0, 1),
('or', 'Pépite d\'or', -1, 0, 1),
('orangina', 'Orangina', 20, 0, 1),
('oxycutter', 'Chalumaux', -1, 0, 1),
('p_armchair_01_s', 'Canapé 06', -1, 0, 1),
('p_ilev_p_easychair_s', 'Canapé 07', -1, 0, 1),
('p_ld_stinger_s', 'Herse', -1, 0, 1),
('p_lestersbed_s', 'Lit 08', -1, 0, 1),
('p_lev_sofa_s', 'Canapé 08', -1, 0, 1),
('p_mbbed_s', 'Lit 09', -1, 0, 1),
('p_patio_lounger1_s', 'Canapé 09', -1, 0, 1),
('p_pharm_unit_01', 'Rangement 02', -1, 0, 1),
('p_pharm_unit_02', 'Rangement 01', -1, 0, 1),
('p_res_sofa_l_s', 'Canapé 10', -1, 0, 1),
('p_v_43_safe_s', 'Rangement 03', -1, 0, 1),
('p_v_med_p_sofa_s', 'Canapé 11', -1, 0, 1),
('pacificidcard', 'Pacific ID', -1, 0, 1),
('paquetnuggets', 'Paquet de nuggets', 50, 0, 1),
('paquetplanche', 'Paquet de planches', 50, 0, 1),
('paracetamol', 'Paracétamol', 25, 0, 1),
('pelle', 'Pelle', 2, 0, 1),
('permis', 'Permis', -1, 0, 1),
('permisarmes', 'Permis d\'armes', -1, 0, 1),
('petrol', 'Pétrole', 50, 0, 1),
('phone', 'Téléphone', 5, 0, 1),
('pierre', 'Pierre', 50, 0, 1),
('pike', 'Pike', 50, 0, 1),
('pistol_ammo', 'Pistol Ammo', -1, 0, 1),
('pizza', 'Pizza', 20, 0, 1),
('planche', 'Planche', 50, 0, 1),
('playersafe', 'Player Safe', 1, 0, 1),
('pneu', 'Pneus', -1, 0, 1),
('poisson', 'Poisson', 50, 0, 1),
('poissoncru', 'Poisson Cru', 50, 0, 1),
('pompom', 'Poisson pompom', 50, 0, 1),
('pot', 'Pot', 20, 0, 1),
('poubelle', 'Poubelle', 50, 0, 1),
('poule', 'Poule', 20, 0, 1),
('powerade', 'PoweRade', 10, 0, 1),
('preparationmeth', 'Preparation of Methamphetamine', -1, 0, 1),
('prisonnier', 'Tenue - Prison', 5, 0, 1),
('prop_barrier_work05', 'Barrière', -1, 0, 1),
('prop_bench_01a', 'Canapé 12', -1, 0, 1),
('prop_bench_06', 'Canapé 13', -1, 0, 1),
('prop_bin_03a', 'Rangement 04', -1, 0, 1),
('prop_bin_07c', 'Rangement 05', -1, 0, 1),
('prop_bin_08open', 'Rangement 06', -1, 0, 1),
('prop_bin_10a', 'Rangement 07', -1, 0, 1),
('prop_boxpile_07d', 'Boîte en carton', -1, 0, 1),
('prop_car_engine_01', 'Moteur', -1, 0, 1),
('prop_carcreeper', 'Carcéral', -1, 0, 1),
('prop_chair_01a', 'Chaise 01', -1, 0, 1),
('prop_chair_01b', 'Chaise 02', -1, 0, 1),
('prop_chair_02', 'Chaise 03', -1, 0, 1),
('prop_chair_03', 'Chaise 04', -1, 0, 1),
('prop_chair_04', 'Chaise 05', -1, 0, 1),
('prop_chair_05', 'Chaise 06', -1, 0, 1),
('prop_chair_06', 'Chaise 07', -1, 0, 1),
('prop_chair_07', 'Chaise 08', -1, 0, 1),
('prop_chair_08', 'Chaise 09', -1, 0, 1),
('prop_chair_09', 'Chaise 10', -1, 0, 1),
('prop_chair_10', 'Chaise 11', -1, 0, 1),
('prop_chateau_table_01', 'Table 03', -1, 0, 1),
('prop_cs_trolley_01', 'Etabli', -1, 0, 1),
('prop_devin_box_01', 'Rangement 08', -1, 0, 1),
('prop_dress_disp_01', 'Rangement 10', -1, 0, 1),
('prop_dress_disp_02', 'Rangement 11', -1, 0, 1),
('prop_dress_disp_03', 'Rangement 12', -1, 0, 1),
('prop_dress_disp_04', 'Rangement 13', -1, 0, 1),
('prop_engine_hoist', 'Poulie 2', -1, 0, 1),
('prop_ld_farm_chair01', 'Canapé 14', -1, 0, 1),
('prop_ld_farm_couch01', 'Canapé 15', -1, 0, 1),
('prop_ld_farm_couch02', 'Canapé 16', -1, 0, 1),
('prop_ld_farm_table02', 'Table 29', -1, 0, 1),
('prop_ld_greenscreen_01', 'Fond vert', -1, 0, 1),
('prop_ld_int_safe_01', 'Rangement 09', -1, 0, 1),
('prop_patio_lounger1_table', 'Table 04', -1, 0, 1),
('prop_proxy_chateau_table', 'Table 05', -1, 0, 1),
('prop_roadcone02a', 'Cône', -1, 0, 1),
('prop_rub_couch04', 'Canapé 17', -1, 0, 1),
('prop_rub_table_01', 'Table 07', -1, 0, 1),
('prop_rub_table_02', 'Table 06', -1, 0, 1),
('prop_stockade_wheel_flat', 'Roue', -1, 0, 1),
('prop_t_coffe_table', 'Table 30', -1, 0, 1),
('prop_t_coffe_table_02', 'Table 31', -1, 0, 1),
('prop_t_sofa', 'Canapé 18', -1, 0, 1),
('prop_t_sofa_02', 'Canapé 19', -1, 0, 1),
('prop_table_01', 'Table 08', -1, 0, 1),
('prop_table_02', 'Table 09', -1, 0, 1),
('prop_table_03', 'Table 10', -1, 0, 1),
('prop_table_04', 'Table 11', -1, 0, 1),
('prop_table_05', 'Table 12', -1, 0, 1),
('prop_table_06', 'Table 13', -1, 0, 1),
('prop_table_07', 'Table 14', -1, 0, 1),
('prop_table_08', 'Table 15', -1, 0, 1),
('prop_toolchest_01', 'Sacoche à outils', -1, 0, 1),
('prop_tv_cam_02', 'Caméra de film', -1, 0, 1),
('prop_ven_market_table1', 'Table 16', -1, 0, 1),
('prop_wheel_rim_02', 'Jante', -1, 0, 1),
('prop_wheel_tyre', 'Pneu', -1, 0, 1),
('prop_yacht_table_01', 'Table 17', -1, 0, 1),
('prop_yacht_table_02', 'Table 18', -1, 0, 1),
('protein_shake', 'Pot de Proteine', 10, 0, 1),
('purifiedwater', 'Purified Water', -1, 0, 1),
('radio', 'Radio', 5, 0, 1),
('raisin', 'Raisin', 50, 0, 1),
('recipe_bagofdope', 'Recipe: Bag of Dope', -1, 0, 1),
('repairkit', 'kit réparation', -1, 0, 1),
('rhum', 'Rhum', 20, 0, 1),
('rifle_ammo', 'Rifle Ammo', -1, 0, 1),
('ring', 'Bague', -1, 0, 1),
('roach', 'Mort', 50, 0, 1),
('rolex', 'Rolex', -1, 0, 1),
('rolpaper', 'Papier a rouler', 500, 0, 1),
('rose', 'Rose', 5, 0, 1),
('sable', 'Sable', 500, 0, 1),
('sacpoubelle', 'Sac poubelle', -1, 0, 1),
('sactactique', 'Sac tactique', -1, 0, 1),
('sactete', 'Sac pour la tête', -1, 0, 1),
('salmon', 'Salmon', 50, 0, 1),
('samsungS10', 'Samsung S10', -1, 0, 1),
('sandwich', 'Sandwich', 50, 0, 1),
('sapphire', 'Sapphire', -1, 0, 1),
('scorcher', 'scorcher', -1, 0, 1),
('scratch', 'Tickets à gratter', -1, 0, 1),
('seau', 'Bouteille vide', 5, 0, 1),
('shotgun_ammo', 'Shotgun Ammo', 100, 0, 1),
('silencieux', 'Silencieux', 5, 0, 1),
('silverbull', 'Silver Bullion', -1, 0, 1),
('silvermedal', 'Médaille d\'argent rallye', 5, 0, 1),
('sim', 'Carte Sim', 10, 0, 1),
('sirop', 'Sirop', 20, 0, 1),
('skin1', 'Classique (Skin)', -1, 0, 1),
('skin2', 'Vert (Skin)', -1, 0, 1),
('skin3', 'Jaune (Skin)', -1, 0, 1),
('skin4', 'Rose (Skin)', -1, 0, 1),
('skin5', 'Or (Skin)', -1, 0, 1),
('skin6', 'Bleu (Skin)', -1, 0, 1),
('skin7', 'Orange (Skin)', -1, 0, 1),
('skydiving', 'Tenue - Parachute', 5, 0, 1),
('smg_ammo', 'SMG Ammo', -1, 0, 1),
('sniffer', 'Tracker - LSPD', 5, 0, 0),
('soda', 'Soda', 20, 0, 1),
('sorted_money', 'Argent trié', -1, 0, 1),
('sportlunch', 'Déjeuner de Sport', 10, 0, 1),
('spray', 'Bombe de peinture', 10, 0, 1),
('sprite', 'Sprite', 20, 0, 1),
('steak', 'Steak', 20, 0, 1),
('stungun_ammo', 'Stungun Ammo', 100, 0, 1),
('sucrecanne', 'Sucre de Canne', 50, 0, 1),
('tabacsec', 'Tabac Sec', 50, 0, 1),
('table', 'Preparation table', -1, 0, 1),
('tapas', 'Tapas', -1, 0, 1),
('tatgun', 'Pistolet tatouage', 5, 0, 1),
('tea', 'Ice-Tea', 20, 0, 1),
('tenuelspd', 'Tenue (LSPD)', 5, 0, 1),
('tequila', 'Tequila', -1, 0, 1),
('terre', 'Terre', 100, 0, 1),
('terrehumide', 'Terre humide', 100, 0, 1),
('traceur', 'Traceur', 20, 0, 1),
('tracker', 'Bracelet électronique', 5, 0, 0),
('tribike', 'tribike', -1, 0, 1),
('tribike2', 'tribike2', -1, 0, 1),
('tribike3', 'tribike3', -1, 0, 1),
('triplebiere', 'Triple bière', -1, 0, 1),
('trout', 'Trout', 50, 0, 1),
('truele', 'Truelle', 5, 0, 1),
('up7', '7up', 20, 0, 1),
('v_ilev_m_sofa', 'Canapé 20', -1, 0, 1),
('v_med_cor_emblmtable', 'Lit d\'hôpital en fer', -1, 0, 1),
('v_med_emptybed', 'Lit d\'hôpital', -1, 0, 1),
('v_res_d_bed', 'Lit 10', -1, 0, 1),
('v_res_mconsoletrad', 'Table 21', -1, 0, 1),
('v_res_mdbed', 'Lit 13', -1, 0, 1),
('v_res_msonbed', 'Lit 14', -1, 0, 1),
('v_res_tre_bed1', 'Lit 12', -1, 0, 1),
('v_res_tre_bed2', 'Lit 11', -1, 0, 1),
('v_res_tre_sofa_s', 'Canapé 21', -1, 0, 1),
('v_res_tt_bed', 'Lit 15', -1, 0, 1),
('v_ret_fh_dinetable', 'Table 19', -1, 0, 1),
('v_ret_fh_dinetble', 'Table 20', -1, 0, 1),
('v_ret_fh_displayc', 'Rangement 14', -1, 0, 1),
('v_ret_gc_bag01', 'Gros sac', -1, 0, 1),
('v_serv_abox_04', 'v_serv_abox_04', -1, 0, 1),
('v_tre_sofa_mess_a_s', 'Canapé 22', -1, 0, 1),
('v_tre_sofa_mess_b_s', 'Canapé 23', -1, 0, 1),
('v_tre_sofa_mess_c_s', 'Canapé 24', -1, 0, 1),
('vaccine', 'vaccine', -1, 0, 1),
('vault', 'vault', 2, 0, 1),
('veganburger', 'Hamburger Végan', 20, 0, 1),
('viande', 'Viande', -1, 0, 1),
('viandepoulet', 'Viande de poulet', -1, 0, 1),
('vin', 'Vin', 50, 0, 1),
('viseur', 'Viseur', -1, 0, 1),
('vodka', 'Vodka', -1, 0, 1),
('warehouse_key', 'Warehouse Key', 1, 0, 1),
('water', 'Bouteille d\'eau', 20, 0, 1),
('waterg', 'Eau Gazeuze', 20, 0, 1),
('weapon_advancedrifle', 'G36 (Schéma)', -1, 0, 1),
('weapon_appistol', 'Pistolet automatique (Schéma)', -1, 0, 1),
('weapon_assaultrifle', 'AK-47 (Schéma)', -1, 0, 1),
('weapon_assaultshotgun', 'Spas 12 (Schéma)', -1, 0, 1),
('weapon_assaultsmg', 'P90 (Schéma)', -1, 0, 1),
('weapon_autoshotgun', 'AA-12 (Schéma)', -1, 0, 1),
('weapon_ball', 'Brique (Schéma)', -1, 0, 1),
('weapon_bat', 'Batte de Baseball (Schéma)', -1, 0, 1),
('weapon_battleaxe', 'Hache de combat (Schéma)', -1, 0, 1),
('weapon_bottle', 'Bouteille cassé (Schéma)', -1, 0, 1),
('weapon_briefcase', 'Malette', 5, 0, 1),
('weapon_briefcase_02', 'Malette en cuir', 5, 0, 1),
('weapon_bullpupshotgun', 'Pompe Lethal (Schéma)', -1, 0, 1),
('weapon_carbinerifle', 'M4A1 (Schéma)', -1, 0, 1),
('weapon_ceramicpistol', 'Pistolet à clous (Schéma)', -1, 0, 1),
('weapon_combatmg', 'Mitrailleuse de combat (Schéma)', -1, 0, 1),
('weapon_combatpdw', 'UMP-45 (Schéma)', -1, 0, 1),
('weapon_combatpistol', 'Glock-17 (Schéma)', -1, 0, 1),
('weapon_compactrifle', 'AK-U (Schéma)', -1, 0, 1),
('weapon_crowbar', 'Pied de biche (Schéma)', -1, 0, 1),
('weapon_dagger', 'Poignard (Schéma)', -1, 0, 1),
('weapon_dbshotgun', 'Fusil a double Canon (Schéma)', -1, 0, 1),
('weapon_fireextinguisher', 'Extincteur (Schéma)', -1, 0, 1),
('weapon_flaregun', 'Pistolet Fumigène (Schéma)', -1, 0, 1),
('weapon_flashlight', 'Lampe torche (Schéma)', -1, 0, 1),
('weapon_golfclub', 'Club de Golf (Schéma)', -1, 0, 1),
('weapon_gusenberg', 'Balayeuse gusenberg (Schéma)', -1, 0, 1),
('weapon_hammer', 'Marteau (Schéma)', -1, 0, 1),
('weapon_hatchet', 'Hachette (Schéma)', -1, 0, 1),
('weapon_heavypistol', 'Colt-911 (Schéma)', -1, 0, 1),
('weapon_heavyshotgun', 'Saiga-12K (Schéma)', -1, 0, 1),
('weapon_knife', 'Couteau (Schéma)', -1, 0, 1),
('weapon_knuckle', 'Poing américain (Schéma)', -1, 0, 1),
('weapon_machete', 'Machete (Schéma)', -1, 0, 1),
('weapon_machinepistol', 'TEC-9 (Schéma)', -1, 0, 1),
('weapon_marksmanpistol', 'Pistolet Marksman (Schéma)', -1, 0, 1),
('weapon_marksmanrifle', 'M39 EMR (Schéma)', -1, 0, 1),
('weapon_mg', 'MG (Schéma)', -1, 0, 1),
('weapon_microsmg', 'UZI (Schéma)', -1, 0, 1),
('weapon_minigun', 'Tronçonneuse (Schéma)', -1, 0, 1),
('weapon_minismg', 'Scorpion VZ61 (Schéma)', -1, 0, 1),
('weapon_molotov', 'Cocktail Molotov (Schéma)', -1, 0, 1),
('weapon_nightstick', 'Matraque (Schéma)', -1, 0, 1),
('weapon_petrolcan', 'Jerrican d\'essence (Schéma)', -1, 0, 1),
('weapon_pistol', 'Berreta 92 (Schéma)', -1, 0, 1),
('weapon_pistol50', 'Desert Eagle (Schéma)', -1, 0, 1),
('weapon_poolcue', 'Queue de billard (Schéma)', -1, 0, 1),
('weapon_pumpshotgun', 'Remingnton (Schéma)', -1, 0, 1),
('weapon_revolver', 'Revolver (Schéma)', -1, 0, 1),
('weapon_sawnoffshotgun', 'ST87 Saw (Schéma)', -1, 0, 1),
('weapon_smg', 'MP5 (Schéma)', -1, 0, 1),
('weapon_smokegrenade', 'Grenage lacrymogène (Schéma)', -1, 0, 1),
('weapon_snowball', 'Boule de neige (Schéma)', -1, 0, 1),
('weapon_snspistol', 'Pétoire (Schéma)', -1, 0, 1),
('weapon_specialcarbine', 'H&K G36C (Schéma)', -1, 0, 1),
('weapon_stungun', 'Tazer X26 (Schéma)', -1, 0, 1),
('weapon_switchblade', 'Cran arrêt (Schéma)', -1, 0, 1),
('weapon_vintagepistol', 'Pistolet Ancien (Schéma)', -1, 0, 1),
('weapon_wrench', 'Clé anglaise (Schéma)', -1, 0, 1),
('weed', 'Cannabis', 100, 0, 1),
('weed20g', 'Weed (20G)', 50, 0, 1),
('weed4g', 'Weed', 100, 0, 1),
('weed_packaged', 'Pochon de Weed', 50, 0, 1),
('weed_pooch', 'Pochon de weed', 50, 0, 1),
('weed_seed', 'Graine de Weed', 50, 0, 1),
('weed_untrimmed', 'Weed', -1, 0, 1),
('weedbrick', 'Paquet(s) de weed', 5, 0, 1),
('weedburn', 'Clé USB Weed', 2, 0, 1),
('wheat', 'Blé', 50, 0, 1),
('whiskey', 'Whiskey', -1, 0, 1),
('whisky', 'Whisky', -1, 0, 1),
('whitefish', 'Poisson blanc', 20, 0, 1),
('wine', 'Wine', -1, 0, 1),
('wipe', 'Pillule Euthanasie', 5, 0, 1),
('wood', 'Rondin', 50, 0, 1),
('xm_prop_body_bag', 'Sac de mort', -1, 0, 1),
('xm_prop_lab_desk_01', 'Table 26', -1, 0, 1),
('xm_prop_lab_desk_02', 'Table 25', -1, 0, 1),
('xm_prop_x17_desk_cover_01a', 'Table 24', -1, 0, 1),
('yusuf', 'Skin de luxe', 5, 0, 1);

-- --------------------------------------------------------

--
-- Structure de la table `iwaclothes`
--

CREATE TABLE `iwaclothes` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `skin` longtext NOT NULL,
  `type` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

CREATE TABLE `jobs` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `whitelisted` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `jobs`
--

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('abatteur', 'Abatteur', 1),
('ambulance', 'LSMD', 1),
('ammunation', 'Ammunation', 1),
('animal', 'Animal', 1),
('avocat', 'Avocat', 1),
('bacars', 'Towing', 1),
('bcfuel', 'BcFuel', 1),
('beekers', 'Beeker\'s', 1),
('bennys', 'Benny\'s', 1),
('bikedealer', 'American Motor\'s', 1),
('brinks', 'Brinks', 1),
('bucheron', 'Bûcheron', 1),
('burgershot', 'BurgerShot', 1),
('cardealer', 'Concessionnaire', 1),
('daymson', 'Capitol Record\'s', 1),
('eboueur', 'Little Pricks', 1),
('farm', 'Fermier', 1),
('farmer', 'Fermier', 1),
('ferrailleur', 'Ferrailleur', 0),
('fishing', 'Pêcheur', 1),
('fueler', 'Raffineur', 1),
('garbage', 'Little Pricks', 0),
('gardien', 'Gardien', 1),
('gouv', 'Gouv', 1),
('journalist', 'DistrictNew\'s', 1),
('krowa', 'Laitier', 0),
('lscustoms', 'Ls Customs', 1),
('ltds', 'LTD LS', 1),
('mechanic', 'Simmons', 1),
('mhmclovin', 'Mineur', 0),
('militaire', 'Militaire', 1),
('offambulance', 'Hors-Service', 1),
('offpolice', 'Hors-Service', 1),
('offsheriff', 'Hors-Service', 1),
('palace', 'Palace', 1),
('pecheur', 'Pêcheur', 1),
('police', 'LSPD', 1),
('rally', 'Rallye', 1),
('realestateagent', 'Agent immobilier', 1),
('security', 'Gruppe6', 1),
('sheriff', 'Sheriff', 1),
('suicidsquad', 'Suicid Squad', 1),
('tabac', 'RedWood', 1),
('taxi', 'Taxi', 1),
('unemployed', 'Sans-Emploi', 0),
('unicorn', 'Unicorn', 1),
('vigneron', 'Vigneron', 1),
('woodcutter', 'Bucheron', 1);

-- --------------------------------------------------------

--
-- Structure de la table `job_grades`
--

CREATE TABLE `job_grades` (
  `id` int(11) NOT NULL,
  `job_name` varchar(50) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext NOT NULL,
  `skin_female` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `job_grades`
--

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
(1, 'unemployed', 0, 'chomage', 'RSA', 10, '{}', '{}'),
(6, 'cardealer', 0, 'recruit', 'Stagiaire', 0, '{}', '{}'),
(7, 'cardealer', 1, 'novice', 'Employé', 0, '{}', '{}'),
(8, 'cardealer', 2, 'experienced', 'Responsable', 0, '{}', '{}'),
(9, 'cardealer', 3, 'boss', 'Patron', 0, '{}', '{}'),
(10, 'mechanic', 0, 'recrue', 'Stagiaire', 1, '{torso_1\":66,\"torso_2\":1,\"tshirt_1\":15,\"tshirt_2\":0,\"arms\":96,\"bags_1\":44,\"bags_2\":0,\"pants_1\":39,\"pants_2\":1,\"shoes_1\":27,\"shoes_2\":0}', '{torso_1\":60,\"torso_2\":1,\"tshirt_1\":14,\"tshirt_2\":0,\"arms\":54,\"bags_1\":44,\"bags_2\":0,\"pants_1\":39,\"pants_2\":1,\"shoes_1\":76,\"shoes_2\":0}'),
(11, 'mechanic', 1, 'novice', 'Mécanicien', 1, '{torso_1\":66,\"torso_2\":0,\"tshirt_1\":15,\"tshirt_2\":0,\"arms\":96,\"bags_1\":40,\"bags_2\":0,\"pants_1\":39,\"pants_2\":1,\"shoes_1\":27,\"shoes_2\":0}', '{torso_1\":60,\"torso_2\":0,\"tshirt_1\":14,\"tshirt_2\":0,\"arms\":54,\"bags_1\":40,\"bags_2\":0,\"pants_1\":39,\"pants_2\":0,\"shoes_1\":76,\"shoes_2\":0}'),
(12, 'mechanic', 2, 'experimente', 'Chef d\'équipe', 1, '{torso_1\":43,\"torso_2\":0,\"tshirt_1\":15,\"tshirt_2\":0,\"arms\":37,\"bags_1\":40,\"bags_2\":0,\"pants_1\":75,\"pants_2\":0,\"shoes_1\":27,\"shoes_2\":0}', '{torso_1\":86,\"torso_2\":0,\"tshirt_1\":14,\"tshirt_2\":0,\"arms\":54,\"bags_1\":40,\"bags_2\":0,\"pants_1\":0,\"pants_2\":1,\"shoes_1\":62,\"shoes_2\":20}'),
(13, 'mechanic', 3, 'chief', 'Co-Patron', 1, '{torso_1\":43,\"torso_2\":0,\"tshirt_1\":15,\"tshirt_2\":0,\"arms\":37,\"bags_1\":40,\"bags_2\":0,\"pants_1\":75,\"pants_2\":0,\"shoes_1\":27,\"shoes_2\":0}', '{torso_1\":86,\"torso_2\":0,\"tshirt_1\":14,\"tshirt_2\":0,\"arms\":54,\"bags_1\":40,\"bags_2\":0,\"pants_1\":0,\"pants_2\":1,\"shoes_1\":62,\"shoes_2\":20}'),
(14, 'mechanic', 4, 'boss', 'Patron', 1, '{torso_1\":56,\"torso_2\":0,\"tshirt_1\":15,\"tshirt_2\":0,\"arms\":74,\"bags_1\":40,\"bags_2\":0,\"pants_1\":1,\"pants_2\":0,\"shoes_1\":35,\"shoes_2\":0}', '{torso_1\":49,\"torso_2\":0,\"tshirt_1\":14,\"tshirt_2\":0,\"arms\":57,\"bags_1\":40,\"bags_2\":0,\"pants_1\":4,\"pants_2\":0,\"shoes_1\":62,\"shoes_2\":20}'),
(20, 'daymson', 0, 'employe', 'Employé', 60, '{}', '{}'),
(21, 'daymson', 1, 'vigile', 'Vigile', 80, '{}', '{}'),
(22, 'daymson', 2, 'artiste', 'Artiste', 100, '{}', '{}'),
(23, 'daymson', 3, 'ingeson', 'Ingé Son', 120, '{}', '{}'),
(24, 'daymson', 4, 'manager', 'Manager', 140, '{}', '{}'),
(25, 'daymson', 5, 'gerant', 'Gérant', 160, '{}', '{}'),
(26, 'daymson', 6, 'boss', 'Patron', 180, '{}', '{}'),
(27, 'avocat', 0, 'employe', 'Employé', 50, '{}', '{}'),
(28, 'avocat', 1, 'boss', 'Patron', 100, '{}', '{}'),
(29, 'journalist', 0, 'stagiaire', 'Stagiaire', 60, '{}', '{}'),
(30, 'journalist', 1, 'employe', 'Journalist', 80, '{}', '{}'),
(31, 'journalist', 2, 'boss', 'Patron', 120, '{}', '{}'),
(32, 'taxi', 0, 'recrue', 'Stagiaire', 0, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":260,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":15,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":11,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":5,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":0,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":21,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":8,\"pants_1\":52}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(33, 'taxi', 1, 'novice', 'Employé', 0, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":260,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":15,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":11,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":5,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":0,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":21,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":8,\"pants_1\":52}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(34, 'taxi', 2, 'experimente', 'Responsable ', 0, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":260,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":15,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":11,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":5,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":0,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":21,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":8,\"pants_1\":52}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(35, 'taxi', 3, 'uber', 'Uber', 0, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":260,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":15,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":11,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":5,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":0,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":21,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":8,\"pants_1\":52}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(36, 'taxi', 4, 'boss', 'Patron', 0, '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":260,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":15,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":11,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":5,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":0,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":21,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":8,\"pants_1\":52}', '{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(37, 'palace', 0, 'employe', 'Barman', 75, '{}', '{}'),
(38, 'palace', 1, 'vigile', 'Vigile', 85, '{}', '{}'),
(39, 'palace', 2, 'danse', 'Danseuse', 95, '{}', '{}'),
(40, 'palace', 3, 'gerant', 'Gérant', 110, '{}', '{}'),
(41, 'palace', 4, 'boss', 'Patron', 125, '{}', '{}'),
(42, 'gouv', 0, 'stagiaire', 'secrétaire', 150, '{}', '{}'),
(43, 'gouv', 1, 'gardedc', 'Garde du Corps', 350, '{}', '{}'),
(44, 'gouv', 2, 'secretaire', 'service secret', 500, '{}', '{}'),
(45, 'gouv', 3, 'coboss', 'Vice-président', 750, '{}', '{}'),
(46, 'gouv', 4, 'boss', 'Président', 1000, '{}', '{}'),
(47, 'tabac', 0, 'stagiaire', 'Stagiaire', 1, '{}', '{}'),
(48, 'tabac', 1, 'employe', 'Employe', 1, '{}', '{}'),
(49, 'tabac', 2, 'responsable', 'Responsable', 1, '{}', '{}'),
(50, 'tabac', 3, 'coboss', 'Co-Patron', 1, '{}', '{}'),
(51, 'tabac', 4, 'boss', 'Patron', 1, '{}', '{}'),
(52, 'vigneron', 0, 'stagiaire', 'Stagiaire', 30, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":0,\"shoes\":24,\"torso_2\":0,\"hair_color_2\":0,\"pants_1\":97,\"glasses_1\":0,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":-1,\"helmet_2\":0,\"arms\":11,\"face\":19,\"decals_1\":0,\"torso_1\":43,\"hair_2\":0,\"skin\":34,\"pants_2\":3}', '{}'),
(53, 'vigneron', 1, 'employe', 'Employe', 30, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":0,\"shoes\":24,\"torso_2\":0,\"hair_color_2\":0,\"pants_1\":97,\"glasses_1\":0,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":-1,\"helmet_2\":0,\"arms\":11,\"face\":19,\"decals_1\":0,\"torso_1\":43,\"hair_2\":0,\"skin\":34,\"pants_2\":3}', '{}'),
(54, 'vigneron', 2, 'responsable', 'Responsable', 40, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":0,\"shoes\":24,\"torso_2\":0,\"hair_color_2\":0,\"pants_1\":97,\"glasses_1\":0,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":-1,\"helmet_2\":0,\"arms\":11,\"face\":19,\"decals_1\":0,\"torso_1\":43,\"hair_2\":0,\"skin\":34,\"pants_2\":3}', '{}'),
(55, 'vigneron', 3, 'boss', 'Patron', 1, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":0,\"shoes\":62,\"torso_2\":0,\"hair_color_2\":0,\"pants_1\":97,\"glasses_1\":0,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":-{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":0,\"shoes\":24,\"torso_2\":0,\"hair_color_2\":0,\"pants_1\":97,\"glasses_1\":0,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":-1,\"helmet_2\":0,\"arms\":11,\"face\":19,\"decals_1\":0,\"torso_1\":43,\"hair_2\":0,\"skin\":34,\"pants_2\":3}', '{}'),
(56, 'unicorn', 0, 'danseuse', 'Danseuse', 1, '{}', '{}'),
(57, 'unicorn', 1, 'vigile', 'Vigile', 1, '{}', '{}'),
(58, 'unicorn', 2, 'barman', 'Barman', 1, '{}', '{}'),
(59, 'unicorn', 3, 'gerant', 'Gérant', 1, '{}', '{}'),
(60, 'unicorn', 4, 'boss', 'Patron', 1, '{}', '{}'),
(61, 'bucheron', 0, 'stagiaire', 'Intérim', 20, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":0,\"shoes\":27,\"torso_2\":0,\"hair_color_2\":0,\"pants_1\":52,\"glasses_1\":0,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":-1,\"helmet_2\":0,\"arms\":11,\"face\":19,\"decals_1\":0,\"torso_1\":44,\"hair_2\":0,\"skin\":34,\"pants_2\":0}', '{}'),
(62, 'bucheron', 1, 'employe', 'Employe', 25, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":0,\"shoes\":27,\"torso_2\":0,\"hair_color_2\":0,\"pants_1\":52,\"glasses_1\":0,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":-1,\"helmet_2\":0,\"arms\":11,\"face\":19,\"decals_1\":0,\"torso_1\":44,\"hair_2\":0,\"skin\":34,\"pants_2\":0}', '{}'),
(63, 'bucheron', 2, 'responsable', 'Responsable', 30, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":0,\"shoes\":27,\"torso_2\":0,\"hair_color_2\":0,\"pants_1\":52,\"glasses_1\":0,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":-1,\"helmet_2\":0,\"arms\":11,\"face\":19,\"decals_1\":0,\"torso_1\":44,\"hair_2\":0,\"skin\":34,\"pants_2\":0}', '{}'),
(64, 'bucheron', 3, 'gerant', 'Gérant', 35, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":0,\"shoes\":27,\"torso_2\":0,\"hair_color_2\":0,\"pants_1\":52,\"glasses_1\":0,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":-1,\"helmet_2\":0,\"arms\":11,\"face\":19,\"decals_1\":0,\"torso_1\":44,\"hair_2\":0,\"skin\":34,\"pants_2\":0}', '{}'),
(65, 'bucheron', 4, 'boss', 'Patron', 40, '{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":0,\"shoes\":27,\"torso_2\":0,\"hair_color_2\":0,\"pants_1\":52,\"glasses_1\":0,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":-1,\"helmet_2\":0,\"arms\":11,\"face\":19,\"decals_1\":0,\"torso_1\":44,\"hair_2\":0,\"skin\":34,\"pants_2\":0}', '{}'),
(66, 'abatteur', 0, 'stagiaire', 'Stagiaire', 12, '{}', '{}'),
(67, 'abatteur', 1, 'employe', 'Employe', 24, '{}', '{}'),
(68, 'abatteur', 2, 'responsable', 'Responsable', 36, '{}', '{}'),
(69, 'abatteur', 3, 'gerant', 'Gérant', 44, '{}', '{}'),
(70, 'abatteur', 4, 'boss', 'Patron', 63, '{}', '{}'),
(71, 'pecheur', 0, 'stagiaire', 'Stagiaire', 12, '{}', '{}'),
(72, 'pecheur', 1, 'employe', 'Employe', 24, '{}', '{}'),
(73, 'pecheur', 2, 'responsable', 'Responsable', 36, '{}', '{}'),
(74, 'pecheur', 3, 'boss', 'Patron', 48, '{}', '{}'),
(75, 'burgershot', 0, 'stagiaire', 'Stagiaire', 1, '{}', '{}'),
(76, 'burgershot', 1, 'employe', 'Employe', 10, '{}', '{}'),
(77, 'burgershot', 2, 'responsable', 'Responsable', 20, '{}', '{}'),
(78, 'burgershot', 3, 'coboss', 'Co-Patron', 20, '{}', '{}'),
(79, 'burgershot', 4, 'boss', 'Patron', 1, '{}', '{}'),
(80, 'bacars', 0, 'stagiaire', 'Stagiaire', 50, '{}', '{}'),
(81, 'bacars', 1, 'expcustom', 'Expert Customs', 85, '{}', '{}'),
(82, 'bacars', 2, 'chef', 'Chef d’équipe', 90, '{}', '{}'),
(83, 'bacars', 3, 'gerant', 'Gérant', 110, '{}', '{}'),
(84, 'bacars', 4, 'boss', 'Patron', 125, '{}', '{}'),
(85, 'bikedealer', 0, 'recruit', 'Stagiaire', 10, '{}', '{}'),
(86, 'bikedealer', 1, 'novice', 'Employé', 10, '{}', '{}'),
(87, 'bikedealer', 2, 'experienced', 'Experimente', 10, '{}', '{}'),
(88, 'bikedealer', 3, 'boss', 'Patron', 10, '{}', '{}'),
(89, 'militaire', 0, 'recrue', 'Recrue', 50, '{}', '{}'),
(90, 'militaire', 1, 'caporal', 'Caporal', 60, '{}', '{}'),
(91, 'militaire', 2, 'sergent', 'Sergent', 70, '{}', '{}'),
(92, 'militaire', 3, 'lieutenant', 'Lieutenant', 80, '{}', '{}'),
(93, 'militaire', 4, 'major', 'Major', 90, '{}', '{}'),
(94, 'militaire', 5, 'colonel', 'Colonel', 100, '{}', '{}'),
(95, 'militaire', 6, 'boss', 'Maréchal', 110, '{}', '{}'),
(96, 'suicidsquad', 1, 'boss', 'Membre', 50, '{}', '{}'),
(97, 'eboueur', 0, 'interim', 'Intérimaire', 50, '{}', '{}'),
(98, 'eboueur', 1, 'boss', 'Patron', 80, '{}', '{}'),
(100, 'realestateagent', 0, 'location', 'Location', 10, '{}', '{}'),
(101, 'realestateagent', 1, 'vendeur', 'Vendeur', 25, '{}', '{}'),
(102, 'realestateagent', 2, 'gestion', 'Gestion', 40, '{}', '{}'),
(103, 'realestateagent', 3, 'boss', 'Patron', 0, '{}', '{}'),
(104, 'gardien', 0, 'recruit', 'Stagiaire', 20, '{}', '{}'),
(106, 'gardien', 2, 'sergeant', 'Gardien-Sup', 60, '{}', '{}'),
(107, 'gardien', 3, 'lieutenant', 'Sous-Chef', 85, '{}', '{}'),
(108, 'gardien', 4, 'boss', 'Directeur', 100, '{}', '{}'),
(109, 'police', 1, 'officer', 'Officier I', 150, '{}', '{}'),
(110, 'police', 2, 'officer', 'Officier II', 175, '{}', '{}'),
(111, 'police', 3, 'officer', 'Officier III', 190, '{}', '{}'),
(112, 'police', 4, 'sergeant', 'Sergent I', 200, '{}', '{}'),
(113, 'police', 5, 'sergeant', 'Sergent II', 225, '{}', '{}'),
(114, 'police', 6, 'sergeant', 'Sergent III', 250, '{}', '{}'),
(115, 'police', 7, 'lieutenant', 'Lieutenant I', 280, '{}', '{}'),
(116, 'police', 8, 'lieutenant', 'Lieutenant II', 300, '{}', '{}'),
(117, 'police', 9, 'lieutenant', 'Lieutenant III', 330, '{}', '{}'),
(118, 'police', 10, 'chef', 'Capitaine', 350, '{}', '{}'),
(119, 'police', 11, 'boss', 'Commandant', 400, '{}', '{}'),
(123, 'sheriff', 4, 'sergeant', 'Major I', 130, '{}', '{}'),
(124, 'sheriff', 5, 'sergeant', 'Major II', 140, '{}', '{}'),
(125, 'sheriff', 6, 'sergeant', 'Major III', 150, '{}', '{}'),
(126, 'sheriff', 7, 'lieutenant', 'Sheriff-Adjoint I', 160, '{}', '{}'),
(127, 'sheriff', 8, 'lieutenant', 'Sheriff-Adjoint II', 170, '{}', '{}'),
(128, 'sheriff', 9, 'lieutenant', 'Sheriff-Adjoint III', 190, '{}', '{}'),
(129, 'sheriff', 10, 'boss', 'Capitaine', 250, '{}', '{}'),
(130, 'sheriff', 11, 'boss', 'Commandant', 400, '{}', '{}'),
(131, 'rally', 0, 'employee', 'Pilote', 50, '{\"shoes_1\":55,\"lipstick_4\":0,\"age_1\":10,\"beard_2\":10,\"decals_1\":12,\"decals_2\":0,\"beard_3\":0,\"lipstick_2\":0,\"mask_2\":0,\"hair_color_2\":0,\"eyebrows_4\":2,\"makeup_3\":0,\"beard_4\":0,\"makeup_2\":0,\"ears_1\":11,\"tshirt_1\":15,\"torso_1\":148,\"ears_2\":1,\"shoes_2\":3,\"lipstick_1\":0,\"helmet_1\":72,\"age_2\":4,\"sex\":0,\"beard_1\":10,\"skin\":0,\"hair_color_1\":2,\"glasses_2\":1,\"hair_1\":21,\"bags_1\":0,\"tshirt_2\":0,\"eyebrows_1\":17,\"bproof_1\":0,\"eyebrows_2\":10,\"glasses_1\":15,\"pants_1\":66,\"hair_2\":1,\"mask_1\":0,\"makeup_1\":0,\"torso_2\":4,\"bags_2\":0,\"face\":31,\"chain_2\":0,\"helmet_2\":5,\"pants_2\":2,\"arms\":1,\"chain_1\":0,\"bproof_2\":0,\"lipstick_3\":0,\"eyebrows_3\":3,\"makeup_4\":0}', '{\"shoes_1\":55,\"lipstick_4\":0,\"age_1\":10,\"beard_2\":10,\"decals_1\":12,\"decals_2\":0,\"beard_3\":0,\"lipstick_2\":0,\"mask_2\":0,\"hair_color_2\":0,\"eyebrows_4\":2,\"makeup_3\":0,\"beard_4\":0,\"makeup_2\":0,\"ears_1\":11,\"tshirt_1\":15,\"torso_1\":148,\"ears_2\":1,\"shoes_2\":3,\"lipstick_1\":0,\"helmet_1\":72,\"age_2\":4,\"sex\":0,\"beard_1\":10,\"skin\":0,\"hair_color_1\":2,\"glasses_2\":1,\"hair_1\":21,\"bags_1\":0,\"tshirt_2\":0,\"eyebrows_1\":17,\"bproof_1\":0,\"eyebrows_2\":10,\"glasses_1\":15,\"pants_1\":66,\"hair_2\":1,\"mask_1\":0,\"makeup_1\":0,\"torso_2\":4,\"bags_2\":0,\"face\":31,\"chain_2\":0,\"helmet_2\":5,\"pants_2\":2,\"arms\":1,\"chain_1\":0,\"bproof_2\":0,\"lipstick_3\":0,\"eyebrows_3\":3,\"makeup_4\":0}'),
(132, 'security', 0, 'recruit', 'Garde Recrue', 35, '{}', '{}'),
(133, 'security', 1, 'guard', 'Guarde Sécurité', 50, '{}', '{}'),
(134, 'security', 2, 'nightwatch', 'Guarde de Nuit', 75, '{}', '{}'),
(135, 'security', 3, 'manager', 'Manager', 10, '{}', '{}'),
(136, 'security', 4, 'boss', 'Directeur', 120, '{}', '{}'),
(137, 'brinks', 0, 'employee', 'Employé(e)', 200, '{}', '{}'),
(138, 'woodcutter', 0, 'empleado', 'Bucheron', 20, '', ''),
(139, 'mhmclovin', 0, 'empleado', 'Mineur', 20, '', ''),
(230, 'krowa', 0, 'employee', 'Fermier', 20, '', ''),
(231, 'ferrailleur', 0, 'employee', 'Ferrailleur', 20, '', ''),
(232, 'farmer', 0, 'employee', 'Fermier', 10, '{}', '{}'),
(233, 'police', 0, 'cadet', 'En Stage', 100, '{}', '{}'),
(234, 'sheriff', 0, 'cadet', 'cadet', 80, '{}', '{}'),
(236, 'fishing', 0, 'recrue', 'Apprentie', 30, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":13,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{}'),
(237, 'fishing', 1, 'recrue', 'Employer', 50, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":13,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{}'),
(238, 'fishing', 2, 'novice', 'Chef équipe', 70, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":13,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{}'),
(239, 'fishing', 3, 'cdisenior', 'Co-Patron', 75, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":13,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{}'),
(240, 'fishing', 4, 'boss', 'Patron', 100, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":13,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{}'),
(241, 'fueler', 0, 'recrue', 'Intérimaire', 250, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":13,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{}'),
(242, 'fueler', 1, 'novice', 'Chef équipe', 500, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":13,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{}'),
(243, 'fueler', 2, 'cdisenior', 'Adjoint', 750, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":13,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{}'),
(244, 'fueler', 3, 'boss', 'Patron', 1000, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":13,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{}'),
(245, 'farm', 0, 'recrue', 'Novice', 0, '{\"tshirt_1\":59,\"tshirt_2\":0,\"torso_1\":12,\"torso_2\":5,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":1, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":0,\"tshirt_2\":0,\"torso_1\":56,\"torso_2\":0,\"shoes_1\":27,\"shoes_2\":0,\"pants_1\":36, \"pants_2\":0, \"arms\":63, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
(246, 'farm', 1, 'novice', 'CDI', 0, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":5,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":0,\"tshirt_2\":0,\"torso_1\":56,\"torso_2\":0,\"shoes_1\":27,\"shoes_2\":0,\"pants_1\":36, \"pants_2\":0, \"arms\":63, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
(247, 'farm', 2, 'cdisenior', 'Gerente', 0, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":5,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":0,\"tshirt_2\":0,\"torso_1\":56,\"torso_2\":0,\"shoes_1\":27,\"shoes_2\":0,\"pants_1\":36, \"pants_2\":0, \"arms\":63, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
(248, 'farm', 3, 'boss', 'Boss', 0, '{\"tshirt_1\":57,\"tshirt_2\":0,\"torso_1\":13,\"torso_2\":5,\"shoes_1\":7,\"shoes_2\":2,\"pants_1\":9, \"pants_2\":7, \"arms\":11, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}', '{\"tshirt_1\":15,\"tshirt_2\":0,\"torso_1\":14,\"torso_2\":15,\"shoes_1\":12,\"shoes_2\":0,\"pants_1\":9, \"pants_2\":5, \"arms\":1, \"helmet_1\":11, \"helmet_2\":0,\"bags_1\":0,\"bags_2\":0,\"ears_1\":0,\"glasses_1\":0,\"ears_2\":0,\"glasses_2\":0}'),
(249, 'beekers', 0, 'recrue', 'Recrue', 12, '{}', '{}'),
(250, 'beekers', 1, 'novice', 'Novice', 24, '{}', '{}'),
(251, 'beekers', 2, 'experimente', 'Experimente', 36, '{}', '{}'),
(252, 'beekers', 3, 'chief', 'Chef d\'équipe', 48, '{}', '{}'),
(253, 'beekers', 4, 'boss', 'Patron', 0, '{}', '{}'),
(254, 'lscustoms', 0, 'recrue', 'Recrue', 25, '{}', '{}'),
(255, 'lscustoms', 1, 'novice', 'Novice', 35, '{}', '{}'),
(256, 'lscustoms', 2, 'experimente', 'Experimente', 45, '{}', '{}'),
(257, 'lscustoms', 3, 'chief', 'Chef d\'équipe', 55, '{}', '{}'),
(258, 'lscustoms', 4, 'boss', 'Patron', 65, '{}', '{}'),
(259, 'garbage', 0, 'employee', 'Employé', 40, '{}', '{}'),
(289, 'ammunation', 1, 'stage', 'Stagiaire', 40, '{}', '{}'),
(290, 'ammunation', 2, 'employé', 'Employé(e)', 40, '{}', '{}'),
(291, 'ammunation', 3, 'chef', 'Directeur', 40, '{}', '{}'),
(295, 'bennys', 0, 'recrue', 'Recrue', 50, '{}', '{}'),
(296, 'bennys', 1, 'novice', 'Novice', 70, '{}', '{}'),
(297, 'bennys', 2, 'experimente', 'Experimente', 100, '{}', '{}'),
(298, 'bennys', 3, 'chief', 'Chef d\'équipe', 125, '{}', '{}'),
(299, 'bennys', 4, 'boss', 'Patron', 150, '{}', '{}'),
(300, 'bcfuel', 0, 'stagiaire', 'Stagiaire', 10, '{}', '{}'),
(301, 'bcfuel', 1, 'employe', 'Employé', 20, '{}', '{}'),
(302, 'bcfuel', 2, 'responsable', 'Responsable', 30, '{}', '{}'),
(303, 'bcfuel', 3, 'boss', 'Patron', 40, '{}', '{}'),
(304, 'ambulance', 0, 'ambulance', 'Stagiaire', 100, '{}', '{}'),
(305, 'ambulance', 1, 'ambulance', 'Ambulancier', 150, '{}', '{}'),
(306, 'ambulance', 2, 'ambulance', 'Infirmier', 175, '{}', '{}'),
(307, 'ambulance', 3, 'doctor', 'Médecin généraliste', 190, '{}', '{}'),
(308, 'ambulance', 4, 'chief_doctor', 'Chef-Medecin', 200, '{}', '{}'),
(309, 'ambulance', 5, 'boss', 'Directeur', 230, '{}', '{}'),
(310, 'animal', 0, 'recrue', 'Animal', 10, '', ''),
(311, 'ltds', 0, 'recrue', 'Employé', 25, '{}', '{}'),
(312, 'ltds', 1, 'boss', 'Patron', 50, '{}', '{}');

-- --------------------------------------------------------

--
-- Structure de la table `known_recipes`
--

CREATE TABLE `known_recipes` (
  `identifier` varchar(50) DEFAULT NULL,
  `data` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `licenses`
--

CREATE TABLE `licenses` (
  `type` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `licenses`
--

INSERT INTO `licenses` (`type`, `label`) VALUES
('aircraft', 'Aircraft License'),
('boating', 'Boating License'),
('chimielicense', 'chimielicense'),
('dmv', 'Code de la route'),
('drive', 'Permis de conduire'),
('drive_bike', 'Permis moto'),
('drive_truck', 'Permis camion'),
('peche', 'peche'),
('weapon', 'Permis de port d\'arme');

-- --------------------------------------------------------

--
-- Structure de la table `meeta_vehicle_trunk`
--

CREATE TABLE `meeta_vehicle_trunk` (
  `id` int(11) NOT NULL,
  `plate` varchar(255) DEFAULT NULL,
  `item` varchar(255) NOT NULL,
  `count` int(11) DEFAULT NULL,
  `isweapon` int(255) NOT NULL DEFAULT 0,
  `owner` varchar(255) DEFAULT NULL,
  `label_weapon` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `open_car`
--

CREATE TABLE `open_car` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `value` varchar(50) DEFAULT NULL,
  `got` varchar(50) DEFAULT NULL,
  `NB` int(11) DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `open_car`
--

INSERT INTO `open_car` (`id`, `identifier`, `label`, `value`, `got`, `NB`) VALUES
(370, 'steam:11000011297a670', 'Cles', '66TDJ648', 'true', 2),
(382, 'steam:110000112d92f07', 'Cles', '65EYB574', 'true', 2),
(451, 'steam:11000010dd459dd', 'Cles', 'KLN56MOP', 'true', 1),
(14, 'steam:110000134476700', 'Cles', '45KKJ262', 'true', 2),
(450, 'steam:11000010dd459dd', 'Cles', 'KLN56MOP', 'true', 1),
(16, 'steam:11000013f8f0b8d', 'Cles', '01GBL623', 'true', 2),
(449, 'steam:11000010dd459dd', 'Cles', 'KLN56MOP', 'true', 1),
(49, 'steam:110000142a46acf', 'Cles', '28YEU766', 'true', 2),
(36, 'steam:110000134476700', 'Cles', '84NZS077', 'true', 2),
(33, 'steam:11000010cabc803', 'Cles', '29XIP289', 'true', 2),
(448, 'steam:11000010dd459dd', 'Cles', 'KLN56MOP', 'true', 1),
(69, 'steam:110000138d7068f', 'Cles', '09GUH760', 'true', 2),
(54, 'steam:11000013f8f0b8d', 'Cles', '88XBK886', 'true', 2),
(37, 'steam:11000011555f910', 'Cles', '84CSM782', 'true', 2),
(52, 'steam:110000142436997', 'Cles', '43VHN562', 'true', 2),
(47, 'steam:110000102e3a20a', 'Cles', '41QUL702', 'true', 2),
(41, 'steam:110000110045a74', 'Cles', '09GEX266', 'true', 2),
(53, 'steam:1100001046d0bec', 'Cles', '66GFN343', 'true', 2),
(48, 'steam:11000011555f910', 'Cles', NULL, 'true', 2),
(56, 'steam:110000142a46acf', 'Cles', '49AHH074', 'true', 2),
(929, 'steam:11000011573843f', 'Cles', '83OBN531', 'true', 2),
(99, 'steam:11000013f8f0b8d', 'Cles', '65HDO616', 'true', 2),
(145, 'steam:11000011573843f', 'Cles', '48HWW104', 'true', 2),
(64, 'steam:11000013f8f0b8d', 'Cles', '40XLP115', 'true', 2),
(66, 'steam:1100001378a3bcf', 'Cles', '07GPQ534', 'true', 2),
(67, 'steam:1100001378a3bcf', 'Cles', '09VEA842', 'true', 2),
(70, 'steam:110000142a46acf', 'Cles', '47LSN096', 'true', 2),
(71, 'steam:11000011573843f', 'Cles', '69GDX463', 'true', 2),
(72, 'steam:110000138d7068f', 'Cles', '89WDR367', 'true', 2),
(89, 'steam:110000142436997', 'Cles', '86GUL953', 'true', 2),
(76, 'steam:11000010ea86065', 'Cles', '26IRS193', 'true', 2),
(82, 'steam:1100001414cb15b', 'Cles', '65SVQ987', 'true', 2),
(79, 'steam:11000011049e800', 'Cles', '03JTJ017', 'true', 2),
(85, 'steam:11000011c805615', 'Cles', '40CEP527', 'true', 2),
(87, 'steam:11000011499d4f4', 'Cles', '84ZYD329', 'true', 2),
(102, 'steam:110000138d7068f', 'Cles', '60FJR380', 'true', 2),
(100, 'steam:11000010cabc803', 'Cles', '01HLV161', 'true', 2),
(366, 'steam:11000013bed25ff', 'Cles', '63DUX722', 'true', 1),
(104, 'steam:110000142436997', 'Cles', '69ZHN883', 'true', 2),
(365, 'steam:11000013bed25ff', 'Cles', '63DUX722', 'true', 1),
(103, 'steam:1100001378a3bcf', 'Cles', '61SGO992', 'true', 2),
(105, 'steam:110000142a46acf', 'Cles', '24HAB922', 'true', 2),
(106, 'steam:11000011573843f', 'Cles', '27FLY218', 'true', 2),
(107, 'steam:110000142a46acf', 'Cles', '83CJW934', 'true', 2),
(120, 'steam:11000010cabc803', 'Cles', '28PXR231', 'true', 2),
(137, 'steam:110000138d7068f', 'Cles', '82RBA580', 'true', 2),
(111, 'steam:11000010dd459dd', 'Cles', '22ATG177', 'true', 2),
(112, 'steam:11000010a284db0', 'Cles', '89GJZ601', 'true', 2),
(812, 'steam:11000011499d4f4', 'Cles', '09FCT633', 'true', 2),
(116, 'steam:11000011499d4f4', 'Cles', '40VDU071', 'true', 2),
(121, 'steam:11000010dd459dd', 'Cles', '87HUA738', 'true', 2),
(122, 'steam:1100001378a3bcf', 'Cles', '62JLC786', 'true', 2),
(124, 'steam:11000011c805615', 'Cles', '86OOL897', 'true', 2),
(126, 'steam:110000138d7068f', 'Cles', '65RGV343', 'true', 2),
(364, 'steam:11000013bed25ff', 'Cles', '63DUX722', 'true', 1),
(141, 'steam:1100001378a3bcf', 'Cles', '47GEJ814', 'true', 2),
(129, 'steam:11000010cabc803', 'Cles', '44XSA836', 'true', 2),
(133, 'steam:110000138d7068f', 'Cles', '61LXH293', 'true', 2),
(134, 'steam:11000011573843f', 'Cles', '81KFV562', 'true', 2),
(140, 'steam:11000011499d4f4', 'Cles', '02LDV471', 'true', 2),
(142, 'steam:11000013f8f0b8d', 'Cles', '63SQK641', 'true', 2),
(143, 'steam:11000011573843f', 'Cles', '20QNW582', 'true', 2),
(363, 'steam:11000013bed25ff', 'Cles', '63DUX722', 'true', 1),
(151, 'steam:1100001378a3bcf', 'Cles', '43BXL233', 'true', 2),
(375, 'steam:11000010dd459dd', 'Cles', '43VKL790', 'true', 2),
(447, 'steam:11000010dd459dd', 'Cles', 'KLN56MOP', 'true', 1),
(357, 'steam:11000013bed25ff', 'Cles', '63DUX722', 'true', 1),
(358, 'steam:11000013bed25ff', 'Cles', '63DUX722', 'true', 1),
(798, 'steam:1100001431c5e7a', 'Cles', 'SDQBWD2 ', 'true', 1),
(159, 'steam:1100001378a3bcf', 'Cles', '49YDF839', 'true', 2),
(160, 'steam:110000138d7068f', 'Cles', '84JIZ877', 'true', 2),
(163, 'steam:1100001378a3bcf', 'Cles', '86VAL679', 'true', 2),
(177, 'steam:11000013f8f0b8d', 'Cles', '60YUO060', 'true', 2),
(175, 'steam:11000013c5b30aa', 'Cles', '85BME585', 'true', 2),
(178, 'steam:110000138fc6304', 'Cles', '44IIR948', 'true', 1),
(362, 'steam:11000013bed25ff', 'Cles', '63DUX722', 'true', 1),
(361, 'steam:11000013bed25ff', 'Cles', '63DUX722', 'true', 1),
(789, 'steam:11000011573843f', 'Cles', '42FIN095', 'true', 2),
(360, 'steam:11000013bed25ff', 'Cles', '63DUX722', 'true', 1),
(192, 'steam:11000011c805615', 'Cles', '01IHX492', 'true', 2),
(832, 'steam:11000013f8f0b8d', 'Cles', '28RVT917', 'true', 2),
(446, 'steam:11000010dd459dd', 'Cles', 'KLN56MOP', 'true', 1),
(469, 'steam:11000013bed25ff', 'Cles', '45LMP368', 'true', 1),
(201, 'steam:1100001378a3bcf', 'Cles', '40KCO396', 'true', 2),
(203, 'steam:11000013bed25ff', 'Cles', '422KNM66', 'true', 1),
(204, 'steam:11000013bed25ff', 'Cles', '422KNM66', 'true', 1),
(205, 'steam:11000013bed25ff', 'Cles', '422KNM66', 'true', 1),
(206, 'steam:11000013bed25ff', 'Cles', '422KNM66', 'true', 1),
(207, 'steam:11000013bed25ff', 'Cles', '422KNM66', 'true', 1),
(208, 'steam:11000013bed25ff', 'Cles', '422KNM66', 'true', 1),
(209, 'steam:11000013bed25ff', 'Cles', '422KNM66', 'true', 1),
(210, 'steam:11000013bed25ff', 'Cles', '422KNM66', 'true', 1),
(211, 'steam:11000013bed25ff', 'Cles', '422KNM66', 'true', 1),
(212, 'steam:11000013bed25ff', 'Cles', '422KNM66', 'true', 1),
(241, 'steam:1100001378a3bcf', 'Cles', '68TPB221', 'true', 2),
(240, 'steam:1100001378a3bcf', 'Cles', '64KEI259', 'true', 2),
(239, 'steam:1100001378a3bcf', 'Cles', '65NCS884', 'true', 2),
(238, 'steam:1100001378a3bcf', 'Cles', '27XLL047', 'true', 2),
(236, 'steam:11000010dd459dd', 'Cles', '60DYM664', 'true', 2),
(254, 'steam:11000011c805615', 'Cles', '63DBP645', 'true', 2),
(246, 'steam:1100001106cce52', 'Cles', '21CWX110', 'true', 2),
(304, 'steam:11000011573843f', 'Cles', '68DCQ754', 'true', 2),
(229, 'steam:1100001106cce52', 'Cles', '21QEH085', 'true', 2),
(359, 'steam:11000013bed25ff', 'Cles', '63DUX722', 'true', 1),
(255, 'steam:11000011573843f', 'Cles', '20TWR479', 'true', 2),
(244, 'steam:11000011c805615', 'Cles', '45VRE348', 'true', 2),
(251, 'steam:11000011c805615', 'Cles', '00IZY773', 'true', 2),
(252, 'steam:11000011c805615', 'Cles', '80XGT456', 'true', 2),
(258, 'steam:11000011c805615', 'Cles', '89YPW610', 'true', 2),
(445, 'steam:11000010dd459dd', 'Cles', 'KLN56MOP', 'true', 1),
(262, 'steam:11000013c5b30aa', 'Cles', '852KJU34', 'true', 1),
(263, 'steam:11000013c5b30aa', 'Cles', '852KJU34', 'true', 1),
(264, 'steam:11000013c5b30aa', 'Cles', '852KJU34', 'true', 1),
(265, 'steam:11000013c5b30aa', 'Cles', '852KJU34', 'true', 1),
(266, 'steam:11000013c5b30aa', 'Cles', '852KJU34', 'true', 1),
(267, 'steam:11000013c5b30aa', 'Cles', '852KJU34', 'true', 1),
(268, 'steam:11000013c5b30aa', 'Cles', '852KJU34', 'true', 1),
(269, 'steam:11000013c5b30aa', 'Cles', '852KJU34', 'true', 1),
(270, 'steam:11000013c5b30aa', 'Cles', '852KJU34', 'true', 1),
(271, 'steam:11000013c5b30aa', 'Cles', '852KJU34', 'true', 1),
(272, 'steam:110000142a46acf', 'Cles', '852KJU34', 'true', 2),
(444, 'steam:11000010dd459dd', 'Cles', 'KLN56MOP', 'true', 1),
(443, 'steam:11000014444a970', 'Cles', '  XXXX  ', 'true', 1),
(442, 'steam:11000014444a970', 'Cles', '  XXXX  ', 'true', 1),
(441, 'steam:11000014444a970', 'Cles', '  XXXX  ', 'true', 1),
(440, 'steam:11000014444a970', 'Cles', '  XXXX  ', 'true', 1),
(439, 'steam:11000014444a970', 'Cles', '  XXXX  ', 'true', 1),
(438, 'steam:11000014444a970', 'Cles', '  XXXX  ', 'true', 1),
(437, 'steam:11000014444a970', 'Cles', '  XXXX  ', 'true', 1),
(436, 'steam:11000014444a970', 'Cles', '  XXXX  ', 'true', 1),
(435, 'steam:11000014444a970', 'Cles', '  XXXX  ', 'true', 1),
(468, 'steam:11000013bed25ff', 'Cles', '45LMP368', 'true', 1),
(467, 'steam:11000013bed25ff', 'Cles', '45LMP368', 'true', 1),
(466, 'steam:11000013bed25ff', 'Cles', '45LMP368', 'true', 1),
(465, 'steam:11000013bed25ff', 'Cles', '45LMP368', 'true', 1),
(464, 'steam:11000013bed25ff', 'Cles', '45LMP368', 'true', 1),
(463, 'steam:11000013bed25ff', 'Cles', '45LMP368', 'true', 1),
(462, 'steam:11000013bed25ff', 'Cles', '45LMP368', 'true', 1),
(459, 'steam:110000138d7068f', 'Cles', '66CMU212', 'true', 2),
(458, 'steam:1100001378a3bcf', 'Cles', '47VKW950', 'true', 2),
(461, 'steam:11000013bed25ff', 'Cles', '45LMP368', 'true', 1),
(295, 'steam:110000138d7068f', 'Cles', '49QWC718', 'true', 2),
(296, 'steam:1100001378a3bcf', 'Cles', '89VNB302', 'true', 2),
(786, 'steam:11000011499d4f4', 'Cles', '03HQW623', 'true', 2),
(300, 'steam:1100001378a3bcf', 'Cles', '46KJI594', 'true', 2),
(302, 'steam:1100001378a3bcf', 'Cles', '88EHS628', 'true', 2),
(303, 'steam:11000013b726a62', 'Cles', '03IRR525', 'true', 2),
(306, 'steam:1100001378a3bcf', 'Cles', '61KUW085', 'true', 2),
(307, 'steam:110000138d7068f', 'Cles', '66UXV061', 'true', 2),
(308, 'steam:110000112d92f07', 'Cles', '04ZHN129', 'true', 2),
(310, 'steam:11000013bed25ff', 'Cles', '453KIZ47', 'true', 1),
(311, 'steam:11000013bed25ff', 'Cles', '453KIZ47', 'true', 1),
(312, 'steam:11000013bed25ff', 'Cles', '453KIZ47', 'true', 1),
(313, 'steam:11000013bed25ff', 'Cles', '453KIZ47', 'true', 1),
(314, 'steam:11000013bed25ff', 'Cles', '453KIZ47', 'true', 1),
(315, 'steam:11000013bed25ff', 'Cles', '453KIZ47', 'true', 1),
(316, 'steam:11000013bed25ff', 'Cles', '453KIZ47', 'true', 1),
(317, 'steam:11000013bed25ff', 'Cles', '453KIZ47', 'true', 1),
(318, 'steam:11000013bed25ff', 'Cles', '453KIZ47', 'true', 1),
(319, 'steam:11000013bed25ff', 'Cles', '453KIZ47', 'true', 1),
(841, 'steam:110000115ee2582', 'Cles', '83CCF894', 'true', 2),
(433, 'steam:11000011573843f', 'Cles', '83KVW061', 'true', 2),
(434, 'steam:11000014444a970', 'Cles', '  XXXX  ', 'true', 1),
(415, 'steam:11000011573843f', 'Cles', '02XRZ052', 'true', 2),
(413, 'steam:11000011145241e', 'Cles', '88APS898', 'true', 2),
(330, 'steam:110000110349c14', 'Cles', '22NRT655', 'true', 1),
(331, 'steam:110000110349c14', 'Cles', '22NRT655', 'true', 1),
(332, 'steam:110000110349c14', 'Cles', '22NRT655', 'true', 1),
(333, 'steam:110000110349c14', 'Cles', '22NRT655', 'true', 1),
(334, 'steam:110000110349c14', 'Cles', '22NRT655', 'true', 1),
(335, 'steam:110000110349c14', 'Cles', '22NRT655', 'true', 1),
(336, 'steam:110000110349c14', 'Cles', '22NRT655', 'true', 1),
(337, 'steam:110000110349c14', 'Cles', '22NRT655', 'true', 1),
(338, 'steam:110000110349c14', 'Cles', '22NRT655', 'true', 1),
(339, 'steam:110000110349c14', 'Cles', '22NRT655', 'true', 1),
(342, 'steam:11000011573843f', 'Cles', '47EBE469', 'true', 2),
(392, 'steam:110000134e55837', 'Cles', '04XUE206', 'true', 2),
(355, 'steam:11000013f162ec6', 'Cles', '89LTX518', 'true', 2),
(380, 'steam:11000011c805615', 'Cles', '61YTH466', 'true', 2),
(379, 'steam:11000013527d71e', 'Cles', '45NLQ132', 'true', 2),
(388, 'steam:11000011573843f', 'Cles', '87CTO767', 'true', 2),
(391, 'steam:11000010abdd58a', 'Cles', '27KTC073', 'true', 2),
(385, 'steam:11000011297a670', 'Cles', '80RHN650', 'true', 2),
(396, 'steam:11000011c805615', 'Cles', '68MNM993', 'true', 2),
(387, 'steam:11000011c805615', 'Cles', '05ZNI955', 'true', 2),
(397, 'steam:11000011573843f', 'Cles', '43IPY875', 'true', 2),
(390, 'steam:11000011c805615', 'Cles', '05JKA647', 'true', 2),
(398, 'steam:1100001378a3bcf', 'Cles', '03PQF418', 'true', 2),
(399, 'steam:110000138d7068f', 'Cles', '01PMT053', 'true', 2),
(400, 'steam:11000013527d71e', 'Cles', '40PRP741', 'true', 2),
(401, 'steam:11000013f162ec6', 'Cles', '60HEK158', 'true', 2),
(402, 'steam:110000138d7068f', 'Cles', '46YTO525', 'true', 2),
(403, 'steam:11000013f162ec6', 'Cles', '46LQS625', 'true', 2),
(414, 'steam:1100001378a3bcf', 'Cles', '08QAU398', 'true', 2),
(412, 'steam:11000013f162ec6', 'Cles', '04ZIH359', 'true', 2),
(452, 'steam:11000010dd459dd', 'Cles', 'KLN56MOP', 'true', 1),
(453, 'steam:11000010dd459dd', 'Cles', 'KLN56MOP', 'true', 1),
(470, 'steam:11000013bed25ff', 'Cles', '45LMP368', 'true', 1),
(471, 'steam:11000013bed25ff', 'Cles', '54JMO451', 'true', 1),
(472, 'steam:11000013bed25ff', 'Cles', '54JMO451', 'true', 1),
(473, 'steam:11000013bed25ff', 'Cles', '54JMO451', 'true', 1),
(474, 'steam:11000013bed25ff', 'Cles', '54JMO451', 'true', 1),
(475, 'steam:11000013bed25ff', 'Cles', '54JMO451', 'true', 1),
(476, 'steam:11000013bed25ff', 'Cles', '54JMO451', 'true', 1),
(477, 'steam:11000013bed25ff', 'Cles', '54JMO451', 'true', 1),
(478, 'steam:11000013bed25ff', 'Cles', '54JMO451', 'true', 1),
(479, 'steam:11000013bed25ff', 'Cles', '54JMO451', 'true', 1),
(480, 'steam:11000013bed25ff', 'Cles', '54JMO451', 'true', 1),
(481, 'steam:110000138d7068f', 'Cles', '        ', 'true', 1),
(482, 'steam:110000138d7068f', 'Cles', '        ', 'true', 1),
(483, 'steam:110000138d7068f', 'Cles', '        ', 'true', 1),
(484, 'steam:110000138d7068f', 'Cles', '        ', 'true', 1),
(485, 'steam:110000138d7068f', 'Cles', '        ', 'true', 1),
(486, 'steam:110000138d7068f', 'Cles', '        ', 'true', 1),
(487, 'steam:110000138d7068f', 'Cles', '        ', 'true', 1),
(488, 'steam:110000138d7068f', 'Cles', '        ', 'true', 1),
(489, 'steam:110000138d7068f', 'Cles', '        ', 'true', 1),
(490, 'steam:110000138d7068f', 'Cles', '        ', 'true', 1),
(496, 'steam:110000138d7068f', 'Cles', '86YVO061', 'true', 2),
(495, 'steam:11000013556bee0', 'Cles', '45QQU765', 'true', 2),
(497, 'steam:1100001378a3bcf', 'Cles', '61AAW063', 'true', 2),
(790, 'steam:11000013f8f0b8d', 'Cles', '09OWV933', 'true', 2),
(782, 'steam:11000011573843f', 'Cles', '21FCJ451', 'true', 2),
(767, 'steam:11000013759b11a', 'Cles', '89NDD676', 'true', 2),
(516, 'steam:11000010dd459dd', 'Cles', '03JLW438', 'true', 2),
(517, 'steam:11000010abdd58a', 'Cles', '02RHM821', 'true', 2),
(518, 'steam:11000010abdd58a', 'Cles', '03XKF314', 'true', 2),
(777, 'steam:1100001004bf05f', 'Cles', '61WCM262', 'true', 2),
(535, 'steam:1100001358da02f', 'Cles', '66KBA826', 'true', 2),
(540, 'steam:11000010abdd58a', 'Cles', '09YWX911', 'true', 2),
(537, 'steam:1100001164b40b0', 'Cles', '48TPY025', 'true', 2),
(542, 'steam:110000138d7068f', 'Cles', '83YPY937', 'true', 2),
(539, 'steam:110000139616534', 'Cles', '86YIL600', 'true', 2),
(541, 'steam:1100001358da02f', 'Cles', '04GJX685', 'true', 2),
(551, 'steam:1100001164b40b0', 'Cles', '26CLQ840', 'true', 2),
(544, 'steam:11000010abdd58a', 'Cles', '44HUG031', 'true', 2),
(545, 'steam:11000011518e1f9', 'Cles', '44UCU545', 'true', 2),
(546, 'steam:110000138d7068f', 'Cles', '06LFN136', 'true', 2),
(550, 'steam:11000011518e1f9', 'Cles', '40LYS607', 'true', 2),
(552, 'steam:11000011518e1f9', 'Cles', '00PLF826', 'true', 2),
(556, 'steam:11000013b241d35', 'Cles', '06GRG759', 'true', 2),
(555, 'steam:11000013d2488f7', 'Cles', '06XXY032', 'true', 2),
(570, 'steam:11000011518e1f9', 'Cles', '86EDJ477', 'true', 2),
(560, 'steam:1100001027eca08', 'Cles', '        ', 'true', 1),
(561, 'steam:1100001027eca08', 'Cles', '        ', 'true', 1),
(562, 'steam:1100001027eca08', 'Cles', '        ', 'true', 1),
(563, 'steam:1100001027eca08', 'Cles', '        ', 'true', 1),
(564, 'steam:1100001027eca08', 'Cles', '        ', 'true', 1),
(565, 'steam:1100001027eca08', 'Cles', '        ', 'true', 1),
(566, 'steam:1100001027eca08', 'Cles', '        ', 'true', 1),
(567, 'steam:1100001027eca08', 'Cles', '        ', 'true', 1),
(568, 'steam:1100001027eca08', 'Cles', '        ', 'true', 1),
(569, 'steam:1100001027eca08', 'Cles', '        ', 'true', 1),
(572, 'steam:11000011518e1f9', 'Cles', '28ZGB409', 'true', 2),
(573, 'steam:11000011518e1f9', 'Cles', '84MVW967', 'true', 2),
(574, 'steam:11000011518e1f9', 'Cles', '47UTX041', 'true', 2),
(576, 'steam:110000113783cba', 'Cles', '48JGG632', 'true', 2),
(579, 'steam:110000113783cba', 'Cles', '41HJS067', 'true', 2),
(581, 'steam:11000013bd48cc5', 'Cles', '44LAX590', 'true', 2),
(586, 'steam:110000138d7068f', 'Cles', '68LKO045', 'true', 2),
(587, 'steam:11000013b726a62', 'Cles', '60JKV455', 'true', 2),
(588, 'steam:11000011518e1f9', 'Cles', '67GPJ312', 'true', 2),
(585, 'steam:1100001164b40b0', 'Cles', '49FOA761', 'true', 2),
(589, 'steam:1100001377aa44b', 'Cles', '42LMP452', 'true', 1),
(590, 'steam:1100001377aa44b', 'Cles', '42LMP452', 'true', 1),
(591, 'steam:1100001377aa44b', 'Cles', '42LMP452', 'true', 1),
(592, 'steam:1100001377aa44b', 'Cles', '42LMP452', 'true', 1),
(593, 'steam:1100001377aa44b', 'Cles', '42LMP452', 'true', 1),
(594, 'steam:1100001377aa44b', 'Cles', '42LMP452', 'true', 1),
(595, 'steam:1100001377aa44b', 'Cles', '42LMP452', 'true', 1),
(596, 'steam:1100001377aa44b', 'Cles', '42LMP452', 'true', 1),
(597, 'steam:1100001377aa44b', 'Cles', '42LMP452', 'true', 1),
(598, 'steam:1100001377aa44b', 'Cles', '42LMP452', 'true', 1),
(599, 'steam:1100001377aa44b', 'Cles', '45LKY569', 'true', 1),
(600, 'steam:1100001377aa44b', 'Cles', '45LKY569', 'true', 1),
(601, 'steam:1100001377aa44b', 'Cles', '45LKY569', 'true', 1),
(602, 'steam:1100001377aa44b', 'Cles', '45LKY569', 'true', 1),
(603, 'steam:1100001377aa44b', 'Cles', '45LKY569', 'true', 1),
(604, 'steam:1100001377aa44b', 'Cles', '45LKY569', 'true', 1),
(605, 'steam:1100001377aa44b', 'Cles', '45LKY569', 'true', 1),
(606, 'steam:1100001377aa44b', 'Cles', '45LKY569', 'true', 1),
(607, 'steam:1100001377aa44b', 'Cles', '45LKY569', 'true', 1),
(608, 'steam:1100001377aa44b', 'Cles', '45LKY569', 'true', 1),
(609, 'steam:1100001377aa44b', 'Cles', '45MHG697', 'true', 1),
(610, 'steam:1100001377aa44b', 'Cles', '45MHG697', 'true', 1),
(611, 'steam:1100001377aa44b', 'Cles', '45MHG697', 'true', 1),
(612, 'steam:1100001377aa44b', 'Cles', '45MHG697', 'true', 1),
(613, 'steam:1100001377aa44b', 'Cles', '45MHG697', 'true', 1),
(614, 'steam:1100001377aa44b', 'Cles', '45MHG697', 'true', 1),
(615, 'steam:1100001377aa44b', 'Cles', '45MHG697', 'true', 1),
(616, 'steam:1100001377aa44b', 'Cles', '45MHG697', 'true', 1),
(617, 'steam:1100001377aa44b', 'Cles', '45MHG697', 'true', 1),
(618, 'steam:1100001377aa44b', 'Cles', '45MHG697', 'true', 1),
(619, 'steam:1100001377aa44b', 'Cles', '  XXXX  ', 'true', 1),
(620, 'steam:1100001377aa44b', 'Cles', '  XXXX  ', 'true', 1),
(621, 'steam:1100001377aa44b', 'Cles', '  XXXX  ', 'true', 1),
(622, 'steam:1100001377aa44b', 'Cles', '  XXXX  ', 'true', 1),
(623, 'steam:1100001377aa44b', 'Cles', '  XXXX  ', 'true', 1),
(624, 'steam:1100001377aa44b', 'Cles', '  XXXX  ', 'true', 1),
(625, 'steam:1100001377aa44b', 'Cles', '  XXXX  ', 'true', 1),
(626, 'steam:1100001377aa44b', 'Cles', '  XXXX  ', 'true', 1),
(627, 'steam:1100001377aa44b', 'Cles', '  XXXX  ', 'true', 1),
(628, 'steam:1100001377aa44b', 'Cles', '  XXXX  ', 'true', 1),
(629, 'steam:1100001377aa44b', 'Cles', '42MPO569', 'true', 1),
(630, 'steam:1100001377aa44b', 'Cles', '42MPO569', 'true', 1),
(631, 'steam:1100001377aa44b', 'Cles', '42MPO569', 'true', 1),
(632, 'steam:1100001377aa44b', 'Cles', '42MPO569', 'true', 1),
(633, 'steam:1100001377aa44b', 'Cles', '42MPO569', 'true', 1),
(634, 'steam:1100001377aa44b', 'Cles', '42MPO569', 'true', 1),
(635, 'steam:1100001377aa44b', 'Cles', '42MPO569', 'true', 1),
(636, 'steam:1100001377aa44b', 'Cles', '42MPO569', 'true', 1),
(637, 'steam:1100001377aa44b', 'Cles', '42MPO569', 'true', 1),
(638, 'steam:1100001377aa44b', 'Cles', '42MPO569', 'true', 1),
(639, 'steam:1100001164b40b0', 'Cles', '24WOT138', 'true', 2),
(640, 'steam:110000113783cba', 'Cles', '81KAL960', 'true', 2),
(647, 'steam:1100001378a3bcf', 'Cles', '84IYJ275', 'true', 2),
(698, 'steam:11000011573843f', 'Cles', '44YVN572', 'true', 2),
(650, 'steam:1100001378a3bcf', 'Cles', '28GKN204', 'true', 2),
(644, 'steam:11000011518e1f9', 'Cles', '48SXF184', 'true', 2),
(645, 'steam:1100001378a3bcf', 'Cles', '83KGY487', 'true', 2),
(646, 'steam:110000138d7068f', 'Cles', '49EPX958', 'true', 2),
(652, 'steam:11000011573843f', 'Cles', '46AWB709', 'true', 2),
(653, 'steam:11000011573843f', 'Cles', '09YYP765', 'true', 2),
(655, 'steam:11000011c805615', 'Cles', '61OPV738', 'true', 2),
(706, 'steam:110000113783cba', 'Cles', '08UEI614', 'true', 2),
(658, 'steam:110000105bff9aa', 'Cles', '45MLO964', 'true', 1),
(659, 'steam:110000105bff9aa', 'Cles', '45MLO964', 'true', 1),
(660, 'steam:110000105bff9aa', 'Cles', '45MLO964', 'true', 1),
(661, 'steam:110000105bff9aa', 'Cles', '45MLO964', 'true', 1),
(662, 'steam:110000105bff9aa', 'Cles', '45MLO964', 'true', 1),
(663, 'steam:110000105bff9aa', 'Cles', '45MLO964', 'true', 1),
(664, 'steam:110000105bff9aa', 'Cles', '45MLO964', 'true', 1),
(665, 'steam:110000105bff9aa', 'Cles', '45MLO964', 'true', 1),
(666, 'steam:110000105bff9aa', 'Cles', '45MLO964', 'true', 1),
(667, 'steam:110000105bff9aa', 'Cles', '45MLO964', 'true', 1),
(668, 'steam:110000105bff9aa', 'Cles', '89LOI587', 'true', 1),
(669, 'steam:110000105bff9aa', 'Cles', '89LOI587', 'true', 1),
(670, 'steam:110000105bff9aa', 'Cles', '89LOI587', 'true', 1),
(671, 'steam:110000105bff9aa', 'Cles', '89LOI587', 'true', 1),
(672, 'steam:110000105bff9aa', 'Cles', '89LOI587', 'true', 1),
(673, 'steam:110000105bff9aa', 'Cles', '89LOI587', 'true', 1),
(674, 'steam:110000105bff9aa', 'Cles', '89LOI587', 'true', 1),
(675, 'steam:110000105bff9aa', 'Cles', '89LOI587', 'true', 1),
(676, 'steam:110000105bff9aa', 'Cles', '89LOI587', 'true', 1),
(677, 'steam:110000105bff9aa', 'Cles', '89LOI587', 'true', 1),
(678, 'steam:11000013bbbf6f8', 'Cles', '58LYU894', 'true', 1),
(679, 'steam:11000013bbbf6f8', 'Cles', '58LYU894', 'true', 1),
(680, 'steam:11000013bbbf6f8', 'Cles', '58LYU894', 'true', 1),
(681, 'steam:11000013bbbf6f8', 'Cles', '58LYU894', 'true', 1),
(682, 'steam:11000013bbbf6f8', 'Cles', '58LYU894', 'true', 1),
(683, 'steam:11000013bbbf6f8', 'Cles', '58LYU894', 'true', 1),
(684, 'steam:11000013bbbf6f8', 'Cles', '58LYU894', 'true', 1),
(685, 'steam:11000013bbbf6f8', 'Cles', '58LYU894', 'true', 1),
(686, 'steam:11000013bbbf6f8', 'Cles', '58LYU894', 'true', 1),
(687, 'steam:11000013bbbf6f8', 'Cles', '58LYU894', 'true', 1),
(688, 'steam:11000013bed25ff', 'Cles', '85MLP963', 'true', 1),
(689, 'steam:11000013bed25ff', 'Cles', '85MLP963', 'true', 1),
(690, 'steam:11000013bed25ff', 'Cles', '85MLP963', 'true', 1),
(691, 'steam:11000013bed25ff', 'Cles', '85MLP963', 'true', 1),
(692, 'steam:11000013bed25ff', 'Cles', '85MLP963', 'true', 1),
(693, 'steam:11000013bed25ff', 'Cles', '85MLP963', 'true', 1),
(694, 'steam:11000013bed25ff', 'Cles', '85MLP963', 'true', 1),
(695, 'steam:11000013bed25ff', 'Cles', '85MLP963', 'true', 1),
(696, 'steam:11000013bed25ff', 'Cles', '85MLP963', 'true', 1),
(697, 'steam:11000013bed25ff', 'Cles', '85MLP963', 'true', 1),
(709, 'steam:1100001377aa44b', 'Cles', '56MLJ254', 'true', 1),
(700, 'steam:11000013b241d35', 'Cles', '28JGX766', 'true', 2),
(701, 'steam:11000010abdd58a', 'Cles', '64TUY234', 'true', 2),
(703, 'steam:11000010abdd58a', 'Cles', '46LWX166', 'true', 2),
(704, 'steam:11000013b241d35', 'Cles', '09MMD821', 'true', 2),
(710, 'steam:1100001377aa44b', 'Cles', '56MLJ254', 'true', 1),
(711, 'steam:1100001377aa44b', 'Cles', '56MLJ254', 'true', 1),
(712, 'steam:1100001377aa44b', 'Cles', '56MLJ254', 'true', 1),
(713, 'steam:1100001377aa44b', 'Cles', '56MLJ254', 'true', 1),
(714, 'steam:1100001377aa44b', 'Cles', '56MLJ254', 'true', 1),
(715, 'steam:1100001377aa44b', 'Cles', '56MLJ254', 'true', 1),
(716, 'steam:1100001377aa44b', 'Cles', '56MLJ254', 'true', 1),
(717, 'steam:1100001377aa44b', 'Cles', '56MLJ254', 'true', 1),
(718, 'steam:1100001377aa44b', 'Cles', '56MLJ254', 'true', 1),
(719, 'steam:1100001377aa44b', 'Cles', '12OIU871', 'true', 1),
(720, 'steam:1100001377aa44b', 'Cles', '12OIU871', 'true', 1),
(721, 'steam:1100001377aa44b', 'Cles', '12OIU871', 'true', 1),
(722, 'steam:1100001377aa44b', 'Cles', '12OIU871', 'true', 1),
(723, 'steam:1100001377aa44b', 'Cles', '12OIU871', 'true', 1),
(724, 'steam:1100001377aa44b', 'Cles', '12OIU871', 'true', 1),
(725, 'steam:1100001377aa44b', 'Cles', '12OIU871', 'true', 1),
(726, 'steam:1100001377aa44b', 'Cles', '12OIU871', 'true', 1),
(727, 'steam:1100001377aa44b', 'Cles', '12OIU871', 'true', 1),
(728, 'steam:1100001377aa44b', 'Cles', '12OIU871', 'true', 1),
(922, 'steam:11000010644522d', 'Cles', '05UOC250', 'true', 2),
(923, 'steam:11000010644522d', 'Cles', '88YER624', 'true', 2),
(928, 'steam:11000013f8f0b8d', 'Cles', '02HOU094', 'true', 2),
(918, 'steam:11000010644522d', 'Cles', '03EPY170', 'true', 2),
(917, 'steam:11000010644522d', 'Cles', '23ZSF074', 'true', 2),
(915, 'steam:11000010644522d', 'Cles', '07QBM245', 'true', 2),
(916, 'steam:11000010644522d', 'Cles', '65SZW432', 'true', 2),
(892, 'steam:11000013f8f0b8d', 'Cles', '62FEC217', 'true', 2),
(889, 'steam:11000011499d4f4', 'Cles', '85HJR876', 'true', 2),
(745, 'steam:11000011573843f', 'Cles', '83ZBK965', 'true', 2),
(741, 'steam:11000011573843f', 'Cles', '26LEA359', 'true', 2),
(785, 'steam:11000013f8f0b8d', 'Cles', '40QEY104', 'true', 2),
(743, 'steam:11000013759b11a', 'Cles', '86NJM109', 'true', 2),
(749, 'steam:1100001358da02f', 'Cles', '01RAW116', 'true', 2),
(747, 'steam:1100001358da02f', 'Cles', '24YHQ535', 'true', 2),
(757, 'steam:11000013f8f0b8d', 'Cles', '83LSU587', 'true', 2),
(756, 'steam:11000011499d4f4', 'Cles', '08IGP014', 'true', 2),
(773, 'steam:11000013f8f0b8d', 'Cles', '47WJZ765', 'true', 2),
(817, 'steam:11000013b241d35', 'Cles', '82LKF644', 'true', 2),
(799, 'steam:1100001431c5e7a', 'Cles', 'SDQBWD2 ', 'true', 1),
(800, 'steam:1100001431c5e7a', 'Cles', 'SDQBWD2 ', 'true', 1),
(801, 'steam:1100001431c5e7a', 'Cles', 'SDQBWD2 ', 'true', 1),
(802, 'steam:1100001431c5e7a', 'Cles', 'SDQBWD2 ', 'true', 1),
(803, 'steam:1100001431c5e7a', 'Cles', 'SDQBWD2 ', 'true', 1),
(804, 'steam:1100001431c5e7a', 'Cles', 'SDQBWD2 ', 'true', 1),
(805, 'steam:1100001431c5e7a', 'Cles', 'SDQBWD2 ', 'true', 1),
(806, 'steam:1100001431c5e7a', 'Cles', 'SDQBWD2 ', 'true', 1),
(807, 'steam:1100001431c5e7a', 'Cles', 'SDQBWD2 ', 'true', 1),
(818, 'steam:11000011499d4f4', 'Cles', '69PZK191', 'true', 2),
(819, 'steam:11000013f8f0b8d', 'Cles', '80OOL248', 'true', 2),
(837, 'steam:11000011573843f', 'Cles', '80PRA928', 'true', 2),
(821, 'steam:11000011499d4f4', 'Cles', '26SDU954', 'true', 2),
(828, 'steam:11000011499d4f4', 'Cles', '22YQG661', 'true', 2),
(826, 'steam:11000011499d4f4', 'Cles', '03JHD514', 'true', 2),
(838, 'steam:11000013f8f0b8d', 'Cles', '61ZDM794', 'true', 2),
(846, 'steam:110000115ee2582', 'Cles', '68SCB334', 'true', 2),
(847, 'steam:11000011499d4f4', 'Cles', '07ONM598', 'true', 2),
(848, 'steam:11000011499d4f4', 'Cles', '43XVF869', 'true', 2),
(850, 'steam:11000013f8f0b8d', 'Cles', '03FUI870', 'true', 2),
(851, 'steam:11000011499d4f4', 'Cles', '81JQJ371', 'true', 2),
(861, 'steam:11000013f8f0b8d', 'Cles', '45FYG712', 'true', 2),
(930, 'steam:11000010644522d', 'Cles', '67XUD614', 'true', 2),
(925, 'steam:110000117c6c085', 'Cles', '88CUD006', 'true', 2),
(866, 'steam:11000013bbbf6f8', 'Cles', 'SQLA6MG ', 'true', 1),
(867, 'steam:11000013bbbf6f8', 'Cles', 'SQLA6MG ', 'true', 1),
(868, 'steam:11000013bbbf6f8', 'Cles', 'SQLA6MG ', 'true', 1),
(869, 'steam:11000013bbbf6f8', 'Cles', 'SQLA6MG ', 'true', 1),
(870, 'steam:11000013bbbf6f8', 'Cles', 'SQLA6MG ', 'true', 1),
(871, 'steam:11000013bbbf6f8', 'Cles', 'SQLA6MG ', 'true', 1),
(872, 'steam:11000013bbbf6f8', 'Cles', 'SQLA6MG ', 'true', 1),
(873, 'steam:11000013bbbf6f8', 'Cles', 'SQLA6MG ', 'true', 1),
(874, 'steam:11000013bbbf6f8', 'Cles', 'SQLA6MG ', 'true', 1),
(875, 'steam:11000013bbbf6f8', 'Cles', 'SQLA6MG ', 'true', 1),
(876, 'steam:1100001027eca08', 'Cles', ' BM89DF ', 'true', 1),
(877, 'steam:1100001027eca08', 'Cles', ' BM89DF ', 'true', 1),
(878, 'steam:1100001027eca08', 'Cles', ' BM89DF ', 'true', 1),
(879, 'steam:1100001027eca08', 'Cles', ' BM89DF ', 'true', 1),
(880, 'steam:1100001027eca08', 'Cles', ' BM89DF ', 'true', 1),
(881, 'steam:1100001027eca08', 'Cles', ' BM89DF ', 'true', 1),
(882, 'steam:1100001027eca08', 'Cles', ' BM89DF ', 'true', 1),
(883, 'steam:1100001027eca08', 'Cles', ' BM89DF ', 'true', 1),
(884, 'steam:1100001027eca08', 'Cles', ' BM89DF ', 'true', 1),
(885, 'steam:1100001027eca08', 'Cles', ' BM89DF ', 'true', 1),
(893, 'steam:110000117c6c085', 'Cles', '47PGJ438', 'true', 2),
(931, 'steam:110000115ee2582', 'Cles', '24UPG789', 'true', 2),
(939, 'steam:11000013b084086', 'Cles', '84UVA905', 'true', 2),
(938, 'steam:11000013b241d35', 'Cles', '66NBT297', 'true', 2),
(949, 'steam:110000113783cba', 'Cles', '58LYU894', 'true', 1),
(945, 'steam:110000117c6c085', 'Cles', '25OXZ024', 'true', 2),
(942, 'steam:110000115ee2582', 'Cles', '81PZN297', 'true', 2),
(964, 'steam:11000010644522d', 'Cles', '88EAB045', 'true', 2),
(953, 'steam:11000010644522d', 'Cles', '41WFN090', 'true', 2),
(954, 'steam:1100001027eca08', 'Cles', 'SWMJ67H ', 'true', 1),
(955, 'steam:1100001027eca08', 'Cles', 'SWMJ67H ', 'true', 1),
(956, 'steam:1100001027eca08', 'Cles', 'SWMJ67H ', 'true', 1),
(957, 'steam:1100001027eca08', 'Cles', 'SWMJ67H ', 'true', 1),
(958, 'steam:1100001027eca08', 'Cles', 'SWMJ67H ', 'true', 1),
(959, 'steam:1100001027eca08', 'Cles', 'SWMJ67H ', 'true', 1),
(960, 'steam:1100001027eca08', 'Cles', 'SWMJ67H ', 'true', 1),
(961, 'steam:1100001027eca08', 'Cles', 'SWMJ67H ', 'true', 1),
(962, 'steam:1100001027eca08', 'Cles', 'SWMJ67H ', 'true', 1),
(963, 'steam:1100001027eca08', 'Cles', 'SWMJ67H ', 'true', 1),
(972, 'steam:110000113783cba', 'Cles', '        ', 'true', 1),
(973, 'steam:110000113783cba', 'Cles', '        ', 'true', 1),
(974, 'steam:110000113783cba', 'Cles', '        ', 'true', 1),
(971, 'steam:110000117c6c085', 'Cles', '29PJA302', 'true', 2),
(975, 'steam:110000113783cba', 'Cles', '        ', 'true', 1),
(976, 'steam:110000113783cba', 'Cles', '        ', 'true', 1),
(977, 'steam:110000113783cba', 'Cles', '        ', 'true', 1),
(978, 'steam:110000113783cba', 'Cles', '        ', 'true', 1),
(979, 'steam:110000113783cba', 'Cles', '        ', 'true', 1),
(980, 'steam:110000113783cba', 'Cles', '        ', 'true', 1),
(981, 'steam:110000113783cba', 'Cles', '        ', 'true', 1),
(982, 'steam:110000113783cba', 'Cles', '00JRM609', 'true', 1),
(983, 'steam:110000113783cba', 'Cles', '00JRM609', 'true', 1),
(984, 'steam:110000113783cba', 'Cles', '00JRM609', 'true', 1),
(985, 'steam:110000113783cba', 'Cles', '00JRM609', 'true', 1),
(986, 'steam:110000113783cba', 'Cles', '00JRM609', 'true', 1),
(987, 'steam:110000113783cba', 'Cles', '00JRM609', 'true', 1),
(988, 'steam:110000113783cba', 'Cles', '00JRM609', 'true', 1),
(989, 'steam:110000113783cba', 'Cles', '00JRM609', 'true', 1),
(990, 'steam:110000113783cba', 'Cles', '00JRM609', 'true', 1),
(991, 'steam:110000113783cba', 'Cles', '00JRM609', 'true', 1),
(993, 'steam:110000115edf4f2', 'Cles', '20LKX750', 'true', 2),
(996, 'steam:11000011573843f', 'Cles', '44FMJ485', 'true', 2),
(997, 'steam:1100001027eca08', 'Cles', '60YTL264', 'true', 1),
(998, 'steam:1100001027eca08', 'Cles', '60YTL264', 'true', 1),
(999, 'steam:1100001027eca08', 'Cles', '60YTL264', 'true', 1),
(1000, 'steam:1100001027eca08', 'Cles', '60YTL264', 'true', 1),
(1001, 'steam:1100001027eca08', 'Cles', '60YTL264', 'true', 1),
(1002, 'steam:1100001027eca08', 'Cles', '60YTL264', 'true', 1),
(1003, 'steam:1100001027eca08', 'Cles', '60YTL264', 'true', 1),
(1004, 'steam:1100001027eca08', 'Cles', '60YTL264', 'true', 1),
(1005, 'steam:1100001027eca08', 'Cles', '60YTL264', 'true', 1),
(1006, 'steam:1100001027eca08', 'Cles', '60YTL264', 'true', 1),
(1007, 'steam:1100001027eca08', 'Cles', '80QVS646', 'true', 1),
(1008, 'steam:1100001027eca08', 'Cles', '80QVS646', 'true', 1),
(1009, 'steam:1100001027eca08', 'Cles', '80QVS646', 'true', 1),
(1010, 'steam:1100001027eca08', 'Cles', '80QVS646', 'true', 1),
(1011, 'steam:1100001027eca08', 'Cles', '80QVS646', 'true', 1),
(1012, 'steam:1100001027eca08', 'Cles', '80QVS646', 'true', 1),
(1013, 'steam:1100001027eca08', 'Cles', '80QVS646', 'true', 1),
(1014, 'steam:1100001027eca08', 'Cles', '80QVS646', 'true', 1),
(1015, 'steam:1100001027eca08', 'Cles', '80QVS646', 'true', 1),
(1016, 'steam:1100001027eca08', 'Cles', '80QVS646', 'true', 1),
(1017, 'steam:11000011573843f', 'Cles', '63YUS153', 'true', 2),
(1018, 'steam:11000011573843f', 'Cles', '64OVB469', 'true', 2),
(1019, 'steam:11000011573843f', 'Cles', '66OWH780', 'true', 2),
(1020, 'steam:11000011573843f', 'Cles', '81YCB380', 'true', 2),
(1021, 'steam:11000011573843f', 'Cles', '84KVQ717', 'true', 2),
(1022, 'steam:11000011573843f', 'Cles', '68ZXT606', 'true', 2),
(1023, 'steam:11000011573843f', 'Cles', '46TVF371', 'true', 2),
(1024, 'steam:11000013b084086', 'Cles', '26QPM301', 'true', 2),
(1025, 'steam:11000011573843f', 'Cles', '68YXI150', 'true', 2),
(1035, 'steam:11000011573843f', 'Cles', '00FEG786', 'true', 2),
(1037, 'steam:11000011573843f', 'Cles', '24TSG340', 'true', 2),
(1048, 'steam:11000011573843f', 'Cles', '24MTV291', 'true', 2),
(1057, 'steam:11000013759b11a', 'Cles', '84OTM011', 'true', 2),
(1044, 'steam:110000117c6c085', 'Cles', '01KBD657', 'true', 2),
(1045, 'steam:11000013759b11a', 'Cles', '27IYL821', 'true', 2),
(1046, 'steam:11000013f8f0b8d', 'Cles', '03DTJ149', 'true', 2),
(1047, 'steam:11000013f8f0b8d', 'Cles', '64NEX426', 'true', 2),
(1049, 'steam:110000117c6c085', 'Cles', '02DKJ886', 'true', 2),
(1056, 'steam:110000117c6c085', 'Cles', '23MFL969', 'true', 2),
(1055, 'steam:110000115edf4f2', 'Cles', '81NVM372', 'true', 2),
(1059, 'steam:110000115edf4f2', 'Cles', '23JEI722', 'true', 2),
(1060, 'steam:110000115edf4f2', 'Cles', '40AOG833', 'true', 2),
(1061, 'steam:110000115edf4f2', 'Cles', '40VHF984', 'true', 2),
(1062, 'steam:110000115edf4f2', 'Cles', '85BDV951', 'true', 2),
(1063, 'steam:11000011b4db7ed', 'Cles', '41SRA452', 'true', 2),
(1064, 'steam:1100001004bf05f', 'Cles', '24ORU169', 'true', 2),
(1066, 'steam:1100001004bf05f', 'Cles', '86BCU283', 'true', 2),
(1067, 'steam:1100001004bf05f', 'Cles', '86CDP488', 'true', 2),
(1068, 'steam:1100001004bf05f', 'Cles', '62895', 'true', 2),
(1074, 'steam:1100001004bf05f', 'Cles', ' 427889 ', 'true', 2),
(1070, 'steam:1100001004bf05f', 'Cles', ' 481756 ', 'true', 2),
(1071, 'steam:1100001004bf05f', 'Cles', ' 449151 ', 'true', 2),
(1072, 'steam:1100001004bf05f', 'Cles', ' 429225 ', 'true', 2),
(1075, 'steam:1100001004bf05f', 'Cles', ' 314086 ', 'true', 2),
(1076, 'steam:1100001004bf05f', 'Cles', ' 840669 ', 'true', 2),
(1077, 'steam:1100001004bf05f', 'Cles', ' 166273 ', 'true', 2),
(1078, 'steam:1100001004bf05f', 'Cles', ' SDQSWQ ', 'true', 1),
(1079, 'steam:1100001004bf05f', 'Cles', '81WVS774', 'true', 1),
(1080, 'steam:1100001004bf05f', 'Cles', '60PQD500', 'true', 2),
(1081, 'steam:1100001004bf05f', 'Cles', ' 397683 ', 'true', 2),
(1082, 'steam:1100001004bf05f', 'Cles', '01KVG527', 'true', 2),
(1084, 'discord:659921990190235650', 'Cles', '42XWY983', 'true', 2),
(1085, 'discord:659921990190235650', 'Cles', '49NCZ005', 'true', 2),
(1086, 'discord:659921990190235650', 'Cles', '25ZRM395', 'true', 2),
(1087, 'discord:659921990190235650', 'Cles', '67MOS216', 'true', 2),
(1088, 'discord:722766829881131038', 'Cles', '06WCJ431', 'true', 2),
(1090, 'discord:722766829881131038', 'Cles', '69MUJ536', 'true', 2),
(1091, 'discord:722766829881131038', 'Cles', 'TAI 607', 'true', 1),
(1094, 'discord:722766829881131038', 'Cles', ' 137494 ', 'true', 2),
(1095, 'discord:722766829881131038', 'Cles', '25SLH394', 'true', 2),
(1096, 'discord:722766829881131038', 'Cles', '44UQZ466', 'true', 2);

-- --------------------------------------------------------

--
-- Structure de la table `org`
--

CREATE TABLE `org` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `org`
--

INSERT INTO `org` (`name`, `label`) VALUES
('20th', '20Th'),
('Arkan', 'Arkan'),
('aztecas', 'Aztecas'),
('ballas', 'Ballas'),
('biker', 'Sons of Anarchy'),
('blackdemon', 'Black Demon'),
('blackos', 'Camorra'),
('bonelli', 'Bonelli'),
('bratiskaia', 'Bratiskaia'),
('cjng', 'CJNG'),
('comorra', 'Comorra'),
('dystopia', 'Dystopia'),
('families', 'Families'),
('fields', 'fields'),
('irish', 'Irish'),
('lost', 'Lost'),
('Madrazo', 'Madrazo'),
('marabunta', 'Marabunta'),
('oneil', 'O\'Neil'),
('organisation', 'État'),
('pcc', 'PCC'),
('reyes', 'Los Reyes'),
('sacra', 'Sacra'),
('sanstreet', 'San Street'),
('sinaloa', 'Sinaloa'),
('triade', 'Triade'),
('vagos', 'Vagos'),
('yb16', 'yb16');

-- --------------------------------------------------------

--
-- Structure de la table `orga_grades`
--

CREATE TABLE `orga_grades` (
  `id_grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `rang` int(11) NOT NULL,
  `id_orga` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `orga_grades`
--

INSERT INTO `orga_grades` (`id_grade`, `name`, `rang`, `id_orga`) VALUES
(14, 'Boss', 1, 4),
(15, 'Habitant', 2, 4),
(16, 'Bras Droit', 3, 4);

-- --------------------------------------------------------

--
-- Structure de la table `orga_grade_perm`
--

CREATE TABLE `orga_grade_perm` (
  `id_grade_perm` int(11) NOT NULL,
  `recruit` varchar(50) DEFAULT NULL,
  `fire` varchar(50) DEFAULT NULL,
  `attribute_property` varchar(50) DEFAULT NULL,
  `give_access_property` varchar(50) DEFAULT NULL,
  `access_property` varchar(50) DEFAULT NULL,
  `see_chest` varchar(50) DEFAULT NULL,
  `deposit` varchar(50) DEFAULT NULL,
  `remove` varchar(50) DEFAULT NULL,
  `access_garage` varchar(50) DEFAULT NULL,
  `take_car` varchar(50) DEFAULT NULL,
  `park_car` varchar(50) DEFAULT NULL,
  `id_grade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `orga_grade_perm`
--

INSERT INTO `orga_grade_perm` (`id_grade_perm`, `recruit`, `fire`, `attribute_property`, `give_access_property`, `access_property`, `see_chest`, `deposit`, `remove`, `access_garage`, `take_car`, `park_car`, `id_grade`) VALUES
(14, '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', '1', 14),
(15, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 15),
(16, '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', 16);

-- --------------------------------------------------------

--
-- Structure de la table `orga_liste`
--

CREATE TABLE `orga_liste` (
  `id_orga` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `devise` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `orga_liste`
--

INSERT INTO `orga_liste` (`id_orga`, `name`, `devise`) VALUES
(4, 'F4L', 'F4L.');

-- --------------------------------------------------------

--
-- Structure de la table `orga_membres`
--

CREATE TABLE `orga_membres` (
  `id_membre` int(11) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `id_grade` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `orga_membres`
--

INSERT INTO `orga_membres` (`id_membre`, `identifier`, `label`, `id_grade`) VALUES
(12, 'discord:722766829881131038', ' ', 14);

-- --------------------------------------------------------

--
-- Structure de la table `org_gradeorg`
--

CREATE TABLE `org_gradeorg` (
  `id` int(11) NOT NULL,
  `org_name` varchar(50) DEFAULT NULL,
  `gradeorg` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext NOT NULL,
  `skin_female` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `org_gradeorg`
--

INSERT INTO `org_gradeorg` (`id`, `org_name`, `gradeorg`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
(1, 'organisation', 0, 'organisation', 'Civil', 0, '{}', '{}'),
(2, 'ballas', 0, 'soldato', 'Ptite-Frappe', 0, '{}', '{}'),
(3, 'ballas', 1, 'capo', 'Capo', 0, '{}', '{}'),
(4, 'ballas', 2, 'consigliere', 'Chef', 0, '{}', '{}'),
(5, 'ballas', 3, 'boss', 'Patron', 0, '{}', '{}'),
(6, 'vagos', 0, 'soldato', 'Ptite-Frappe', 0, '{}', '{}'),
(7, 'vagos', 1, 'capo', 'Capo', 0, '{}', '{}'),
(8, 'vagos', 2, 'consigliere', 'Chef', 0, '{}', '{}'),
(9, 'vagos', 3, 'boss', 'Patron', 0, '{}', '{}'),
(10, 'families', 0, 'soldato', 'Ptite-Frappe', 0, '{}', '{}'),
(11, 'families', 1, 'capo', 'Capo', 0, '{}', '{}'),
(12, 'families', 2, 'consigliere', 'Chef', 0, '{}', '{}'),
(13, 'families', 3, 'boss', 'OG', 0, '{}', '{}'),
(14, 'sacra', 0, 'soldato', 'Principiante', 0, '{}', '{}'),
(15, 'sacra', 1, 'capo', 'Venditore', 0, '{}', '{}'),
(16, 'sacra', 2, 'consigliere', 'Tenente', 0, '{}', '{}'),
(17, 'sacra', 3, 'boss', 'El Capo', 0, '{}', '{}'),
(22, 'Arkan', 0, 'soldato', 'Ptite-Frappe', 0, '{}', '{}'),
(23, 'Arkan', 1, 'capo', 'Capo', 0, '{}', '{}'),
(24, 'Arkan', 2, 'consigliere', 'Chef', 0, '{}', '{}'),
(25, 'Arkan', 3, 'boss', 'Patron', 0, '{}', '{}'),
(26, 'Madrazo', 0, 'soldato', 'Ptite-Frappe', 0, '{}', '{}'),
(27, 'Madrazo', 1, 'capo', 'Capo', 0, '{}', '{}'),
(28, 'Madrazo', 2, 'consigliere', 'Chef', 0, '{}', '{}'),
(29, 'Madrazo', 3, 'boss', 'Patron', 0, '{}', '{}'),
(30, 'marabunta', 0, 'soldato', 'Ptite-Frappe', 0, '{}', '{}'),
(31, 'marabunta', 1, 'capo', 'Capo', 0, '{}', '{}'),
(32, 'marabunta', 2, 'consigliere', 'Chef', 0, '{}', '{}'),
(33, 'marabunta', 3, 'boss', 'Patron', 0, '{}', '{}'),
(34, 'lost', 0, 'soldato', 'Ptite-Frappe', 0, '{}', '{}'),
(35, 'lost', 1, 'capo', 'Capo', 0, '{}', '{}'),
(36, 'lost', 2, 'consigliere', 'Chef', 0, '{}', '{}'),
(37, 'lost', 3, 'boss', 'Patron', 0, '{}', '{}'),
(38, 'aztecas', 0, 'soldato', 'Ptite-Frappe', 0, '{}', '{}'),
(39, 'aztecas', 1, 'capo', 'Capo', 0, '{}', '{}'),
(40, 'aztecas', 2, 'consigliere', 'Chef', 0, '{}', '{}'),
(41, 'aztecas', 3, 'boss', 'Patron', 0, '{}', '{}'),
(42, 'triade', 0, 'soldato', 'Ptite-Frappe', 0, '{}', '{}'),
(43, 'triade', 1, 'capo', 'Capo', 0, '{}', '{}'),
(44, 'triade', 2, 'consigliere', 'Chef', 0, '{}', '{}'),
(45, 'triade', 3, 'boss', 'Patron', 0, '{}', '{}'),
(46, 'oneil', 0, 'soldato', 'Ptite-Frappe', 0, '{}', '{}'),
(47, 'oneil', 1, 'capo', 'Capo', 0, '{}', '{}'),
(48, 'oneil', 2, 'consigliere', 'Chef', 0, '{}', '{}'),
(49, 'oneil', 3, 'boss', 'Patron', 0, '{}', '{}'),
(50, 'dystopia', 0, 'soldato', 'Ptite-Frappe', 1500, '{}', '{}'),
(51, 'dystopia', 1, 'capo', 'Capo', 1800, '{}', '{}'),
(52, 'dystopia', 2, 'consigliere', 'Chef', 2100, '{}', '{}'),
(53, 'dystopia', 3, 'boss', 'Patron', 2700, '{}', '{}'),
(54, 'sanstreet', 0, 'soldato', 'Ptite-Frappe', 1500, '{}', '{}'),
(55, 'sanstreet', 1, 'capo', 'Capo', 1800, '{}', '{}'),
(56, 'sanstreet', 2, 'consigliere', 'Chef', 2100, '{}', '{}'),
(57, 'sanstreet', 3, 'boss', 'Patron', 2700, '{}', '{}'),
(58, 'comorra', 0, 'soldato', 'Ptite-Frappe', 0, '{}', '{}'),
(59, 'comorra', 1, 'capo', 'Capo', 0, '{}', '{}'),
(60, 'comorra', 2, 'consigliere', 'Chef', 0, '{}', '{}'),
(61, 'comorra', 3, 'boss', 'Patron', 0, '{}', '{}'),
(62, 'biker', 0, 'soldato', 'Ptite-Frappe', 0, '{}', '{}'),
(63, 'biker', 1, 'capo', 'Capo', 0, '{}', '{}'),
(64, 'biker', 2, 'consigliere', 'Chef', 0, '{}', '{}'),
(65, 'biker', 3, 'boss', 'Patron', 0, '{}', '{}'),
(66, 'bratiskaia', 0, 'soldato', 'Ptite-Frappe', 0, '{}', '{}'),
(67, 'bratiskaia', 1, 'capo', 'Capo', 0, '{}', '{}'),
(68, 'bratiskaia', 2, 'consigliere', 'Chef', 0, '{}', '{}'),
(69, 'bratiskaia', 3, 'boss', 'Patron', 0, '{}', '{}'),
(70, 'yb16', 0, 'soldato', 'Ptite-Frappe', 0, '{}', '{}'),
(71, 'yb16', 1, 'capo', 'Capo', 0, '{}', '{}'),
(72, 'yb16', 2, 'consigliere', 'Chef', 0, '{}', '{}'),
(73, 'yb16', 3, 'boss', 'Patron', 0, '{}', '{}'),
(74, 'fields', 0, 'soldato', 'Ptite-Frappe', 0, '{}', '{}'),
(75, 'fields', 1, 'capo', 'Capo', 0, '{}', '{}'),
(76, 'fields', 2, 'consigliere', 'Chef', 0, '{}', '{}'),
(77, 'fields', 3, 'boss', 'Patron', 0, '{}', '{}'),
(78, 'blackdemon', 0, 'soldato', 'Ptite-Frappe', 0, '{}', '{}'),
(79, 'blackdemon', 1, 'capo', 'Capo', 0, '{}', '{}'),
(80, 'blackdemon', 2, 'consigliere', 'Chef', 0, '{}', '{}'),
(81, 'blackdemon', 3, 'boss', 'Patron', 0, '{}', '{}'),
(82, 'cjng', 0, 'soldato', 'Ptite-Frappe', 0, '{}', '{}'),
(83, 'cjng', 1, 'capo', 'Capo', 0, '{}', '{}'),
(84, 'cjng', 2, 'consigliere', 'Chef', 0, '{}', '{}'),
(85, 'cjng', 3, 'boss', 'Patron', 0, '{}', '{}'),
(86, 'bonelli', 0, 'soldato', 'Ptite-Frappe', 0, '{}', '{}'),
(87, 'bonelli', 1, 'capo', 'Capo', 0, '{}', '{}'),
(88, 'bonelli', 2, 'consigliere', 'Chef', 0, '{}', '{}'),
(89, 'bonelli', 3, 'boss', 'Patron', 0, '{}', '{}'),
(90, 'irish', 0, 'soldato', 'Ptite-Frappe', 0, '{}', '{}'),
(91, 'irish', 1, 'capo', 'Capo', 0, '{}', '{}'),
(92, 'irish', 2, 'consigliere', 'Chef', 0, '{}', '{}'),
(93, 'irish', 3, 'boss', 'Patron', 0, '{}', '{}'),
(94, 'sinaloa', 0, 'soldato', 'Ptite-Frappe', 0, '{}', '{}'),
(95, 'sinaloa', 1, 'capo', 'Capo', 0, '{}', '{}'),
(96, 'sinaloa', 2, 'consigliere', 'Chef', 0, '{}', '{}'),
(97, 'sinaloa', 3, 'boss', 'Patron', 0, '{}', '{}'),
(98, 'blackos', 0, 'soldato', 'Ptite-Frappe', 0, '{}', '{}'),
(99, 'blackos', 1, 'capo', 'Capo', 0, '{}', '{}'),
(100, 'blackos', 2, 'consigliere', 'Chef', 0, '{}', '{}'),
(101, 'blackos', 3, 'boss', 'Patron', 0, '{}', '{}'),
(102, 'reyes', 0, 'soldato', 'Ptite-Frappe', 0, '{}', '{}'),
(103, 'reyes', 1, 'capo', 'Capo', 0, '{}', '{}'),
(104, 'reyes', 2, 'consigliere', 'Chef', 0, '{}', '{}'),
(105, 'reyes', 3, 'boss', 'Patron', 0, '{}', '{}'),
(106, '20th', 0, 'soldato', 'Ptite-Frappe', 0, '{}', '{}'),
(107, '20th', 1, 'capo', 'Capo', 0, '{}', '{}'),
(108, '20th', 2, 'consigliere', 'Chef', 0, '{}', '{}'),
(109, '20th', 3, 'boss', 'Patron', 0, '{}', '{}'),
(114, 'pcc', 0, 'soldato', 'Ptite-Frappe', 0, '{}', '{}'),
(115, 'pcc', 1, 'capo', 'Capo', 0, '{}', '{}'),
(116, 'pcc', 2, 'consigliere', 'Chef', 0, '{}', '{}'),
(117, 'pcc', 3, 'boss', 'Patron', 0, '{}', '{}');

-- --------------------------------------------------------

--
-- Structure de la table `owned_boats`
--

CREATE TABLE `owned_boats` (
  `id` int(11) NOT NULL,
  `vehicle` longtext NOT NULL,
  `owner` varchar(60) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'State of the boat'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `owned_properties`
--

CREATE TABLE `owned_properties` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `rented` int(11) NOT NULL,
  `owner` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `owned_shops`
--

CREATE TABLE `owned_shops` (
  `identifier` varchar(250) DEFAULT NULL,
  `ShopNumber` int(11) DEFAULT NULL,
  `money` int(11) DEFAULT 0,
  `ShopValue` int(11) DEFAULT NULL,
  `LastRobbery` int(11) DEFAULT 0,
  `ShopName` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `owned_vehicles`
--

CREATE TABLE `owned_vehicles` (
  `owner` varchar(22) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Etat de la voiture',
  `garageperso` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'Garage Personnel',
  `plate` varchar(12) NOT NULL,
  `vehicle` longtext DEFAULT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `job` varchar(20) DEFAULT NULL,
  `stored` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `owned_vehicles`
--

INSERT INTO `owned_vehicles` (`owner`, `state`, `garageperso`, `plate`, `vehicle`, `type`, `job`, `stored`) VALUES
('discord:72276682988113', 0, 0, 'TAI 607', '{\"modHood\":-1,\"modTransmission\":-1,\"wheelColor\":156,\"modTrimB\":-1,\"modOrnaments\":-1,\"modSideSkirt\":-1,\"modFender\":-1,\"modRightFender\":-1,\"modRearBumper\":-1,\"neonColor\":[255,0,255],\"modEngineBlock\":-1,\"modTank\":-1,\"modVanityPlate\":-1,\"modFrontWheels\":-1,\"modSpeakers\":-1,\"windowTint\":-1,\"modTrunk\":-1,\"modBackWheels\":-1,\"modStruts\":-1,\"extras\":{\"11\":true,\"12\":false},\"dirtLevel\":3.0,\"modSeats\":-1,\"modXenon\":false,\"modLivery\":-1,\"modSuspension\":-1,\"modArmor\":-1,\"modGrille\":-1,\"modAPlate\":-1,\"modArchCover\":-1,\"color1\":1,\"modDial\":-1,\"modHorns\":-1,\"modTurbo\":false,\"modSpoilers\":-1,\"modFrontBumper\":-1,\"pearlescentColor\":10,\"model\":-511601230,\"modShifterLeavers\":-1,\"modDoorSpeaker\":-1,\"color2\":1,\"modAerials\":-1,\"modWindows\":-1,\"modSteeringWheel\":-1,\"neonEnabled\":[false,false,false,false],\"tyreSmokeColor\":[255,255,255],\"modEngine\":-1,\"modRoof\":-1,\"modPlateHolder\":-1,\"modAirFilter\":-1,\"wheels\":0,\"modDashboard\":-1,\"fuelLevel\":65.0,\"modSmokeEnabled\":false,\"plateIndex\":0,\"modBrakes\":-1,\"modExhaust\":-1,\"health\":1000,\"plate\":\"TAI 607\",\"modTrimA\":-1,\"modFrame\":-1,\"modHydrolic\":-1}', 'car', NULL, 0);

-- --------------------------------------------------------

--
-- Structure de la table `pawnshops`
--

CREATE TABLE `pawnshops` (
  `shopdata` longtext DEFAULT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `phone_app_chat`
--

CREATE TABLE `phone_app_chat` (
  `id` int(11) NOT NULL,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `phone_calls`
--

CREATE TABLE `phone_calls` (
  `id` int(11) NOT NULL,
  `owner` varchar(10) NOT NULL COMMENT 'Num tel proprio',
  `num` varchar(10) NOT NULL COMMENT 'Num reférence du contact',
  `incoming` int(11) NOT NULL COMMENT 'Défini si on est à l''origine de l''appels',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `accepts` int(11) NOT NULL COMMENT 'Appels accepter ou pas'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `phone_messages`
--

CREATE TABLE `phone_messages` (
  `id` int(11) NOT NULL,
  `transmitter` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `phone_messages`
--

INSERT INTO `phone_messages` (`id`, `transmitter`, `receiver`, `message`, `time`, `isRead`, `owner`) VALUES
(106, '555777', '5551669', 'eeeee', '2021-06-15 15:51:49', 1, 1),
(107, '5551669', '5551669', 'ahahahah', '2021-06-15 15:52:51', 1, 0),
(108, '5551669', '5551669', 'ahahahah', '2021-06-15 15:52:52', 1, 1),
(109, '5551669', '5551669', 'GPS: 141.75108337402, -995.03259277344', '2021-06-15 15:52:54', 1, 0),
(110, '5551669', '5551669', 'GPS: 141.75108337402, -995.03259277344', '2021-06-15 15:52:55', 1, 1),
(111, '5551669', '5551669', 'zzzzzzzzzzzzzzzz', '2021-06-15 17:04:43', 1, 0),
(112, '5551669', '5551669', 'zzzzzzzzzzzzzzzz', '2021-06-15 17:04:43', 1, 1),
(113, 'unicorn', '5551669', 'zzzzz', '2021-06-15 17:16:22', 1, 1),
(114, '5551669', '5550469', 'zzzzzzzzzzzzzzzzzzzzzzzzddddddd', '2021-06-19 09:44:18', 1, 1),
(115, '5551669', '5550469', 'ok', '2021-06-19 09:44:22', 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `phone_users_contacts`
--

CREATE TABLE `phone_users_contacts` (
  `id` int(11) NOT NULL,
  `identifier` varchar(60) CHARACTER SET utf8mb4 DEFAULT NULL,
  `number` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL,
  `display` varchar(64) CHARACTER SET utf8mb4 NOT NULL DEFAULT '-1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `phone_users_contacts`
--

INSERT INTO `phone_users_contacts` (`id`, `identifier`, `number`, `display`) VALUES
(7, 'steam:11000013e993a14', '5557892', 'Zlife'),
(8, 'steam:11000013e993a14', '5554793', 'ZK'),
(9, 'discord:722766829881131038', '5551669', 'Zk');

-- --------------------------------------------------------

--
-- Structure de la table `playerstattoos`
--

CREATE TABLE `playerstattoos` (
  `identifier` mediumtext NOT NULL,
  `tattoos` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `playerstattoos`
--

INSERT INTO `playerstattoos` (`identifier`, `tattoos`) VALUES
('license:17f6400eca49b79c6ae5dbc889e0bcbbf3ce9039', '[]'),
('steam:11000013e993a14', '[]');

-- --------------------------------------------------------

--
-- Structure de la table `position_agricultures`
--

CREATE TABLE `position_agricultures` (
  `id` varchar(255) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `x` double(8,2) NOT NULL,
  `y` double(8,2) NOT NULL,
  `z` double(8,2) NOT NULL,
  `percent` double(8,2) DEFAULT 0.00
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `properties`
--

CREATE TABLE `properties` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `entering` varchar(255) DEFAULT NULL,
  `exit` varchar(255) DEFAULT NULL,
  `inside` varchar(255) DEFAULT NULL,
  `outside` varchar(255) DEFAULT NULL,
  `ipls` varchar(255) DEFAULT '[]',
  `gateway` varchar(255) DEFAULT NULL,
  `is_single` int(11) DEFAULT NULL,
  `is_room` int(11) DEFAULT NULL,
  `is_gateway` int(11) DEFAULT NULL,
  `room_menu` varchar(255) DEFAULT NULL,
  `garage` varchar(255) DEFAULT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `properties_access`
--

CREATE TABLE `properties_access` (
  `id_access` int(11) NOT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `id_property` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `properties_inventory`
--

CREATE TABLE `properties_inventory` (
  `id` int(11) NOT NULL,
  `propertie_id` int(11) DEFAULT NULL,
  `item` varchar(255) NOT NULL,
  `count` int(11) DEFAULT NULL,
  `isweapon` int(255) NOT NULL DEFAULT 0,
  `owner` varchar(255) DEFAULT NULL,
  `label_weapon` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `properties_list`
--

CREATE TABLE `properties_list` (
  `id_property` int(11) NOT NULL,
  `property_name` varchar(50) NOT NULL,
  `property_pos` varchar(100) DEFAULT NULL,
  `property_chest` varchar(50) DEFAULT NULL,
  `property_type` varchar(50) DEFAULT NULL,
  `property_price` int(11) DEFAULT NULL,
  `property_status` varchar(50) DEFAULT 'free',
  `property_owner` varchar(50) DEFAULT NULL,
  `garage_pos` varchar(100) DEFAULT NULL,
  `garage_max` int(11) DEFAULT NULL,
  `jobs` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `properties_list`
--

INSERT INTO `properties_list` (`id_property`, `property_name`, `property_pos`, `property_chest`, `property_type`, `property_price`, `property_status`, `property_owner`, `garage_pos`, `garage_max`, `jobs`) VALUES
(13, 'Mirror Drive West 6346', '{\"x\":961.193115234375,\"y\":-669.4647827148438,\"z\":58.44914245605469}', '500', 'Appartement1', 1150, 'rented', 'discord:722766829881131038', '{\"x\":943.8989868164063,\"y\":-670.07958984375,\"z\":58.01144409179687}', 10, NULL),
(14, 'Mirror Drive West 6803', '{\"x\":943.244384765625,\"y\":-464.3009338378906,\"z\":61.2523078918457}', '500', 'Appartement2', 1725, 'rented', 'discord:722766829881131038', '{\"x\":939.944580078125,\"y\":-464.30975341796877,\"z\":61.2523078918457}', 10, NULL),
(15, 'Vespucci Boulevard 4248', '{\"x\":-1078.7119140625,\"y\":-856.5838623046875,\"z\":5.04271078109741}', '1000', 'Entrepot2', 3750, 'bought', 'discord:722766829881131038', '{\"x\":-1068.4931640625,\"y\":-856.729248046875,\"z\":4.86762809753418}', 95, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `properties_vehicles`
--

CREATE TABLE `properties_vehicles` (
  `id_vehicle` int(11) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `vehicle_property` longtext DEFAULT NULL,
  `health_engine` int(11) DEFAULT NULL,
  `tire_front_left` tinyint(1) DEFAULT NULL,
  `tire_front_right` tinyint(1) DEFAULT NULL,
  `tire_back_left` tinyint(1) DEFAULT NULL,
  `tire_back_right` tinyint(1) DEFAULT NULL,
  `id_property` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `rented_bikes`
--

CREATE TABLE `rented_bikes` (
  `vehicle` varchar(60) NOT NULL,
  `plate` varchar(12) NOT NULL,
  `player_name` varchar(255) NOT NULL,
  `base_price` int(11) NOT NULL,
  `rent_price` int(11) NOT NULL,
  `owner` varchar(22) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `rented_boats`
--

CREATE TABLE `rented_boats` (
  `id` int(11) NOT NULL,
  `vehicle` varchar(60) NOT NULL,
  `plate` varchar(10) NOT NULL,
  `player_name` varchar(255) NOT NULL,
  `base_price` int(11) NOT NULL,
  `rent_price` int(11) NOT NULL,
  `owner` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `rented_vehicles`
--

CREATE TABLE `rented_vehicles` (
  `vehicle` varchar(60) NOT NULL,
  `plate` varchar(12) NOT NULL,
  `player_name` varchar(255) NOT NULL,
  `base_price` int(11) NOT NULL,
  `rent_price` int(11) NOT NULL,
  `owner` varchar(22) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `savedobjects`
--

CREATE TABLE `savedobjects` (
  `pos` longtext DEFAULT NULL,
  `rot` longtext DEFAULT NULL,
  `model` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `sim`
--

CREATE TABLE `sim` (
  `identifier` varchar(50) NOT NULL,
  `phone_number` varchar(10) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `sim`
--

INSERT INTO `sim` (`identifier`, `phone_number`) VALUES
('discord:659921990190235650', '5557745'),
('discord:722766829881131038', NULL),
('discord:722766829881131038', '5552021'),
('discord:722766829881131038', '5555979'),
('discord:722766829881131038', NULL),
('discord:722766829881131038', '5551669'),
('discord:722766829881131038', NULL),
('discord:722766829881131038', '5556936'),
('discord:722766829881131038', NULL),
('discord:722766829881131038', '5550469');

-- --------------------------------------------------------

--
-- Structure de la table `society_moneywash`
--

CREATE TABLE `society_moneywash` (
  `id` int(11) NOT NULL,
  `identifier` varchar(60) NOT NULL,
  `society` varchar(60) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `territories`
--

CREATE TABLE `territories` (
  `zone` varchar(50) NOT NULL,
  `control` varchar(50) NOT NULL,
  `influence` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `territories`
--

INSERT INTO `territories` (`zone`, `control`, `influence`) VALUES
('Bay City Avenue', 'reyes', 88),
('Boulevard Del Perro', 'vagos', 100),
('Catfish View', 'Madrazo', 100),
('Crusade Road', 'cjng', 100),
('Didion Drive', 'families', 100),
('Dry Dock Street', '20th', 100),
('Ginger Street', 'reyes', 100),
('Invention Court', 'marabunta', 100),
('Marina Drive', 'pcc', 100),
('Mirror Park Boulevard', 'ballas', 100),
('North Calafia Way', 'Madrazo', 100),
('Olympic Freeway', 'lost', 100),
('Route 68', 'pcc', 100),
('Smoke Tree Road', 'cjng', 100),
('Union Road', '20th', 100);

-- --------------------------------------------------------

--
-- Structure de la table `trucks`
--

CREATE TABLE `trucks` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `trucks`
--

INSERT INTO `trucks` (`name`, `model`, `price`, `category`) VALUES
('Burrito', 'burrito3', 40000, 'fourgonnette'),
('Camping Car Moderne', 'camper', 39500, 'voyage'),
('Burrito Spoiler', 'gburrito', 28200, 'fourgonnette'),
('Burrito Spoiler 2', 'gburrito2', 29350, 'fourgonnette'),
('Camping Car Modeste', 'journey', 22030, 'voyage'),
('Paradise', 'paradise', 27600, 'fourgonnette'),
('Rumpo', 'rumpo', 27600, 'fourgonnette'),
('Rumpo 2', 'rumpo2', 22030, 'fourgonnette'),
('Rumpo 3', 'rumpo3', 30000, 'fourgonnette'),
('Speedo', 'speedo', 23150, 'fourgonnette'),
('Speedo 2', 'speedo2', 39500, 'fourgonnette'),
('Speedo 3', 'speedo3', 23150, 'fourgonnette'),
('Surfer Nouveau', 'surfer', 22030, 'voyage'),
('Surfer Ancien', 'surfer2', 19830, 'voyage'),
('Youga', 'youga', 22030, 'fourgonnette'),
('Youga Retro', 'youga2', 27600, 'fourgonnette');

-- --------------------------------------------------------

--
-- Structure de la table `truck_categories`
--

CREATE TABLE `truck_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `truck_categories`
--

INSERT INTO `truck_categories` (`name`, `label`) VALUES
('fourgonnette', 'Fourgonettes'),
('voyage', 'Voyage');

-- --------------------------------------------------------

--
-- Structure de la table `trunk_inventory`
--

CREATE TABLE `trunk_inventory` (
  `id` int(11) NOT NULL,
  `plate` varchar(8) NOT NULL,
  `data` text NOT NULL,
  `owned` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `trunk_inventory`
--

INSERT INTO `trunk_inventory` (`id`, `plate`, `data`, `owned`) VALUES
(1, '46CKB456', '{}', 0),
(2, '28GYD616', '{\"coffre\":[]}', 0),
(3, '05VDS454', '{\"coffre\":[]}', 0);

-- --------------------------------------------------------

--
-- Structure de la table `tweets`
--

CREATE TABLE `tweets` (
  `handle` longtext NOT NULL,
  `message` varchar(500) NOT NULL,
  `time` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `twitter_accounts`
--

CREATE TABLE `twitter_accounts` (
  `id` int(11) NOT NULL,
  `username` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `password` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `avatar_url` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `identifier` varchar(50) COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `twitter_likes`
--

CREATE TABLE `twitter_likes` (
  `id` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `tweetId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `twitter_tweets`
--

CREATE TABLE `twitter_tweets` (
  `id` int(11) NOT NULL,
  `authorId` int(11) NOT NULL,
  `realUser` varchar(50) NOT NULL,
  `message` varchar(256) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `likes` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `twitter_tweets`
--

INSERT INTO `twitter_tweets` (`id`, `authorId`, `realUser`, `message`, `time`, `likes`) VALUES
(30, 1639, 'steam:11000011937156d', 'bojour', '2020-08-25 10:54:38', 0),
(31, 1639, 'steam:11000011937156d', 'Bonjour, l\'hopital de la ville est enfin ouvert , n\'hesitez pas  a venir nous voir pour tout soins ou tout renseignements', '2020-08-25 10:55:43', 0),
(33, 1641, 'steam:1100001425390d0', 'Hola ya til le patron du ls custom svp', '2020-08-25 13:35:30', 0),
(35, 1643, 'steam:11000013d27b782', 'Hôpital ouvert ?', '2020-08-25 20:51:40', 0),
(39, 1639, 'steam:11000011937156d', 'Pour tout soins, les EMS sont actuellement en ville, hesiotez pas a nous contacter', '2020-08-26 08:30:31', 2),
(40, 1639, 'steam:11000011937156d', 'Y-a-t-il un concessionnaire en ville?', '2020-08-26 11:57:36', 1),
(42, 1646, 'steam:11000010de9a87b', 'Ola ola c\'est amadeo le vrai marabunta, je tiens pas l\'alcool je vous nique vos mère', '2020-08-26 15:47:59', 0),
(46, 1646, 'steam:11000010de9a87b', '@SanCoss Nik ta mer', '2020-08-27 01:19:42', 0),
(47, 1639, 'steam:11000011937156d', 'Les EMS sont en ville hesitez pas a nous contacter', '2020-08-27 14:31:13', 0),
(48, 1648, 'steam:11000013ddb3871', 'il y a t\'il un cocessionaire en ville?', '2020-08-27 16:27:39', 0),
(49, 1639, 'steam:11000011937156d', 'Un EMS est en ville, hesitez pas a le contacter pour tout soins', '2020-08-28 15:46:43', 1),
(50, 1649, 'steam:11000011561bb76', 'le LS Custom est ouvert', '2020-08-28 19:27:31', 0),
(52, 1651, 'steam:11000011d5227a2', 'Բարեւ Ձեզ Los Santos ! :)', '2020-08-30 16:27:07', 0),
(53, 1639, 'steam:11000011937156d', 'EMS en ville pour ceux qui ont besoin!', '2020-08-30 16:32:15', 0),
(55, 1651, 'steam:11000011d5227a2', '@Rapido comment ça oui?', '2020-08-30 19:37:48', 0),
(56, 1653, 'steam:110000132474c7c', 'ya t-il un agent immo en ville ?', '2020-08-31 09:20:29', 0),
(62, 1652, 'steam:110000112ebfb95', '@Rapido dispo ?', '2020-08-31 13:59:49', 0),
(64, 1652, 'steam:110000112ebfb95', '@Rapido', '2020-08-31 14:12:14', 0),
(66, 1652, 'steam:110000112ebfb95', '@Rapido', '2020-08-31 14:13:12', 0),
(68, 1652, 'steam:110000112ebfb95', '@Agents X 5559752', '2020-08-31 14:13:45', 0),
(69, 1652, 'steam:110000112ebfb95', '@Agents X au pire j ai l impression que l un l autre on c est pas se joindre ni part appel ni part message je suis au concessionaire prenez votre temps venez quand vous etes dispo merci', '2020-08-31 14:16:39', 0),
(70, 1652, 'steam:110000112ebfb95', '@Rapido possible de se rejoindre concess impossible de vous joindre part gsm merci', '2020-08-31 15:02:09', 0),
(73, 1642, 'steam:110000117aa7c9d', 'Bonjour, EMS dispo !!!', '2020-09-02 16:17:34', 2),
(74, 1652, 'steam:110000112ebfb95', 'Cherche vendeur de concess Merci', '2020-09-02 17:24:55', 0),
(75, 1653, 'steam:110000132474c7c', 'un gang ou orga en ville ?', '2020-09-02 19:08:39', 0),
(77, 1639, 'steam:11000011937156d', 'Un EMS est en ville, hesitez pas a demander vos soins', '2020-09-04 16:13:44', 0),
(78, 1662, 'steam:110000138fc6304', 'Yo', '2020-09-05 14:52:02', 0),
(79, 1662, 'steam:110000138fc6304', '@Enzo Fellechia', '2020-09-05 14:52:13', 0),
(80, 1661, 'steam:1100001062e2682', 'Roulez prudement, un accident est si vite arrivé.', '2020-09-06 09:23:46', 0),
(81, 1665, 'steam:110000112ebfb95', 'recherche agents immo 555 9752', '2020-09-06 12:15:32', 0),
(82, 1662, 'steam:110000138fc6304', 'Coiffeur dispo svp ?', '2020-09-06 15:47:19', 0),
(83, 1667, 'steam:11000013dbeb1f6', 'YO, qui en ville', '2020-09-07 13:51:43', 0),
(84, 1639, 'steam:11000011937156d', 'besoin d\'un ems? je suis  la n\'ehsitez pas', '2020-09-08 11:58:43', 0),
(85, 1668, 'steam:1100001365a672b', 'mecano dispo ???', '2020-09-08 18:44:12', 0),
(86, 1664, 'steam:11000010681b002', 'Les Lost cherchent à discuter, rendez-vous Place des Cubes !!!', '2020-09-08 21:31:28', 4),
(87, 1668, 'steam:1100001365a672b', '@Zak Aarons  tes dispo ?', '2020-09-09 13:01:23', 0),
(88, 1664, 'steam:11000010681b002', 'Rendez-vous Place des Cubes si vous voulez passer du bon temps !', '2020-09-09 15:11:37', 5),
(89, 1670, 'steam:110000104af0fa8', '@Kid.', '2020-09-09 15:13:18', 1),
(91, 1664, 'steam:11000010681b002', 'Apéro à Stab City (club des Lost), venez nombreux !!!', '2020-09-09 15:40:03', 6),
(92, 1665, 'steam:110000112ebfb95', 'je recherche un agents immo 555-9752', '2020-09-10 12:12:26', 0),
(93, 1676, 'steam:110000106a80e40', 'Bonjour, recherche un agent immo 555 6902. Merci.', '2020-09-10 18:28:37', 0),
(94, 1665, 'steam:110000112ebfb95', 'recherche concess 555-9752', '2020-09-11 20:00:47', 0),
(95, 1674, 'steam:11000010be08db6', 'La concession Benefactor ouvre ses portes, venez vous offir le véhicule de vos reves', '2020-09-12 15:39:19', 0),
(96, 1674, 'steam:11000010be08db6', 'Concession Benefactor - Pour plus de détail vous pouvez contacter le 5551320 ou le 5551480. Cordialement', '2020-09-12 15:41:34', 1),
(97, 1679, 'steam:1100001116a084e', 'Concession Benefactor - vous souhaitez vous offrir la voiture de vos rêves! venez visiter notre catalogue nous vous attendons! 5551320 ou 5551480 Cordialement', '2020-09-12 19:10:42', 1),
(98, 1680, 'steam:11000013eb448dd', '@Tom Peterson t ou man', '2020-09-13 11:36:25', 0),
(99, 1674, 'steam:11000010be08db6', '@Travis Danson', '2020-09-13 11:47:36', 0),
(100, 1679, 'steam:1100001116a084e', 'Je suis à la concession Mr Danson Trevis, Tom', '2020-09-13 11:54:17', 0),
(101, 1674, 'steam:11000010be08db6', 'La concession Benefactor ouvre ses portes. Pour plus de détails vous pouvez contacter le 5551320 ainsi que le 5551480. Cordialement', '2020-09-13 11:59:35', 0),
(102, 1681, 'steam:1100001075e689a', 'Agent immobilier disponible ? merci de ocntacter le 5551480', '2020-09-13 13:25:53', 0),
(103, 1681, 'steam:1100001075e689a', 'La concession est ouverte, venez faire vos achats', '2020-09-13 15:41:04', 0),
(104, 1679, 'steam:1100001116a084e', 'A vendre coupés Zion Bleu, moteur transmission frein améliorer avec vitre teintées, 25000 $, disponible de suite au Vapid Occasion', '2020-09-14 18:10:16', 0),
(108, 1674, 'steam:11000010be08db6', 'Benefactor - La concession ouvre ses portes', '2020-09-16 19:01:13', 1),
(109, 1639, 'steam:11000011937156d', '@Tom Peterson pouvez vous m\'en dire plus sur les performances du vehicule? (acceleration, vitesse max, consommation,...) merci', '2020-09-17 08:31:02', 0),
(110, 1639, 'steam:11000011937156d', 'Un avocat est en ville, envoyez moi un message au 5558656 et je vous répindrez dans les plus bref délais. merci', '2020-09-17 08:31:41', 0),
(111, 1665, 'steam:110000112ebfb95', 'Mecano en ville ??', '2020-09-17 20:46:56', 0),
(112, 1687, 'steam:11000011939a561', 'Bonjour tout le monde je propose mes service de uber à 30$ du km n\'hésitez pas a me contacter au 5553991', '2020-09-19 10:33:50', 1),
(113, 1688, 'steam:11000011939a561', 'Agent immo en ville ?', '2020-09-19 10:40:24', 0),
(114, 1688, 'steam:11000011939a561', '@UBER Wave', '2020-09-19 14:07:04', 0),
(115, 1674, 'steam:11000010be08db6', '@Billy Castannier', '2020-09-20 12:00:09', 0),
(116, 1688, 'steam:11000011939a561', '@Richard LEMAITRE Oui ?', '2020-09-20 12:00:22', 0),
(117, 1674, 'steam:11000010be08db6', '@Billy Castannier fausse manipulation je m\'excuse', '2020-09-20 12:00:50', 0),
(118, 1688, 'steam:11000011939a561', 'Un mécano de dispo ?', '2020-09-20 14:26:06', 0),
(119, 1674, 'steam:11000010be08db6', 'Benefactor - Votre concession automobile est ouverte pour vous conseiller au mieux en terme de véhicule neuf. Contactez nous au 5551320/5551480', '2020-09-20 15:16:30', 0),
(120, 1687, 'steam:11000011939a561', 'Bonsoir, Uber Wave est disponible livraison de nouritures et de boissons ainsi que service de Taxi prix en sms au 5553991 !', '2020-09-20 17:44:31', 1),
(121, 1660, 'steam:11000010e4aa775', 'LS Customs ouvert?', '2020-09-20 19:03:47', 0),
(122, 1674, 'steam:11000010be08db6', 'Bonjour, un garagiste de disponible ? Me contacter au 5551320', '2020-09-21 13:37:00', 0),
(123, 1688, 'steam:11000011939a561', 'Mécano de dispo ? Contactez moi au 5553991', '2020-09-21 16:39:17', 0),
(124, 1671, 'steam:11000010ce613ce', 'EMS de dispos ?', '2020-09-22 19:53:09', 0),
(125, 1679, 'steam:1100001116a084e', 'Vous souhaitez acheter un premier véhicule votre concessionnaire Bénéfactor vous propose la asea au prix de 4600, plusieurs couleur possible. renseignements 5555573 Tom Peterson', '2020-09-22 20:30:17', 0),
(126, 1688, 'steam:11000011939a561', 'UBER WAVE livraison de nouriture et course de TAXI disponible contactez moi au 5553991 !', '2020-09-23 16:37:10', 1),
(127, 1674, 'steam:11000010be08db6', 'Benefactor - La concession est ouverte toute la soirée. Contactez le 5551320 ou le 5551480. Cordialement', '2020-09-23 19:32:03', 0),
(128, 1693, 'steam:11000014118789d', 'fuck le families', '2020-09-24 19:28:24', 1),
(129, 1674, 'steam:11000010be08db6', 'Benefactor - La concession est ouverte avec de nombreuses promotions', '2020-09-24 20:20:21', 0),
(130, 1674, 'steam:11000010be08db6', 'Recherche un garagiste pour faire une peinture de voiture. Me contacter au 5551320', '2020-09-25 16:41:42', 0),
(131, 1688, 'steam:11000011939a561', 'Bonjour, les TAXIS sont disponible mais nous avons quelque problème de beeper n\'hésitez pa à nous appeler au 5553991', '2020-09-26 13:17:38', 1),
(132, 1684, 'steam:11000010747853f', 'besoin d un taxi contacté le numero par sms le 5558777', '2020-09-26 16:50:00', 0),
(133, 1696, 'steam:11000010b5f9dc2', 'UPDATE:Concert Daft Punk la billeterie ferme a 22:50', '2020-09-26 20:34:12', 0),
(134, 1696, 'steam:11000010b5f9dc2', 'MERCI C\'ETAIT INCROYABLE !!!', '2020-09-26 21:17:15', 0),
(135, 1694, 'steam:11000010b5f9dc2', 'Taxi dispo actuellement', '2020-09-26 22:42:44', 0),
(136, 1688, 'steam:11000011939a561', 'Taxi dispo n\'hésitez pas à appeller :)', '2020-09-27 12:25:57', 0),
(137, 1694, 'steam:11000010b5f9dc2', 'Taxi dispo', '2020-09-27 13:18:52', 0),
(138, 1674, 'steam:11000010be08db6', 'Benefactor - Session de recrutement en cours. Pour plus d\'informations veuillez consulter l\'intranet de la ville', '2020-09-27 16:02:24', 0),
(139, 1697, 'steam:1100001434e64e1', 'jaurais besoin dun mecano devant le ls custom', '2020-09-27 21:12:53', 0),
(140, 1697, 'steam:1100001434e64e1', 'ya till un mecano en ville', '2020-09-27 21:24:41', 0),
(141, 1698, 'steam:1100001416b16df', 'un metier recrute maintenant?', '2020-09-28 16:35:18', 0),
(142, 1674, 'steam:11000010be08db6', '@Arthur Lazo Bonjour, l\'entreprise benefactor recrute. Une annonce est en ligne sur l\'intranet de la ville.', '2020-09-28 16:36:46', 0),
(143, 1698, 'steam:1100001416b16df', '@Richard LEMAITRE On peut se voir? je uis interresser', '2020-09-28 16:37:24', 1),
(144, 1674, 'steam:11000010be08db6', '@Arthur Lazo Je vous laisse lire l\'annonce. Suite a cela nous vous re contacterons', '2020-09-28 16:38:44', 0),
(145, 1671, 'steam:11000010ce613ce', 'Je recherche un agent immobiliers d\'urgence merci', '2020-09-28 20:50:25', 0),
(146, 1684, 'steam:11000010747853f', 'cherche agent immobilié merci', '2020-09-28 21:36:53', 0),
(147, 1699, 'steam:11000010ce613ce', 'Hé les Vagos ya moyen de se capter', '2020-09-29 22:20:30', 0),
(148, 1688, 'steam:11000011939a561', 'Je cherches un mécano contacter moi au 5553991', '2020-10-01 19:30:00', 0),
(149, 1696, 'steam:11000010b5f9dc2', 'Concert Daft Punk au Unicorn vers 23h', '2020-10-02 20:35:29', 0),
(150, 1702, 'steam:11000011aeca15a', 'C\'est la Street', '2020-10-03 17:35:11', 0),
(151, 1674, 'steam:11000010be08db6', 'Benefactor - La concession ouvre ses portes', '2020-10-03 18:50:47', 0),
(152, 1688, 'steam:11000011939a561', 'L\'entreprise TAXI cherches de nouveaux chauffeurs ! Contactez moi au 5553991 pour plus d\'info.', '2020-10-05 17:49:14', 0),
(153, 1706, 'steam:1100001133ab39e', 'Holà', '2020-10-08 10:48:22', 0);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `money` int(11) NOT NULL,
  `license` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `skin` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `job` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'unemployed',
  `job_grade` int(11) DEFAULT 0,
  `org` varchar(50) DEFAULT 'organisation',
  `org_gradeorg` int(11) DEFAULT 0,
  `faction` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'resid',
  `faction_grade` int(11) DEFAULT 0,
  `loadout` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `inventory` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `position` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `bank` int(11) DEFAULT NULL,
  `permission_level` int(11) DEFAULT NULL,
  `group` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `health` varchar(50) DEFAULT '200',
  `is_dead` tinyint(1) DEFAULT 0,
  `tattoos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `firstname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `lastname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `dateofbirth` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `sex` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `height` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '',
  `last_property` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `pet` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `skellydata` longtext NOT NULL,
  `model` longtext DEFAULT NULL,
  `drawables` longtext DEFAULT NULL,
  `props` longtext DEFAULT NULL,
  `drawtextures` longtext DEFAULT NULL,
  `proptextures` longtext DEFAULT NULL,
  `rp_xp` int(11) NOT NULL DEFAULT 0,
  `rp_rank` int(11) NOT NULL DEFAULT 1,
  `demarche` varchar(50) DEFAULT NULL,
  `humeur` varchar(50) DEFAULT NULL,
  `food` int(11) DEFAULT 100,
  `thirst` int(11) DEFAULT 100,
  `phone_number` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`identifier`, `money`, `license`, `name`, `skin`, `job`, `job_grade`, `org`, `org_gradeorg`, `faction`, `faction_grade`, `loadout`, `inventory`, `position`, `bank`, `permission_level`, `group`, `status`, `health`, `is_dead`, `tattoos`, `firstname`, `lastname`, `dateofbirth`, `sex`, `height`, `last_property`, `pet`, `skellydata`, `model`, `drawables`, `props`, `drawtextures`, `proptextures`, `rp_xp`, `rp_rank`, `demarche`, `humeur`, `food`, `thirst`, `phone_number`) VALUES
('discord:722766829881131038', 9830480, 'license:f8a242105b5f668f68232e1d0a919b7287da8d36', 'TLRR trop ma pute', '{\"lipstick_3\":0,\"makeup_1\":0,\"beard_3\":0,\"sun_2\":0,\"Abaissementdumenton\":0,\"shoes_1\":45,\"eyebrows_2\":0,\"blush_2\":0,\"arms\":15,\"facepeds2\":0,\"ears_2\":0,\"eyebrows_1\":0,\"tshirt_1\":15,\"mask_2\":0,\"Torsiondunez\":20,\"watches_1\":-1,\"skin\":0,\"ears_1\":-1,\"Largeurdesjoues\":0,\"lipstick_1\":0,\"Hauteursourcils\":0,\"eye_color\":0,\"Longueurdelosdumenton\":0,\"chest_1\":0,\"Largeurdelamachoire\":0,\"Ouverturedesyeux\":0,\"age_2\":0,\"makeup_3\":0,\"beard_4\":0,\"Largeurdespommettes\":0,\"age_1\":0,\"Hauteurnez\":20,\"lipstick_4\":0,\"Longueurnez\":20,\"bproof_1\":0,\"complexion_1\":0,\"hair_2\":0,\"bracelets_2\":0,\"moles_2\":0,\"sex\":513,\"face\":0,\"complexion_2\":0,\"beard_2\":0,\"bodyb_1\":0,\"chest_3\":0,\"watches_2\":0,\"blush_3\":0,\"Largeurnez\":20,\"bodyb_2\":0,\"Troudumenton\":0,\"eyebrows_4\":0,\"bags_2\":0,\"torso_1\":15,\"bproof_2\":0,\"eyebrows_3\":0,\"decals_2\":0,\"glasses_2\":0,\"chain_1\":0,\"Epaisseurdeslevres\":0,\"beard_1\":0,\"Largeurdumenton\":0,\"chest_2\":0,\"moles_1\":0,\"Longueurdudosdelamachoire\":0,\"blemishes_1\":0,\"lipstick_2\":0,\"shoes_2\":0,\"glasses_1\":0,\"Profondeursourcils\":0,\"Abaissementpicdunez\":20,\"Epaisseurducou\":0,\"Abaissementdunez\":20,\"bags_1\":0,\"blemishes_2\":0,\"tshirt_2\":0,\"mask_1\":0,\"makeup_4\":0,\"arms_2\":0,\"helmet_2\":0,\"blush_1\":0,\"Hauteurdespommettes\":0,\"hair_1\":0,\"facepeds\":0,\"sun_1\":0,\"makeup_2\":0,\"hair_color_1\":0,\"chain_2\":0,\"bracelets_1\":-1,\"hair_color_2\":0,\"decals_1\":0,\"torso_2\":0,\"helmet_1\":-1,\"pants_2\":0,\"pants_1\":14}', 'police', 6, 'organisation', 0, 'resid', 0, '[{\"ammo\":0,\"name\":\"WEAPON_PISTOL\",\"tint\":0,\"label\":\"Berreta 92\",\"components\":[\"clip_default\"]}]', NULL, '{\"y\":-996.0,\"z\":13.0,\"x\":-1640.3}', 20000, 0, 'superadmin', '[{\"percent\":95.6125,\"name\":\"hunger\",\"val\":956125},{\"percent\":95.6125,\"name\":\"thirst\",\"val\":956125}]', '175', 0, NULL, '', '', '', '', '', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, 0, 1, NULL, NULL, 100, 100, '5550469');

-- --------------------------------------------------------

--
-- Structure de la table `user_accessories`
--

CREATE TABLE `user_accessories` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `mask` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(50) COLLATE utf8mb4_bin DEFAULT 'Masque',
  `type` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `index` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `user_accounts`
--

CREATE TABLE `user_accounts` (
  `id` int(11) NOT NULL,
  `identifier` varchar(22) NOT NULL,
  `name` varchar(50) NOT NULL,
  `money` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `user_accounts`
--

INSERT INTO `user_accounts` (`id`, `identifier`, `name`, `money`) VALUES
(1, 'discord:65992199019023', 'black_money', 0),
(2, 'discord:65992199019023', 'black_money', 0),
(3, 'discord:72276682988113', 'black_money', 0),
(4, 'discord:72276682988113', 'black_money', 0),
(5, 'discord:72276682988113', 'black_money', 0),
(6, 'discord:72276682988113', 'black_money', 0),
(7, 'discord:72276682988113', 'black_money', 0),
(8, 'discord:72276682988113', 'black_money', 0),
(9, 'discord:72276682988113', 'black_money', 0),
(10, 'discord:72276682988113', 'black_money', 0),
(11, 'discord:72276682988113', 'black_money', 0),
(12, 'discord:72276682988113', 'black_money', 0),
(13, 'discord:72276682988113', 'black_money', 0),
(14, 'discord:72276682988113', 'black_money', 0),
(15, 'discord:72276682988113', 'black_money', 0),
(16, 'discord:72276682988113', 'black_money', 0),
(17, 'discord:72276682988113', 'black_money', 0),
(18, 'discord:72276682988113', 'black_money', 0),
(19, 'discord:72276682988113', 'black_money', 0),
(20, 'discord:72276682988113', 'black_money', 0),
(21, 'discord:72276682988113', 'black_money', 0),
(22, 'discord:72276682988113', 'black_money', 0),
(23, 'discord:72276682988113', 'black_money', 0),
(24, 'discord:72276682988113', 'black_money', 0),
(25, 'discord:72276682988113', 'black_money', 0),
(26, 'discord:72276682988113', 'black_money', 0),
(27, 'discord:72276682988113', 'black_money', 0),
(28, 'discord:72276682988113', 'black_money', 0),
(29, 'discord:72276682988113', 'black_money', 0),
(30, 'discord:72276682988113', 'black_money', 0),
(31, 'discord:72276682988113', 'black_money', 0),
(32, 'discord:72276682988113', 'black_money', 0),
(33, 'discord:72276682988113', 'black_money', 0),
(34, 'discord:72276682988113', 'black_money', 0),
(35, 'discord:72276682988113', 'black_money', 0),
(36, 'discord:72276682988113', 'black_money', 0),
(37, 'discord:72276682988113', 'black_money', 0),
(38, 'discord:72276682988113', 'black_money', 0),
(39, 'discord:72276682988113', 'black_money', 0),
(40, 'discord:72276682988113', 'black_money', 0),
(41, 'discord:72276682988113', 'black_money', 0),
(42, 'discord:72276682988113', 'black_money', 0),
(43, 'discord:72276682988113', 'black_money', 0),
(44, 'discord:72276682988113', 'black_money', 0),
(45, 'discord:72276682988113', 'black_money', 0),
(46, 'discord:72276682988113', 'black_money', 0),
(47, 'discord:72276682988113', 'black_money', 0),
(48, 'discord:72276682988113', 'black_money', 0),
(49, 'discord:72276682988113', 'black_money', 0),
(50, 'discord:72276682988113', 'black_money', 0),
(51, 'discord:72276682988113', 'black_money', 0),
(52, 'discord:72276682988113', 'black_money', 0),
(53, 'discord:72276682988113', 'black_money', 0),
(54, 'discord:72276682988113', 'black_money', 0),
(55, 'discord:72276682988113', 'black_money', 0),
(56, 'discord:72276682988113', 'black_money', 0),
(57, 'discord:72276682988113', 'black_money', 0),
(58, 'discord:72276682988113', 'black_money', 0),
(59, 'discord:72276682988113', 'black_money', 0),
(60, 'discord:72276682988113', 'black_money', 0),
(61, 'discord:72276682988113', 'black_money', 0),
(62, 'discord:72276682988113', 'black_money', 0),
(63, 'discord:72276682988113', 'black_money', 0),
(64, 'discord:72276682988113', 'black_money', 0),
(65, 'discord:72276682988113', 'black_money', 0),
(66, 'discord:72276682988113', 'black_money', 0),
(67, 'discord:72276682988113', 'black_money', 0),
(68, 'discord:72276682988113', 'black_money', 0),
(69, 'discord:72276682988113', 'black_money', 0),
(70, 'discord:72276682988113', 'black_money', 0),
(71, 'discord:72276682988113', 'black_money', 0),
(72, 'discord:72276682988113', 'black_money', 0),
(73, 'discord:72276682988113', 'black_money', 0),
(74, 'discord:72276682988113', 'black_money', 0),
(75, 'discord:72276682988113', 'black_money', 0),
(76, 'discord:72276682988113', 'black_money', 0),
(77, 'discord:72276682988113', 'black_money', 0),
(78, 'discord:72276682988113', 'black_money', 0),
(79, 'discord:72276682988113', 'black_money', 0),
(80, 'discord:72276682988113', 'black_money', 0),
(81, 'discord:72276682988113', 'black_money', 0),
(82, 'discord:72276682988113', 'black_money', 0),
(83, 'discord:72276682988113', 'black_money', 0),
(84, 'discord:72276682988113', 'black_money', 0),
(85, 'discord:72276682988113', 'black_money', 0),
(86, 'discord:72276682988113', 'black_money', 0),
(87, 'discord:72276682988113', 'black_money', 0),
(88, 'discord:72276682988113', 'black_money', 0),
(89, 'discord:72276682988113', 'black_money', 0),
(90, 'discord:72276682988113', 'black_money', 0),
(91, 'discord:72276682988113', 'black_money', 0),
(92, 'discord:72276682988113', 'black_money', 0),
(93, 'discord:72276682988113', 'black_money', 0),
(94, 'discord:72276682988113', 'black_money', 0),
(95, 'discord:72276682988113', 'black_money', 0),
(96, 'discord:72276682988113', 'black_money', 0),
(97, 'discord:72276682988113', 'black_money', 0),
(98, 'discord:72276682988113', 'black_money', 0),
(99, 'discord:72276682988113', 'black_money', 0),
(100, 'discord:72276682988113', 'black_money', 0),
(101, 'discord:72276682988113', 'black_money', 0),
(102, 'discord:72276682988113', 'black_money', 0),
(103, 'discord:72276682988113', 'black_money', 0),
(104, 'discord:72276682988113', 'black_money', 0),
(105, 'discord:72276682988113', 'black_money', 0),
(106, 'discord:72276682988113', 'black_money', 0),
(107, 'discord:72276682988113', 'black_money', 0),
(108, 'discord:72276682988113', 'black_money', 0),
(109, 'discord:72276682988113', 'black_money', 0),
(110, 'discord:72276682988113', 'black_money', 0),
(111, 'discord:72276682988113', 'black_money', 0),
(112, 'discord:72276682988113', 'black_money', 0),
(113, 'discord:72276682988113', 'black_money', 0),
(114, 'discord:72276682988113', 'black_money', 0),
(115, 'discord:72276682988113', 'black_money', 0),
(116, 'discord:72276682988113', 'black_money', 0),
(117, 'discord:72276682988113', 'black_money', 0),
(118, 'discord:72276682988113', 'black_money', 0),
(119, 'discord:72276682988113', 'black_money', 0),
(120, 'discord:72276682988113', 'black_money', 0),
(121, 'discord:72276682988113', 'black_money', 0),
(122, 'discord:72276682988113', 'black_money', 0),
(123, 'discord:72276682988113', 'black_money', 0),
(124, 'discord:72276682988113', 'black_money', 0),
(125, 'discord:72276682988113', 'black_money', 0),
(126, 'discord:72276682988113', 'black_money', 0),
(127, 'discord:72276682988113', 'black_money', 0),
(128, 'discord:72276682988113', 'black_money', 0),
(129, 'discord:72276682988113', 'black_money', 0),
(130, 'discord:72276682988113', 'black_money', 0),
(131, 'discord:72276682988113', 'black_money', 0),
(132, 'discord:72276682988113', 'black_money', 0);

-- --------------------------------------------------------

--
-- Structure de la table `user_contacts`
--

CREATE TABLE `user_contacts` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `user_documents`
--

CREATE TABLE `user_documents` (
  `id` int(11) NOT NULL,
  `owner` varchar(45) NOT NULL,
  `data` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `user_hangard`
--

CREATE TABLE `user_hangard` (
  `id` int(11) NOT NULL,
  `identifier` varchar(60) COLLATE utf8mb4_bin DEFAULT NULL,
  `vehicle` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `plate` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `user_inventory`
--

CREATE TABLE `user_inventory` (
  `id` int(11) NOT NULL,
  `identifier` varchar(60) NOT NULL,
  `item` varchar(50) NOT NULL,
  `count` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `user_inventory`
--

INSERT INTO `user_inventory` (`id`, `identifier`, `item`, `count`) VALUES
(0, 'discord:722766829881131038', 'disc_ammo_rifle_large', 0),
(0, 'discord:722766829881131038', 'ba_prop_int_trad_table', 0),
(0, 'discord:722766829881131038', 'apa_mp_h_stn_chairarm_26', 0),
(0, 'discord:722766829881131038', 'weapon_pumpshotgun', 0),
(0, 'discord:722766829881131038', 'apa_mp_h_stn_chairarm_01', 0),
(0, 'discord:722766829881131038', 'rolex', 0),
(0, 'discord:722766829881131038', 'prop_toolchest_01', 0),
(0, 'discord:722766829881131038', 'contract', 0),
(0, 'discord:722766829881131038', 'prop_chair_05', 0),
(0, 'discord:722766829881131038', 'bong', 0),
(0, 'discord:722766829881131038', 'gpblo', 0),
(0, 'discord:722766829881131038', 'whitefish', 0),
(0, 'discord:722766829881131038', 'pierre', 0),
(0, 'discord:722766829881131038', 'paquetnuggets', 0),
(0, 'discord:722766829881131038', 'pompom', 0),
(0, 'discord:722766829881131038', 'v_med_cor_emblmtable', 0),
(0, 'discord:722766829881131038', 'v_res_msonbed', 0),
(0, 'discord:722766829881131038', 'paquetplanche', 0),
(0, 'discord:722766829881131038', 'apa_mp_h_din_chair_09', 0),
(0, 'discord:722766829881131038', 'disc_ammo_snp_large', 0),
(0, 'discord:722766829881131038', 'apple_p', 0),
(0, 'discord:722766829881131038', 'cdvierge', 0),
(0, 'discord:722766829881131038', 'prop_dress_disp_03', 0),
(0, 'discord:722766829881131038', 'prop_table_04', 0),
(0, 'discord:722766829881131038', 'apa_mp_h_stn_chairarm_24', 0),
(0, 'discord:722766829881131038', 'bankidcard', 0),
(0, 'discord:722766829881131038', 'xm_prop_lab_desk_01', 0),
(0, 'discord:722766829881131038', 'v_serv_abox_04', 0),
(0, 'discord:722766829881131038', 'apa_mp_h_stn_chairarm_02', 0),
(0, 'discord:722766829881131038', 'prop_yacht_table_01', 0),
(0, 'discord:722766829881131038', 'cokeburn', 0),
(0, 'discord:722766829881131038', 'mask_swim', 0),
(0, 'discord:722766829881131038', 'apa_mp_h_bed_double_08', 0),
(0, 'discord:722766829881131038', 'micro', 0),
(0, 'discord:722766829881131038', 'prop_rub_table_02', 0),
(0, 'discord:722766829881131038', 'prop_chateau_table_01', 0),
(0, 'discord:722766829881131038', 'mackerel', 0),
(0, 'discord:722766829881131038', 'opium_pooch', 0),
(0, 'discord:722766829881131038', 'antifreeze', 0),
(0, 'discord:722766829881131038', 'imp_prop_impexp_sofabed_01a', 0),
(0, 'discord:722766829881131038', 'apa_mp_h_bed_wide_05', 0),
(0, 'discord:722766829881131038', 'prop_ld_int_safe_01', 0),
(0, 'discord:722766829881131038', 'prop_t_sofa', 0),
(0, 'discord:722766829881131038', 'prop_ld_farm_chair01', 0),
(0, 'discord:722766829881131038', 'ba_prop_battle_club_chair_01', 0),
(0, 'discord:722766829881131038', 'v_res_mconsoletrad', 0),
(0, 'discord:722766829881131038', 'prop_rub_couch04', 0),
(0, 'discord:722766829881131038', 'prop_dress_disp_02', 0),
(0, 'discord:722766829881131038', 'weapon_knuckle', 0),
(0, 'discord:722766829881131038', 'goldwatch', 0),
(0, 'discord:722766829881131038', 'prop_ven_market_table1', 0),
(0, 'discord:722766829881131038', 'preparationmeth', 0),
(0, 'discord:722766829881131038', 'prop_stockade_wheel_flat', 0),
(0, 'discord:722766829881131038', 'terre', 0),
(0, 'discord:722766829881131038', 'acidesulfurique', 0),
(0, 'discord:722766829881131038', 'weapon_battleaxe', 0),
(0, 'discord:722766829881131038', 'james_fishingbait', 0),
(0, 'discord:722766829881131038', 'cigarette', 0),
(0, 'discord:722766829881131038', 'hei_prop_yah_lounger', 0),
(0, 'discord:722766829881131038', 'permis', 1),
(0, 'discord:722766829881131038', 'milkshake', 0),
(0, 'discord:722766829881131038', 'bullet3', 0),
(0, 'discord:722766829881131038', 'goldbull', 0),
(0, 'discord:722766829881131038', 'neckbrace', 0),
(0, 'discord:722766829881131038', 'apa_mp_h_yacht_armchair_03', 0),
(0, 'discord:722766829881131038', 'cokebrut', 0),
(0, 'discord:722766829881131038', 'fixtool', 0),
(0, 'discord:722766829881131038', 'gpbm', 0),
(0, 'discord:722766829881131038', 'cigar', 0),
(0, 'discord:722766829881131038', 'purifiedwater', 0),
(0, 'discord:722766829881131038', 'armbrace', 0),
(0, 'discord:722766829881131038', 'meth_pooch', 0),
(0, 'discord:722766829881131038', 'silvermedal', 0),
(0, 'discord:722766829881131038', 'brique', 0),
(0, 'discord:722766829881131038', 'weapon_stungun', 0),
(0, 'discord:722766829881131038', 'milho', 0),
(0, 'discord:722766829881131038', 'sorted_money', 0),
(0, 'discord:722766829881131038', 'jusfruit', 0),
(0, 'discord:722766829881131038', 'prop_cs_trolley_01', 0),
(0, 'discord:722766829881131038', 'fricadelle', 0),
(0, 'discord:722766829881131038', 'weapon_fireextinguisher', 0),
(0, 'discord:722766829881131038', 'joint2g', 0),
(0, 'discord:722766829881131038', 'sniffer', 0),
(0, 'discord:722766829881131038', 'madera', 0),
(0, 'discord:722766829881131038', 'drugbags', 0),
(0, 'discord:722766829881131038', 'hazmat1', 0),
(0, 'discord:722766829881131038', 'maderam', 0),
(0, 'discord:722766829881131038', 'feuilles', 0),
(0, 'discord:722766829881131038', 'apa_mp_h_yacht_bed_01', 0),
(0, 'discord:722766829881131038', 'weapon_marksmanrifle', 0),
(0, 'discord:722766829881131038', 'hei_prop_yah_table_01', 0),
(0, 'discord:722766829881131038', 'prop_engine_hoist', 0),
(0, 'discord:722766829881131038', 'weapon_dbshotgun', 0),
(0, 'discord:722766829881131038', 'prop_ld_greenscreen_01', 0),
(0, 'discord:722766829881131038', 'camera', 0),
(0, 'discord:722766829881131038', 'skin1', 0),
(0, 'discord:722766829881131038', 'pot', 0),
(0, 'discord:722766829881131038', 'weapon_briefcase', 1),
(0, 'discord:722766829881131038', 'chocolat', 6),
(0, 'discord:722766829881131038', 'feijao', 0),
(0, 'discord:722766829881131038', 'up7', 0),
(0, 'discord:722766829881131038', 'tequila', 0),
(0, 'discord:722766829881131038', 'prop_table_06', 0),
(0, 'discord:722766829881131038', 'casserole', 0),
(0, 'discord:722766829881131038', 'hackerDevice', 0),
(0, 'discord:722766829881131038', 'meth100g', 0),
(0, 'discord:722766829881131038', 'prop_bench_06', 0),
(0, 'discord:722766829881131038', 'v_med_emptybed', 0),
(0, 'discord:722766829881131038', 'p_v_med_p_sofa_s', 0),
(0, 'discord:722766829881131038', 'v_tre_sofa_mess_c_s', 0),
(0, 'discord:722766829881131038', 'whisky', 0),
(0, 'discord:722766829881131038', 'feuilletabac', 0),
(0, 'discord:722766829881131038', 'banane', 0),
(0, 'discord:722766829881131038', 'prop_bin_10a', 0),
(0, 'discord:722766829881131038', 'dopebag', 0),
(0, 'discord:722766829881131038', 'hei_prop_yah_seat_02', 0),
(0, 'discord:722766829881131038', 'goodbread', 0),
(0, 'discord:722766829881131038', 'pneu', 1),
(0, 'discord:722766829881131038', 'prop_wheel_tyre', 0),
(0, 'discord:722766829881131038', 'drill', 0),
(0, 'discord:722766829881131038', 'rolpaper', 0),
(0, 'discord:722766829881131038', 'prop_dress_disp_04', 0),
(0, 'discord:722766829881131038', 'v_res_tre_bed2', 0),
(0, 'discord:722766829881131038', 'sapphire', 0),
(0, 'discord:722766829881131038', 'coyote', 0),
(0, 'discord:722766829881131038', 'feuilledecoca', 0),
(0, 'discord:722766829881131038', 'gr_prop_gr_tool_draw_01a', 0),
(0, 'discord:722766829881131038', 'prop_yacht_table_02', 0),
(0, 'discord:722766829881131038', 'fishburger', 0),
(0, 'discord:722766829881131038', 'prop_ld_farm_couch02', 0),
(0, 'discord:722766829881131038', 'weapon_briefcase_02', 0),
(0, 'discord:722766829881131038', 'skin6', 0),
(0, 'discord:722766829881131038', 'kitcarro', 2),
(0, 'discord:722766829881131038', 'poubelle', 0),
(0, 'discord:722766829881131038', 'glacon', 0),
(0, 'discord:722766829881131038', 'prop_table_01', 0),
(0, 'discord:722766829881131038', 'notepad', 0),
(0, 'discord:722766829881131038', 'p_pharm_unit_02', 0),
(0, 'discord:722766829881131038', 'donut', 0),
(0, 'discord:722766829881131038', 'drugscales', 0),
(0, 'discord:722766829881131038', 'idcard', 0),
(0, 'discord:722766829881131038', 'orangina', 0),
(0, 'discord:722766829881131038', 'karting2', 0),
(0, 'discord:722766829881131038', 'bag', 0),
(0, 'discord:722766829881131038', 'methbrick', 0),
(0, 'discord:722766829881131038', 'bait', 0),
(0, 'discord:722766829881131038', 'p_mbbed_s', 0),
(0, 'discord:722766829881131038', 'moukate_pooch', 0),
(0, 'discord:722766829881131038', 'bka_prop_biker_chairstrip_02', 0),
(0, 'discord:722766829881131038', 'triplebiere', 0),
(0, 'discord:722766829881131038', 'prop_proxy_chateau_table', 0),
(0, 'discord:722766829881131038', 'rose', 0),
(0, 'discord:722766829881131038', 'apa_mp_h_yacht_strip_chair_01', 0),
(0, 'discord:722766829881131038', 'weapon_minigun', 0),
(0, 'discord:722766829881131038', 'copper', 0),
(0, 'discord:722766829881131038', 'goldNecklace', 0),
(0, 'discord:722766829881131038', 'skydiving', 0),
(0, 'discord:722766829881131038', 'weed_untrimmed', 0),
(0, 'discord:722766829881131038', 'gadget_nightvision', 0),
(0, 'discord:722766829881131038', 'prop_bin_03a', 0),
(0, 'discord:722766829881131038', 'fish', 0),
(0, 'discord:722766829881131038', 'prop_chair_09', 0),
(0, 'discord:722766829881131038', 'weapon_smg', 0),
(0, 'discord:722766829881131038', 'samsungS10', 0),
(0, 'discord:722766829881131038', 'pacificidcard', 0),
(0, 'discord:722766829881131038', 'acid', 0),
(0, 'discord:722766829881131038', 'bka_prop_biker_chairstrip_01', 0),
(0, 'discord:722766829881131038', 'tracker', 0),
(0, 'discord:722766829881131038', 'LittlePricks', 0),
(0, 'discord:722766829881131038', 'weapon_gusenberg', 0),
(0, 'discord:722766829881131038', 'p_ld_stinger_s', 0),
(0, 'discord:722766829881131038', 'bka_prop_biker_boardchair01', 0),
(0, 'discord:722766829881131038', 'sportlunch', 0),
(0, 'discord:722766829881131038', 'weapon_snspistol', 0),
(0, 'discord:722766829881131038', 'bulletproofsheriff', 0),
(0, 'discord:722766829881131038', 'magnum', 0),
(0, 'discord:722766829881131038', 'wood', 0),
(0, 'discord:722766829881131038', 'p_pharm_unit_01', 0),
(0, 'discord:722766829881131038', 'bmx', 0),
(0, 'discord:722766829881131038', 'traceur', 0),
(0, 'discord:722766829881131038', 'opium', 0),
(0, 'discord:722766829881131038', 'xm_prop_x17_desk_cover_01a', 0),
(0, 'discord:722766829881131038', 'coke10g', 0),
(0, 'discord:722766829881131038', 'jumelles', 1),
(0, 'discord:722766829881131038', 'apa_mp_h_stn_chairstrip_04', 0),
(0, 'discord:722766829881131038', 'cuff_keys', 0),
(0, 'discord:722766829881131038', 'bois', 0),
(0, 'discord:722766829881131038', 'brolly', 0),
(0, 'discord:722766829881131038', 'badgelspd', 0),
(0, 'discord:722766829881131038', 'permisarmes', 0),
(0, 'discord:722766829881131038', 'recipe_bagofdope', 0),
(0, 'discord:722766829881131038', 'v_ret_fh_dinetable', 0),
(0, 'discord:722766829881131038', 'prop_table_08', 0),
(0, 'discord:722766829881131038', 'odznaka', 0),
(0, 'discord:722766829881131038', 'hamburger', 0),
(0, 'discord:722766829881131038', 'playersafe', 0),
(0, 'discord:722766829881131038', 'prop_table_07', 0),
(0, 'discord:722766829881131038', 'weed_seed', 0),
(0, 'discord:722766829881131038', 'weapon_switchblade', 0),
(0, 'discord:722766829881131038', 'craftingtable', 0),
(0, 'discord:722766829881131038', 'iron', 0),
(0, 'discord:722766829881131038', 'cuffs', 0),
(0, 'discord:722766829881131038', 'darkshop', 0),
(0, 'discord:722766829881131038', 'vodka', 0),
(0, 'discord:722766829881131038', 'malbora', 0),
(0, 'discord:722766829881131038', 'disc_ammo_pistol_large', 0),
(0, 'discord:722766829881131038', 'petrol', 0),
(0, 'discord:722766829881131038', 'gantbox', 0),
(0, 'discord:722766829881131038', 'weapon_appistol', 0),
(0, 'discord:722766829881131038', 'cocktail', 0),
(0, 'discord:722766829881131038', 'miss_rub_couch_01', 0),
(0, 'discord:722766829881131038', 'mojito', 0),
(0, 'discord:722766829881131038', 'coke', 0),
(0, 'discord:722766829881131038', 'diamond', 0),
(0, 'discord:722766829881131038', 'prop_car_engine_01', 0),
(0, 'discord:722766829881131038', 'citron', 0),
(0, 'discord:722766829881131038', 'truele', 0),
(0, 'discord:722766829881131038', 'kalilinux', 0),
(0, 'discord:722766829881131038', 'prop_t_coffe_table', 0),
(0, 'discord:722766829881131038', 'wheat', 0),
(0, 'discord:722766829881131038', 'meth_packaged', 0),
(0, 'discord:722766829881131038', 'v_ret_gc_bag01', 0),
(0, 'discord:722766829881131038', 'maderaf', 0),
(0, 'discord:722766829881131038', 'fixter', 0),
(0, 'discord:722766829881131038', 'lockpick', 0),
(0, 'discord:722766829881131038', 'apa_mp_h_stn_chairarm_09', 0),
(0, 'discord:722766829881131038', 'prop_bench_01a', 0),
(0, 'discord:722766829881131038', 'rhum', 0),
(0, 'discord:722766829881131038', 'clipextended', 0),
(0, 'discord:722766829881131038', 'silverbull', 0),
(0, 'discord:722766829881131038', 'c4_bank', 0),
(0, 'discord:722766829881131038', 'tapas', 0),
(0, 'discord:722766829881131038', 'jupiler', 0),
(0, 'discord:722766829881131038', 'meth', 0),
(0, 'discord:722766829881131038', 'weapon_heavyshotgun', 0),
(0, 'discord:722766829881131038', 'grain', 0),
(0, 'discord:722766829881131038', 'weapon_poolcue', 0),
(0, 'discord:722766829881131038', 'weed20g', 0),
(0, 'discord:722766829881131038', 'weapon_bottle', 0),
(0, 'discord:722766829881131038', 'carteidentite', 1),
(0, 'discord:722766829881131038', 'fishd', 0),
(0, 'discord:722766829881131038', 'chinook', 0),
(0, 'discord:722766829881131038', 'v_res_d_bed', 0),
(0, 'discord:722766829881131038', 'meth10g', 0),
(0, 'discord:722766829881131038', 'apa_mp_h_yacht_armchair_04', 0),
(0, 'discord:722766829881131038', 'disc_ammo_pistol', 0),
(0, 'discord:722766829881131038', 'legbrace', 0),
(0, 'discord:722766829881131038', 'hei_prop_yah_seat_01', 0),
(0, 'discord:722766829881131038', 'mclon', 0),
(0, 'discord:722766829881131038', 'mask', 0),
(0, 'discord:722766829881131038', 'yusuf', 0),
(0, 'discord:722766829881131038', 'hei_prop_yah_table_02', 0),
(0, 'discord:722766829881131038', 'prop_bin_08open', 0),
(0, 'discord:722766829881131038', 'prop_chair_07', 0),
(0, 'discord:722766829881131038', 'or', 0),
(0, 'discord:722766829881131038', 'prop_t_coffe_table_02', 0),
(0, 'discord:722766829881131038', 'kebab', 0),
(0, 'discord:722766829881131038', 'opal', 0),
(0, 'discord:722766829881131038', 'bulletproof', 0),
(0, 'discord:722766829881131038', 'gym_membership', 0),
(0, 'discord:722766829881131038', 'beer', 0),
(0, 'discord:722766829881131038', 'lobster', 0),
(0, 'discord:722766829881131038', 'weapon_hammer', 0),
(0, 'discord:722766829881131038', 'p_v_43_safe_s', 0),
(0, 'discord:722766829881131038', 'weapon_crowbar', 0),
(0, 'discord:722766829881131038', 'prisonnier', 0),
(0, 'discord:722766829881131038', 'p_res_sofa_l_s', 0),
(0, 'discord:722766829881131038', 'skin2', 0),
(0, 'discord:722766829881131038', 'disc_ammo_smg_large', 0),
(0, 'discord:722766829881131038', 'acetone', 0),
(0, 'discord:722766829881131038', 'graineweed', 0),
(0, 'discord:722766829881131038', 'char', 0),
(0, 'discord:722766829881131038', 'prop_bin_07c', 0),
(0, 'discord:722766829881131038', 'prop_chair_03', 0),
(0, 'discord:722766829881131038', 'sacpoubelle', 0),
(0, 'discord:722766829881131038', 'planche', 0),
(0, 'discord:722766829881131038', 'vin', 0),
(0, 'discord:722766829881131038', 'cutting_pliers', 0),
(0, 'discord:722766829881131038', 'hotdog', 0),
(0, 'discord:722766829881131038', 'scratch', 0),
(0, 'discord:722766829881131038', 'weapon_ball', 0),
(0, 'discord:722766829881131038', 'radio', 1),
(0, 'discord:722766829881131038', 'ipad', 0),
(0, 'discord:722766829881131038', 'LsCustoms', 0),
(0, 'discord:722766829881131038', 'icetea', 0),
(0, 'discord:722766829881131038', 'crystaldemeth', 0),
(0, 'discord:722766829881131038', 'p_lestersbed_s', 0),
(0, 'discord:722766829881131038', 'ba_prop_battle_club_chair_02', 0),
(0, 'discord:722766829881131038', 'p_armchair_01_s', 0),
(0, 'discord:722766829881131038', 'cddaym', 0),
(0, 'discord:722766829881131038', 'apa_mp_h_bed_with_table_02', 0),
(0, 'discord:722766829881131038', 'gpbl', 0),
(0, 'discord:722766829881131038', 'xm_prop_body_bag', 0),
(0, 'discord:722766829881131038', 'briquet', 0),
(0, 'discord:722766829881131038', 'menthe', 0),
(0, 'discord:722766829881131038', 'weapon_combatpdw', 0),
(0, 'discord:722766829881131038', 'prop_chair_10', 0),
(0, 'discord:722766829881131038', 'mg_ammo', 0),
(0, 'discord:722766829881131038', 'Nokia', 0),
(0, 'discord:722766829881131038', 'meth1g', 0),
(0, 'discord:722766829881131038', 'prop_ld_farm_couch01', 0),
(0, 'discord:722766829881131038', 'prop_chair_04', 0),
(0, 'discord:722766829881131038', 'apa_mp_h_din_chair_12', 0),
(0, 'discord:722766829881131038', 'essence', 0),
(0, 'discord:722766829881131038', 'bread', 0),
(0, 'discord:722766829881131038', 'weapon_petrolcan', 0),
(0, 'discord:722766829881131038', 'nightvision', 0),
(0, 'discord:722766829881131038', 'billets', 0),
(0, 'discord:722766829881131038', 'weapon_assaultrifle', 0),
(0, 'discord:722766829881131038', 'sactactique', 1),
(0, 'discord:722766829881131038', 'imp_prop_engine_hoist_02a', 0),
(0, 'discord:722766829881131038', 'skin3', 0),
(0, 'discord:722766829881131038', 'p_lev_sofa_s', 0),
(0, 'discord:722766829881131038', 'oxycutter', 0),
(0, 'discord:722766829881131038', 'prop_patio_lounger1_table', 0),
(0, 'discord:722766829881131038', 'seau', 0),
(0, 'discord:722766829881131038', 'burger', 0),
(0, 'discord:722766829881131038', 'cokebrick', 0),
(0, 'discord:722766829881131038', 'weapon_carbinerifle', 0),
(0, 'discord:722766829881131038', 'meth_raw', 0),
(0, 'discord:722766829881131038', 'biere', 0),
(0, 'discord:722766829881131038', 'grip', 0),
(0, 'discord:722766829881131038', 'prop_rub_table_01', 0),
(0, 'discord:722766829881131038', 'antigel', 0),
(0, 'discord:722766829881131038', 'prop_table_03', 0),
(0, 'discord:722766829881131038', 'mleko', 0),
(0, 'discord:722766829881131038', 'goldfish', 0),
(0, 'discord:722766829881131038', 'disc_ammo_rifle', 16),
(0, 'discord:722766829881131038', 'carotool', 0),
(0, 'discord:722766829881131038', 'hqscale', 0),
(0, 'discord:722766829881131038', 'coke1g', 0),
(0, 'discord:722766829881131038', 'powerade', 0),
(0, 'discord:722766829881131038', 'coke_pooch', 0),
(0, 'discord:722766829881131038', 'tatgun', 0),
(0, 'discord:722766829881131038', 'advancedlockpick', 0),
(0, 'discord:722766829881131038', 'fanta', 0),
(0, 'discord:722766829881131038', 'prop_table_05', 0),
(0, 'discord:722766829881131038', 'gr_prop_gr_tool_chest_01a', 0),
(0, 'discord:722766829881131038', 'gadget_parachute', 0),
(0, 'discord:722766829881131038', 'weed4g', 0),
(0, 'discord:722766829881131038', 'juscanne', 0),
(0, 'discord:722766829881131038', 'ciseau', 0),
(0, 'discord:722766829881131038', 'bulletproofpolice', 2),
(0, 'discord:722766829881131038', 'xm_prop_lab_desk_02', 0),
(0, 'discord:722766829881131038', 'raisin', 0),
(0, 'discord:722766829881131038', 'maderag', 0),
(0, 'discord:722766829881131038', 'wipe', 0),
(0, 'discord:722766829881131038', 'lokalizator', 0),
(0, 'discord:722766829881131038', 'wine', 0),
(0, 'discord:722766829881131038', 'paracetamol', 0),
(0, 'discord:722766829881131038', 'whiskey', 0),
(0, 'discord:722766829881131038', 'weedburn', 0),
(0, 'discord:722766829881131038', 'energy', 0),
(0, 'discord:722766829881131038', 'weedbrick', 0),
(0, 'discord:722766829881131038', 'hazmat2', 0),
(0, 'discord:722766829881131038', 'weed_pooch', 0),
(0, 'discord:722766829881131038', 'prop_chair_06', 0),
(0, 'discord:722766829881131038', 'weed', 0),
(0, 'discord:722766829881131038', 'weapon_wrench', 0),
(0, 'discord:722766829881131038', 'disc_ammo_shotgun_large', 0),
(0, 'discord:722766829881131038', 'viande', 0),
(0, 'discord:722766829881131038', 'v_tre_sofa_mess_a_s', 0),
(0, 'discord:722766829881131038', 'weapon_snowball', 0),
(0, 'discord:722766829881131038', 'pike', 0),
(0, 'discord:722766829881131038', 'weapon_smokegrenade', 0),
(0, 'discord:722766829881131038', 'terrehumide', 0),
(0, 'discord:722766829881131038', 'weapon_sawnoffshotgun', 0),
(0, 'discord:722766829881131038', 'weapon_revolver', 0),
(0, 'discord:722766829881131038', 'weapon_pistol50', 0),
(0, 'discord:722766829881131038', 'weapon_pistol', 1),
(0, 'discord:722766829881131038', 'apa_mp_h_stn_chairarm_11', 0),
(0, 'discord:722766829881131038', 'weapon_machete', 0),
(0, 'discord:722766829881131038', 'v_res_tt_bed', 0),
(0, 'discord:722766829881131038', 'weapon_molotov', 0),
(0, 'discord:722766829881131038', 'weapon_minismg', 0),
(0, 'discord:722766829881131038', 'weapon_microsmg', 0),
(0, 'discord:722766829881131038', 'gpbml', 0),
(0, 'discord:722766829881131038', 'ferraille', 0),
(0, 'discord:722766829881131038', 'fishingpermit', 0),
(0, 'discord:722766829881131038', 'weapon_mg', 0),
(0, 'discord:722766829881131038', 'weapon_marksmanpistol', 0),
(0, 'discord:722766829881131038', 'weapon_machinepistol', 0),
(0, 'discord:722766829881131038', 'apa_mp_h_stn_chairarm_23', 0),
(0, 'discord:722766829881131038', 'weapon_nightstick', 0),
(0, 'discord:722766829881131038', 'viseur', 0),
(0, 'discord:722766829881131038', 'weapon_knife', 0),
(0, 'discord:722766829881131038', 'weapon_heavypistol', 0),
(0, 'discord:722766829881131038', 'weapon_hatchet', 0),
(0, 'discord:722766829881131038', 'ghb_pooch', 0),
(0, 'discord:722766829881131038', 'weapon_golfclub', 0),
(0, 'discord:722766829881131038', 'bodybandage', 0),
(0, 'discord:722766829881131038', 'weapon_flashlight', 0),
(0, 'discord:722766829881131038', 'disc_ammo_snp', 0),
(0, 'discord:722766829881131038', 'prop_table_02', 0),
(0, 'discord:722766829881131038', 'apa_mp_h_stn_chairarm_13', 0),
(0, 'discord:722766829881131038', 'weapon_dagger', 0),
(0, 'discord:722766829881131038', 'cocaine_cut', 0),
(0, 'discord:722766829881131038', 'prop_carcreeper', 0),
(0, 'discord:722766829881131038', 'jewels', 0),
(0, 'discord:722766829881131038', 'pistol_ammo', 0),
(0, 'discord:722766829881131038', 'laptop', 0),
(0, 'discord:722766829881131038', 'carokit', 0),
(0, 'discord:722766829881131038', 'james_fish', 0),
(0, 'discord:722766829881131038', 'weapon_combatpistol', 0),
(0, 'discord:722766829881131038', 'cafe', 0),
(0, 'discord:722766829881131038', 'weapon_combatmg', 0),
(0, 'discord:722766829881131038', 'methburn', 0),
(0, 'discord:722766829881131038', 'clipdrum', 0),
(0, 'discord:722766829881131038', 'boitierarmesdepoing', 0),
(0, 'discord:722766829881131038', 'prop_ld_farm_table02', 0),
(0, 'discord:722766829881131038', 'access_key', 0),
(0, 'discord:722766829881131038', 'hazmat4', 0),
(0, 'discord:722766829881131038', 'fishingrod', 1),
(0, 'discord:722766829881131038', 'GADGET_HAZMAT1', 0),
(0, 'discord:722766829881131038', 'apa_mp_h_stn_chairstrip_05', 0),
(0, 'discord:722766829881131038', 'ex_mp_h_din_table_05', 0),
(0, 'discord:722766829881131038', 'goldmedal', 0),
(0, 'discord:722766829881131038', 'weapon_bat', 0),
(0, 'discord:722766829881131038', 'fly-ticket', 0),
(0, 'discord:722766829881131038', 'apa_mp_h_din_chair_08', 0),
(0, 'discord:722766829881131038', 'stungun_ammo', 0),
(0, 'discord:722766829881131038', 'iphone', 0),
(0, 'discord:722766829881131038', 'coca', 0),
(0, 'discord:722766829881131038', 'ring', 0),
(0, 'discord:722766829881131038', 'weapon_autoshotgun', 0),
(0, 'discord:722766829881131038', 'morphine', 0),
(0, 'discord:722766829881131038', 'weapon_assaultsmg', 0),
(0, 'discord:722766829881131038', 'weapon_assaultshotgun', 0),
(0, 'discord:722766829881131038', 'carpecuir', 0),
(0, 'discord:722766829881131038', 'prop_chair_02', 0),
(0, 'discord:722766829881131038', 'gps', 1),
(0, 'discord:722766829881131038', 'coffee', 0),
(0, 'discord:722766829881131038', 'apa_mp_h_bed_double_09', 0),
(0, 'discord:722766829881131038', 'tenuelspd', 4),
(0, 'discord:722766829881131038', 'apa_mp_h_stn_chairstrip_08', 0),
(0, 'discord:722766829881131038', 'warehouse_key', 0),
(0, 'discord:722766829881131038', 'water', 5),
(0, 'discord:722766829881131038', 'keycard', 0),
(0, 'discord:722766829881131038', 'weapon_ceramicpistol', 0),
(0, 'discord:722766829881131038', 'viandepoulet', 0),
(0, 'discord:722766829881131038', 'goldbar', 0),
(0, 'discord:722766829881131038', 'diamondring', 0),
(0, 'discord:722766829881131038', 'cheese', 0),
(0, 'discord:722766829881131038', 'vault', 0),
(0, 'discord:722766829881131038', 'sprite', 0),
(0, 'discord:722766829881131038', 'magazine', 0),
(0, 'discord:722766829881131038', 'v_tre_sofa_mess_b_s', 0),
(0, 'discord:722766829881131038', 'prop_boxpile_07d', 0),
(0, 'discord:722766829881131038', 'weapon_specialcarbine', 0),
(0, 'discord:722766829881131038', 'jusraisin', 0),
(0, 'discord:722766829881131038', 'apple_cleaver', 0),
(0, 'discord:722766829881131038', 'skin7', 0),
(0, 'discord:722766829881131038', 'v_ret_fh_dinetble', 0),
(0, 'discord:722766829881131038', 'prop_dress_disp_01', 0),
(0, 'discord:722766829881131038', 'moteur', 1),
(0, 'discord:722766829881131038', 'v_res_tre_sofa_s', 0),
(0, 'discord:722766829881131038', 'salmon', 0),
(0, 'discord:722766829881131038', 'v_res_mdbed', 0),
(0, 'discord:722766829881131038', 'poule', 0),
(0, 'discord:722766829881131038', 'apa_mp_h_din_chair_04', 0),
(0, 'discord:722766829881131038', 'table', 0),
(0, 'discord:722766829881131038', 'protein_shake', 0),
(0, 'discord:722766829881131038', 'v_ilev_m_sofa', 0),
(0, 'discord:722766829881131038', 'sable', 0),
(0, 'discord:722766829881131038', 'disc_ammo_shotgun', 11),
(0, 'discord:722766829881131038', 'cocaine', 0),
(0, 'discord:722766829881131038', 'trout', 0),
(0, 'discord:722766829881131038', 'poissoncru', 0),
(0, 'discord:722766829881131038', 'tribike3', 0),
(0, 'discord:722766829881131038', 'joint', 0),
(0, 'discord:722766829881131038', 'medikit', 0),
(0, 'discord:722766829881131038', 'tribike', 0),
(0, 'discord:722766829881131038', 'apple_pack', 0),
(0, 'discord:722766829881131038', 'hazmat3', 0),
(0, 'discord:722766829881131038', 'malette', 0),
(0, 'discord:722766829881131038', 'roach', 0),
(0, 'discord:722766829881131038', 'vaccine', 0),
(0, 'discord:722766829881131038', 'kitpic', 0),
(0, 'discord:722766829881131038', 'clip', 0),
(0, 'discord:722766829881131038', 'tea', 0),
(0, 'discord:722766829881131038', 'weapon_vintagepistol', 0),
(0, 'discord:722766829881131038', 'gold', 0),
(0, 'discord:722766829881131038', 'tabacsec', 0),
(0, 'discord:722766829881131038', 'sucrecanne', 0),
(0, 'discord:722766829881131038', 'bouteilleessence', 0),
(0, 'discord:722766829881131038', 'silencieux', 0),
(0, 'discord:722766829881131038', 'jbl', 0),
(0, 'discord:722766829881131038', 'chanvre', 0),
(0, 'discord:722766829881131038', 'prop_wheel_rim_02', 0),
(0, 'discord:722766829881131038', 'veganburger', 0),
(0, 'discord:722766829881131038', 'bagofdope', 0),
(0, 'discord:722766829881131038', 'spray', 0),
(0, 'discord:722766829881131038', 'karting1', 0),
(0, 'discord:722766829881131038', 'casapapel', 0),
(0, 'discord:722766829881131038', 'handcuff', 0),
(0, 'discord:722766829881131038', 'moukate', 0),
(0, 'discord:722766829881131038', 'apa_mp_h_stn_chairarm_12', 0),
(0, 'discord:722766829881131038', 'colis', 0),
(0, 'discord:722766829881131038', 'p_ilev_p_easychair_s', 0),
(0, 'discord:722766829881131038', 'sirop', 0),
(0, 'discord:722766829881131038', 'tel', 0),
(0, 'discord:722766829881131038', 'croquettes', 0),
(0, 'discord:722766829881131038', 'soda', 0),
(0, 'discord:722766829881131038', 'smg_ammo', 0),
(0, 'discord:722766829881131038', 'v_ret_fh_displayc', 0),
(0, 'discord:722766829881131038', 'cocaine_packaged', 0),
(0, 'discord:722766829881131038', 'clous', 0),
(0, 'discord:722766829881131038', 'blowpipe', 0),
(0, 'discord:722766829881131038', 'skin5', 0),
(0, 'discord:722766829881131038', 'prop_barrier_work05', 0),
(0, 'discord:722766829881131038', 'skin4', 0),
(0, 'discord:722766829881131038', 'ghb', 0),
(0, 'discord:722766829881131038', 'hei_prop_yah_seat_03', 0),
(0, 'discord:722766829881131038', 'sactete', 0),
(0, 'discord:722766829881131038', 'levure', 0),
(0, 'discord:722766829881131038', 'tribike2', 0),
(0, 'discord:722766829881131038', 'waterg', 0),
(0, 'discord:722766829881131038', 'weapon_compactrifle', 0),
(0, 'discord:722766829881131038', 'sim', 0),
(0, 'discord:722766829881131038', 'shotgun_ammo', 0),
(0, 'discord:722766829881131038', 'fichepaye', 0),
(0, 'discord:722766829881131038', 'scorcher', 0),
(0, 'discord:722766829881131038', 'bullet1', 0),
(0, 'discord:722766829881131038', 'weapon_bullpupshotgun', 0),
(0, 'discord:722766829881131038', 'prop_devin_box_01', 0),
(0, 'discord:722766829881131038', 'sandwich', 0),
(0, 'discord:722766829881131038', 'ingredients', 0),
(0, 'discord:722766829881131038', 'v_res_tre_bed1', 0),
(0, 'discord:722766829881131038', 'bronzemedal', 0),
(0, 'discord:722766829881131038', 'prop_chair_01a', 0),
(0, 'discord:722766829881131038', 'bullet2', 0),
(0, 'discord:722766829881131038', 'milkbottle', 0),
(0, 'discord:722766829881131038', 'rifle_ammo', 0),
(0, 'discord:722766829881131038', 'fixkit', 0),
(0, 'discord:722766829881131038', 'prop_t_sofa_02', 0),
(0, 'discord:722766829881131038', 'cartebleu', 1),
(0, 'discord:722766829881131038', 'apa_mp_h_stn_chairstrip_06', 0),
(0, 'discord:722766829881131038', 'cut_money', 0),
(0, 'discord:722766829881131038', 'condom', 0),
(0, 'discord:722766829881131038', 'steak', 0),
(0, 'discord:722766829881131038', 'bandage', 0),
(0, 'discord:722766829881131038', 'houblon', 0),
(0, 'discord:722766829881131038', 'bullet4', 0),
(0, 'discord:722766829881131038', 'flashlight', 0),
(0, 'discord:722766829881131038', 'prop_tv_cam_02', 0),
(0, 'discord:722766829881131038', 'crawfish', 0),
(0, 'discord:722766829881131038', 'hei_prop_yah_table_03', 0),
(0, 'discord:722766829881131038', 'p_patio_lounger1_s', 0),
(0, 'discord:722766829881131038', 'prop_roadcone02a', 0),
(0, 'discord:722766829881131038', 'prop_chair_08', 0),
(0, 'discord:722766829881131038', 'weed_packaged', 0),
(0, 'discord:722766829881131038', 'prop_chair_01b', 0),
(0, 'discord:722766829881131038', 'fishandchips', 0),
(0, 'discord:722766829881131038', 'gazbottle', 0),
(0, 'discord:722766829881131038', 'apa_mp_h_stn_chairarm_25', 0),
(0, 'discord:722766829881131038', 'disc_ammo_smg', 0),
(0, 'discord:722766829881131038', 'poisson', 0),
(0, 'discord:722766829881131038', 'pizza', 0),
(0, 'discord:722766829881131038', 'phone', 1),
(0, 'discord:722766829881131038', 'champagne', 0),
(0, 'discord:722766829881131038', 'apa_mp_h_yacht_bed_02', 0),
(0, 'discord:722766829881131038', 'malt', 0),
(0, 'discord:722766829881131038', 'blowtorch', 0),
(0, 'discord:722766829881131038', 'handcuffs', 0),
(0, 'discord:722766829881131038', 'weapon_flaregun', 0),
(0, 'discord:722766829881131038', 'bkr_prop_duffel_bag_01a', 0),
(0, 'discord:722766829881131038', 'milk', 0),
(0, 'discord:722766829881131038', 'ba_prop_battle_club_chair_03', 0),
(0, 'discord:722766829881131038', 'boitierarmeslourdes', 0),
(0, 'discord:722766829881131038', 'weapon_advancedrifle', 0),
(0, 'discord:722766829881131038', 'pelle', 0),
(0, 'discord:722766829881131038', 'frites', 0),
(0, 'discord:722766829881131038', 'repairkit', 0),
(0, 'discord:722766829881131038', 'carosskit', 0);

-- --------------------------------------------------------

--
-- Structure de la table `user_lastcharacter`
--

CREATE TABLE `user_lastcharacter` (
  `steamid` varchar(255) NOT NULL,
  `charid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `user_licenses`
--

CREATE TABLE `user_licenses` (
  `id` int(11) NOT NULL,
  `type` varchar(60) NOT NULL,
  `owner` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `user_licenses`
--

INSERT INTO `user_licenses` (`id`, `type`, `owner`) VALUES
(1, 'drive', 'discord:722766829881131038');

-- --------------------------------------------------------

--
-- Structure de la table `user_parkings`
--

CREATE TABLE `user_parkings` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) DEFAULT NULL,
  `plate` varchar(60) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `zone` longtext DEFAULT NULL,
  `vehicle` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `user_settings`
--

CREATE TABLE `user_settings` (
  `id` int(11) NOT NULL,
  `identifier` varchar(60) COLLATE utf8mb4_bin DEFAULT '{}',
  `humor` varchar(60) COLLATE utf8mb4_bin DEFAULT '{}',
  `demarche` varchar(150) COLLATE utf8mb4_bin NOT NULL DEFAULT '{}',
  `pav7` varchar(150) COLLATE utf8mb4_bin DEFAULT '{}',
  `pav8` varchar(150) COLLATE utf8mb4_bin DEFAULT '{}',
  `pav9` varchar(150) COLLATE utf8mb4_bin DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `user_sim`
--

CREATE TABLE `user_sim` (
  `id` int(11) NOT NULL,
  `identifier` varchar(555) NOT NULL,
  `number` varchar(555) NOT NULL,
  `label` varchar(555) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `user_tenue`
--

CREATE TABLE `user_tenue` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `tenue` longtext COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Structure de la table `vehicles`
--

CREATE TABLE `vehicles` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `vehicles`
--

INSERT INTO `vehicles` (`name`, `model`, `price`, `category`) VALUES
('Adder', 'adder', 190000, 'super'),
('Akuma', 'AKUMA', 7500, 'motorcycles'),
('Alpha', 'alpha', 40000, 'sports'),
('Alpha-Z1', 'alphaz1', 310000, 'avion'),
('Ambulance', 'ambulance', 12500, 'service'),
('Ardent', 'ardent', 100000, 'sportsclassics'),
('Asbo', 'asbo', 9850, 'casino'),
('Asea', 'asea', 4050, 'berlines'),
('Asterope', 'asterope', 4950, 'berlines'),
('Autarch', 'autarch', 200000, 'super'),
('Avarus', 'avarus', 18000, 'motorcycles'),
('Bagger', 'bagger', 13500, 'motorcycles'),
('Baller', 'baller', 25000, 'suv'),
('Baller2', 'baller2', 35000, 'suv'),
('Baller LE', 'baller3', 40000, 'suv'),
('Baller LE LWB', 'baller4', 45000, 'suv'),
('Banshee', 'banshee', 50000, 'sports'),
('Bashee', 'banshee2', 170000, 'super'),
('Bati 801', 'bati', 12000, 'motorcycles'),
('Bati 801RR', 'bati2', 19000, 'motorcycles'),
('Bestia GTS', 'bestiagts', 65400, 'sports'),
('BF400', 'bf400', 6500, 'motorcycles'),
('Bfinjection', 'bfinjection', 12120, 'muscles'),
('Bifta', 'bifta', 19500, 'coupes'),
('Bison', 'bison', 12000, 'vans'),
('Bison', 'bison3', 14000, 'vans'),
('BeeJay XL', 'bjxl', 15000, 'suv'),
('Blade', 'blade', 9000, 'muscles'),
('Blazer', 'blazer', 4500, 'motorcycles'),
('Blazer Hot Rod', 'blazer3', 6500, 'motorcycles'),
('blazer4', 'blazer4', 10000, 'motorcycles'),
('Blista', 'blista', 3450, 'compacts'),
('Blista 2', 'blista2', 6290, 'sports'),
('Blista 3', 'blista3', 6860, 'sports'),
('BMX (velo)', 'bmx', 160, 'motorcycles'),
('Bobcat XL', 'bobcatxl', 13500, 'vans'),
('Bodhi', 'bodhi2', 12000, 'suv'),
('Brawler', 'brawler', 27500, 'vans'),
('Brioso', 'brioso', 3000, 'compacts'),
('Roosevelt', 'btype', 56000, 'sportsclassics'),
('Franken Stange', 'btype2', 74000, 'sportsclassics'),
('Roosevelt Valor', 'btype3', 65000, 'sportsclassics'),
('Buccaneer', 'buccaneer', 12000, 'muscles'),
('Buccaneer ', 'buccaneer2', 17000, 'muscles'),
('Buffalo', 'buffalo', 30000, 'sports'),
('Buffalo Sport', 'buffalo2', 40000, 'sports'),
('Buzzard', 'buzzard2', 458230, 'heli'),
('Caddie', 'caddy', 8650, 'compacts'),
('Caddie Abimé', 'caddy2', 7500, 'compacts'),
('Caracara custom', 'caracara2', 36500, 'casino'),
('Carbonizzare', 'carbonizzare', 50000, 'sports'),
('Carbon RS', 'carbonrs', 18000, 'motorcycles'),
('Cargobob', 'cargobob2', 605000, 'heli'),
('Casco', 'casco', 100000, 'sportsclassics'),
('Cavalcade', 'cavalcade', 20000, 'suv'),
('Cavalcade V2', 'cavalcade2', 25000, 'suv'),
('Cheburek', 'cheburek', 14260, 'compacts'),
('Cheetah', 'cheetah', 210000, 'super'),
('Cheetah', 'cheetah2', 200000, 'sportsclassics'),
('Chimera', 'chimera', 38000, 'motorcycles'),
('Chino', 'chino', 16520, 'muscles'),
('Chino Custom', 'chino2', 11000, 'muscles'),
('Cliffhanger', 'cliffhanger', 9500, 'motorcycles'),
('Clique', 'clique', 9000, 'compacts'),
('BF Club', 'club', 9850, 'summer'),
('Cognoscenti Cabrio', 'cogcabrio', 18000, 'coupes'),
('Cognoscenti', 'cognoscenti', 20000, 'berlines'),
('Comet', 'comet2', 108000, 'sports'),
('Comet Retro', 'comet3', 110000, 'sports'),
('Comet ', 'comet4', 115000, 'sports'),
('Comet SR', 'comet5', 125000, 'sports'),
('Contender', 'contender', 90000, 'suv'),
('Coquette', 'coquette', 70000, 'sports'),
('Coquette', 'coquette2', 90000, 'sportsclassics'),
('Coquette ', 'coquette3', 100000, 'muscles'),
('Invetero Coquette D10', 'coquette4', 125000, 'summer'),
('Cruiser (velo)', 'cruiser', 510, 'motorcycles'),
('Cuban 800', 'cuban800', 225000, 'avion'),
('Cyclone', 'cyclone', 160000, 'super'),
('Daemon', 'daemon', 11500, 'motorcycles'),
('Daemon custom', 'daemon2', 13500, 'motorcycles'),
('Deathbike', 'deathbike', 8650, 'motorcycles'),
('Defiler', 'defiler', 9800, 'motorcycles'),
('Deveste', 'deveste', 230000, 'super'),
('Deviant', 'deviant', 20000, 'muscles'),
('Diablous', 'diablous', 11250, 'motorcycles'),
('Diablous Remastered', 'diablous2', 17500, 'motorcycles'),
('Dilettante', 'dilettante', 3850, 'compacts'),
('Dinghy 4 places', 'dinghy', 9070, 'boat'),
('Dinghy 2 places', 'dinghy2', 8000, 'boat'),
('D Loader', 'dloader', 7260, 'muscles'),
('Dodo', 'dodo', 275000, 'avion'),
('Dominator', 'dominator', 27600, 'muscles'),
('Dominator 2', 'dominator2', 31200, 'muscles'),
('Dominato', 'dominator3', 55000, 'muscles'),
('Double T', 'double', 28000, 'motorcycles'),
('Drafter', 'drafter', 54250, 'casino'),
('Dubsta', 'dubsta', 30000, 'suv'),
('Dubsta Luxury', 'dubsta2', 41900, 'suv'),
('Dubsta 6x6', 'dubsta3', 121000, 'suv'),
('Dukes', 'dukes', 18730, 'muscles'),
('Imponte Beater Dukes', 'dukes3', 22730, 'summer'),
('Dune Buggy', 'dune', 19400, 'muscles'),
('Duster', 'duster', 300000, 'avion'),
('Dynasty', 'Dynasty', 14550, 'casino'),
('Elegy Retro', 'elegy', 95000, 'sports'),
('Elegy', 'elegy2', 83890, 'sports'),
('Ellie', 'ellie', 54000, 'muscles'),
('Emerus', 'emerus', 186500, 'casino'),
('Emperor', 'emperor', 4050, 'berlines'),
('Emperor Rouillé', 'emperor2', 3650, 'berlines'),
('Enduro', 'enduro', 5500, 'motorcycles'),
('Entity XXR', 'entity2', 215000, 'super'),
('Entity XF', 'entityxf', 195000, 'super'),
('Esskey', 'esskey', 4200, 'motorcycles'),
('Everon', 'everon', 32500, 'casino'),
('Exemplar', 'exemplar', 95500, 'coupes'),
('F620', 'f620', 59500, 'coupes'),
('Faction', 'faction', 14260, 'muscles'),
('Faction ', 'faction2', 18190, 'muscles'),
('Faction Custom 3', 'faction3', 20930, 'muscles'),
('Fagaloa', 'fagaloa', 26500, 'sportsclassics'),
('Faggio', 'faggio', 1900, 'motorcycles'),
('Vespa', 'faggio2', 2800, 'motorcycles'),
('Faggio plage', 'faggio3', 4500, 'motorcycles'),
('Bannalisé', 'fbi', 18500, 'service'),
('Granger bannalisé', 'fbi2', 24500, 'service'),
('FCR', 'fcr', 18450, 'motorcycles'),
('FCR Remastered', 'fcr2', 21500, 'motorcycles'),
('Felon', 'felon', 27600, 'coupes'),
('Felon 2', 'felon2', 31200, 'sports'),
('Feltzer', 'feltzer2', 102500, 'sports'),
('Stirling GT', 'feltzer3', 64000, 'sportsclassics'),
('Fixter (velo)', 'fixter', 225, 'motorcycles'),
('Flash GT', 'flashgt', 35000, 'sports'),
('FMJ', 'fmj', 202000, 'super'),
('FQ 2', 'fq2', 34750, 'suv'),
('Freecrawler', 'freecrawler', 26300, 'coupes'),
('Frogger', 'frogger', 352500, 'heli'),
('Fugitive', 'fugitive', 18730, 'berlines'),
('Furia', 'furia', 172300, 'casino'),
('Furore GT', 'furoregt', 95000, 'sports'),
('Fusilade', 'fusilade', 30000, 'sports'),
('Futo', 'futo', 7260, 'compacts'),
('Gargoyle', 'gargoyle', 16500, 'motorcycles'),
('Gauntlet', 'gauntlet', 20000, 'muscles'),
('Gauntlet 2', 'gauntlet2', 23000, 'muscles'),
('Gauntlet 3', 'gauntlet3', 17500, 'casino'),
('Gauntlet 4', 'gauntlet4', 26400, 'casino'),
('Gauntlet Classic Custom', 'gauntlet5', 29400, 'summer'),
('GB200', 'gb200', 35000, 'sports'),
('GBurrito', 'gburrito', 17000, 'suv'),
('GBurrito 2', 'gburrito2', 20000, 'suv'),
('Glendale', 'glendale', 4050, 'berlines'),
('Benefactor Glendale Custom', 'glendale2', 11050, 'summer'),
('GP1', 'gp1', 175000, 'super'),
('Granger', 'granger', 20000, 'suv'),
('Gresley', 'gresley', 16000, 'suv'),
('GT500', 'gt500', 150000, 'sportsclassics'),
('Guardian', 'guardian', 36500, 'vans'),
('Habanero', 'habanero', 12000, 'suv'),
('Hakuchou', 'hakuchou', 31000, 'motorcycles'),
('Hakuchou Sport', 'hakuchou2', 55000, 'motorcycles'),
('Havok', 'havok', 120000, 'heli'),
('Hellion', 'hellion', 24500, 'casino'),
('Hermes', 'hermes', 16000, 'muscles'),
('Hexer', 'hexer', 12000, 'motorcycles'),
('Hotknife', 'hotknife', 26500, 'muscles'),
('Hotring Sabre', 'hotring', 35000, 'sports'),
('Howard NX-25', 'howard', 320000, 'avion'),
('Huntley', 'huntley', 20000, 'suv'),
('Hustler', 'hustler', 11000, 'coupes'),
('Imorgon', 'imorgon', 186500, 'casino'),
('Impaler', 'impaler', 12000, 'muscles'),
('Imperator', 'imperator', 24500, 'muscles'),
('Infernus', 'infernus', 120000, 'super'),
('Infernus Classique', 'infernus2', 110000, 'sportsclassics'),
('Ingot', 'ingot', 5250, 'berlines'),
('Innovation', 'innovation', 23500, 'motorcycles'),
('Intruder', 'intruder', 6860, 'berlines'),
('Issi ', 'issi2', 4450, 'compacts'),
('Issi Classique', 'issi3', 5000, 'compacts'),
('Issi 7', 'issi7', 19600, 'casino'),
('Itali GT', 'italigtb', 152000, 'super'),
('Itali GT Custom', 'italigtb2', 164000, 'super'),
('Itali GTO', 'italigto', 165000, 'sports'),
('Jackal', 'jackal', 15000, 'coupes'),
('JB 700', 'jb700', 43000, 'sportsclassics'),
('Dewbauch', 'jb7002', 14600, 'casino'),
('Jester', 'jester', 115000, 'sports'),
('Jester 2', 'jester2', 108000, 'sports'),
('Jester 3', 'jester3', 170600, 'sports'),
('Jetmax', 'jetmax', 17000, 'boat'),
('Journey', 'journey', 10000, 'muscles'),
('Jugular', 'jugular', 75620, 'casino'),
('Kalahari', 'kalahari', 12500, 'coupes'),
('Kamacho', 'kamacho', 60500, 'suv'),
('Kanjo', 'kanjo', 14250, 'casino'),
('Khamelion', 'khamelion', 96000, 'sports'),
('Komoda', 'komoda', 123000, 'casino'),
('Krieger', 'krieger', 164500, 'casino'),
('Kuruma', 'kuruma', 40000, 'sports'),
('Landstalker', 'landstalker', 43700, 'suv'),
('Dundreary Landstalker', 'landstalker2', 56250, 'summer'),
('Lectro', 'lectro', 12500, 'motorcycles'),
('Locust', 'locust', 152500, 'casino'),
('Luxor', 'luxor', 650000, 'avion'),
('Luxor deluxe', 'luxor2', 680000, 'avion'),
('Lynx', 'lynx', 56250, 'sports'),
('Mamba', 'mamba', 90000, 'sportsclassics'),
('Mammatus', 'mammatus', 375000, 'avion'),
('Manana', 'manana', 13710, 'sportsclassics'),
('Albany Manana Custom', 'manana2', 15710, 'summer'),
('Manchez', 'manchez', 5300, 'motorcycles'),
('Marquis', 'marquis', 25000, 'boat'),
('Massacro', 'massacro', 115000, 'sports'),
('Massacro 2', 'massacro2', 108000, 'sports'),
('Maverick', 'maverick', 335260, 'heli'),
('Mesa', 'mesa', 61200, 'suv'),
('Mesa 2', 'mesa2', 26500, 'suv'),
('Mesa 3', 'mesa3', 30100, 'suv'),
('Michelli GT', 'michelli', 19500, 'sportsclassics'),
('ULM', 'microlight', 26500, 'avion'),
('Mini Van', 'minivan', 19830, 'vans'),
('Mini Van ', 'minivan2', 24600, 'vans'),
('Monroe', 'monroe', 121900, 'sportsclassics'),
('Moon Beam', 'moonbeam', 16030, 'suv'),
('Moon Beam Custom', 'moonbeam2', 20600, 'suv'),
('Tondeuse', 'mower', 3280, 'compacts'),
('Nebula', 'nebula', 21350, 'casino'),
('Nemesis', 'nemesis', 5800, 'motorcycles'),
('Neo', 'neo', 76420, 'casino'),
('Neon', 'neon', 184400, 'sports'),
('Nero', 'nero', 136000, 'super'),
('Nero Custom', 'nero2', 213000, 'super'),
('Nightblade', 'nightblade', 35000, 'motorcycles'),
('Nightshade', 'nightshade', 85000, 'muscles'),
('Nimbus', 'nimbus', 600000, 'avion'),
('9F', 'ninef', 108000, 'sports'),
('9F ', 'ninef2', 115000, 'sports'),
('Novak', 'Novak', 24500, 'casino'),
('Omnis', 'omnis', 30000, 'sports'),
('Oracle', 'oracle', 27600, 'coupes'),
('Oracle XS', 'oracle2', 32400, 'coupes'),
('Osiris', 'osiris', 200000, 'super'),
('Outlaw', 'outlaw', 16500, 'casino'),
('Panto', 'panto', 3280, 'compacts'),
('Paradise', 'paradise', 9500, 'vans'),
('Paragon', 'paragon', 94500, 'casino'),
('Pariah', 'pariah', 250000, 'sports'),
('Patriot', 'patriot', 53500, 'suv'),
('Patriot Limousine', 'patriot2', 193900, 'suv'),
('PCJ-600', 'pcj', 6200, 'motorcycles'),
('Penumbra', 'penumbra', 31800, 'sports'),
('Maibatsu Penumbra', 'penumbra2', 12500, 'summer'),
('Peyote', 'peyote', 14260, 'sportsclassics'),
('Peyote custom', 'peyote2', 18260, 'casino'),
('Vapid Peyote Custom', 'peyote3', 20260, 'summer'),
('Phoenix', 'phoenix', 90000, 'muscles'),
('Picador', 'picador', 13710, 'muscles'),
('Pigalle', 'pigalle', 78000, 'sportsclassics'),
('CVPI police', 'police', 12500, 'service'),
('Dodge police', 'police2', 12500, 'service'),
('Explorer police', 'police3', 12500, 'service'),
('Pony', 'pony', 24250, 'suv'),
('Pony 2', 'pony2', 28200, 'suv'),
('Prairie', 'prairie', 5050, 'compacts'),
('Premier', 'premier', 4250, 'berlines'),
('Primo', 'primo', 6700, 'berlines'),
('Primo Custom', 'primo2', 14870, 'berlines'),
('X80 Proto', 'prototipo', 215000, 'super'),
('Radi', 'radi', 24250, 'suv'),
('Raiden', 'raiden', 170600, 'sports'),
('Rancher XL', 'rancherxl', 39500, 'suv'),
('Rapid GT', 'rapidgt', 121000, 'sports'),
('Rapid GT ', 'rapidgt2', 127000, 'sports'),
('Rapid G', 'rapidgt3', 77000, 'sportsclassics'),
('Rat Bike', 'ratbike', 11250, 'motorcycles'),
('Rat Loader Rouillé', 'ratloader', 8500, 'muscles'),
('Ratloader 2', 'ratloader2', 11000, 'muscles'),
('Reaper', 'reaper', 175000, 'super'),
('Rebel', 'rebel', 14000, 'suv'),
('Rebel', 'rebel2', 20000, 'suv'),
('Rebla', 'rebla', 43250, 'casino'),
('Regina', 'regina', 4900, 'berlines'),
('Retinue', 'retinue', 27600, 'sportsclassics'),
('Retinue custom', 'retinue2', 34600, 'casino'),
('Revolter', 'revolter', 71500, 'sports'),
('Rhapsody', 'rhapsody', 4050, 'compacts'),
('Riata', 'riata', 37020, 'suv'),
('Rocoto', 'rocoto', 26900, 'suv'),
('Rogue', 'rogue', 275000, 'avion'),
('Rrocket', 'rrocket', 23250, 'casino'),
('Ruffian', 'ruffian', 6800, 'motorcycles'),
('Ruiner', 'ruiner', 17620, 'muscles'),
('Rumpo', 'rumpo', 27600, 'suv'),
('Rumpo 2', 'rumpo2', 22030, 'suv'),
('Ruston', 'ruston', 126000, 'super'),
('Sabre Turbo', 'sabregt', 22600, 'muscles'),
('Sabre GT ', 'sabregt2', 31200, 'muscles'),
('Sadler', 'sadler', 17000, 'vans'),
('Sanchez', 'sanchez', 5300, 'motorcycles'),
('Sanchez Sport', 'sanchez2', 5300, 'motorcycles'),
('Sanctus', 'sanctus', 25000, 'motorcycles'),
('Sandking XL', 'sandking', 59550, 'suv'),
('Sandking', 'sandking2', 30000, 'suv'),
('Savestra', 'savestra', 30500, 'sportsclassics'),
('SC1', 'sc1', 202000, 'super'),
('Schafter 2', 'schafter2', 27600, 'coupes'),
('Schafter V12', 'schafter3', 35000, 'sports'),
('Schafter LWB', 'schafter4', 52000, 'sports'),
('Schlagen', 'schlagen', 100000, 'sports'),
('Schwarzer', 'schwarzer', 53500, 'sports'),
('Scorcher (velo)', 'scorcher', 280, 'motorcycles'),
('Tracteur', 'scrap', 8590, 'muscles'),
('Seabreeze', 'seabreeze', 135000, 'avion'),
('Seashark', 'seashark', 4600, 'boat'),
('Seminole', 'seminole', 13000, 'suv'),
('Canis Seminole Frontier', 'seminole2', 18200, 'summer'),
('Sentinel', 'sentinel', 22750, 'coupes'),
('Sentinel C', 'sentinel2', 26400, 'coupes'),
('Sentiel 3', 'sentinel3', 32000, 'sports'),
('Serrano', 'serrano', 22500, 'suv'),
('Seven 70', 'seven70', 171000, 'sports'),
('Shamal', 'shamal', 164500, 'avion'),
('ETR1', 'sheava', 132000, 'super'),
('Shotaro Concept', 'shotaro', 320000, 'motorcycles'),
('Slamvan', 'slamvan', 12650, 'suv'),
('Slamvan 2', 'slamvan2', 20350, 'suv'),
('Slamvan 3', 'slamvan3', 26000, 'suv'),
('Sovereign', 'sovereign', 22000, 'motorcycles'),
('Specter', 'specter', 103500, 'sports'),
('Specter', 'specter2', 125000, 'sports'),
('Speeder', 'speeder', 19000, 'boat'),
('Speedo', 'speedo', 16150, 'suv'),
('Speedo 2', 'speedo2', 20500, 'suv'),
('Speedo 3', 'speedo3', 23150, 'suv'),
('Squalo', 'squalo', 13000, 'boat'),
('Stafford', 'stafford', 20000, 'berlines'),
('Stallion', 'stalion', 14870, 'muscles'),
('Stallion 2', 'stalion2', 27000, 'muscles'),
('Stanier', 'stanier', 6860, 'berlines'),
('Stinger', 'stinger', 83000, 'sportsclassics'),
('Stinger GT', 'stingergt', 94000, 'sportsclassics'),
('Stratum', 'stratum', 5350, 'berlines'),
('Streiter', 'streiter', 42000, 'sports'),
('Stretch', 'stretch', 263000, 'berlines'),
('Stromberg', 'stromberg', 102000, 'sportsclassics'),
('Stryder', 'stryder', 32150, 'casino'),
('Mallard', 'stunt', 96500, 'avion'),
('Sugoi', 'Sugoi', 34250, 'casino'),
('Sultan', 'sultan', 20400, 'sports'),
('Sultan custom', 'sultan2', 26400, 'casino'),
('Sultan RS', 'sultanrs', 50000, 'super'),
('Suntrap', 'suntrap', 12000, 'boat'),
('Super Diamond', 'superd', 19600, 'berlines'),
('SuperVolito Carbone', 'supervolito2', 525000, 'heli'),
('Surano', 'surano', 84000, 'sports'),
('Surfer', 'surfer', 15030, 'suv'),
('Surfer Rouille', 'surfer2', 8650, 'vans'),
('Surge', 'surge', 5250, 'berlines'),
('Swift Simple', 'swift', 595000, 'heli'),
('Swift Deluxe', 'swift2', 555000, 'heli'),
('Swinger', 'swinger', 210000, 'sportsclassics'),
('T-20', 't20', 200000, 'super'),
('Tailgater', 'tailgater', 24250, 'berlines'),
('Taipan', 'taipan', 205000, 'super'),
('Tampa', 'tampa', 24250, 'muscles'),
('Tampa 2', 'tampa2', 45000, 'muscles'),
('Tempesta', 'tempesta', 185000, 'super'),
('Thrax', 'thrax', 215000, 'casino'),
('Thrust', 'thrust', 24000, 'motorcycles'),
('Lampadati Tigon', 'tigon', 96500, 'summer'),
('Torero', 'torero', 197000, 'sportsclassics'),
('Tornado classique', 'tornado', 14520, 'sportsclassics'),
('Tornado décapotable', 'tornado2', 18730, 'sportsclassics'),
('Tornado ', 'tornado3', 13240, 'sportsclassics'),
('Tornado ', 'tornado4', 7260, 'sportsclassics'),
('Tornado Cabriolet 5', 'tornado5', 27600, 'sportsclassics'),
('Tornado Cabriolet 6', 'tornado6', 15420, 'sportsclassics'),
('Toro', 'toro', 18000, 'boat'),
('Toros', 'toros', 200000, 'suv'),
('Tracteur', 'tractor', 7680, 'muscles'),
('Tracteur 2', 'tractor2', 8000, 'muscles'),
('Tri bike (velo)', 'tribike3', 520, 'motorcycles'),
('Trophy Truck', 'trophytruck', 28500, 'vans'),
('Buggy raid', 'trophytruck2', 34500, 'vans'),
('Tropic', 'tropic', 15000, 'boat'),
('Tropos', 'tropos', 107000, 'sports'),
('Tulip', 'tulip', 18000, 'muscles'),
('Turismo', 'turismo2', 211000, 'sportsclassics'),
('Turismo R', 'turismor', 195000, 'super'),
('Tyrant', 'tyrant', 193000, 'super'),
('Vacca', 'vacca', 95000, 'super'),
('Vader', 'vader', 7200, 'motorcycles'),
('Vagner', 'vagner', 189000, 'super'),
('Vagrant', 'vagrant', 38500, 'casino'),
('Vamos', 'vamos', 15500, 'muscles'),
('Velum', 'velum', 410000, 'avion'),
('Velum', 'velum2', 460000, 'avion'),
('Verlierer', 'verlierer2', 123000, 'sports'),
('Vestra', 'vestra', 325000, 'avion'),
('Vigero', 'vigero', 10620, 'muscles'),
('Vindicator', 'vindicator', 23500, 'motorcycles'),
('Virgo', 'virgo', 10080, 'muscles'),
('Virgo Custom', 'virgo2', 13000, 'muscles'),
('Virgo Custom 2', 'virgo3', 11000, 'muscles'),
('Viseris', 'viseris', 140000, 'sportsclassics'),
('Visione', 'visione', 197000, 'super'),
('Volatus', 'volatus', 610000, 'heli'),
('Voltic', 'voltic', 150000, 'super'),
('Voodoo', 'voodoo', 11620, 'muscles'),
('Voodoo 2', 'voodoo2', 10240, 'muscles'),
('Vortex', 'vortex', 9800, 'motorcycles'),
('VSTR', 'vstr', 64250, 'casino'),
('Warrener', 'warrener', 7260, 'berlines'),
('Washington', 'washington', 6860, 'berlines'),
('Windsor', 'windsor', 20000, 'coupes'),
('Windsor ', 'windsor2', 26000, 'coupes'),
('Woflsbane', 'wolfsbane', 9000, 'motorcycles'),
('XA21', 'xa21', 200000, 'super'),
('XLS', 'xls', 21000, 'suv'),
('Yosemite', 'yosemite', 27600, 'muscles'),
('Yosemite custom', 'yosemite2', 33600, 'casino'),
('Yosemite Ranchez', 'yosemite3', 36600, 'summer'),
('Youga', 'youga', 18000, 'suv'),
('Youga 2', 'youga2', 20000, 'suv'),
('Youga Classic 4x4', 'youga3', 23000, 'summer'),
('190Z', 'z190', 45000, 'sportsclassics'),
('Zentorno', 'zentorno', 206000, 'super'),
('Zion', 'zion', 15000, 'coupes'),
('Zion Cabriolet', 'zion2', 41900, 'coupes'),
('Zion 3', 'zion3', 26350, 'casino'),
('Zombie', 'zombiea', 9500, 'motorcycles'),
('Zombie Luxuary', 'zombieb', 12000, 'motorcycles'),
('Zorrusso', 'zorrusso', 168500, 'casino'),
('Z Type', 'ztype', 130000, 'sportsclassics');

-- --------------------------------------------------------

--
-- Structure de la table `vehicles_for_sale`
--

CREATE TABLE `vehicles_for_sale` (
  `id` int(11) NOT NULL,
  `seller` varchar(50) NOT NULL,
  `vehicleProps` longtext NOT NULL,
  `price` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `vehicles_for_sale`
--

INSERT INTO `vehicles_for_sale` (`id`, `seller`, `vehicleProps`, `price`) VALUES
(14, 'steam:110000118886056', '{\"modTrunk\":-1,\"health\":1000,\"modTurbo\":false,\"modFender\":-1,\"modSpoilers\":-1,\"modRearBumper\":-1,\"extras\":{\"1\":false},\"modHorns\":-1,\"neonEnabled\":[false,false,false,false],\"modVanityPlate\":-1,\"color2\":3,\"wheels\":5,\"modRightFender\":-1,\"modRoof\":-1,\"modLivery\":-1,\"modWindows\":-1,\"modSmokeEnabled\":1,\"modBackWheels\":-1,\"modTrimB\":-1,\"modEngine\":1,\"modTrimA\":-1,\"modFrontBumper\":-1,\"modEngineBlock\":-1,\"wheelColor\":156,\"modSuspension\":-1,\"modHydrolic\":-1,\"model\":2016857647,\"modAerials\":-1,\"modGrille\":-1,\"modAirFilter\":-1,\"pearlescentColor\":6,\"modHood\":-1,\"color1\":0,\"modFrontWheels\":-1,\"modSteeringWheel\":-1,\"dirtLevel\":1.3539762496948,\"modDoorSpeaker\":-1,\"modShifterLeavers\":-1,\"neonColor\":[255,0,255],\"modFrame\":-1,\"tyreSmokeColor\":[255,255,255],\"modXenon\":false,\"modSpeakers\":-1,\"modAPlate\":-1,\"modBrakes\":-1,\"plateIndex\":3,\"modArchCover\":-1,\"modOrnaments\":-1,\"modSeats\":-1,\"modStruts\":-1,\"modExhaust\":-1,\"modArmor\":-1,\"modSideSkirt\":-1,\"modTransmission\":-1,\"fuelLevel\":30.0,\"windowTint\":-1,\"modDashboard\":-1,\"modPlateHolder\":-1,\"plate\":\"854KLN98\",\"modTank\":-1,\"modDial\":-1}', 8000);

-- --------------------------------------------------------

--
-- Structure de la table `vehicle_categories`
--

CREATE TABLE `vehicle_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

--
-- Déchargement des données de la table `vehicle_categories`
--

INSERT INTO `vehicle_categories` (`name`, `label`) VALUES
('avion', 'Avions'),
('berlines', 'Berlines'),
('boat', 'Bateaux'),
('casino', 'Casino'),
('compacts', 'Compacts'),
('coupes', 'Coupés'),
('heli', 'Hélicoptère'),
('motorcycles', 'Motos'),
('muscles', 'Muscles'),
('service', 'Services'),
('sports', 'Sports'),
('sportsclassics', 'Sports Classics'),
('summer', 'Summer'),
('super', 'Supers'),
('suv', 'SUV'),
('vans', 'Vans');

-- --------------------------------------------------------

--
-- Structure de la table `vehicle_sold`
--

CREATE TABLE `vehicle_sold` (
  `client` varchar(50) NOT NULL,
  `model` varchar(50) NOT NULL,
  `plate` varchar(50) NOT NULL,
  `soldby` varchar(50) NOT NULL,
  `date` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Structure de la table `veh_km`
--

CREATE TABLE `veh_km` (
  `carplate` varchar(10) NOT NULL,
  `km` varchar(255) NOT NULL DEFAULT '0',
  `state` int(1) NOT NULL DEFAULT 0,
  `reset` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `warrants_list`
--

CREATE TABLE `warrants_list` (
  `id` int(11) NOT NULL,
  `json_data` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `wh_test`
--

CREATE TABLE `wh_test` (
  `identifier` varchar(50) NOT NULL,
  `warehouse` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `addon_account`
--
ALTER TABLE `addon_account`
  ADD PRIMARY KEY (`name`) USING BTREE;

--
-- Index pour la table `addon_account_data`
--
ALTER TABLE `addon_account_data`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `index_addon_account_data_account_name_owner` (`account_name`,`owner`) USING BTREE,
  ADD KEY `index_addon_account_data_account_name` (`account_name`) USING BTREE;

--
-- Index pour la table `addon_inventory`
--
ALTER TABLE `addon_inventory`
  ADD PRIMARY KEY (`name`) USING BTREE;

--
-- Index pour la table `addon_inventory_items`
--
ALTER TABLE `addon_inventory_items`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `index_addon_inventory_items_inventory_name_name` (`inventory_name`,`name`) USING BTREE,
  ADD KEY `index_addon_inventory_items_inventory_name_name_owner` (`inventory_name`,`name`,`owner`) USING BTREE,
  ADD KEY `index_addon_inventory_inventory_name` (`inventory_name`) USING BTREE;

--
-- Index pour la table `arrests_list`
--
ALTER TABLE `arrests_list`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `baninfo`
--
ALTER TABLE `baninfo`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `bank_transfer`
--
ALTER TABLE `bank_transfer`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `bikedealer_vehicles`
--
ALTER TABLE `bikedealer_vehicles`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `bikes`
--
ALTER TABLE `bikes`
  ADD PRIMARY KEY (`model`) USING BTREE;

--
-- Index pour la table `bike_categories`
--
ALTER TABLE `bike_categories`
  ADD PRIMARY KEY (`name`) USING BTREE;

--
-- Index pour la table `bike_sold`
--
ALTER TABLE `bike_sold`
  ADD PRIMARY KEY (`plate`) USING BTREE;

--
-- Index pour la table `billing`
--
ALTER TABLE `billing`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `identifier` (`identifier`) USING BTREE;

--
-- Index pour la table `blacklist`
--
ALTER TABLE `blacklist`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `boatdealer_boats`
--
ALTER TABLE `boatdealer_boats`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `boats`
--
ALTER TABLE `boats`
  ADD PRIMARY KEY (`model`) USING BTREE;

--
-- Index pour la table `boat_categories`
--
ALTER TABLE `boat_categories`
  ADD PRIMARY KEY (`name`) USING BTREE;

--
-- Index pour la table `bolos_list`
--
ALTER TABLE `bolos_list`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `cardealer_vehicles`
--
ALTER TABLE `cardealer_vehicles`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `characters`
--
ALTER TABLE `characters`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `clothes`
--
ALTER TABLE `clothes`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `datastore`
--
ALTER TABLE `datastore`
  ADD PRIMARY KEY (`name`) USING BTREE;

--
-- Index pour la table `datastore_data`
--
ALTER TABLE `datastore_data`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `index_datastore_data_name_owner` (`name`,`owner`) USING BTREE,
  ADD KEY `index_datastore_data_name` (`name`) USING BTREE;

--
-- Index pour la table `data_inventory`
--
ALTER TABLE `data_inventory`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plate` (`plate`);

--
-- Index pour la table `dpkeybinds`
--
ALTER TABLE `dpkeybinds`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `glovebox_inventory`
--
ALTER TABLE `glovebox_inventory`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plate` (`plate`);

--
-- Index pour la table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`name`) USING BTREE;

--
-- Index pour la table `iwaclothes`
--
ALTER TABLE `iwaclothes`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `job_grades`
--
ALTER TABLE `job_grades`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `licenses`
--
ALTER TABLE `licenses`
  ADD PRIMARY KEY (`type`) USING BTREE;

--
-- Index pour la table `meeta_vehicle_trunk`
--
ALTER TABLE `meeta_vehicle_trunk`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `open_car`
--
ALTER TABLE `open_car`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `identifier_value` (`identifier`,`value`) USING BTREE;

--
-- Index pour la table `org`
--
ALTER TABLE `org`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `orga_grades`
--
ALTER TABLE `orga_grades`
  ADD PRIMARY KEY (`id_grade`),
  ADD KEY `id_orga` (`id_orga`);

--
-- Index pour la table `orga_grade_perm`
--
ALTER TABLE `orga_grade_perm`
  ADD PRIMARY KEY (`id_grade_perm`),
  ADD KEY `id_grade` (`id_grade`);

--
-- Index pour la table `orga_liste`
--
ALTER TABLE `orga_liste`
  ADD PRIMARY KEY (`id_orga`);

--
-- Index pour la table `orga_membres`
--
ALTER TABLE `orga_membres`
  ADD PRIMARY KEY (`id_membre`),
  ADD KEY `id_grade` (`id_grade`);

--
-- Index pour la table `org_gradeorg`
--
ALTER TABLE `org_gradeorg`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `owned_boats`
--
ALTER TABLE `owned_boats`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `owned_properties`
--
ALTER TABLE `owned_properties`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `owned_vehicles`
--
ALTER TABLE `owned_vehicles`
  ADD PRIMARY KEY (`plate`);

--
-- Index pour la table `pawnshops`
--
ALTER TABLE `pawnshops`
  ADD UNIQUE KEY `id` (`id`);

--
-- Index pour la table `phone_app_chat`
--
ALTER TABLE `phone_app_chat`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_calls`
--
ALTER TABLE `phone_calls`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_messages`
--
ALTER TABLE `phone_messages`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `phone_users_contacts`
--
ALTER TABLE `phone_users_contacts`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `position_agricultures`
--
ALTER TABLE `position_agricultures`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `properties_access`
--
ALTER TABLE `properties_access`
  ADD PRIMARY KEY (`id_access`),
  ADD KEY `id_property` (`id_property`);

--
-- Index pour la table `properties_inventory`
--
ALTER TABLE `properties_inventory`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `properties_list`
--
ALTER TABLE `properties_list`
  ADD PRIMARY KEY (`id_property`),
  ADD UNIQUE KEY `property_name` (`property_name`),
  ADD UNIQUE KEY `property_pos` (`property_pos`),
  ADD UNIQUE KEY `garage_pos` (`garage_pos`),
  ADD KEY `jobs` (`jobs`);

--
-- Index pour la table `properties_vehicles`
--
ALTER TABLE `properties_vehicles`
  ADD PRIMARY KEY (`id_vehicle`),
  ADD KEY `id_property` (`id_property`);

--
-- Index pour la table `rented_bikes`
--
ALTER TABLE `rented_bikes`
  ADD PRIMARY KEY (`plate`) USING BTREE;

--
-- Index pour la table `rented_boats`
--
ALTER TABLE `rented_boats`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `rented_vehicles`
--
ALTER TABLE `rented_vehicles`
  ADD PRIMARY KEY (`plate`) USING BTREE;

--
-- Index pour la table `territories`
--
ALTER TABLE `territories`
  ADD PRIMARY KEY (`zone`);

--
-- Index pour la table `trucks`
--
ALTER TABLE `trucks`
  ADD PRIMARY KEY (`model`) USING BTREE;

--
-- Index pour la table `truck_categories`
--
ALTER TABLE `truck_categories`
  ADD PRIMARY KEY (`name`) USING BTREE;

--
-- Index pour la table `trunk_inventory`
--
ALTER TABLE `trunk_inventory`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plate` (`plate`);

--
-- Index pour la table `twitter_accounts`
--
ALTER TABLE `twitter_accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Index pour la table `twitter_likes`
--
ALTER TABLE `twitter_likes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_twitter_likes_twitter_accounts` (`authorId`),
  ADD KEY `FK_twitter_likes_twitter_tweets` (`tweetId`);

--
-- Index pour la table `twitter_tweets`
--
ALTER TABLE `twitter_tweets`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`identifier`) USING BTREE,
  ADD KEY `identifier_money_bank` (`identifier`,`money`,`bank`) USING BTREE;

--
-- Index pour la table `user_accessories`
--
ALTER TABLE `user_accessories`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user_accounts`
--
ALTER TABLE `user_accounts`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `user_contacts`
--
ALTER TABLE `user_contacts`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user_documents`
--
ALTER TABLE `user_documents`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user_hangard`
--
ALTER TABLE `user_hangard`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user_lastcharacter`
--
ALTER TABLE `user_lastcharacter`
  ADD PRIMARY KEY (`steamid`) USING BTREE;

--
-- Index pour la table `user_licenses`
--
ALTER TABLE `user_licenses`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `user_parkings`
--
ALTER TABLE `user_parkings`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user_settings`
--
ALTER TABLE `user_settings`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user_sim`
--
ALTER TABLE `user_sim`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user_tenue`
--
ALTER TABLE `user_tenue`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`model`) USING BTREE;

--
-- Index pour la table `vehicles_for_sale`
--
ALTER TABLE `vehicles_for_sale`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `vehicle_categories`
--
ALTER TABLE `vehicle_categories`
  ADD PRIMARY KEY (`name`) USING BTREE;

--
-- Index pour la table `vehicle_sold`
--
ALTER TABLE `vehicle_sold`
  ADD PRIMARY KEY (`plate`) USING BTREE;

--
-- Index pour la table `veh_km`
--
ALTER TABLE `veh_km`
  ADD PRIMARY KEY (`carplate`),
  ADD UNIQUE KEY `carplate` (`carplate`),
  ADD KEY `carplate_2` (`carplate`);

--
-- Index pour la table `warrants_list`
--
ALTER TABLE `warrants_list`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `wh_test`
--
ALTER TABLE `wh_test`
  ADD PRIMARY KEY (`identifier`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `addon_account_data`
--
ALTER TABLE `addon_account_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=125;

--
-- AUTO_INCREMENT pour la table `addon_inventory_items`
--
ALTER TABLE `addon_inventory_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `arrests_list`
--
ALTER TABLE `arrests_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `baninfo`
--
ALTER TABLE `baninfo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=713;

--
-- AUTO_INCREMENT pour la table `bank_transfer`
--
ALTER TABLE `bank_transfer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `bikedealer_vehicles`
--
ALTER TABLE `bikedealer_vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `billing`
--
ALTER TABLE `billing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `blacklist`
--
ALTER TABLE `blacklist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT pour la table `boatdealer_boats`
--
ALTER TABLE `boatdealer_boats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `bolos_list`
--
ALTER TABLE `bolos_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `cardealer_vehicles`
--
ALTER TABLE `cardealer_vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT pour la table `characters`
--
ALTER TABLE `characters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `clothes`
--
ALTER TABLE `clothes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `datastore_data`
--
ALTER TABLE `datastore_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;

--
-- AUTO_INCREMENT pour la table `data_inventory`
--
ALTER TABLE `data_inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `glovebox_inventory`
--
ALTER TABLE `glovebox_inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `iwaclothes`
--
ALTER TABLE `iwaclothes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `meeta_vehicle_trunk`
--
ALTER TABLE `meeta_vehicle_trunk`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `open_car`
--
ALTER TABLE `open_car`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1097;

--
-- AUTO_INCREMENT pour la table `orga_grades`
--
ALTER TABLE `orga_grades`
  MODIFY `id_grade` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `orga_grade_perm`
--
ALTER TABLE `orga_grade_perm`
  MODIFY `id_grade_perm` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `orga_liste`
--
ALTER TABLE `orga_liste`
  MODIFY `id_orga` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `orga_membres`
--
ALTER TABLE `orga_membres`
  MODIFY `id_membre` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `org_gradeorg`
--
ALTER TABLE `org_gradeorg`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;

--
-- AUTO_INCREMENT pour la table `owned_boats`
--
ALTER TABLE `owned_boats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `owned_properties`
--
ALTER TABLE `owned_properties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `pawnshops`
--
ALTER TABLE `pawnshops`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `phone_app_chat`
--
ALTER TABLE `phone_app_chat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT pour la table `phone_calls`
--
ALTER TABLE `phone_calls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=125;

--
-- AUTO_INCREMENT pour la table `phone_messages`
--
ALTER TABLE `phone_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=116;

--
-- AUTO_INCREMENT pour la table `phone_users_contacts`
--
ALTER TABLE `phone_users_contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `properties`
--
ALTER TABLE `properties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `properties_access`
--
ALTER TABLE `properties_access`
  MODIFY `id_access` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `properties_inventory`
--
ALTER TABLE `properties_inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `properties_list`
--
ALTER TABLE `properties_list`
  MODIFY `id_property` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `properties_vehicles`
--
ALTER TABLE `properties_vehicles`
  MODIFY `id_vehicle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT pour la table `rented_boats`
--
ALTER TABLE `rented_boats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `trunk_inventory`
--
ALTER TABLE `trunk_inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `twitter_accounts`
--
ALTER TABLE `twitter_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `twitter_likes`
--
ALTER TABLE `twitter_likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `twitter_tweets`
--
ALTER TABLE `twitter_tweets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=154;

--
-- AUTO_INCREMENT pour la table `user_accessories`
--
ALTER TABLE `user_accessories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `user_accounts`
--
ALTER TABLE `user_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=133;

--
-- AUTO_INCREMENT pour la table `user_contacts`
--
ALTER TABLE `user_contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `user_documents`
--
ALTER TABLE `user_documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `user_hangard`
--
ALTER TABLE `user_hangard`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `user_licenses`
--
ALTER TABLE `user_licenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `user_parkings`
--
ALTER TABLE `user_parkings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `user_sim`
--
ALTER TABLE `user_sim`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `user_tenue`
--
ALTER TABLE `user_tenue`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `vehicles_for_sale`
--
ALTER TABLE `vehicles_for_sale`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `warrants_list`
--
ALTER TABLE `warrants_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `orga_grades`
--
ALTER TABLE `orga_grades`
  ADD CONSTRAINT `orga_grades_ibfk_1` FOREIGN KEY (`id_orga`) REFERENCES `orga_liste` (`id_orga`);

--
-- Contraintes pour la table `orga_grade_perm`
--
ALTER TABLE `orga_grade_perm`
  ADD CONSTRAINT `orga_grade_perm_ibfk_1` FOREIGN KEY (`id_grade`) REFERENCES `orga_grades` (`id_grade`);

--
-- Contraintes pour la table `orga_membres`
--
ALTER TABLE `orga_membres`
  ADD CONSTRAINT `orga_membres_ibfk_1` FOREIGN KEY (`id_grade`) REFERENCES `orga_grades` (`id_grade`);

--
-- Contraintes pour la table `properties_access`
--
ALTER TABLE `properties_access`
  ADD CONSTRAINT `properties_access_ibfk_1` FOREIGN KEY (`id_property`) REFERENCES `properties_list` (`id_property`);

--
-- Contraintes pour la table `properties_vehicles`
--
ALTER TABLE `properties_vehicles`
  ADD CONSTRAINT `properties_vehicles_ibfk_1` FOREIGN KEY (`id_property`) REFERENCES `properties_list` (`id_property`);

--
-- Contraintes pour la table `twitter_likes`
--
ALTER TABLE `twitter_likes`
  ADD CONSTRAINT `FK_twitter_likes_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`),
  ADD CONSTRAINT `FK_twitter_likes_twitter_tweets` FOREIGN KEY (`tweetId`) REFERENCES `twitter_tweets` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
