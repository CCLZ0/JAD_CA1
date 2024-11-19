CREATE TABLE IF NOT EXISTS `user` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`email` varchar(45) NOT NULL UNIQUE,
	`name` varchar(45) NOT NULL,
	`password` varchar(255) NOT NULL,
	`role` varchar(45) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `service` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`category_id` int NOT NULL,
	`service_name` varchar(45) NOT NULL,
	`description` varchar(255) NOT NULL DEFAULT 'NULL',
	`price` decimal(10,2) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `service_category` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`category_name` varchar(45) NOT NULL,
	`description` varchar(255) NOT NULL DEFAULT 'NULL',
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `booking` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`member_id` int NOT NULL,
	`service_id` int NOT NULL,
	`booking_date` datetime NOT NULL,
	`remarks` varchar(255) NOT NULL DEFAULT 'NULL',
	`status` int NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `status` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`status_name` varchar(45) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `Feedback` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`memberId` int NOT NULL,
	`service_id` int NOT NULL,
	`booking_id` int NOT NULL,
	`description` text,
	`suggestion` text NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `cart` (
	`id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`user_id` int NOT NULL,
	`service_id` int NOT NULL,
	`booking_time` datetime NOT NULL,
	`price` int NOT NULL,
	`remarks` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
);


ALTER TABLE `service` ADD CONSTRAINT `service_fk1` FOREIGN KEY (`category_id`) REFERENCES `service_category`(`id`);

ALTER TABLE `booking` ADD CONSTRAINT `booking_fk5` FOREIGN KEY (`status`) REFERENCES `status`(`id`);

ALTER TABLE `Feedback` ADD CONSTRAINT `Feedback_fk1` FOREIGN KEY (`memberId`) REFERENCES `booking`(`member_id`);

ALTER TABLE `Feedback` ADD CONSTRAINT `Feedback_fk2` FOREIGN KEY (`service_id`) REFERENCES `booking`(`service_id`);

ALTER TABLE `Feedback` ADD CONSTRAINT `Feedback_fk3` FOREIGN KEY (`booking_id`) REFERENCES `booking`(`id`);
ALTER TABLE `cart` ADD CONSTRAINT `cart_fk1` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`);

ALTER TABLE `cart` ADD CONSTRAINT `cart_fk2` FOREIGN KEY (`service_id`) REFERENCES `service`(`id`);

ALTER TABLE `cart` ADD CONSTRAINT `cart_fk4` FOREIGN KEY (`price`) REFERENCES `service`(`price`);