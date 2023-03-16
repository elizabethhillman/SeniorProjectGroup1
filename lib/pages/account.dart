import 'package:fitlife/pages/calorie.dart';
import 'package:fitlife/pages/homePage.dart';
import 'package:fitlife/pages/socialMedia.dart';
import 'package:fitlife/pages/workouts.dart';
import 'package:flutter/material.dart';

import '../database.dart';
import '../main.dart';
import 'User.dart';

class Accounts extends StatefulWidget {
  const Accounts({Key? key}) : super(key: key);

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final handleController = TextEditingController();

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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyWorkouts()));
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SocialMedia()));
                },
              ),
            ]),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Name',
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
                child: Text(currentUser.name),
              ),
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
                child: Text(currentUser.handle),
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
                child: Text(currentUser.email),
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
                child: Text(currentUser.password),
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
                        //add something where user can edit info and either save or cancel
                        onPressed: () {updateUser(emailController.text, handleController.text, passwordController.text, nameController.text);},
                        child: Text('Edit'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          setCurrentUser("", "", "","");
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
                        onPressed: () {
                          String email = getCurrentUser().email;
                          deleteUser(email);
                          setCurrentUser("", "", "", "");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MyApp(title: "FITLIFE")));
                        },
                        child: Text('Delete account'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
