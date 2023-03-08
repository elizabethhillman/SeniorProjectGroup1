import 'package:fitlife/pages/homePage.dart';
import 'package:fitlife/main.dart';
import 'package:fitlife/pages/user.dart';
import 'package:flutter/material.dart';
import 'package:fitlife/database.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

//https://pub.dev/packages/mysql1/example
Future addUser(String email, String password, String name) async {
  var db =  TestData();
  //var conn = await db.connectDB();

  String sql = 'INSERT INTO user (email, password, name) VALUES (?, ?, ?)';
  String table =
      'CREATE TABLE IF NOT EXISTS user (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, email varchar(45) NOT NULL, password varchar(45) NOT NULL, name varchar(45) NOT NULL)';
  await db.getConnection().then((conn) async {
    // Future.delayed(const Duration(seconds: 3));
    await conn.query(table);
    // Future.delayed(const Duration(seconds: 3));
    await conn.query(sql, [email, password, name]);
    await conn.close();
    myList.add(User(email: email, password: password, name: name));
  });
}

// Future findUser(String email, String password) async {
//   var db = TestData();
//
//   String sql = 'select * fitlife.user where email = ? and password = ?';
//   await db.connectDB().then((conn) async {
//     await conn.query(
//         'CREATE TABLE IF NOT EXISTS user (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, email varchar(45), password varchar(45), name varchar(45))');
//     await conn.query(sql, [email, password]).then((results) {
//       for (var res in results) {
//         final User myuser = User(
//             password: res['password'].toString(),
//             email: res['email'].toString(),
//             name: res['name'].toString());
//
//         thislist.add(myuser);
//       }
//     });
//     conn.close();
//   });
// }

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

      ///wrote what was going on with this in main.dart
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

  // futureFind(String email, String password) {
  //   return FutureBuilder(
  //       future: findUser(email, password),
  //       builder: (BuildContext context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return const CircularProgressIndicator();
  //         } else if (snapshot.hasError) {
  //           return Text(snapshot.error.toString());
  //         }
  //         return const Text("err");
  //       });
  // }

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
              /*
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
                addUser(emailController.text, passwordController.text,
                    nameController.text);
                User newUser = User(
                    email: emailController.text,
                    password: passwordController.text,
                    name: nameController.text);
                // futureFind(emailController.text, passwordController.text);
                // if (thislist.isNotEmpty &&thislist.elementAt(0).toString().compareTo(emailController.text) == 0 &&
                //     thislist.elementAt(1).toString().compareTo(passwordController.text) == 0) {
                //   myList.add(newUser);
                // }
                if (myList.contains(newUser)) {
               */
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                  /*
                } else {
                  clearControllers();
                  alertMessage(context, "Invalid Email", "User already exists");
                }
              }
                  */
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
