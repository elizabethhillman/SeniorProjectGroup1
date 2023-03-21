import 'package:fitlife/view/Results.dart';
import 'package:fitlife/view/account.dart';
import 'package:fitlife/controller/editCalorie.dart';
import 'package:fitlife/view/homePage.dart';
import 'package:fitlife/view/socialMedia.dart';
import 'package:fitlife/view/workouts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class Calorie extends StatefulWidget {
  const Calorie({Key? key}) : super(key: key);

  @override
  State<Calorie> createState() => _CalorieState();
}
class CalorieTile extends StatelessWidget {
  final String tileFoodName;
  final int tileCalorie;
  final int tileQuantity;
  //TODO final int tileProtein
  //TODO final int tileCarbs
  final void Function(BuildContext)? editTap; //TODO implement method
  final void Function(BuildContext)? deleteTap;//TODO  implement method

  const CalorieTile({
    Key? key,
    required this.tileFoodName,
    required this.tileCalorie,
    required this.tileQuantity,
    this.editTap,
    this.deleteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: editTap,
              backgroundColor: Colors.greenAccent,
              icon: Icons.edit,
              borderRadius: BorderRadius.circular(12),
            ),
            SlidableAction(
              onPressed: deleteTap,
              backgroundColor: Colors.redAccent,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.only(
            top: 15.0,
            bottom: 1.0,
            left: 15.0,
            right: 15.0,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$tileFoodName x $tileQuantity',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(
                    '$tileCalorie calories',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Chip(
                        backgroundColor: Colors.brown[100],
                        label: Text("50g protein",
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Chip(
                        backgroundColor: Colors.orange[100],
                        label: Text("50g carb",
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Transform.translate(
                offset: Offset(0,-7.0),
                child:  Text(
                  'Slide to edit',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(0, -7.0),
                child: Icon(Icons.arrow_forward_ios_sharp),
              ),
              // SizedBox(width: 30),
            ],
          ),
        ),
      ),
    );
  }
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
          children: [
            if(_foodList.isEmpty)
              Padding(
                padding: EdgeInsets.only(top: 125.0),
                child: Text(
                  "No meals logged for today",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
              ),
            const SizedBox(
              height: 45,
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
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(25),
                  child: const Center(
                      child: Text(
                        'Log Foods',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                  )
              ),
            ),

            if(_foodList.isNotEmpty)
              const Padding(
                padding: EdgeInsets.only(top: 175.0),
                child: Text(
                  'Todays Meals',
                  style: TextStyle(
                    //  color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
              ),
            if(_foodList.isNotEmpty)
              Text(
                'Total calories for the day: $totalCalories',
                style: const TextStyle(
                  // color: Colors.white,
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

