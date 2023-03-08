import 'package:fitlife/pages/calorie.dart';
import 'package:fitlife/pages/homePage.dart';
import 'package:fitlife/pages/socialMedia.dart';
import 'package:fitlife/pages/workouts.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../database.dart';

class Accounts extends StatefulWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
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
          "Account",
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.fitness_center),
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Workouts()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.restaurant),
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Calorie()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.group),
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SocialMedia()));
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.fitness_center),
              color: Colors.black,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyWorkouts()));
              },
            ),
            SizedBox(height: 16),
            Text(
              'Social Username',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('@dog55385'),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Email',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('test@example.com'),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Password',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('******************'),
              ),
            ),
            Spacer(),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Edit'),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const MyApp(title: "FITLIFE")));
                          },
                          child: Text('Logout'),
                        ),
                        SizedBox(height: 20),
                        TextButton(
                          onPressed: () {},
                          child: Text('Delete account'),
                        ),
                      ],
                    ),
                  ],
                ),
            ),
          ],
        ),

      ),//unsure if needed
    );//unsure

        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                child: const Text("Log out"),
                onPressed: () {
                  setCurrentUser("", "", "");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyApp(title: "FITLIFE")));
                },
              ),
              TextButton(
                  child: const Text("Delete Account"),
                  onPressed: () {
                    String email = getCurrentUser().email;
                    deleteUser(email);
                    setCurrentUser("", "", "");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const MyApp(title: "FITLIFE")));
                  }),
            ]));
  }
}
