import 'package:fitlife/pages/Results.dart';
import 'package:fitlife/pages/account.dart';
import 'package:fitlife/pages/editCalorie.dart';
import 'package:fitlife/pages/homePage.dart';
import 'package:fitlife/pages/socialMedia.dart';
import 'package:fitlife/pages/workouts.dart';
import 'package:flutter/material.dart';

class Calorie extends StatefulWidget {
  const Calorie({Key? key}) : super(key: key);

  @override
  State<Calorie> createState() => _CalorieState();
}

class _CalorieState extends State<Calorie> {
  List<String> _foodList = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  MaterialPageRoute(builder: (context) => const Workouts()));
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
      body: Column(
        children: [
          SizedBox(
              height: 10,
          ),
             Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  {
                    Navigator.push(
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
                      if (dataFromResults != null){
                        setState(() {
                          _foodList = dataFromResults;
                        });//data from returned selected food
                      }
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ), child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Log foods',
                    style: TextStyle(fontSize: 18),
                  ),
                  //SizedBox(width: 10), //changes spacing of the button text nd icon
                  Icon(Icons.search, size: 36),
                ],
              ),
              ),
            ),

          if(_foodList.isEmpty)
            Padding(
              padding: EdgeInsets.only(top: 175.0),
                child: Text(
                  "No meals logged for today",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
            ),
          if(_foodList.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 175.0),
              child: Text(
                "Todays Meals",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _foodList.length,//list after selected
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_foodList[index]),
                  onTap: () async {//edit
                    final updatedFoodItem = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => EditCalorie(foodItem: _foodList[index]),
                      ),
                    );
                    if (updatedFoodItem != null) {
                      setState(() {
                        _foodList[index] = updatedFoodItem;
                      });
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
