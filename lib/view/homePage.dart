import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:fitlife/controller/enterWeight.dart';
import 'package:fitlife/model/User.dart';
import 'package:fitlife/view/Widgets/HomePageWidgets.dart';
import 'package:fitlife/view/account.dart';
import 'package:fitlife/view/calorie.dart';
import 'package:fitlife/view/socialMedia.dart';
import 'package:fitlife/view/workouts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              //spacer
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  "Welcome Back, ${currentUser.name}",
                  style: GoogleFonts.montserrat(
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  const SizedBox(height: 35),
                  const HomePageWidget(),
                  Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "GO TO",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 137,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.favorite,
                                color: homePageIconColor),
                            label: const Text("Favorite Workouts",
                                style: TextStyle(color: Colors.black)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                elevation: 0),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 137,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const enterWeight()));
                            },
                            icon: const Icon(Icons.monitor_weight,
                                color: homePageIconColor),
                            label: const Text("Enter Weight",
                                style: TextStyle(color: Colors.black)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                elevation: 0),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 137,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.front_hand_rounded,
                                color: homePageIconColor),
                            label: const Text("Join Competition",
                                style: TextStyle(color: Colors.black)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                elevation: 0),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 137,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.push_pin,
                                color: homePageIconColor),
                            label: const Text("Gyms Near Me",
                                style: TextStyle(color: Colors.black)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                elevation: 0),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 137,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.camera_alt,
                                color: homePageIconColor),
                            label: const Text("Progress Pictures",
                                style: TextStyle(color: Colors.black)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                elevation: 0),
                          ),
                        ),
                      ],
                    ),
                  ),
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
            ]));
  }
}
