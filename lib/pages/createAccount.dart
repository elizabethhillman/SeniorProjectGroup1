import 'dart:developer';

import 'package:fitlife/pages/homePage.dart';
import 'package:fitlife/main.dart';
import 'package:fitlife/pages/user.dart';
import 'package:flutter/material.dart';
import 'package:fitlife/database.dart';
// import 'package:mysql1/mysql1.dart';
// import 'dart:async';
//
// //https://pub.dev/packages/mysql1/example
// Future addUser(String name, String email, String pass) async {
//   final conn = await MySqlConnection.connect(ConnectionSettings(
//       host: 'localhost',
//       port: 3306,
//       user: 'root',
//       password: 'fitlife',
//       db: 'fitlife'));
//
//   await conn.query(
//       'CREATE TABLE IF NOT EXISTS user (email varchar(255) NOT NULL PRIMARY KEY, password varchar(255) NOT NULL, name varchar(255) NOT NULL)');
//
//   await conn.query('insert into user (email, password, name) values (?, ?, ?)',
//       [email, pass, name]);
//   // log(result.first.toString());
//   await conn.close();
// }

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final reEnterController = TextEditingController();
  final nameController = TextEditingController();

  void clearControllers() {
    emailController.clear();
    passwordController.clear();
    reEnterController.clear();
    nameController.clear();
  }

  //https://stackoverflow.com/questions/53844052/how-to-make-an-alertdialog-in-flutter
  alertMessage(BuildContext context, String title, String content) {
    AlertDialog popUp = AlertDialog(
      title: Text(title),
      content: Text(content),
      // actions: [
      //   TextButton(
      //       onPressed: () {
      //         Navigator.pop(context, false);
      //       },
      //       child: const Text("okay"))
      // ],
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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        // title: Text(widget.title),
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
            onPressed: () {
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
              } else {
                addUser(nameController.text, emailController.text,
                    passwordController.text);

                  final User newUser = User(email: emailController.text, password: passwordController.text, name: nameController.text);

                if(myList.contains(newUser)) {
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                }
                else
                {
                  clearControllers();
                  alertMessage(context, "Invalid Email", "User already exists");
                }
              }
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
