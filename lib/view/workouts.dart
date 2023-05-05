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

class MyWorkouts extends StatefulWidget {
  final Exercise? updatedExercise;

  const MyWorkouts({Key? key, this.updatedExercise}) : super(key: key);

  @override
  State<MyWorkouts> createState() => _MyWorkoutsState();
}

class _MyWorkoutsState extends State<MyWorkouts> {
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


  Future<void> _getSelectedExercisesFromDB() async {
    //idk how to add to model
    try {
      Database db = Database();
      var conn = await db.getSettings();
      var id = await conn.query(
          "SELECT * from fitlife.userexerciselog WHERE user_id = ${currentUser.id}");
      // loop through the list of foods and insert each one

      var result = await conn.query(
          'SELECT id,user_id, exercise_id, muscle_group, equipment, workoutGif, name, target, reps, sets FROM fitlife.userexerciselog WHERE user_id = ${currentUser.id}');
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
          "MyWorkouts",
          style: TextStyle(fontSize: 22, color: Colors.black),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Exercises()));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.black),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                ),
                child: const Text(
                  "Add an Exercise",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ),
            ],
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
                  tileWorkout: _selectedUserExerciseListFromDB[index].name,
                  tileWorkoutEquipment: _selectedUserExerciseListFromDB[index].equipment,
                  tileTargetMuscle: _selectedUserExerciseListFromDB[index].target,
                  tileMuscleGroup: _selectedUserExerciseListFromDB[index].muscleGroup,
                  tileReps: _selectedUserExerciseListFromDB[index].reps,
                  tileSets: _selectedUserExerciseListFromDB[index].sets,
                  index: index+1,
                  editTap: (context) => _handleEditTap(index),
                  deleteTap: (context) => _handleDeleteTap(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}