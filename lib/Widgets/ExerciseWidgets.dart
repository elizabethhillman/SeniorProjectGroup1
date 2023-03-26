import 'package:flutter/material.dart';

import '../controller/addExercise.dart';

class exerciseTile extends StatelessWidget {
  final String tileMuscleGroup;
  final String tileWorkout;
  final String tileWorkoutGif;

  const exerciseTile({
    Key? key,
    required this.tileMuscleGroup,
    required this.tileWorkout,
    required this.tileWorkoutGif,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        alignment: Alignment.bottomRight,
        //temporary for now, replace with the exercises pulled from database
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              tileWorkout,
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child:
                ClipRRect(borderRadius: BorderRadius.circular(12), child:
                Image.network(tileWorkoutGif)
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddExercise()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    decoration:
                    BoxDecoration(color:
                    Colors.grey[800],
                        borderRadius:
                        const BorderRadius.only(
                            topLeft: Radius.circular(19),
                            bottomRight : Radius.circular(19))
                    ),
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
