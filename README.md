# FitLife
- [Build/Setup Instructions](#build/setup-instructions)
- [Code Structure](#code-structure)

## Build/Setup Instructions
- Project Code
  - Flutter v. 3.7.5 (Dart and DevTools are typically downloaded after installing Flutter)
  - Dart v. 2.19.2
  - DevTools v 2.20.1 
  - Android Studios 

- Database
  - MySQL v. 8.0.32^
  - MySQL Workbench v 8.0.31^ (Mac M1 Venture requires 8.0.31)
  - Create the database tables from "allTables.sql" 

- Emulators
  - XCode (iOS)
  - CocoaPods (iOS)

- Steps
  1. Open the project in Android Studios
  2. Go to the pubspec.yaml file
  3. Select "pub get"
  4. Open the iOS and/or Android emulator
  5. Run the project 

## Code Structure
- The android, ios and web directories are created by Flutter so that the application runs on these devices
- The lib directory is the source code for this project, broken down by a model-view-controller set up
  - The files within model describe each objects attributes and connect to the database 
  - The files within view illustrate the UI pages
  - The files within controller are action classes that will interact with the database to change records based on user inputs  
  - The main.dart file is the runnable file

- model
  - Exercises.dart:
  - Food.dart:
  - Post.dart:
  - User.dart:
  - post_database.dart:
  - userWeight.dart:
  - user_database.dart:

- view
  - Feed.dart:
  - Results.dart:
  - account.dart:
  - calorie.dart:
  - comment.dart:
  - commentFromSocial.dart:
  - exercises.dart:
  - favoriteworkouts.dart:
  - homePage.dart:
  - searchedFriend.dart:
  - socialMedia.dart:
  - workouts.dart:
  - /image/blankAvatar.png:
  - /Widgets/ExerciseWidgets.dart:
  - /Widgets/FoodWidgets.dart:
  - /Widgets/HomePageWidgets.dart:
  - /Widgets/WorkoutWidgets.dart:

- controller
  - EditExerciseDialog.dart:
  - EditFoodDialog.dart:
  - addExercise.dart:
  - createAccount.dart:
  - createPost.dart:
  - editCalorie.dart:
  - enterWeight.dart:
  - searchFriends.dart:
  - searchTrainers.dart:
  - updateAccount.dart:
  - updateCaption.dart
