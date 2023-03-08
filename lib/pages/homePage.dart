import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fitlife/pages/account.dart';
import 'package:fitlife/pages/calorie.dart';
import 'package:fitlife/pages/enterWeight.dart';
import 'package:fitlife/pages/socialMedia.dart';
import 'package:fitlife/pages/workouts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Senior Project',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'FITLIFE'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Widget _buildChart() {//test chart
  var data = [
    charts.Series<MyData, String>(
      id: 'myData',
      domainFn: (MyData myData, _) => myData.label,
      measureFn: (MyData myData, _) => myData.value,
      data: [
        MyData('A', 5),
        MyData('B', 25),
     //   MyData('C', 100),
      ],
    ),
  ];

  return SizedBox(//test chart
    height: 240,
    width: 215,
    child: charts.BarChart(
      data,
      animate: true,
      animationDuration: const Duration(milliseconds: 500),
      barRendererDecorator: charts.BarLabelDecorator<String>(),
    ),
  );
}

class MyData {//test chart
  final String label;
  final int value;

  MyData(this.label, this.value);
}

class _MyHomePageState extends State<MyHomePage> {
  static const homePageIconColor = Color(0xFFD76363);

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          // title: Text(widget.title),
          title: const Text(
            "FITLIFE",
            style: TextStyle(fontSize: 40, color: Colors.black),
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
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              //spacer
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  "Welcome Back, User",
                  style: GoogleFonts.montserrat(
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  const SizedBox(height: 35),
                  _buildChart(),
                  Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "GO TO",
                            style: TextStyle(
                              fontSize: 12,fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 137,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.favorite,
                                color: homePageIconColor),
                            label: Text("Favorite Workouts",
                                style: TextStyle(color: Colors.black)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                elevation: 0),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 137,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const enterWeight()));
                            },
                            icon: const Icon(Icons.monitor_weight,
                                color: homePageIconColor),
                            label: Text("Enter Weight",
                                style: TextStyle(color: Colors.black)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                elevation: 0),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 137,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.front_hand_rounded,
                                color: homePageIconColor),
                            label: const Text("Join Competition",
                                style: TextStyle(color: Colors.black)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                elevation: 0),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 137,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.push_pin,
                                color: homePageIconColor),
                            label: const Text("Gyms Near Me",
                                style: TextStyle(color: Colors.black)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                elevation: 0),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 137,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.camera_alt,
                                color: homePageIconColor),
                            label: const Text("Progress Pictures",
                                style: TextStyle(color: Colors.black)),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                elevation: 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35),
       AnimatedTextKit(
        isRepeatingAnimation: true,
        repeatForever: true,
        animatedTexts: [
          RotateAnimatedText('YOU HAVE BURNED 700 CALORIES TODAY',duration: Duration(seconds:7)),
          RotateAnimatedText('YOU STILL NEED 32g PROTEIN FOR THE DAY',duration: Duration(seconds:7)),
        ],
      ),
     ])
      );
  }
}
