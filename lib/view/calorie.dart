import 'package:fitlife/view/Results.dart';
import 'package:fitlife/view/account.dart';
import 'package:fitlife/controller/editCalorie.dart';
import 'package:fitlife/view/homePage.dart';
import 'package:fitlife/view/socialMedia.dart';
import 'package:fitlife/view/workouts.dart';
import '../model/Food.dart';
import '../Widgets/FoodWidgets.dart';
import 'package:flutter/material.dart';

class Calorie extends StatefulWidget {
  const Calorie({Key? key}) : super(key: key);

  @override
  State<Calorie> createState() => _CalorieState();
}


class _CalorieState extends State<Calorie> {
  List<Food> _foodList = [];
  int totalCalories=0;

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
            if(_foodList.isEmpty)
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "No meals logged for today",
                  style: TextStyle(
                    color: Colors.grey[600],
                    //fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: ()=> Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const Results(),
                  transitionDuration: const Duration(milliseconds: 1000),//page transition animation
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {//page transition animation
                    var begin = const Offset(0.0, 2.0);//page transition animation
                    var end = Offset.zero;//page transition animation
                    var curve = Curves.ease;//page transition animation
                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));//page transition animation
                    var offsetAnimation = animation.drive(tween);//page transition animation
                    return SlideTransition(//page transition animation
                      position: offsetAnimation,//page transition animation
                      child: child,
                    );
                  },
                ),
              )
                  .then((dataFromResults) {
                if (dataFromResults != null) {
                  setState(() {
                    _foodList = dataFromResults;
                  });
                }
              }
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
                      )
                  )
              ),
            ),

            if(_foodList.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 175.0),
                child: Text(
                  'Todays Meals',
                  style: TextStyle(
                    //  color: Colors.white,
                   // fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Colors.grey[600]
                  ),
                ),
              ),
            if(_foodList.isNotEmpty)
              Text(
                'Total calories for the day: $totalCalories',
                style: TextStyle(
                   color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            SizedBox(height: 25,),
            Expanded(
              child: ListView.builder(
                itemCount: _foodList.length,//list after selected
                itemBuilder: (context, index) {
                  totalCalories += _foodList[index].calorie;
                  return CalorieTile(
                    // add current food's calorie count to totalCalories
                      tileFoodName: _foodList[index].foodName,
                      tileCalorie: _foodList[index].calorie,
                      tileQuantity: _foodList[index].quantity
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

