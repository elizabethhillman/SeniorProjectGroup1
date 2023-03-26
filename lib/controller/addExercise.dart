import 'package:flutter/material.dart';
import 'package:fitlife/view/account.dart';
import 'package:fitlife/view/calorie.dart';
import 'package:fitlife/view/socialMedia.dart';
import 'package:fitlife/view/workouts.dart';
import 'package:fitlife/view/homePage.dart';

class AddExercise extends StatefulWidget {
  const AddExercise({Key? key}) : super(key: key);

  @override
  State<AddExercise> createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {
  final TextEditingController _setsController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.home,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
        title: const Text(
          "Add Exercise",
          style: TextStyle(fontSize: 19, color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Input Number of Sets",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 200,
              child: TextField(
                controller: _setsController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: "Enter sets",
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Input Number of Reps",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 200,
              child: TextField(
                controller: _repsController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: "Enter reps",
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyWorkouts()),
                  );
                },
                child: const Text(
                  "Add",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}