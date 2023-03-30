import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomePageWidget extends StatelessWidget{
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //test chart
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
}

class MyData {
  //test chart
  final String label;
  final int value;

  MyData(this.label, this.value);
}

