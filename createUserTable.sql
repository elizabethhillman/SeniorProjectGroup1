CREATE SCHEMA `fitlife`;

CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `handle` varchar(45) NOT NULL,
  `bio` varchar(45) DEFAULT NULL,
  `followers` int DEFAULT '0',
  `following` int DEFAULT '0',
  PRIMARY KEY (`id`)
) 
