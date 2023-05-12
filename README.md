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

### Steps
1. Open the project in Android Studios
2. Go to the pubspec.yaml file
3. Select "pub get" (this gets all of the dependencies)
4. Open the iOS and/or Android emulator
5. Run the project 

## Code Structure
- The android, ios and web directories are created by Flutter so that the application runs on these devices
- The lib directory is the source code for this project, broken down by a model-view-controller set up
  - The files within model describe each objects attributes and define methods to connect/interact with the database 
  - The files within view illustrate the UI pages
  - The files within controller are action classes that will interact with the database to change records based on user inputs  
  - The main.dart file is the runnable file

### model
- Exercises.dart: Defines the attributes of an exercise object
- Food.dart: Defines the attributes of a food object
- Post.dart: Defines the attributes of a post object
- User.dart: Defines the attributes of a user object
- post_database.dart: Defines methods to insert/delete/update/select from the post table in the database
- userWeight.dart: Defines the attributes of a userWeight object
- user_database.dart: Initializes the settings for connecting to the database and defines methods to insert/delete/update/select from the user table in the database

### view
- Feed.dart: Illustrates the social media feed page, showing users their own + who they follow uploaded pictures
- Results.dart: Illustrates the search page that shows the resulting food items being searched for, based on what is in the database
- account.dart: Illustrates the user's account information that is within the database
- calorie.dart: Illustrates the user's calorie log + updates this data in the database
- exercises.dart: Illustrates the excerise page filled with exercises matching the user selected muscle group for users to look through
- favoriteworkouts.dart: Illustrates the favorite workout page, filled with the logged in user's favorited exercises
- homePage.dart: Illustrates the home page
- searchedFriend.dart: Illustrates the social media page of a "searched for user", essentially a user that is not the one logged in
- searchFriends.dart: Illustrates the search page that shows the resulting non-trainer user being searched for, based on what is in the database
- searchTrainers.dart: Illustrates the search page that shows the resulting trainer user being searched for, based on what is in the database
- socialMedia.dart: Illustrates the social media page for the logged in user, with their follower/following count, profile pic, bio, and photos they have uploaded
- workouts.dart: Illustrates the workout page that the logged in user has added to their workout plan
- image/
  - blankAvatar.png: The basic profile picture if a user does not upload their own
- Widgets/
  - ExerciseWidgets.dart: Creates a widget for each exercise on the exercises.dart page, with the exercise's specific details for the user to scroll through
  - FoodWidgets.dart: Creates a widget for each food item on the calorie.dart page, with the food's specific nutritional value
  - HomePageWidgets.dart: Creates a widget for the weight progress generated graph on the home page, with each inputted weight update as an element of the graph
  - WorkoutWidgets.dart: Creates a widget for each saved workout on the workout.dart page, with the workout's specific details 

### controller
- EditExerciseDialog.dart: Allows a user to change their reps/set number of a workout and update that in the database
- EditFoodDialog.dart: Allows a user to change their quantity size of a food item and update that in the database
- addExercise.dart: Allows a user to add a specific workout to the database they want to add to their workout plan
- createAccount.dart: Allows a user to create an account to the database
- createPost.dart: Allows a user to create a new post to add to the database with an image from their device's gallery along with a caption
- editCalorie.dart: ???????????????????????
- enterWeight.dart: Allows a user to input their weight for the day and add that to the database
- updateAccount.dart: Allows a user to change their account information in the database
- updateCaption.dart: Allows a user to change a caption in the database for any of their uploaded pictures
- updateComment.dart: Allows a user to add/remove their comment on anyone's uploaded picture, save that information in the database and be directed back to the feed page 
- updateCommentFromSocial.dart: Allows a user to add/remove their comment on their own uploaded picture, save that information in the database and be directed back to their social media page
