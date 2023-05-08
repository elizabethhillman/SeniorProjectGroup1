import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/User.dart';
import '../../model/userWeight.dart';
import '../../model/user_database.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final List<userWeight> _userWeightList = [];

  Future<void> _getWeightFromDB() async {
    try {
      Database db = Database();
      var conn = await db.getSettings();
      var id = await conn.query(
          "SELECT * from fitlife.userweight WHERE user_id = ${currentUser.id}");
      var result = await conn.query(
          "SELECT id, user_id, user_weight, created_at FROM fitlife.userweight WHERE user_id = ${currentUser.id}");
      setState(() {
        for (var row in result) {
          String? formattedDate = row[3] != null
              ? DateFormat('MM-dd').format(row[3].toUtc())
              : null;
          _userWeightList.add(userWeight(row[0], row[2], date: formattedDate));
        }
      });
      await conn.close();

      // Print the first content of _userWeightList after the list has been updated
    } catch (e) {
      print("Error Occurred: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _getWeightFromDB();
  }

  @override
  Widget build(BuildContext context) {
    List<MyData> chartData = _userWeightList
        .map((weight) => MyData(weight.date ?? '', weight.weight))
        .toList();

    var data = [
      charts.Series<MyData, String>(
        id: 'myData',
        domainFn: (MyData myData, _) => myData.label,
        measureFn: (MyData myData, _) => myData.value,
        data: chartData,
        // Use the generated chartData
        labelAccessorFn: (MyData myData, _) =>
            '${myData.value}', // Add this line
      ),
    ];

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
       Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Weight Progress',
          style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey[600]),
        ),
      ),
      SizedBox(
        height: 250,
        width: 300,
        child: charts.BarChart(
          data,
          animate: true,
          animationDuration: const Duration(milliseconds: 1000),
          barRendererDecorator: charts.BarLabelDecorator<String>(
            insideLabelStyleSpec: const charts.TextStyleSpec(
              fontSize: 13, // size in Pts.
              color: charts.MaterialPalette.white,
            ),
          ),
          primaryMeasureAxis: const charts.NumericAxisSpec(
            renderSpec: charts.GridlineRendererSpec(
              labelStyle: charts.TextStyleSpec(
                fontSize: 12, // size in Pts.
                color: charts.MaterialPalette.black,
              ),
              lineStyle: charts.LineStyleSpec(
                color: charts.MaterialPalette.black,
              ),
            ),
          ),
          domainAxis: charts.OrdinalAxisSpec(
            renderSpec: charts.SmallTickRendererSpec(
              labelStyle: const charts.TextStyleSpec(
                fontSize: 12, // size in Pts.
                color: charts.MaterialPalette.black,
              ),
              lineStyle: charts.LineStyleSpec(
                color: charts.MaterialPalette.gray.shadeDefault,
              ),
            ),
          ),
        ),
      )
    ]);
  }
}

class MyData {
  final String label;
  final int value;

  MyData(this.label, this.value);
}
