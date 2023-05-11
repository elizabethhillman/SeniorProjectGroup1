import 'package:file_picker/file_picker.dart';
import 'package:fitlife/model/post_database.dart';
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
import 'package:image_picker/image_picker.dart';



class UpdateAcct extends StatefulWidget {
  const UpdateAcct({Key? key}) : super(key: key);

  @override
  State<UpdateAcct> createState() => _UpdateAcctState();
}

class _UpdateAcctState extends State<UpdateAcct> {
  String trainerStat = currentUser.trainer;

  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Save the image to a variable or use it directly
      File image = File(pickedFile.path);
      updateProfilePic(currentUser.id, image);
    }
  }

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

  final emailController = TextEditingController(text: currentUser.email);
  final passwordController = TextEditingController(text: currentUser.password);
  final nameController = TextEditingController(text: currentUser.name);
  final handleController = TextEditingController(text: currentUser.handle);
  final bioController = TextEditingController(text: currentUser.bio);


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
                              getImage();
                            }, child: const Text("Change Image"))
                      ],
                    ),
                const SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.account_box_outlined, size: 50,),
                    const SizedBox(width: 10,),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * .80,
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("@", style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),),
                    const SizedBox(width: 10,),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * .80,
                      child: TextField(
                        controller: handleController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.mail_outline, size: 50,),
                    const SizedBox(width: 10,),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * .80,
                      child: TextField(
                        controller: emailController,
                        enabled: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.lock_outline, size: 50,),
                    const SizedBox(width: 10,),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * .80,
                      child: TextField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.sticky_note_2_outlined,size: 50,),
                    const SizedBox(width: 10,),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * .80,
                      child: TextField(
                        controller: bioController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: isTrainer,
                      onChanged: (bool? value) {
                        setState(() {
                          isTrainer = value ?? false;
                          if(isTrainer) {
                            updateUserTrainer("true");
                          } else {
                            updateUserTrainer("false");
                          }
                        });
                      },
                    ),
                    const Text('Are you a Trainer?'),
                    const Icon(Icons.star, size: 20,),
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
