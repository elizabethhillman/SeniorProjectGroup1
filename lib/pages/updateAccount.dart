import 'package:fitlife/pages/calorie.dart';
import 'package:fitlife/pages/homePage.dart';
import 'package:fitlife/pages/socialMedia.dart';
import 'package:fitlife/pages/workouts.dart';
import 'package:flutter/material.dart';
import 'package:fitlife/pages/account.dart';
import '../database.dart';
import 'User.dart';

class UpdateAcct extends StatefulWidget {
  const UpdateAcct({Key? key}) : super(key: key);

  @override
  State<UpdateAcct> createState() => _UpdateAcctState();
}

class _UpdateAcctState extends State<UpdateAcct> {
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
    padding: const EdgeInsets.all(10.0),
    child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              '  Name',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration:  InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: currentUser.name,),
              ),
            ),
            const Text(
              '  Social Username',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: handleController,
                decoration:  InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: currentUser.handle,),
              ),
            ),
            const Text(
              '  Email',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                readOnly: true,
                controller: emailController,
                decoration:  InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: currentUser.email),
              ),
            ),
            const Text(
              '  Password',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: passwordController,
                decoration:  InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: currentUser.password,),
              ),
            ),
            const Spacer(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        //add something where user can edit info and either save or cancel
                        onPressed: () {
                          if(handleController.text.compareTo("")== 0)
                          {
                            handleController.text = currentUser.handle;
                          }
                          if(passwordController.text.compareTo("")== 0)
                          {
                            passwordController.text = currentUser.password;
                          }
                          if(nameController.text.compareTo("")== 0)
                          {
                            nameController.text = currentUser.name;
                          }
                          updateUser(currentUser.id,emailController.text, handleController.text, passwordController.text, nameController.text);
                          setCurrentUser(nameController.text, handleController.text, currentUser.email, passwordController.text);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const Accounts()));
            },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const Accounts()));
                        },
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(height: 20),

                    ],
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
