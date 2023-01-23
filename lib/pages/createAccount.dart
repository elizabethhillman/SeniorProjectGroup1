import 'package:flutter/material.dart';
import 'package:fitlife/pages/homePage.dart';
import 'package:fitlife/main.dart';
import 'package:fitlife/models/user.dart';
import 'package:fitlife/database.dart';


Future<List<User>> addUser(String email, String password) async {
  var db = Database();

  final List<User> myList = [];
  final conn = await db.getConnection();

  var results = await conn.query(
      'insert into fitlife.user (email, password) values (?,?)',
      [email, password]);

  for (var res in results) {
    final User newUser = User(
        email: res['email'].toString(), password: res['password'].toString());

    myList.add(newUser);
  }
  conn.close();


  return myList;
}

class CreateAccount extends StatefulWidget
{
  const CreateAccount({Key? key}) : super(key: key);

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount>
{
  @override
  Widget build(BuildContext context)
  {
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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 40),
                )),
            const Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                obscureText: false,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    hintText: "Enter email"),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    hintText: "Enter Password"),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Re-Enter Password",
                    hintText: "Enter the Same Password"),
              ),
            ),
            ElevatedButton(
              //https://docs.flutter.dev/cookbook/forms/retrieve-input
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePage()));
              },
              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0))),
              child: const Text("Submit", style: TextStyle(fontSize: 25, color: Colors.black)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?",),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyApp(title: "FITLIFE")));
                    },
                    child: const Text("Log In")),
              ],
            )
          ],
        ),
      ),
    );
  }
}