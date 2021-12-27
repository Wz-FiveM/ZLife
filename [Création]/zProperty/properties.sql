SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

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

ALTER TABLE `properties_list`
  ADD PRIMARY KEY (`id_property`),
  ADD UNIQUE KEY `property_name` (`property_name`),
  ADD UNIQUE KEY `property_pos` (`property_pos`),
  ADD UNIQUE KEY `garage_pos` (`garage_pos`),
  ADD KEY `jobs` (`jobs`);

ALTER TABLE `properties_list`
  MODIFY `id_property` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;


CREATE TABLE `properties_access` (
  `id_access` int(11) NOT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `id_property` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `properties_access`
  ADD PRIMARY KEY (`id_access`),
  ADD KEY `id_property` (`id_property`);

ALTER TABLE `properties_access`
  MODIFY `id_access` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;


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

ALTER TABLE `properties_vehicles`
  ADD PRIMARY KEY (`id_vehicle`),
  ADD KEY `id_property` (`id_property`);

ALTER TABLE `properties_vehicles`
  MODIFY `id_vehicle` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

ALTER TABLE `properties_access`
  ADD CONSTRAINT `properties_access_ibfk_1` FOREIGN KEY (`id_property`) REFERENCES `properties_list` (`id_property`);
COMMIT;

ALTER TABLE `properties_vehicles`
  ADD CONSTRAINT `properties_vehicles_ibfk_1` FOREIGN KEY (`id_property`) REFERENCES `properties_list` (`id_property`);
COMMIT;

CREATE TABLE `data_inventory` (
  `id` int(11) NOT NULL,
  `plate` varchar(50) NOT NULL,
  `data` text NOT NULL,
  `owned` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `data_inventory`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plate` (`plate`);

ALTER TABLE `data_inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;