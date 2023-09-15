import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';

import '../models/push_up_add.dart';

class StatsFilterButton extends StatelessWidget {
  final List<PushUpAdd> chartData;
  const StatsFilterButton({super.key, required this.chartData});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      series: <ChartSeries>[
        ColumnSeries<PushUpAdd, String>(
          dataSource: chartData,
          xValueMapper: (PushUpAdd pushUp, _) => pushUp.axe,
          yValueMapper: (PushUpAdd pushUp, _) => pushUp.number,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          borderColor: Colors.black,
          borderWidth: 3,
          color: Colors.white,
        )
      ]
    );
  }
}


//
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// @override
// Widget build(BuildContext context) {
//   final List<PushUpAdd> chartData = [
//     PushUpAdd(2010, 35),
//     PushUpAdd(2011, 28),
//     PushUpAdd(2012, 34),
//     PushUpAdd(2013, 32),
//     PushUpAdd(2014, 40)
//   ];
//   return Scaffold(
//   body: Center(
//   child: Container(
//   child: SfCartesianChart(
//   primaryXAxis: DateTimeAxis(),
//   series: <ChartSeries>[
//   // Renders line chart
//   LineSeries<PushUpAdd, DateTime>(
//   dataSource: chartData,
//   xValueMapper: (PushUpAdd sales, _) => sales.year,
//   yValueMapper: (PushUpAdd sales, _) => sales.sales
//   )
//   ]
//   )
//   )
//   )
//   );
// }
//
// class PushUpAdd {
//   PushUpAdd(this.year, this.sales);
//   final DateTime year;
//   final double sales;
// }