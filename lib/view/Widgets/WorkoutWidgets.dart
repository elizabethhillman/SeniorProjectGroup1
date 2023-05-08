import 'package:fitlife/controller/addExercise.dart';
import 'package:flutter/material.dart';

import '../../model/Exercises.dart';
import '../../model/User.dart';
import '../../model/user_database.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class WorkoutTile extends StatefulWidget {
  final Exercise exercise;
  final int index;
  final void Function(BuildContext)? editTap;
  final void Function(BuildContext)? deleteTap;
  final void Function(Exercise)? updateFavoriteStatus;
  final Color? containerColor;
  const WorkoutTile({
    Key? key,
    required this.exercise,
    required this.index,
    this.editTap,
    this.deleteTap,
    this.updateFavoriteStatus, this.containerColor,
  }) : super(key: key);

  @override
  _WorkoutTileState createState() => _WorkoutTileState();
}

class _WorkoutTileState extends State<WorkoutTile> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: widget.editTap,
              backgroundColor: Colors.greenAccent,
              icon: Icons.edit,
              borderRadius: BorderRadius.circular(12),
            ),
            SlidableAction(
              onPressed: widget.deleteTap,
              backgroundColor: Colors.redAccent,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: widget.containerColor ?? Colors.grey[300],
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
                    'Workout ${widget.index}',
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
                    '${widget.exercise.name}',
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
                    '${widget.exercise.target}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      //  fontWeight: FontWeight.bold,
                      fontSize: 12.5,
                    ),
                  ),
                  Text(
                    widget.exercise.equipment!,
                    style: TextStyle(
                   //   color: Colors.red[800],
                      //  fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    widget.exercise.muscleGroup!,
                    style: TextStyle(
                    //  color: Colors.brown[400],
                      //  fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Reps/Sets:${widget.exercise.reps} x ${widget.exercise.sets}',
                    style: TextStyle(
                      fontSize: 13,
                      textBaseline: TextBaseline.alphabetic,
                      height: 0.8, // adjust this value as needed
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child:  IconButton(
                      icon: widget.exercise.isPressed!
                          ? Icon(Icons.favorite, color: Colors.red)
                          : Icon(Icons.favorite_border),
                      onPressed: () {
                        setState(() {
                          widget.exercise.isPressed = !widget.exercise.isPressed!;
                        });
                        if (widget.updateFavoriteStatus != null) {
                          widget.updateFavoriteStatus!(widget.exercise);
                        }
                      },
                    ),
                    ),

                ],
              )

                  ,const SizedBox(width: 35),

            ],
          ),

          // SizedBox(width: 30),

        ),
      ),
    );
  }

}

