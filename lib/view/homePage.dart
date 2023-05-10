import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fitlife/controller/enterWeight.dart';
import 'package:fitlife/model/User.dart';
import 'package:fitlife/view/Widgets/HomePageWidgets.dart';
import 'package:fitlife/view/account.dart';
import 'package:fitlife/view/calorie.dart';
import 'package:fitlife/view/favoriteworkouts.dart';
import 'package:fitlife/view/socialMedia.dart';
import 'package:fitlife/view/workouts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Feed.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Senior Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'FITLIFE'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const homePageIconColor = Color(0xFFD76363);

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          // title: Text(widget.title),
          title: const Text(
            "FITLIFE",
            style: TextStyle(fontSize: 40, color: Colors.black),
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
            IconButton(
              icon: const Icon(Icons.account_circle),
              color: Colors.black,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Accounts()));
              },
            ),
          ],
        ),
    body: SingleChildScrollView(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
              const SizedBox(height: 25),
              //spacer
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "Welcome Back, ${currentUser.name}",
                  style: GoogleFonts.montserrat(
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Container(
                alignment: Alignment.center,
                // padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    // const Padding(
                    //   padding: EdgeInsets.all(5),
                    // ),
                    // const SizedBox(width: 10),
                    SizedBox(
                      width: 132,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const favoriteWorkouts()));
                        },
                        icon: const Icon(Icons.favorite,
                            color: homePageIconColor,size: 40),
                        label: const Text("Favorite Workouts",
                            style: TextStyle(color: Colors.black,fontSize: 12)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            elevation: 0),
                      ),
                    ),
                    // const SizedBox(width: 10),
                    SizedBox(
                      width: 130,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const enterWeight()));
                        },
                        icon: const Icon(Icons.monitor_weight,size: 40,
                            color: homePageIconColor),
                        label: const Text("Enter Weight",
                            style: TextStyle(color: Colors.black,fontSize: 12)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            elevation: 0),
                      ),
                    ),
                    // const SizedBox(width: 10),
                    SizedBox(
                      width: 130,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const Feed()));
                        },
                        icon: const Icon(Icons.camera_alt_sharp,size: 40,
                            color: homePageIconColor),
                        label: const Text("View Feed",
                            style: TextStyle(color: Colors.black,fontSize: 12)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            elevation: 0),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  SizedBox(width: 30),
                  const HomePageWidget(),
                ],
              ),

              const SizedBox(height: 35),
              AnimatedTextKit(
                isRepeatingAnimation: true,
                repeatForever: true,
                animatedTexts: [
                  RotateAnimatedText('YOU HAVE BURNED 700 CALORIES TODAY',
                      duration: const Duration(seconds: 7)),
                  RotateAnimatedText('YOU STILL NEED 32g PROTEIN FOR THE DAY',
                      duration: const Duration(seconds: 7)),
                ],
              ),
            ])));
  }
}
