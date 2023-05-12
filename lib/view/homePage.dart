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

import '../model/Food.dart';
import '../model/user_database.dart';
import 'Feed.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
  num totalCalories = 0;
  num totalCarbs = 0;
  num totalProtein = 0;
  num totalFat = 0;

  final List<Food> _currentUserFoodListFromDB = [];
  DateTime _selectedDate = DateTime.now();
  DateTime currentDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  void initState() {
    super.initState();
    _getSelectedFoodFromDB();
  }

  Future<void> _getSelectedFoodFromDB() async {
    try {
      Database db = Database();
      var conn = await db.getSettings();
      var id = await conn.query(
          "SELECT * from fitlife.userfoodlog WHERE user_id = ${currentUser.id}");
      var result = await conn.query(
          'SELECT * FROM fitlife.userfoodlog WHERE user_id = ${currentUser.id} AND DATE(created_at) = ?',
          [
            DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day)
                .toIso8601String()
                .substring(0, 10)
          ]);
      setState(() {
        for (var row in result) {
          {
            _currentUserFoodListFromDB.add(Food(row[0], row[3].toString(),
                row[4], row[5], row[6], row[7], row[8], row[9]));
          }
          totalCalories += row[4];
          totalCarbs += row[6] ?? 0;
          totalProtein += row[7] ?? 0;
          totalFat += row[8] ?? 0;
        }
      });
      await conn.close();
    } catch (e) {
      print("Error Occurred: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                child: Row(
                  children: [
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
                            color: homePageIconColor, size: 40),
                        label: const Text("Favorite Workouts",
                            style:
                                TextStyle(color: Colors.black, fontSize: 12)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent, elevation: 0),
                      ),
                    ),
                    SizedBox(
                      width: 130,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const enterWeight()));
                        },
                        icon: const Icon(Icons.monitor_weight,
                            size: 40, color: homePageIconColor),
                        label: const Text("Enter Weight",
                            style:
                                TextStyle(color: Colors.black, fontSize: 12)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent, elevation: 0),
                      ),
                    ),
                    SizedBox(
                      width: 130,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Feed()));
                        },
                        icon: const Icon(Icons.camera_alt_sharp,
                            size: 40, color: homePageIconColor),
                        label: const Text("View Feed",
                            style:
                                TextStyle(color: Colors.black, fontSize: 12)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent, elevation: 0),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Row(
                children: const [
                  SizedBox(width: 30),
                  HomePageWidget(),
                ],
              ),

              const SizedBox(height: 35),
              AnimatedTextKit(
                isRepeatingAnimation: true,
                repeatForever: true,
                animatedTexts: [
                  RotateAnimatedText(
                      'YOU HAVE LOGGED ${totalCalories} CALORIES FOR THE DAY',
                      duration: const Duration(seconds: 5)),
                  RotateAnimatedText('YOU HAD ${totalCarbs}g CARBS FOR THE DAY',
                      duration: const Duration(seconds: 5)),
                  RotateAnimatedText(
                      'YOU HAD ${totalProtein}g PROTEIN FOR THE DAY',
                      duration: const Duration(seconds: 5)),
                  RotateAnimatedText('YOU HAD ${totalFat}g FAT FOR THE DAY',
                      duration: const Duration(seconds: 5)),
                ],
              ),
            ])));
  }
}
