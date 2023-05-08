
import 'package:fitlife/model/User.dart';
import 'package:flutter/material.dart';
import 'package:fitlife/controller/createAccount.dart';
import 'package:fitlife/view/homePage.dart';
import 'package:fitlife/model/user_database.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Senior Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void clearLogInControllers() {
    emailController.clear();
    passwordController.clear();
  }

  //https://stackoverflow.com/questions/53844052/how-to-make-an-alertdialog-in-flutter
  alertMessageLogIn(BuildContext context) {
    AlertDialog popUp = const AlertDialog(
      title: Text("Error"),
      content: Text("Incorrect Credentials"),

      ///this doesn't work right if you log in and then log out and go to sign up (goes back to log in)
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
        title: const Text(
          "FITLIFE",
          style: TextStyle(fontSize: 40, color: Colors.black),
        ),
      ),
      body: Column(
        //https://levelup.gitconnected.com/login-page-ui-in-flutter-65210e7a6c90
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "Login",
            style: TextStyle(fontSize: 40),
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
          ElevatedButton(
            onPressed: () async {//bypass login with database
              if(await logIn(emailController.text, passwordController.text) == true)
              {
                setCurrentUser(await getName(emailController.text, passwordController.text), await getHandle(emailController.text, passwordController.text), emailController.text, passwordController.text, await getBio(emailController.text),await getFollowers(emailController.text) ,await getFollowing(emailController.text), await getTrainerStatus(emailController.text));
                setId(await getID(emailController.text, passwordController.text));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePage()));
              }
              else
              {
                clearLogInControllers();
                alertMessageLogIn(context);
              }
              // logIn(emailController.text, passwordController.text);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const HomePage()));
              // bool loggedIn = false;

              // if (await foundUser(emailController.text, passwordController.text)) {
      // for(int i = 0; i < allUsers.length; i++){
      //   if(allUsers[i].email == emailController.text && allUsers[i].password == passwordController.text){
      //     loggedIn = true;
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => const HomePage()));
      //         }
      // }
      // if(loggedIn == false)
      // {
      //   clearLogInControllers();
      //   alertMessageLogIn(context);
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
                "Don't have an account?",
              ),
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
