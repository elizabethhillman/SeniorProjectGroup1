import 'package:fitlife/model/User.dart';
import 'package:fitlife/view/Results.dart';
import 'package:fitlife/view/Widgets/FoodWidgets.dart';
import 'package:fitlife/view/account.dart';
import 'package:fitlife/view/homePage.dart';
import 'package:fitlife/view/socialMedia.dart';
import 'package:fitlife/view/workouts.dart';
import 'package:flutter/material.dart';

import '../model/Food.dart';
import '../model/user_database.dart';

class Calorie extends StatefulWidget {
  const Calorie({Key? key}) : super(key: key);

  @override
  State<Calorie> createState() => _CalorieState();
}

class _CalorieState extends State<Calorie> {
  num totalCalories = 0;
  final List<Food> _currentUserFoodListFromDB = [];

  //TODO implement edit method

  @override
  void initState() {
    super.initState();
    _getSelectedFoodFromDB();
  }

  Future<void> _getSelectedFoodFromDB() async {
    //idk how to add to model
    try {
      Database db = Database();
      var conn = await db.getSettings();
      var id = await conn.query(
          "SELECT * from fitlife.userfoodlog WHERE user_id = ${currentUser.id}");
      var result = await conn.query(
          'SELECT id,user_id,foodName, calorie, quantity FROM fitlife.userfoodlog WHERE user_id = ${currentUser.id}');

      setState(() {
        for (var row in result) {
          {
            _currentUserFoodListFromDB
                .add(Food(row[0], row[3], row[4], row[5]));
          }
          totalCalories += row[4];
        }
      });
      await conn.close();
    } catch (e) {
      print("Error Occurred: $e");
    }
  }

  Future<void> deleteRowFromTable(int index) async {
    try {
      Database db = Database();
      var conn = await db.getSettings();
      var id = await conn.query("SELECT * from fitlife.userfoodlog");
      var result = await conn.query(
          'DELETE FROM fitlife.userfoodlog WHERE id = ?',
          [_currentUserFoodListFromDB[index].foodId]);

      await conn.close();
    } catch (e) {
      print('Error while deleting row: $e');
    }
  }

  void _handleDeleteTap(int index) async {
    await deleteRowFromTable(index);
    setState(() {
      _currentUserFoodListFromDB.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blue[100],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.home,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
        ),
        title: const Text(
          "Calories",
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.fitness_center),
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyWorkouts()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.group),
            color: Colors.black,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SocialMedia()));
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_currentUserFoodListFromDB.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 155),
                child: Text(
                  "No meals logged for today",
                  style: TextStyle(
                    color: Colors.grey[600], //fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
              ),
            const SizedBox(
              height: 20,
            ),

            if (_currentUserFoodListFromDB.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Text(
                  'Todays Meals',
                  style: TextStyle(
                      //  color: Colors.white,
                      // fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      color: Colors.grey[600]),
                ),
              ),
            if (_currentUserFoodListFromDB.isNotEmpty)
              Text(
                'Total calories for the day: $totalCalories',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: ListView.builder(
                itemCount:
                    _currentUserFoodListFromDB.length, //list after selected
                itemBuilder: (context, index) {
                  return CalorieTile(
                    // add current food's calorie count to totalCalories
                    tileFoodName: _currentUserFoodListFromDB[index].foodName,
                    tileCalorie: _currentUserFoodListFromDB[index].calorie,
                    tileQuantity: _currentUserFoodListFromDB[index].quantity,
                    deleteTap: (context) => _handleDeleteTap(index),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const Results(),
                  transitionDuration: const Duration(milliseconds: 1000),
                  //page transition animation
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    //page transition animation
                    var begin =
                    const Offset(0.0, 2.0); //page transition animation
                    var end = Offset.zero; //page transition animation
                    var curve = Curves.ease; //page transition animation
                    var tween = Tween(begin: begin, end: end).chain(
                        CurveTween(curve: curve)); //page transition animation
                    var offsetAnimation =
                    animation.drive(tween); //page transition animation
                    return SlideTransition(
                      //page transition animation
                      position: offsetAnimation, //page transition animation
                      child: child,
                    );
                  },
                ),
              ),
              child: Container(
                  width: 225,
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(25),
                  child: Center(
                      child: Text(
                        'Log Foods',
                        style: TextStyle(
                          color: Colors.grey[200],
                          fontWeight: FontWeight.bold,
                        ),
                      ))),
            ),
            const SizedBox(
              height: 125,
            ),
          ],
        ),
      ),
    );
  }
}
