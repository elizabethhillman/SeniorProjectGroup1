import 'package:flutter/material.dart';
import 'package:fitlife/pages/calorie.dart';
import 'package:fitlife/pages/account.dart';
import 'package:fitlife/pages/socialMedia.dart';
import 'package:fitlife/pages/homePage.dart';
import 'package:google_fonts/google_fonts.dart';
class enterWeight extends StatefulWidget {
  const enterWeight({Key? key}) : super(key: key);

  @override
  State<enterWeight> createState() => _enterWeightState();
}

class _enterWeightState extends State<enterWeight> {
  String weight = '';
  String date = '';

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
        //  crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Please Input your weight below',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )
              ),
            SizedBox(height: 100.0),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter weight',
                contentPadding: EdgeInsets.all(16.0),
                  suffixIcon: Icon(Icons.monitor_weight_outlined),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(13.0),
                  )
              ),
              onChanged: (value) {
                setState(() {
                  weight = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter date',
                contentPadding: EdgeInsets.all(16.0),
                suffixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(13.0),
                ),
            ),
              onChanged: (value) {
                setState(() {
                  date = value;
                });
              },
            ),

            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
              Navigator.pop(context);
              },
              child: Text('Save Weight'),
            ),
          ],
        ),
      ),
    );
  }
}
