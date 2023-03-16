import 'package:fitlife/pages/homePage.dart';
import 'package:fitlife/pages/User.dart';
import 'package:fitlife/main.dart';
import 'package:flutter/material.dart';
import 'package:fitlife/database.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final reEnterController = TextEditingController();
  final nameController = TextEditingController();
  final handleController = TextEditingController();


  void clearControllers() {
    emailController.clear();
    passwordController.clear();
    reEnterController.clear();
    nameController.clear();
    handleController.clear();
  }

  //https://stackoverflow.com/questions/53844052/how-to-make-an-alertdialog-in-flutter
  alertMessage(BuildContext context, String title, String content) {
    AlertDialog popUp = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text("okay"))
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return popUp;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "FITLIFE",
          style: TextStyle(fontSize: 40, color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Sign Up",
                style: TextStyle(fontSize: 40),
              )),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: nameController,
              obscureText: false,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Full Name",
                  hintText: "Enter your Name"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: handleController,
              obscureText: false,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Social Media Handle",
                  hintText: "Enter your Social Media Handle"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: emailController,
              obscureText: false,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                  hintText: "Enter email"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                  hintText: "Enter Password"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: reEnterController,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Re-Enter Password",
                  hintText: "Enter the Same Password"),
            ),
          ),
          ElevatedButton(
            //https://docs.flutter.dev/cookbook/forms/retrieve-input
            onPressed: () async {
              if (passwordController.text.compareTo(reEnterController.text) !=
                  0) {
                clearControllers();
                alertMessage(context, "Error", "Passwords do not match");
              } else if (emailController.text.compareTo("") == 0 ||
                  passwordController.text.compareTo("") == 0 ||
                  reEnterController.text.compareTo("") == 0 ||
                  nameController.text.compareTo("") == 0) {
                clearControllers();
                alertMessage(context, "Error", "Missing information");
              } else if(await emailExists(emailController.text) == true)
              {
                alertMessage(context, "Error", "Email already exists");
              } else {
                addUser(emailController.text, passwordController.text,
                    nameController.text, handleController.text);

                User u =  User(id: 0, name: nameController.text, handle: handleController.text, email: emailController.text, password: passwordController.text);
                setCurrentUser(nameController.text, handleController.text, emailController.text, passwordController.text);
                allUsers.add(u);

                // bool canSwitchPages = await foundUser(emailController.text, passwordController.text);

                // if (canSwitchPages) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));

                // } else {
                //   clearControllers();
                //   alertMessage(context, "Invalid Email", "User already exists");
                }
              // }
            },
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0))),
            child: const Text("Submit",
                style: TextStyle(fontSize: 25, color: Colors.black)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Already have an account?",
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const MyApp(title: "FITLIFE")));
                  },
                  child: const Text("Log In")),
            ],
          )
        ],
      ),
    );
  }
}

// futureAdd(String email, String password, String name) {
//   return FutureBuilder(
//       future: addUser(email, password, name),
//       builder: (BuildContext context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         } else if (snapshot.hasError) {
//           return Text(snapshot.error.toString());
//         }
//         return const Text("err");
//       });
// }
