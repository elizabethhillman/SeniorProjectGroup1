import 'package:fitlife/controller/updateAccount.dart';
import 'package:fitlife/view/calorie.dart';
import 'package:fitlife/view/homePage.dart';
import 'package:fitlife/view/socialMedia.dart';
import 'package:fitlife/view/workouts.dart';
import 'package:flutter/material.dart';


import '../main.dart';
import '../model/User.dart';
import '../model/user_database.dart';

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


  bool getTrainerStat()
  {
    if(currentUser.trainer == "true") return true;
    return false;
  }

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
            title:  const Text(
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
          padding: const EdgeInsets.all(12.0),
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 75,
                  backgroundImage: currentUser.profilePic.isNotEmpty ? AssetImage(currentUser.profilePic) : const AssetImage('lib/view/image/blankAvatar.png'),
                )
              ],
            ),
            const SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.account_box_outlined, size: 50,),
                const SizedBox(width: 10,),
                Text(currentUser.name, style: TextStyle(fontSize: 20),),
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              const Text("@", style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
              const SizedBox(width: 10,),
              Text(currentUser.handle, style: const TextStyle(fontSize: 20),),
                getTrainerStat() ? const Icon(Icons.star) : const SizedBox.shrink(),
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.email_outlined, size: 50,),
                const SizedBox(width: 10,),
                Text(currentUser.email, style: const TextStyle(fontSize: 20),),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const[
                Icon(Icons.lock_outline, size: 50,),
                SizedBox(width: 10,),
                Text("*********", style: const TextStyle(fontSize: 20),),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.sticky_note_2_outlined, size: 50,),
                const SizedBox(width: 10,),
                Text(currentUser.bio, style: const TextStyle(fontSize: 20),),
              ],
            ),
            const SizedBox(height: 30),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UpdateAcct()));
                        },
                        child: const Text('Edit'),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 20),
                  Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          setCurrentUser("", "", "", "", "", "", "", "", "");
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyApp(title: "FITLIFE")),
                                (route) => false,
                          );
                        },
                        child: const Text('Logout'),
                      ),
                      // const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          String email = getCurrentUser().email;
                          deleteUser(email);
                          setCurrentUser("", "", "", "", "", "", "", "", "");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const MyApp(title: "FITLIFE")));
                        },
                        child: const Text('Delete account'),
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
