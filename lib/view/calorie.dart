import 'package:fitlife/model/User.dart';
import 'package:fitlife/view/Results.dart';
import 'package:fitlife/view/Widgets/FoodWidgets.dart';
import 'package:fitlife/view/account.dart';
import 'package:fitlife/view/homePage.dart';
import 'package:fitlife/view/socialMedia.dart';
import 'package:fitlife/view/workouts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../controller/EditFoodDialog.dart';
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
  bool _isToday = true;
  final List<Food> _currentUserFoodListFromDB = [];
  DateTime _selectedDate = DateTime.now();
  DateTime currentDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);



  @override
  void initState() {
    super.initState();
    _isToday = isToday(_selectedDate);
    _getSelectedFoodFromDB();
  }

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  /* Future<void> _getSelectedFoodFromDB() async {
    _currentUserFoodListFromDB.clear();
    totalCalories = 0;
    totalCarbs = 0;
    totalProtein = 0;
    totalFat = 0;
    try {
      Database db = Database();
      var conn = await db.getSettings();
      var id = await conn.query(
          "SELECT * from fitlife.userfoodlog WHERE user_id = ${currentUser.id}");
      var result = await conn.query(
          'SELECT id,user_id,foodName, calorie, quantity,carbs, protein, fat,grams, created_at FROM fitlife.userfoodlog WHERE user_id = ${currentUser.id} AND DATE created_at = ${_selectedDate.toIso8601String().substring(0, 10)}');
      setState(() {
        for (var row in result) {
          {
            _currentUserFoodListFromDB.add(Food(row[0], row[3].toString(),
                row[4], row[5], row[6], row[7], row[8],row[9]));
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
  }*/

  Future<void> _getSelectedFoodFromDB() async {
    _currentUserFoodListFromDB.clear();
    totalCalories = 0;
    totalCarbs = 0;
    totalProtein = 0;
    totalFat = 0;
    try {
      Database db = Database();
      var conn = await db.getSettings();
      var id = await conn.query(
          "SELECT * from fitlife.userfoodlog WHERE user_id = ${currentUser.id}");
      var result = await conn.query(
          'SELECT * FROM fitlife.userfoodlog WHERE user_id = ${currentUser.id} AND DATE(created_at) = ?',
          [DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day).toIso8601String().substring(0, 10)]);
      setState(() {
        for (var row in result) {
          {
            _currentUserFoodListFromDB.add(Food(row[0], row[3].toString(),
                row[4], row[5], row[6], row[7], row[8],row[9]));
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2018, 1),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = DateTime(picked.year, picked.month, picked.day);
        _isToday = isToday(_selectedDate); // Add this line
      });
      _getSelectedFoodFromDB(); // Refresh the food data after changing the date
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
      totalProtein =
          totalProtein - (_currentUserFoodListFromDB[index].protein ?? 0);
      totalCarbs = totalCarbs - (_currentUserFoodListFromDB[index].carbs ?? 0);
      totalFat = totalFat - (_currentUserFoodListFromDB[index].fat ?? 0);
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

  void _handleEditTap(int index) async {
    final originalFood = _currentUserFoodListFromDB[index];
    final updatedFood = await showDialog<Food>(
      context: context,
      builder: (context) {
        return EditFoodDialog(
          food: originalFood,
        );
      },
    );

    if (updatedFood != null) {
      await updateRowInTable(updatedFood);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        setState(() {
          // Update the food item in the list
          _currentUserFoodListFromDB[index] = updatedFood;

          totalCalories =
              totalCalories - originalFood.calorie + updatedFood.calorie;
          totalCarbs =
              totalCarbs - (originalFood.carbs ?? 0) + (updatedFood.carbs ?? 0);
          totalProtein = totalProtein -
              (originalFood.protein ?? 0) +
              (updatedFood.protein ?? 0);
          totalFat =
              totalFat - (originalFood.fat ?? 0) + (updatedFood.fat ?? 0);
        });
      });
    }
  }

  Future<void> updateRowInTable(Food updatedFoods) async {
    try {
      Database db = Database();
      var conn = await db.getSettings();
      var id = await conn.query("SELECT * from fitlife.userexerciselog");
      var result = await conn.query(
          'UPDATE fitlife.userfoodlog SET quantity = ?, calorie = ?, carbs = ?, protein = ?, fat = ? WHERE id = ?',
          [
            updatedFoods.quantity,
            updatedFoods.calorie,
            updatedFoods.carbs,
            updatedFoods.protein,
            updatedFoods.fat,
            updatedFoods.foodId
          ]);
    } catch (e) {
      print('Error while updating row: $e');
    }
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

            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                _isToday ? 'Today\'s Meals' : 'Meals from ${_selectedDate.month}/${_selectedDate.day}/${_selectedDate.year}',
                style: TextStyle(
                  fontSize: 25.0,
                  color: _isToday ? Colors.grey[700] : Colors.blueAccent[400],
                ),
              ),
            ),

            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total calories for the day:',
                  style: TextStyle(
                    color: _isToday ? Colors.grey[600] : Colors.blueAccent[400],
                    fontSize: 14.0,
                  ),
                ),
                Text(
                  ' $totalCalories',
                  style: TextStyle(
                    color:totalCalories==0 ? Colors.red[300] : Colors.green[200] ,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              'Total macros:',
              style: TextStyle(
                color: _isToday ? Colors.grey[500] : Colors.blueAccent[200],
                fontSize: 13.5,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Chip(
                  backgroundColor: totalCarbs==0 ?  Colors.red[200] : Colors.orange[100],
                  label: Text(
                    "$totalCarbs" "g carb",
                    style: TextStyle(
                      color: Colors.grey[800] ,
                      fontSize: 10,
                    ),
                  ),
                ),
                Chip(
                  backgroundColor: totalProtein==0 ? Colors.red[200] : Colors.brown[100],
                  label: Text(
                    "$totalProtein" "g protein",
                    style: TextStyle(
                      color: Colors.grey[800] ,
                      fontSize: 10,
                    ),
                  ),
                ),
                Chip(
                  backgroundColor: totalCarbs==0 ?  Colors.red[200] : Colors.yellow[400],
                  label: Text(
                    "$totalFat" "g fat",
                    style: TextStyle(
                      color: Colors.grey[800] ,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: _isToday ? Colors.grey[600] : Colors.blueAccent[400],
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${_selectedDate.month}/${_selectedDate.day}/${_selectedDate.year}:',
                    style: TextStyle(
                      color: _isToday ? Colors.grey[600] : Colors.blueAccent[400],
                      fontSize: 13.5,
                    ),
                  ),
                ],
              ),
            ),

            if (_currentUserFoodListFromDB.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Text(
                  "No meals logged for the day",
                  style: TextStyle(
                    color: Colors.grey[600], //fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  ),
                ),
              ),

            if (_currentUserFoodListFromDB.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text(
                  "Select another date to view previous logs",
                  style: TextStyle(
                    color: Colors.grey[500], //fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
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
                    editTap: (context) => _handleEditTap(index),
                    deleteTap: (context) => _handleDeleteTap(index),
                    containerColor: _isToday ?  Colors.grey[300] : Colors.blue[50],
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