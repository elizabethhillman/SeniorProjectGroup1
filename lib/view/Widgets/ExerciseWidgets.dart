import 'package:fitlife/controller/addExercise.dart';
import 'package:flutter/material.dart';

import '../../model/Exercises.dart';
import '../../model/User.dart';
import '../../model/user_database.dart';

class exerciseTile extends StatelessWidget {
  final String? tileMuscleGroup;
  final String? tileWorkout;
  final String? tileWorkoutGif;
  final String? tileWorkoutEquipment;
  final String? tileTargetMuscle;
  final Exercise selectedExercise;

  const exerciseTile({
    Key? key,
    required this.tileMuscleGroup,
    required this.tileWorkout,
    required this.tileWorkoutGif,
    required this.tileWorkoutEquipment,
    required this.tileTargetMuscle,
    required this.selectedExercise,
  }) : super(key: key);

  Future<void> insertExercises(int userId, Exercise selectedExercise) async {
    //idk how to add to model
    try {
      Database db = Database();
      var conn = await db.getSettings();
      var id = await conn.query("SELECT id from fitlife.userexerciselog;");
      // loop through the list of foods and insert each one

      await conn.query(
          'INSERT INTO fitlife.userexerciselog (user_id, exercise_id, muscle_group, equipment, workoutGif, name, target, reps, sets) VALUES (?,?,?,?,?,?,?,?,?);',
          [userId, selectedExercise.exerciseId ,selectedExercise.muscleGroup, selectedExercise.equipment, selectedExercise.workoutGif, selectedExercise.name,selectedExercise.target,selectedExercise.reps,selectedExercise.sets]);
      await conn.close();
    } catch (e) {
      print("Error Occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        //alignment: Alignment.bottomRight,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              left: 20,
              right: 20,
              bottom: 10,
            ),
            child: Text(
              tileWorkout!,
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey[700],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Targeted Muscle: ${tileTargetMuscle!}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
          Text(
            'Equipment: ${tileWorkoutEquipment!}',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[600],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(tileWorkoutGif!)),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () async {
                  final updatedExercise = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddExercise(selectedExercise: selectedExercise)),
                  );
                  if (updatedExercise != null) {
                    insertExercises(currentUser.id, selectedExercise);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(19),
                          bottomRight: Radius.circular(19))),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
