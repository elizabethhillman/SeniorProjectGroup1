--UPDATED 4/2/23
--exercises come from api now
--still added db cause limited in api requests
--run the api command getExercises in view/exercises.dart,
--then run the other commented out getExercises to store it all in the mysql table


--UPDATED 3/30/23
-- added database capability for storing food information b/w accounts
--only use with premade users, buggy with new accounts due to currentUser.id

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
---------------------------------------Exercise database
--step1 execute this
--this provides ability to store logged exercises between users
CREATE TABLE `userexerciselog` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `exercise_id` int NOT NULL,
  `muscle_group` varchar(255) DEFAULT NULL,
  `equipment` varchar(255) DEFAULT NULL,
  `workoutGif` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `target` varchar(255) DEFAULT NULL,
  `reps` int DEFAULT NULL,
  `sets` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--step2 after u grab the api from view/exercises getexercises(), create this table and store it all in here
--to do so, you have to go into the emulator, navigate to workouts, add an exercise,
 --and select anything from the dropdown menu, nd shud be good to go
CREATE TABLE `exerciseapi` (
  `id` int NOT NULL AUTO_INCREMENT,
  `muscle_group` varchar(255) DEFAULT NULL,
  `equipment` varchar(255) DEFAULT NULL,
  `workout_gif` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `target` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1325 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


----------------------------------------------------------------Food database
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
--UPDATED 3/30/23
--step 2 execute this to save food information to account
CREATE TABLE `userfoodlog` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `food_id` int NOT NULL,
  `foodName` varchar(255) DEFAULT NULL,
  `calorie` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `protein` int DEFAULT NULL,
  `carb` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--step 3 execuse these for test data
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
