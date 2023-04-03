import 'package:fitlife/controller/addExercise.dart';
import 'package:flutter/material.dart';

import '../../model/Exercises.dart';
import '../../model/User.dart';
import '../../model/user_database.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class WorkoutTile extends StatelessWidget {
  final String? tileMuscleGroup;
  final String? tileWorkout;
 // final String? tileWorkoutGif;
  final String? tileWorkoutEquipment;
  final String? tileTargetMuscle;
  final int tileReps;
  final int tileSets;
  final int index;
//  final Exercise selectedExercise;
  final void Function(BuildContext)? editTap; //TODO implement method
  final void Function(BuildContext)? deleteTap;

  const WorkoutTile({
    Key? key,
    required this.tileMuscleGroup,
    required this.tileWorkout,
  //  required this.tileWorkoutGif,
    required this.tileWorkoutEquipment,
    required this.tileTargetMuscle,
   // required this.selectedExercise,
    required this.tileReps,
    required this.tileSets,
    this.editTap,
    this.deleteTap,
    required this.index,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: editTap,
              backgroundColor: Colors.greenAccent,
              icon: Icons.edit,
              borderRadius: BorderRadius.circular(12),
            ),
            SlidableAction(
              onPressed: deleteTap,
              backgroundColor: Colors.redAccent,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
        //    mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Workout $index',
                    style:  TextStyle(
                      color: Colors.grey[600],
                      // fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    ' ${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}',
                    style:  TextStyle(
                      color: Colors.grey[600],
                      // fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$tileWorkout',
                    style: const TextStyle(
                      color: Colors.black,
                      // fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 1,
                    child: Icon(
                      Icons.arrow_forward_ios_sharp,
                      size: 20,
                      color: Colors.grey[700],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 2),
                  Text(
                    '$tileTargetMuscle',
                    style: TextStyle(
                      color: Colors.grey[600],
                      //  fontWeight: FontWeight.bold,
                      fontSize: 12.5,
                    ),
                  ),
                  Text(
                    tileWorkoutEquipment!,
                    style: TextStyle(
                   //   color: Colors.red[800],
                      //  fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    tileMuscleGroup!,
                    style: TextStyle(
                    //  color: Colors.brown[400],
                      //  fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    'Reps/Sets:$tileReps x $tileSets',
                    style: TextStyle(
                    //  color: Colors.lime[700],
                      //  fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 35),

            ],
          ),

          // SizedBox(width: 30),

        ),
      ),
    );
  }

}

