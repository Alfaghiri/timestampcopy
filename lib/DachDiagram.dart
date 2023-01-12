import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:fl_chart/fl_chart.dart';
class DashDiagram extends StatefulWidget {
  const DashDiagram({super.key});
  @override
  State<DashDiagram> createState() => _DashDiagramState();
}
class _DashDiagramState extends State<DashDiagram> {
  double _containerwidth = 700;
  double _containerheight = 350;
  List<_worktimeData> data = [
    _worktimeData('MO', 8, 5, 6, 7),
    _worktimeData('DI', 9.5, 7, 6, 7),
    _worktimeData(
      'MI',
      7,
      6,
      8,
      9,
    ),
    _worktimeData('DO', 10, 5, 8, 4),
    _worktimeData('FR', 5, 4.5, 3.5, 2),
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            color: Color.fromARGB(80, 43, 181, 216).withOpacity(0.1),
          ),
          width: _containerwidth,
          height: _containerheight,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SfCartesianChart(
                    enableAxisAnimation: true,
                    primaryXAxis: CategoryAxis(),
                    // Chart title
                    title: ChartTitle(text: 'Arbeitsstunden'),
                    // Enable legend
                    legend: Legend(isVisible: true),
                    // Enable tooltip
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <ChartSeries<_worktimeData, String>>[
                      LineSeries<_worktimeData, String>(
                          animationDuration: 4000,
                          animationDelay: 4000,
                          dataSource: data,
                          xValueMapper: (_worktimeData worktime, _) =>
                              worktime.day,
                          yValueMapper: (_worktimeData worktime, _) =>
                              worktime.worktime,
                          name: 'Oktober W 1',
                          // Enable data label
                          dataLabelSettings:
                              DataLabelSettings(isVisible: true)),
                      LineSeries<_worktimeData, String>(
                          animationDuration: 6000,
                          animationDelay: 6000,
                          dataSource: data,
                          xValueMapper: (_worktimeData worktime, _) =>
                              worktime.day,
                          yValueMapper: (_worktimeData worktime, _) =>
                              worktime.worktime1,
                          name: 'Oktober W 2',
                          // Enable data label
                          dataLabelSettings:
                              DataLabelSettings(isVisible: true)),
                      LineSeries<_worktimeData, String>(
                          animationDuration: 8000,
                          animationDelay: 8000,
                          dataSource: data,
                          xValueMapper: (_worktimeData worktime, _) =>
                              worktime.day,
                          yValueMapper: (_worktimeData worktime, _) =>
                              worktime.worktime2,
                          name: 'Oktober W 3',
                          // Enable data label
                          dataLabelSettings:
                              DataLabelSettings(isVisible: true)),
                      LineSeries<_worktimeData, String>(
                          animationDuration: 10000,
                          animationDelay: 10000,
                          dataSource: data,
                          xValueMapper: (_worktimeData worktime, _) =>
                              worktime.day,
                          yValueMapper: (_worktimeData worktime, _) =>
                              worktime.worktime3,
                          name: 'Oktober W 4',
                          // Enable data label
                          dataLabelSettings: DataLabelSettings(isVisible: true))
                    ]),
              ],
            ),
          ),
          /* SfCartesianChart(
            plotAreaBorderWidth: 0,
            borderWidth: 2,
            primaryXAxis: CategoryAxis(title: AxisTitle(text: "")),
            primaryYAxis: CategoryAxis(title: AxisTitle(text: "Stunden")),
            legend: Legend(isVisible: false),
            plotAreaBackgroundColor: Color.fromARGB(0, 96, 125, 139),
            plotAreaBorderColor: Colors.blueAccent,
            tooltipBehavior: TooltipBehavior(enable: true),
            title: ChartTitle(text: ""),
            series: <ChartSeries>[
              BarSeries<_worktimeData, String>(
                  dataSource: data,
                  width: 0.7,
                  xValueMapper: (_worktimeData worktime, _) => worktime.day,
                  yValueMapper: (_worktimeData worktime, _) => worktime.worktime,
                  dataLabelSettings: DataLabelSettings(isVisible: true))
            ],
          ), */
        ),
      ),
    );
  }
}
class _worktimeData {
  _worktimeData(
      this.day, this.worktime, this.worktime1, this.worktime2, this.worktime3);
  final String day;
  final double worktime;
  final double worktime1;
  final double worktime2;
  final double worktime3;
}
