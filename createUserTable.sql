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
-------------Exercise database
--step1 execute this
CREATE TABLE `exercises` (
  `id` int NOT NULL AUTO_INCREMENT,
  `muscle_group` varchar(255) NOT NULL,
  `workout` varchar(255) NOT NULL,
  `workout_gif` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--step 2 execute these for test data
INSERT INTO `exercises` (`id`,`muscle_group`,`workout`,`workout_gif`) VALUES (1,'Chest','Bench Press','https://www.inspireusafoundation.org/wp-content/uploads/2022/04/barbell-bench-press.gif');
INSERT INTO `exercises` (`id`,`muscle_group`,`workout`,`workout_gif`) VALUES (2,'Chest','Push Ups','https://homeworkouts.org/wp-content/uploads/anim-push-ups.gif');
INSERT INTO `exercises` (`id`,`muscle_group`,`workout`,`workout_gif`) VALUES (3,'Chest','Incline Bench Press','https://www.inspireusafoundation.org/wp-content/uploads/2022/04/barbell-bench-press.gif');
INSERT INTO `exercises` (`id`,`muscle_group`,`workout`,`workout_gif`) VALUES (4,'Chest','Decline Bench Press','https://www.inspireusafoundation.org/wp-content/uploads/2022/04/barbell-bench-press.gif');
INSERT INTO `exercises` (`id`,`muscle_group`,`workout`,`workout_gif`) VALUES (5,'Back','Pull Ups','https://www.inspireusafoundation.org/wp-content/uploads/2022/04/barbell-bench-press.gif');
INSERT INTO `exercises` (`id`,`muscle_group`,`workout`,`workout_gif`) VALUES (6,'Shoulders','Shoulder Press','https://www.inspireusafoundation.org/wp-content/uploads/2022/04/barbell-bench-press.gif');
INSERT INTO `exercises` (`id`,`muscle_group`,`workout`,`workout_gif`) VALUES (7,'Biceps','Bicep Curl','https://www.inspireusafoundation.org/wp-content/uploads/2022/04/barbell-bench-press.gif');
INSERT INTO `exercises` (`id`,`muscle_group`,`workout`,`workout_gif`) VALUES (8,'Triceps','Tricep Extension ','https://www.inspireusafoundation.org/wp-content/uploads/2022/04/barbell-bench-press.gif');
INSERT INTO `exercises` (`id`,`muscle_group`,`workout`,`workout_gif`) VALUES (9,'Legs ',' Squat ','https://www.inspireusafoundation.org/wp-content/uploads/2022/04/barbell-bench-press.gif');
INSERT INTO `exercises` (`id`,`muscle_group`,`workout`,`workout_gif`) VALUES (10,'Abs','Crunch','https://www.inspireusafoundation.org/wp-content/uploads/2022/04/barbell-bench-press.gif');
--
-------------------Food database
--step 1 execute this
CREATE TABLE `food` (
  `id` int NOT NULL AUTO_INCREMENT,
  `foodName` varchar(255) NOT NULL,
  `calorie` int NOT NULL,
  `quantity` int NOT NULL,
  `protein` int DEFAULT '0',
  `carbs` int DEFAULT '0',
  `fat` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
--step 2 execuse these for test data
INSERT INTO `food` (`id`,`foodName`,`calorie`,`quantity`,`protein`,`carbs`,`fat`) VALUES (1,'Banana',89,0,0,0,0);
INSERT INTO `food` (`id`,`foodName`,`calorie`,`quantity`,`protein`,`carbs`,`fat`) VALUES (2,'Orange',47,0,0,0,0);
INSERT INTO `food` (`id`,`foodName`,`calorie`,`quantity`,`protein`,`carbs`,`fat`) VALUES (3,'Pear',57,0,0,0,0);
INSERT INTO `food` (`id`,`foodName`,`calorie`,`quantity`,`protein`,`carbs`,`fat`) VALUES (4,'Pineapple',82,0,0,0,0);
INSERT INTO `food` (`id`,`foodName`,`calorie`,`quantity`,`protein`,`carbs`,`fat`) VALUES (5,'Mango',135,0,0,0,0);
INSERT INTO `food` (`id`,`foodName`,`calorie`,`quantity`,`protein`,`carbs`,`fat`) VALUES (6,'Grapes',62,0,0,0,0);
INSERT INTO `food` (`id`,`foodName`,`calorie`,`quantity`,`protein`,`carbs`,`fat`) VALUES (7,'Apple',95,0,0,0,0);
INSERT INTO `food` (`id`,`foodName`,`calorie`,`quantity`,`protein`,`carbs`,`fat`) VALUES (8,'Blueberries',84,0,0,0,0);
INSERT INTO `food` (`id`,`foodName`,`calorie`,`quantity`,`protein`,`carbs`,`fat`) VALUES (9,'Strawberries',49,0,0,0,0);
INSERT INTO `food` (`id`,`foodName`,`calorie`,`quantity`,`protein`,`carbs`,`fat`) VALUES (10,'Raspberries',52,0,0,0,0);
INSERT INTO `food` (`id`,`foodName`,`calorie`,`quantity`,`protein`,`carbs`,`fat`) VALUES (11,'Watermelon',30,0,0,0,0);
INSERT INTO `food` (`id`,`foodName`,`calorie`,`quantity`,`protein`,`carbs`,`fat`) VALUES (12,'Peaches',59,0,0,0,0);
INSERT INTO `food` (`id`,`foodName`,`calorie`,`quantity`,`protein`,`carbs`,`fat`) VALUES (13,'Kiwi',61,0,0,0,0);
INSERT INTO `food` (`id`,`foodName`,`calorie`,`quantity`,`protein`,`carbs`,`fat`) VALUES (14,'Pomegranate',83,0,0,0,0);
INSERT INTO `food` (`id`,`foodName`,`calorie`,`quantity`,`protein`,`carbs`,`fat`) VALUES (15,'Cherries',77,0,0,0,0);
INSERT INTO `food` (`id`,`foodName`,`calorie`,`quantity`,`protein`,`carbs`,`fat`) VALUES (16,'Plums',46,0,0,0,0);
INSERT INTO `food` (`id`,`foodName`,`calorie`,`quantity`,`protein`,`carbs`,`fat`) VALUES (17,'Cantaloupe',54,0,0,0,0);
INSERT INTO `food` (`id`,`foodName`,`calorie`,`quantity`,`protein`,`carbs`,`fat`) VALUES (18,'Honeydew melon',64,0,0,0,0);
INSERT INTO `food` (`id`,`foodName`,`calorie`,`quantity`,`protein`,`carbs`,`fat`) VALUES (19,'Grapefruit',52,0,0,0,0);
INSERT INTO `food` (`id`,`foodName`,`calorie`,`quantity`,`protein`,`carbs`,`fat`) VALUES (20,'Pineapple slices',42,0,0,0,0);
