import 'package:fitlife/main.dart';
import 'package:flutter/material.dart';
import 'package:fitlife/pages/workouts.dart';
import 'package:fitlife/pages/calorie.dart';
import 'package:fitlife/pages/socialMedia.dart';
import 'package:fitlife/pages/homePage.dart';


class Accounts extends StatefulWidget
{
  const Accounts({Key? key}) : super(key: key);

  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar
        (
        leading: IconButton(
          icon: const Icon(Icons.home, color: Colors.black,),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
        title: const Text("Account", style: TextStyle(fontSize: 30, color: Colors.black),),
        actions: <Widget>[

          IconButton(
            icon: const Icon(Icons.fitness_center), color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Workouts()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.restaurant), color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Calorie()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.group), color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SocialMedia()));
            },
          ),
        ],
      ),
      body: TextButton(child: const Text("Log out"), onPressed: (){Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
              const MyApp(title: "FITLIFE")));},)
    );
  }
}