import 'package:flutter/material.dart';

import '../Widgets/ExerciseWidgets.dart';
import '../model/Exercises.dart';
import '../model/user_database.dart';

class Exercises extends StatefulWidget {
  const Exercises({Key? key}) : super(key: key);

  @override
  State<Exercises> createState() => _ExercisesState();
}

class _ExercisesState extends State<Exercises> {
  String? _selectedMuscleGroup;
  bool _hasSelected = false;
  List<Exercise> exercises = [];
  List<Exercise> _selectedExercises = [];

  @override
  void initState() {
    super.initState();
    _getExercises(); // add call to get exercises on initialization
  }

  Future<void> _getExercises() async { //idk how to add to model
    try {
      Database db = Database();
      var conn = await db.getSettings();
      var id = await conn.query("SELECT * from fitlife.exercises");
      var result = await conn.query(
          'SELECT muscle_group, workout, workout_gif FROM fitlife.exercises;');

      setState(() {
        for (var row in result) {
          exercises.add(Exercise(row[1].toString(), row[2].toString(), row[3].toString()));
        }
      });
      await conn.close();
    } catch (e) {
      print("Error Occurred: $e");
    }
  }

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  Set<String> getUniqueMuscleGroups(List<Exercise> exercises) {
    return exercises.map((exercise) => exercise.muscleGroup).toSet();
  }

  @override
  Widget build(BuildContext context) {
    _selectedExercises = (_selectedMuscleGroup == null
        ? [...exercises]
        : exercises
            .where((exercise) => exercise.muscleGroup == _selectedMuscleGroup)
            .toList());
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Exercises',
          style: TextStyle(
            color: Colors.grey[900],
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey[900],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Muscle Group",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SizedBox(
              width: 150,
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                value: _selectedMuscleGroup,
                onChanged: (String? newValue) {
                  setState(() {
                    _hasSelected = true;
                    _selectedMuscleGroup = newValue;
                  });
                },
                items: getUniqueMuscleGroups(exercises)
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          if (_hasSelected) //displays only if dropdown is selected
            Expanded(
              child: PageView.builder(
                itemCount: _selectedExercises.length,
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return exerciseTile(
                      tileMuscleGroup: _selectedExercises[index].muscleGroup,
                      tileWorkout: _selectedExercises[index].workout,
                      tileWorkoutGif: _selectedExercises[index].workoutGif);
                },
              ),
            ),
          if (_hasSelected)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < _selectedExercises.length; i++)
                    Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == i ? Colors.blue : Colors.grey,
                      ),
                    ),
                ],
              ),
            ),
          if (!_hasSelected)
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                'Please select a Muscle Group',
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 23,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
