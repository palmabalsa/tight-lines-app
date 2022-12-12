import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../services/tt_river_level.dart';

class LineChartWidget extends StatelessWidget {
  final List<TTRiverLevelData>? datapoints;
  const LineChartWidget({Key? key, this.datapoints}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(LineChartData(
          gridData: FlGridData(
              show: true,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Color.fromARGB(255, 185, 184, 183),
                  strokeWidth: 1,
                );
              },
              drawVerticalLine: true,
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Color.fromARGB(255, 185, 184, 183),
                  strokeWidth: 1,
                );
              }),
          // minX: 0,
          // maxX: 4,
          // minY: 0,
          //  for maxY you can take value that is from your data?
          // maxY: 500,
          borderData: FlBorderData(
              show: true,
              border: Border.all(
                  color: Color.fromARGB(255, 185, 184, 183), width: 1)),
          titlesData: FlTitlesData(
              show: true,
              leftTitles: AxisTitles(
                  axisNameWidget: const Text('Water Level'),
                  sideTitles: SideTitles(
                    showTitles: true,
                  )),
              topTitles: null,
              rightTitles: null,
              bottomTitles: AxisTitles(axisNameWidget: const Text('Date'))),
          lineBarsData: [
            LineChartBarData(
                spots: [
                  FlSpot(1, 10),
                  FlSpot(2, 100),
                  FlSpot(3, 250),
                  FlSpot(4, 50),
                  FlSpot(5, 100),
                ],
                isCurved: true,
                barWidth: 3,
                belowBarData: BarAreaData(
                  show: true,
                  color: Color.fromARGB(255, 179, 221, 241).withOpacity(0.3),
                )
                // spots: datapoints
                //     .map((point) =>
                //         FlSpot(point.fiveMinInterval, point.waterLevel))
                //     .toList()
                )
          ])),
    );
  }
}
