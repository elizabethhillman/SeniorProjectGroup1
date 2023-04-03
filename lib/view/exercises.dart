import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fitlife/view/Widgets/ExerciseWidgets.dart';
import 'package:flutter/material.dart';
import '../model/Exercises.dart';
import '../model/user_database.dart';


class Exercises extends StatefulWidget {
  const Exercises({Key? key}) : super(key: key);

  @override
  State<Exercises> createState() => _ExercisesState();
}

class _ExercisesState extends State<Exercises> {
  String? _selectedMuscleGroup;
  String? _selectedTarget;
  bool _hasSelected = false;
  List<Exercise> exercises = [];
  List<Exercise> _selectedExercises = [];
  List<String?> _selectedTargets = ["All"];

//TODO ADD FILTER FOR TARGETED MUSCLES

  @override
  void initState() {
    super.initState();
    _getExercises(); // add call to get exercises on initialization
  }

   String capitalize(String s) {
    List<String> words = s.split(" ");
    List<String> capitalizedWords = [];

    for (String word in words) {
      if (word.isNotEmpty) {
        capitalizedWords.add(word[0].toUpperCase() + word.substring(1));
      } else {
        capitalizedWords.add(word);
      }
    }
    return capitalizedWords.join(" ");
  }

  Future<void> _getExercises() async {    //TODO first use to save api requests,then comment this out after your exerciseapi database table gets populated,
    String apiUrlMuscles = 'https://exercisedb.p.rapidapi.com/exercises';
    final Map<String, String> headers = {
      'X-Rapidapi-Key': '205d35886cmsh5b1ec99d4c12573p16cd50jsncec4aa535cd4',
      'X-Rapidapi-Host': 'exercisedb.p.rapidapi.com',
      'Host': 'exercisedb.p.rapidapi.com',
    };
    try {
      final response =
          await http.get(Uri.parse(apiUrlMuscles), headers: headers);
      if (response.statusCode == 200) {
        final List<dynamic> muscleGroup = jsonDecode(response.body);

        setState(() {
          for (var x in muscleGroup) {
            exercises.add(Exercise(
              0,
              capitalize(x['bodyPart']),
              capitalize(x['equipment']),
              capitalize(x['gifUrl']),
              capitalize(x['name']),
              capitalize(x['target']),
              0,
              0
            ));
          }
          insertExerciseToDB(exercises);
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error Occurred: $e');
    }
  }

   Future<void> insertExerciseToDB(List<Exercise> exercise) async { //TODO comment this function out as well
    //idk how to add to model
    try {
      Database db = Database();
      var conn = await db.getSettings();
      var id = await conn.query("SELECT id from fitlife.exerciseapi;");
      // loop through the list of foods and insert each one
      for (var ex in exercise) {
        await conn.query(
            'INSERT INTO fitlife.exerciseapi (muscle_group, equipment, workout_gif, name, target) VALUES (?,?,?,?,?);',
            [ex.muscleGroup, ex.equipment, ex.workoutGif, ex.name, ex.target]);
      }
      await conn.close();
    } catch (e) {
      print("Error Occurred: $e");
    }
  }

/*  Future<void> _getExercises() async { //TODO uncomment this out, and comment out the above once your database is populated from the api
    //idk how to add to model
    try {
      Database db = Database();
      var conn = await db.getSettings();
      var id = await conn.query("SELECT * from fitlife.exerciseapi");
      var result = await conn.query(
          'SELECT id,muscle_group, equipment, workout_gif, name, target FROM fitlife.exerciseapi;');

      setState(() {
        for (var row in result) {
          exercises.add(Exercise(
            row[0],
            row[1].toString(),
            row[2].toString(),
            row[3].toString(),
            row[4].toString(),
            row[5].toString(),
            0,
            0,
          ));
        }
      });
      await conn.close();
    } catch (e) {
      print("Error Occurred: $e");
    }
  }*/

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  Set<String?> getUniqueTargets(List<Exercise> exercises) {
    return exercises
        .map((exercise) => exercise.target)
        .where((target) => target != null)
        .toSet();
  }

  List<Exercise> getFilteredExercises() {
    List<Exercise> filteredExercises = [];

    if (_selectedMuscleGroup != null) {
      filteredExercises.addAll(exercises
          .where((exercise) => exercise.muscleGroup == _selectedMuscleGroup));
    } else {
      filteredExercises.addAll(exercises);
    }

    if (_selectedTarget != null) {
      filteredExercises
          .retainWhere((exercise) => exercise.target == _selectedTarget);
    }

    return filteredExercises;
  }

  Set<String?> getUniqueMuscleGroups(List<Exercise> exercises) {
    return exercises
        .map((exercise) => exercise.muscleGroup)
        .where((muscleGroup) => muscleGroup != null)
        .toSet();
  }

  @override
  Widget build(BuildContext context) {
    _selectedExercises = (_selectedMuscleGroup == null)
        ? [...exercises]
        : exercises
            .where((Exercise exercise) =>
                exercise.muscleGroup == _selectedMuscleGroup)
            .toList();
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
                // fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: SizedBox(
              width: 200,
              child: DropdownButton<String>(
                hint: const Text("Select a muscle group"),
                value: _selectedMuscleGroup,
                onChanged: (String? newValue) {
                  setState(() {
                    _hasSelected = true;
                    _selectedMuscleGroup = newValue;
                    _selectedTarget =
                        null; // Reset selected target when changing muscle group
                  });
                },
                items: [...getUniqueMuscleGroups(exercises)]
                    .map((muscleGroup) => DropdownMenuItem<String>(
                          value: muscleGroup,
                          child: Text(muscleGroup ?? "All"),
                        ))
                    .toList(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          if (_hasSelected) const SizedBox(height: 20),
          if (_hasSelected)
            Wrap(
              spacing: 8.0,
              children: [
                for (String? target in [
                  "All",
                  ...getUniqueTargets(_selectedExercises)
                ])
                  InputChip(
                    label: Text(target ?? "All"),
                    selected: _selectedTargets.contains(target),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _selectedTargets.add(target);
                        } else {
                          _selectedTargets.remove(target);
                        }
                      });
                    },
                  ),
              ],
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
                  List<Exercise> filteredExercises =
                      _selectedExercises.where((exercise) {
                    return _selectedTargets.contains(exercise.target) ||
                        _selectedTargets.contains("All");
                  }).toList();

                  if (filteredExercises.isEmpty) {
                    Text(
                      'Please select a Muscle Target',
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 23,
                      ),
                    );
                    return null;
                  }

                  Exercise selectedExercise = filteredExercises[index];
                  return exerciseTile(
                    tileMuscleGroup: selectedExercise.muscleGroup,
                    tileWorkout: selectedExercise.name,
                    tileWorkoutGif: selectedExercise.workoutGif,
                    tileWorkoutEquipment: selectedExercise.equipment,
                    tileTargetMuscle: selectedExercise.target,
                    selectedExercise: selectedExercise,
                  );
                },
              ),
            ),
          if (_hasSelected) //TODO some1 fix this shit idk how it works
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 0; i < _selectedExercises.length; i++)
                    Expanded(
                      child: Container(
                        width: 10,
                        height: 10,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentPage == i ? Colors.blue : Colors.grey,
                        ),
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
