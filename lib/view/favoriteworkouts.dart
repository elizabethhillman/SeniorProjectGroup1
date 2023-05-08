import 'package:fitlife/model/Exercises.dart';
import 'package:fitlife/view/Widgets/WorkoutWidgets.dart';
import 'package:flutter/material.dart';
import 'package:fitlife/view/calorie.dart';
import 'package:fitlife/view/account.dart';
import 'package:fitlife/view/socialMedia.dart';
import 'package:fitlife/view/homePage.dart';
import 'package:flutter/scheduler.dart';
import 'package:mysql1/mysql1.dart';

import '../controller/EditExerciseDialog.dart';
import '../model/User.dart';
import '../model/user_database.dart';
import 'exercises.dart';

class favoriteWorkouts extends StatefulWidget {
  final Exercise? updatedExercise;

  const favoriteWorkouts({Key? key, this.updatedExercise}) : super(key: key);

  @override
  State<favoriteWorkouts> createState() => _favoriteWorkoutsState();
}

class _favoriteWorkoutsState extends State<favoriteWorkouts> {
  final List<Exercise> _selectedUserExerciseListFromDB =[];

  @override
  void initState() {
    super.initState();
    _getSelectedExercisesFromDB();
  }


  Future<void> deleteRowFromTable(int index) async {
    try {
      Database db = Database();
      var conn = await db.getSettings();
      var id = await conn.query("SELECT * from fitlife.userexerciselog");
      var result = await conn.query(
          'DELETE FROM fitlife.userexerciselog WHERE id = ?',
          [_selectedUserExerciseListFromDB[index].exerciseId]);
      await conn.close();
    } catch (e) {
      print('Error while deleting row: $e');
    }
  }

  Future<void> updateRowInTable(Exercise updatedExercise) async {
    try {
      Database db = Database();
      var conn = await db.getSettings();
      var id = await conn.query("SELECT * from fitlife.userexerciselog");
      var result =  await conn.query(
          'UPDATE fitlife.userexerciselog SET reps = ?, sets = ? WHERE id = ?',
          [
            updatedExercise.reps,
            updatedExercise.sets,
            updatedExercise.exerciseId
          ]);
    } catch (e) {
      print('Error while updating row: $e');
    }
  }


  void _handleDeleteTap(int index) async {
    await deleteRowFromTable(index);
    setState(() {
      _selectedUserExerciseListFromDB.removeAt(index);
    });
  }

  void _handleEditTap(int index) async {
    final updatedExercise = await showDialog<Exercise>(
      context: context,
      builder: (context) {
        return EditExerciseDialog(
          exercise: _selectedUserExerciseListFromDB[index],
        );
      },
    );

    if (updatedExercise != null) {
      await updateRowInTable(updatedExercise);
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          _selectedUserExerciseListFromDB[index] = updatedExercise;
        });
      });
    }
  }

  Future<void> updateToggleFavorite(Exercise exercise) async {
    try {
      Database db = Database();
      var conn = await db.getSettings();
      var id = await conn.query(
          "SELECT * from fitlife.userexerciselog WHERE user_id = ${currentUser.id}");
      var result =  await conn.query(
          'UPDATE fitlife.userexerciselog SET favorited = ? WHERE workoutGif = ?',
          [
            exercise.isPressed,
            exercise.workoutGif
          ]);
    } catch (e) {
      print('Error while updating row: $e');
    }
  }
  Future<void> _getSelectedExercisesFromDB() async {
    //idk how to add to model
    try {
      Database db = Database();
      var conn = await db.getSettings();
      var id = await conn.query(
          "SELECT * from fitlife.userexerciselog WHERE user_id = ${currentUser.id}");
      // loop through the list of foods and insert each one

      var result = await conn.query(
          'SELECT id, user_id, exercise_id, muscle_group, equipment, workoutGif, name, target, reps, sets, favorited FROM fitlife.userexerciselog WHERE user_id = ${currentUser.id} AND favorited = ?',
      [1]
      );
      setState(() {
        for (var row in result) {
          {
            _selectedUserExerciseListFromDB
                .add(Exercise(
              row[0],
              row[3].toString(),
              row[4].toString(),
              row[5].toString(),//workoutgif
              row[6].toString(),
              row[7].toString(),
              row[8],
              row[9],
              isPressed: true
            ));
          }
        }
      });
      await conn.close();
    } catch (e) {
      print("Error Occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[200],
        leading: IconButton(
          icon: const Icon(
            Icons.home,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
        title: const Text(
          "Favorite Workouts",
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.restaurant),
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Calorie()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.group),
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SocialMedia()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Accounts()));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 15,),
          if (_selectedUserExerciseListFromDB.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Column(
                children: [
                  Text(
                    "No favorite workouts available",
                    style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.grey[700]
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Tap the heart icon to add a workout to favorites",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600]
                    ),
                  ),
                ],
              ),
            ),
          Row(  //temporary, replace with exercises that users select from database
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount:
              _selectedUserExerciseListFromDB.length, //list after selected
              itemBuilder: (context, index) {

                return WorkoutTile(
                  // add current food's calorie count to totalCalories
                  exercise: _selectedUserExerciseListFromDB[index],
                  index: index+1,
                  editTap: (context) => _handleEditTap(index),
                  deleteTap: (context) => _handleDeleteTap(index),
                  updateFavoriteStatus: (exercise) => updateToggleFavorite(_selectedUserExerciseListFromDB[index]),
                  containerColor: Colors.red[100],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}