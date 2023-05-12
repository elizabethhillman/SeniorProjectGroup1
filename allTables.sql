
CREATE SCHEMA `fitlife`;

--TABLE FOR USERS
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `handle` varchar(45) NOT NULL,
  `bio` varchar(45) NOT NULL,
  `followers` varchar(500) NOT NULL,
  `following` varchar(500) NOT NULL,
  `profilePic` varchar(500) DEFAULT NULL,
  `trainer` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

-- TABLE FOR SOCIAL MEDIA POSTS
CREATE TABLE `posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `handle` varchar(45) NOT NULL,
  `imageURL` varchar(500) NOT NULL,
  `caption` varchar(45) DEFAULT NULL,
  `likes` int DEFAULT NULL,
  `whoLiked` varchar(100) DEFAULT NULL,
  `comments` varchar(500) DEFAULT NULL,
  `userTrainer` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

--TABLE TO STORE USER SAVED EXERCISES
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
  `favorited` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


--TABLE TO STORE EXERCISES IF API REQUESTS ARE EXHAUSTED
CREATE TABLE `exerciseapi` (
  `id` int NOT NULL AUTO_INCREMENT,
  `muscle_group` varchar(255) DEFAULT NULL,
  `equipment` varchar(255) DEFAULT NULL,
  `workout_gif` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `target` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64877 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--TABLE TO STORE USER SAVED FOOD
CREATE TABLE `userfoodlog` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `food_id` int NOT NULL,
  `foodName` varchar(255) DEFAULT NULL,
  `calorie` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `carbs` int DEFAULT NULL,
  `protein` int DEFAULT NULL,
  `fat` int DEFAULT NULL,
  `grams` double DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--TABLE TO STORE USER WEIGHT
CREATE TABLE `userweight` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `user_weight` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
