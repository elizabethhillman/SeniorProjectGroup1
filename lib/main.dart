import 'package:flutter/material.dart';
import 'package:fitlife/pages/createAccount.dart';
import 'package:fitlife/pages/homePage.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Senior Project',
      theme: ThemeData(primarySwatch: Colors.blue,
      ),
      home: const MyApp(title: 'FITLIFE'),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FITLIFE", style: TextStyle(fontSize: 40, color: Colors.black),
        ),
      ),
      body: Column(
        //https://levelup.gitconnected.com/login-page-ui-in-flutter-65210e7a6c90
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("Login", style: TextStyle(fontSize: 40),),
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
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
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
              const Text("Don't have an account?",),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateAccount()));
                  },
                  child: const Text("Create Account")),
            ],
          )
        ],
      ),
    );
  }
}
