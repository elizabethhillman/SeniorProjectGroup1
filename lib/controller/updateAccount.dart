import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

import 'package:fitlife/view/calorie.dart';
import 'package:fitlife/view/homePage.dart';
import 'package:fitlife/view/socialMedia.dart';
import 'package:fitlife/view/workouts.dart';
import 'package:flutter/material.dart';
import 'package:fitlife/view/account.dart';
import '../model/user_database.dart';
import '../model/User.dart';
import 'dart:io';


class UpdateAcct extends StatefulWidget {
  const UpdateAcct({Key? key}) : super(key: key);

  @override
  State<UpdateAcct> createState() => _UpdateAcctState();
}

class _UpdateAcctState extends State<UpdateAcct> {
  String trainerStat = currentUser.trainer;

  bool getTrainerStat()
  {
    if(trainerStat == "true")
    {
      return true;
    }
    return false;
  }

  late bool isTrainer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isTrainer = getTrainerStat();
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final handleController = TextEditingController();
  final bioController = TextEditingController();


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
          padding: const EdgeInsets.all(5.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:const [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTd9JoBogU1DLQ-UIOxa8lv2Jn9_lBArw9eSffqemgHgQ&usqp=CAU&ec=48665698',
                          ),
                        ),
                      ],
                    ),
                Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                            }, child: const Text("Change Image"))
                      ],
                    ),
                const Text(
                  '  Name',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: currentUser.name,
                    ),
                  ),
                ),
                const Text(
                  '  Social Username',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: TextField(
                    controller: handleController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: currentUser.handle,
                    ),
                  ),
                ),
                const Text(
                  '  Email',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: TextField(
                    readOnly: true,
                    controller: emailController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: currentUser.email),
                  ),
                ),
                const Text(
                  '  Password',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: currentUser.password,
                    ),
                  ),
                ),
                const Text(
                  '  Bio',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: TextField(
                    controller: bioController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: currentUser.bio,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: isTrainer,
                      onChanged: (bool? value) {
                        setState(() {
                          isTrainer = value ?? false;
                        });
                      },
                    ),
                    const Text('Are you a Trainer?'),
                  ],
                ),
                // const Spacer(),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            //add something where user can edit info and either save or cancel
                            onPressed: () async {
                              if (handleController.text.compareTo("") == 0) {
                                handleController.text = currentUser.handle;
                              }
                              if (passwordController.text.compareTo("") == 0) {
                                passwordController.text = currentUser.password;
                              }
                              if (nameController.text.compareTo("") == 0) {
                                nameController.text = currentUser.name;
                              }
                              if (bioController.text.compareTo("") == 0) {
                                bioController.text = currentUser.bio;
                              }
                              updateUser(
                                  currentUser.id,
                                  emailController.text,
                                  handleController.text,
                                  passwordController.text,
                                  nameController.text,
                                  bioController.text,
                                  "$isTrainer");
                              setCurrentUser(
                                  nameController.text,
                                  handleController.text,
                                  currentUser.email,
                                  passwordController.text,
                                  bioController.text,
                                  currentUser.followers,
                                  currentUser.following,
                                  "$isTrainer");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Accounts()));
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Accounts()));
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
