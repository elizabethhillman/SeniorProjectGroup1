import 'package:fitlife/controller/addExercise.dart';
import 'package:flutter/material.dart';

class exerciseTile extends StatelessWidget {
  final String? tileMuscleGroup;
  final String? tileWorkout;
  final String? tileWorkoutGif;
  final String? tileWorkoutEquipment;
  final String? tileTargetMuscle;

  const exerciseTile({
    Key? key,
    required this.tileMuscleGroup,
    required this.tileWorkout,
    required this.tileWorkoutGif,
    required this.tileWorkoutEquipment,
    required this.tileTargetMuscle,
  }) : super(key: key);

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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddExercise()),
                  );
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
