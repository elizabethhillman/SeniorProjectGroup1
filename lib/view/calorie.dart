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
  final void Function(BuildContext)? editTap; //not implemented yet
  final void Function(BuildContext)? deleteTap;//not implemented yet

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
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[200],
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
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(
                    '$tileCalorie calories',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text("50g of protein",
                    style: TextStyle(
                      color: Colors.brown[400],
                      fontSize: 13,
                    ),
                  ),
                  Text("30g of carbs",
                    style: TextStyle(
                      color: Colors.brown[400],
                      fontSize: 13,
                    ),
                  ),

                ],
              ),
              SizedBox(width: 30),
              Text(
                'Slide to edit',
                style: TextStyle(
                  color: Colors.grey[350],
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Icon(Icons.arrow_forward_ios_sharp)
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
      backgroundColor: Colors.blue[800],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
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
      body: Column(
        children: [
          const SizedBox(
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
                backgroundColor: Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ), child: Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.search, size: 36,color: Colors.black,),
                SizedBox(width: 80),
                Text(
                  'Log foods',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18
                  ),
                ),
              ],
            ),
            ),
          ),

          if(_foodList.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 175.0),
              child: Text(
                "No meals logged for today",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ),
          if(_foodList.isNotEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 175.0),
              child: Text(
                'Todays Meals',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ),
          if(_foodList.isNotEmpty)
            Text(
              'Total calories for the day: $totalCalories',
              style: TextStyle(
                color: Colors.white,
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
    );
  }
}

