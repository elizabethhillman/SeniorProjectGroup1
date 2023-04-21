import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/Exercises.dart';

class EditExerciseDialog extends StatefulWidget {
  final Exercise exercise;

  const EditExerciseDialog({Key? key, required this.exercise})
      : super(key: key);

  @override
  _EditExerciseDialogState createState() => _EditExerciseDialogState();
}

class _EditExerciseDialogState extends State<EditExerciseDialog> {
  late TextEditingController _nameController;
  late TextEditingController _targetController;
  late TextEditingController _equipmentController;
  late TextEditingController _muscleGroupController;
  late TextEditingController _repsController;
  late TextEditingController _setsController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.exercise.name);
    _targetController =
        TextEditingController(text: widget.exercise.target.toString());
    _equipmentController =
        TextEditingController(text: widget.exercise.equipment);
    _muscleGroupController =
        TextEditingController(text: widget.exercise.muscleGroup);
    _repsController =
        TextEditingController(text: widget.exercise.reps.toString());
    _setsController =
        TextEditingController(text: widget.exercise.sets.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _targetController.dispose();
    _equipmentController.dispose();
    _muscleGroupController.dispose();
    _repsController.dispose();
    _setsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Exercise'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Exercise Name',
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _targetController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Target',
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _equipmentController,
              decoration: const InputDecoration(
                labelText: 'Equipment',
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _muscleGroupController,
              decoration: const InputDecoration(
                labelText: 'Muscle Group',
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _repsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Reps',
              ),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _setsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Sets',
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final updatedExercise = Exercise(
              widget.exercise.exerciseId,
              _muscleGroupController.text,
              _equipmentController.text,
              widget.exercise.workoutGif,
              _nameController.text,
              double.tryParse(_targetController.text)?.toString(),
              int.tryParse(_repsController.text) ?? 0,
              int.tryParse(_setsController.text) ?? 0,
            );
            Navigator.of(context).pop(updatedExercise);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
