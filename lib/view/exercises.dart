import 'dart:convert';

import 'package:fitlife/view/Widgets/ExerciseWidgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/User.dart';
import '../model/user_database.dart';
import '../model/Exercises.dart';

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
//TODO ADD FILTER FOR TARGETED MUSCLES

  @override
  void initState() {
    super.initState();
    _getExercises(); // add call to get exercises on initialization
  }

 /* String capitalize(String s) {
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

  Future<void> _getExercises() async {
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
         // insertExerciseToDB(exercises);
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error Occurred: $e');
    }
  }

   Future<void> insertExerciseToDB(List<Exercise> exercise) async {
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
  }*/

  Future<void> _getExercises() async { //idk how to add to model
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
  }

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

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
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
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
                    .map<DropdownMenuItem<String>>((String? value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value!),
                  );
                }).toList()
                  ..sort((a, b) =>
                      a.child.toString().compareTo(b.child.toString())),
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
                    tileWorkout: _selectedExercises[index].name,
                    tileWorkoutGif: _selectedExercises[index].workoutGif,
                    tileWorkoutEquipment: _selectedExercises[index].equipment,
                    tileTargetMuscle: _selectedExercises[index].target,
                    selectedExercise: _selectedExercises[index],
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
