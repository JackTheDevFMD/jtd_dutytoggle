USE `es_extended`;

CREATE TABLE `jtd_storage` (
    `id` int NOT NULL AUTO_INCREMENT,
    `identifier` varchar(60) NOT NULL,
    `jtdgrade` INT NOT NULL,

    PRIMARY KEY (`id`)
);