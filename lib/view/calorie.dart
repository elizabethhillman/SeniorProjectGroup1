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
  num totalCarbs = 0;
  num totalProtein = 0;
  num totalFat = 0;
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
          'SELECT id,user_id,foodName, calorie, quantity,carbs, protein, fat FROM fitlife.userfoodlog WHERE user_id = ${currentUser.id}');

      setState(() {
        for (var row in result) {
          {
            _currentUserFoodListFromDB
                .add(Food(row[0], row[3], row[4], row[5], row[6], row[7], row[8]));
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

  Future<void> deleteRowFromTable(int index) async {
    try {
      Database db = Database();
      var conn = await db.getSettings();
      var id = await conn.query("SELECT * from fitlife.userfoodlog");
      var result = await conn.query(
          'DELETE FROM fitlife.userfoodlog WHERE id = ?',
          [_currentUserFoodListFromDB[index].foodId]);

      totalCalories = totalCalories - _currentUserFoodListFromDB[index].calorie;
      totalProtein = totalProtein - (_currentUserFoodListFromDB[index].protein ?? 0);
      totalCarbs = totalCarbs - (_currentUserFoodListFromDB[index].carbs ?? 0);
      totalFat = totalFat - (_currentUserFoodListFromDB[index].fat ?? 0 );
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
                      fontSize: 25.0,
                      color: Colors.grey[700]),
                ),
              ),
            SizedBox(
              height: 16,
            ),
            if (_currentUserFoodListFromDB.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total calories for the day:',
                    style: TextStyle(
                      color: Colors.grey[600], //   fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    ' $totalCalories',
                    style: TextStyle(
                      color: Colors.green[200],
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            SizedBox(
              height: 6,
            ),
            if (_currentUserFoodListFromDB.isNotEmpty)
              Text(
                'Total macros:',
                style: TextStyle(
                  color: Colors.grey[500], //  fontWeight: FontWeight.bold,
                  fontSize: 13.5,
                ),
              ),
            if (_currentUserFoodListFromDB.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Chip(
                    backgroundColor: Colors.orange[100],
                    label: Text(
                      "$totalCarbs"+"g carb",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Chip(
                    backgroundColor: Colors.brown[100],
                    label: Text(
                      "$totalProtein"+"g protein",
                      style: TextStyle(
                        color: Colors.grey[800], // fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Chip(
                    backgroundColor: Colors.yellow[400],
                    label: Text(
                      "$totalFat"+"g fat",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(
              height: 25,
            ),
            if (_currentUserFoodListFromDB.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: Colors.grey[700],
                  ),SizedBox(width: 5,),
                  Text(
                    '${DateTime.now().month}/${DateTime.now().day}/${DateTime.now().year}:',
                    style: TextStyle(
                      color: Colors.grey[600], //  fontWeight: FontWeight.bold,
                      fontSize: 13.5,
                    ),
                  ),
                ],
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
                    tileCarbs: _currentUserFoodListFromDB[index].carbs,
                    tileProtein: _currentUserFoodListFromDB[index].protein,
                    tileFat: _currentUserFoodListFromDB[index].fat,
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
