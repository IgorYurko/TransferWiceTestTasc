CREATE DATABASE IF NOT EXISTS `transwerwise`;
USE `transwerwise`;

CREATE TABLE IF NOT EXISTS `banks` (
  `id` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `banks` (`id`, `name`) VALUES
	('59117feb85e4c06e5c6ccbc7', 'German Bank'),
	('59117feb85e4c06e5c6ccbc9', 'Indian Bank'),
	('59117feb85e4c06e5c6ccbcc', 'Mexican Bank'),
	('59117feb85e4c06e5c6ccbce', 'US Bank'),
	('59117feb85e4c06e5c6ccbd0', 'UK Bank');

CREATE TABLE IF NOT EXISTS `bank_account` (
  `id` varchar(50) NOT NULL,
  `accountNumber` bigint(20) NOT NULL,
  `accountName` varchar(50) NOT NULL,
  `bankId` varchar(50) NOT NULL,
  `currency` enum('INR','EUR','GBP','MXN','USD') NOT NULL,
  `balance` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_bank_account_banks` (`bankId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `bank_account` (`id`, `accountNumber`, `accountName`, `bankId`, `currency`, `balance`) VALUES
	('59117feb85e4c06e5c6ccbc8', 5400753077, 'TransferWise Ltd', '59117feb85e4c06e5c6ccbc7', 'EUR', 10000000),
	('59117feb85e4c06e5c6ccbca', 2588320325, 'TransferWise Ltd', '59117feb85e4c06e5c6ccbc9', 'INR', 10000000),
	('59117feb85e4c06e5c6ccbcb', 8646173305, 'TransferWise Ltd', '59117feb85e4c06e5c6ccbc9', 'GBP', 10000000),
	('59117feb85e4c06e5c6ccbcd', 4147554325, 'TransferWise Ltd', '59117feb85e4c06e5c6ccbcc', 'MXN', 10000011),
	('59117feb85e4c06e5c6ccbcf', 8736061715, 'TransferWise Ltd', '59117feb85e4c06e5c6ccbce', 'USD', 10000000),
	('59117feb85e4c06e5c6ccbd1', 4735606728, 'TransferWise Ltd', '59117feb85e4c06e5c6ccbd0', 'GBP', 10000005),
	('59117feb85e4c06e5c6ccbd2', 7582667774, 'Customer 1', '59117feb85e4c06e5c6ccbcc', 'MXN', 0),
	('59117feb85e4c06e5c6ccbd4', 8604370405, 'Customer 2', '59117feb85e4c06e5c6ccbc7', 'EUR', 0),
	('59117feb85e4c06e5c6ccbd6', 5830831356, 'Customer 3', '59117feb85e4c06e5c6ccbce', 'USD', 0),
	('59117feb85e4c06e5c6ccbd8', 4023868756, 'Customer 4', '59117feb85e4c06e5c6ccbcc', 'MXN', 0),
	('59117feb85e4c06e5c6ccbda', 7081226413, 'Customer 5', '59117feb85e4c06e5c6ccbc7', 'EUR', 0),
	('59117feb85e4c06e5c6ccbdc', 3615528161, 'Customer 6', '59117feb85e4c06e5c6ccbce', 'USD', 0),
	('59117feb85e4c06e5c6ccbde', 5312341740, 'Customer 7', '59117feb85e4c06e5c6ccbc9', 'GBP', 0),
	('59117feb85e4c06e5c6ccbe0', 6624264661, 'Customer 8', '59117feb85e4c06e5c6ccbc7', 'EUR', 0),
	('59117feb85e4c06e5c6ccbe2', 1133611552, 'Customer 9', '59117feb85e4c06e5c6ccbc9', 'GBP', 0),
	('59117feb85e4c06e5c6ccbe4', 8212443024, 'Customer 10', '59117feb85e4c06e5c6ccbc9', 'INR', 0),
	('59117feb85e4c06e5c6ccbe6', 7842778302, 'Customer 11', '59117feb85e4c06e5c6ccbce', 'USD', 0),
	('59117feb85e4c06e5c6ccbe8', 35473770, 'Customer 12', '59117feb85e4c06e5c6ccbce', 'USD', 0),
	('59117feb85e4c06e5c6ccbea', 877770883, 'Customer 13', '59117feb85e4c06e5c6ccbc9', 'INR', 0),
	('59117feb85e4c06e5c6ccbec', 3421386710, 'Customer 14', '59117feb85e4c06e5c6ccbc7', 'EUR', 0),
	('59117feb85e4c06e5c6ccbee', 880813478, 'Customer 15', '59117feb85e4c06e5c6ccbcc', 'MXN', 0),
	('59117feb85e4c06e5c6ccbf0', 7658325422, 'Customer 16', '59117feb85e4c06e5c6ccbce', 'USD', 0),
	('59117feb85e4c06e5c6ccbf2', 4361361881, 'Customer 17', '59117feb85e4c06e5c6ccbcc', 'MXN', 0),
	('59117feb85e4c06e5c6ccbf4', 332006882, 'Customer 18', '59117feb85e4c06e5c6ccbc7', 'EUR', 0),
	('59117feb85e4c06e5c6ccbf6', 6631763424, 'Customer 19', '59117feb85e4c06e5c6ccbc7', 'EUR', 0),
	('59117feb85e4c06e5c6ccbf8', 2243822517, 'Customer 20', '59117feb85e4c06e5c6ccbc7', 'EUR', 0);

CREATE TABLE IF NOT EXISTS `payment` (
  `id` varchar(50) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `sourceCurrency` enum('INR','EUR','GBP','MXN','USD') NOT NULL,
  `targetCurrency` enum('INR','EUR','GBP','MXN','USD') NOT NULL,
  `recipientBankId` varchar(50) NOT NULL,
  `iban` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_payment_banks` (`recipientBankId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `payment` (`id`, `amount`, `sourceCurrency`, `targetCurrency`, `recipientBankId`, `iban`, `created`) VALUES
	('59117feb85e4c06e5c6ccbd3', 168.92, 'EUR', 'MXN', '59117feb85e4c06e5c6ccbcc', 7582667774, '2017-05-08 21:17:02'),
	('59117feb85e4c06e5c6ccbd5', 5.51, 'INR', 'EUR', '59117feb85e4c06e5c6ccbc7', 8604370405, '2017-05-08 21:18:02'),
	('59117feb85e4c06e5c6ccbd7', 80676.80, 'MXN', 'USD', '59117feb85e4c06e5c6ccbce', 5830831356, '2017-05-08 21:19:12'),
	('59117feb85e4c06e5c6ccbd9', 33.66, 'USD', 'MXN', '59117feb85e4c06e5c6ccbcc', 4023868756, '2017-05-08 21:20:14'),
	('59117feb85e4c06e5c6ccbdb', 46.38, 'GBP', 'EUR', '59117feb85e4c06e5c6ccbc7', 7081226413, '2017-05-08 21:21:02'),
	('59117feb85e4c06e5c6ccbdd', 882.31, 'GBP', 'USD', '59117feb85e4c06e5c6ccbce', 3615528161, '2017-05-08 21:21:51'),
	('59117feb85e4c06e5c6ccbdf', 67508.90, 'INR', 'GBP', '59117feb85e4c06e5c6ccbc9', 5312341740, '2017-05-08 21:22:48'),
	('59117feb85e4c06e5c6ccbe1', 62.02, 'USD', 'EUR', '59117feb85e4c06e5c6ccbc7', 6624264661, '2017-05-08 21:23:43'),
	('59117feb85e4c06e5c6ccbe3', 47.61, 'INR', 'GBP', '59117feb85e4c06e5c6ccbc9', 1133611552, '2017-05-08 21:24:27'),
	('59117feb85e4c06e5c6ccbe5', 22.00, 'EUR', 'INR', '59117feb85e4c06e5c6ccbc9', 8212443024, '2017-05-08 21:25:28'),
	('59117feb85e4c06e5c6ccbe7', 74926.74, 'INR', 'USD', '59117feb85e4c06e5c6ccbce', 7842778302, '2017-05-08 21:27:31'),
	('59117feb85e4c06e5c6ccbe9', 438.75, 'GBP', 'USD', '59117feb85e4c06e5c6ccbce', 35473770, '2017-05-08 21:28:17'),
	('59117feb85e4c06e5c6ccbeb', 28.01, 'EUR', 'INR', '59117feb85e4c06e5c6ccbc9', 877770883, '2017-05-08 21:29:16'),
	('59117feb85e4c06e5c6ccbed', 77.82, 'GBP', 'EUR', '59117feb85e4c06e5c6ccbc7', 3421386710, '2017-05-08 21:30:17'),
	('59117feb85e4c06e5c6ccbef', 97.30, 'GBP', 'MXN', '59117feb85e4c06e5c6ccbcc', 880813478, '2017-05-08 21:31:06'),
	('59117feb85e4c06e5c6ccbf1', 45793.07, 'MXN', 'USD', '59117feb85e4c06e5c6ccbce', 7658325422, '2017-05-08 21:32:09'),
	('59117feb85e4c06e5c6ccbf3', 21.18, 'USD', 'MXN', '59117feb85e4c06e5c6ccbcc', 4361361881, '2017-05-08 21:32:56'),
	('59117feb85e4c06e5c6ccbf5', 31329.10, 'INR', 'EUR', '59117feb85e4c06e5c6ccbc7', 332006882, '2017-05-08 21:33:43'),
	('59117feb85e4c06e5c6ccbf7', 78.50, 'INR', 'EUR', '59117feb85e4c06e5c6ccbc7', 6631763424, '2017-05-08 21:34:33'),
	('59117feb85e4c06e5c6ccbf9', 653.64, 'MXN', 'EUR', '59117feb85e4c06e5c6ccbc7', 2243822517, '2017-05-08 21:35:32');

CREATE TABLE `transfer_wice_acounts` (
	`accountNumber` BIGINT(20) NOT NULL,
	`accountName` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`name` VARCHAR(50) NOT NULL COLLATE 'utf8_general_ci',
	`currency` ENUM('INR','EUR','GBP','MXN','USD') NOT NULL COLLATE 'utf8_general_ci',
	`balance` BIGINT(20) NOT NULL
) ENGINE=MyISAM;

DROP TABLE IF EXISTS `transfer_wice_acounts`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `transfer_wice_acounts` AS select `ba`.`accountNumber` AS `accountNumber`,`ba`.`accountName` AS `accountName`,`b`.`name` AS `name`,`ba`.`currency` AS `currency`,`ba`.`balance` AS `balance` from (`bank_account` `ba` join `banks` `b` on((`ba`.`bankId` = `b`.`id`))) where (`ba`.`accountName` = 'TransferWise Ltd');