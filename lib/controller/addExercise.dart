import 'package:flutter/material.dart';
import '../model/Exercises.dart';
import 'package:fitlife/view/workouts.dart';
class AddExercise extends StatefulWidget {
  final Exercise selectedExercise;

  const AddExercise({Key? key, required this.selectedExercise}) : super(key: key);

  @override
  _AddExerciseState createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {
  late Exercise _updatedExercise;

  @override
  void initState() {
    super.initState();
    // initialize _updatedExercise with the selectedExercise passed from the previous page
    _updatedExercise = widget.selectedExercise;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Exercise'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Muscle Group: ${_updatedExercise.muscleGroup}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Text(
              'Workout: ${_updatedExercise.name}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _updatedExercise.reps.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Reps',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _updatedExercise.reps = int.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _updatedExercise.sets.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Sets',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _updatedExercise.sets = int.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // pass the updated exercise back to the previous page using Navigator.pop
                  Navigator.of(context).pop(_updatedExercise);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyWorkouts(updatedExercise: _updatedExercise),
                    ),
                  );
                  setState(() {});
                  },
                child: const Text('Add Exercise'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}