import 'package:flutter/material.dart';
import 'package:fitlife/view/calorie.dart';
import 'package:fitlife/view/account.dart';
import 'package:fitlife/view/socialMedia.dart';
import 'package:fitlife/view/homePage.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitlife/model/userWeight.dart';

import '../model/User.dart';
import '../model/user_database.dart';
class enterWeight extends StatefulWidget {
  const enterWeight({Key? key}) : super(key: key);

  @override
  State<enterWeight> createState() => _enterWeightState();
}

class _enterWeightState extends State<enterWeight> {
  int weight = 0;
  //String date = '';
  final List<userWeight> _userWeightList = [];

  void _saveWeight() {
    if (weight > 0 ) {
      setState(() {
        _userWeightList.add(userWeight(
          _userWeightList.length + 1,
          weight,
        ));
        weight = 0;
      });
    }
  }



  Future<void> insertUserWeight(int userId, List<userWeight> weightList) async {
    //idk how to add to model
    try {
      Database db = Database();
      var conn = await db.getSettings();
      var id = await conn.query("SELECT id from fitlife.userweight;");
      for (var weight in weightList) {
        await conn.query(
            'INSERT INTO fitlife.userweight (user_id, user_weight) VALUES (?,?);',
            [userId, weight.weight]);
      }
      await conn.close();
    } catch (e) {
      print("Error Occurred: $e");
    }
  }


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
          "Weigh In",
          style: TextStyle(fontSize: 26.5, color: Colors.black),
        ),
        actions: <Widget>[
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
            Text(
              'Please Input your weight in lbs below',
          style: GoogleFonts.montserrat(
            fontSize: 18.5,
            fontWeight: FontWeight.bold,
          )
              ),
            const SizedBox(height: 100.0),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter weight (lbs)',
                contentPadding: const EdgeInsets.all(16.0),
                suffixIcon: const Icon(Icons.monitor_weight_outlined),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(13.0),
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) {
                setState(() {
                  weight = int.parse(value);
                });
              },
            ),
            const SizedBox(height: 16.0),

            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed:  () async {
                _saveWeight();
                await insertUserWeight(currentUser.id, _userWeightList);
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
                setState(() {});
              },
              child: const Text('Save Weight'),
            ),
          ],
        ),
      ),
    );
  }
}
