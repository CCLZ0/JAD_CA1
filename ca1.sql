CREATE TABLE IF NOT EXISTS `user` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`email` varchar(45) NOT NULL UNIQUE,
	`name` varchar(45) NOT NULL,
	`password` varchar(45) NOT NULL,
	`role` varchar(45) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `service` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`category_id` int NOT NULL,
	`service_name` varchar(45) NOT NULL,
	`description` varchar(45) NOT NULL DEFAULT 'NULL',
	`price` decimal(10,2) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `service_category` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`category_name` varchar(45) NOT NULL,
	`description` varchar(45) NOT NULL DEFAULT 'NULL',
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `booking` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`member_id` int NOT NULL,
	`service_id` int NOT NULL,
	`booking_date` datetime NOT NULL,
	`remarks` varchar(45) NOT NULL DEFAULT 'NULL',
	`status` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `status` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`status_name` varchar(45) NOT NULL,
	PRIMARY KEY (`id`)
);


ALTER TABLE `service` ADD CONSTRAINT `service_fk1` FOREIGN KEY (`category_id`) REFERENCES `service_category`(`id`);

ALTER TABLE `booking` ADD CONSTRAINT `booking_fk1` FOREIGN KEY (`member_id`) REFERENCES `user`(`id`);

ALTER TABLE `booking` ADD CONSTRAINT `booking_fk2` FOREIGN KEY (`service_id`) REFERENCES `service`(`id`);

ALTER TABLE `booking` ADD CONSTRAINT `booking_fk5` FOREIGN KEY (`status`) REFERENCES `status`(`id`);
