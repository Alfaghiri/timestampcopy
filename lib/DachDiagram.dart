/* 
 @authors:
 Abdul Wahhab Alfaghiri Al Anzi   01524445
 Nouzad Mohammad                  00820679
*/
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:week_of_year/week_of_year.dart';
import 'package:timestamp/Calculate.dart';

int _year = DateTime.now().year;
int _monthvalue = DateTime.now().month;

class DashDiagram extends StatefulWidget {
  const DashDiagram({super.key});
  @override
  State<DashDiagram> createState() => _DashDiagramState();
}

class _DashDiagramState extends State<DashDiagram> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
  }

  double _containerwidth = 700;
  double _containerheight = 350;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
          child: StreamBuilder<DocumentSnapshot>(
        // Get a stream of document snapshots using the user's UID
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          // Check if the snapshot has data
          if (snapshot.hasData) {
            // Get the data from the snapshot
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            List items = data['stunden'];
            List stamp = data['stamps'];
            Map contracts = data['contracts'];
            List holidays = data['holidays'];
            List competime = ['2000-01-01'];
            competime.addAll(data['comptime']);
            List vacation = data['vacation'];
            List sick = data['sick'];
            List start = [];
            List end = [];
            List days = [];
            List<int> workingDays = [];
            List<int> workingHours = [];
            String _monthname = Calculate().getmonthname(_monthvalue);
            List _weeks = Calculate().getWeeksOfMonth(_monthvalue, 2022);
            print(_weeks);
            String _weeknumber =
                Calculate().getWeekNumber(2, _monthvalue, _year).toString();
            for (int i = 0; i < contracts.length; i++) {
              start.add(contracts[(i + 1).toString()]['start']);
              end.add(contracts[(i + 1).toString()]['end']);
              days.add(contracts[(i + 1).toString()]['days']);
              workingDays.add(contracts[(i + 1).toString()]['workingDays']);
              workingHours.add(contracts[(i + 1).toString()]['workingHours']);
            }

            List<_worktimeData> datas = [
              _worktimeData(
                  'MO',
                  Calculate().toDoubleWithTwoDecimal(Calculate()
                      .toDoubleWithTwoDecimal(
                          Calculate().getHoursDay(stamp, 1, _weeks[0]+1 , _year))),
                  Calculate().toDoubleWithTwoDecimal(Calculate()
                      .toDoubleWithTwoDecimal(
                          Calculate().getHoursDay(stamp, 1, _weeks[1]+1 , _year))),
                  Calculate().toDoubleWithTwoDecimal(Calculate()
                      .toDoubleWithTwoDecimal(
                          Calculate().getHoursDay(stamp, 1, _weeks[2]+1 , _year))),
                  Calculate().toDoubleWithTwoDecimal(Calculate()
                      .toDoubleWithTwoDecimal(
                          Calculate().getHoursDay(stamp, 1, _weeks[3]+1 , _year))),
                           Calculate().toDoubleWithTwoDecimal(Calculate()
                      .toDoubleWithTwoDecimal(
                          Calculate().getHoursDay(stamp, 1, _weeks[4]+1 , _year)))),



              _worktimeData('DI', Calculate().toDoubleWithTwoDecimal(Calculate()
                      .toDoubleWithTwoDecimal(
                          Calculate().getHoursDay(stamp, 2, _weeks[0]+1 , _year))),  Calculate().toDoubleWithTwoDecimal(Calculate()
                      .toDoubleWithTwoDecimal(
                          Calculate().getHoursDay(stamp, 2, _weeks[1]+1 , _year))),  Calculate().toDoubleWithTwoDecimal(Calculate()
                      .toDoubleWithTwoDecimal(
                          Calculate().getHoursDay(stamp, 2, _weeks[2]+1 , _year))),  Calculate().toDoubleWithTwoDecimal(Calculate()
                      .toDoubleWithTwoDecimal(
                          Calculate().getHoursDay(stamp, 2, _weeks[3]+1 , _year))),
                          Calculate().toDoubleWithTwoDecimal(Calculate()
                      .toDoubleWithTwoDecimal(
                          Calculate().getHoursDay(stamp, 2, _weeks[4]+1 , _year)))),



              _worktimeData(
                'MI',
                 Calculate().toDoubleWithTwoDecimal(Calculate()
                      .toDoubleWithTwoDecimal(
                          Calculate().getHoursDay(stamp, 3, _weeks[0]+1 , _year))),
                 Calculate().toDoubleWithTwoDecimal(Calculate()
                      .toDoubleWithTwoDecimal(
                          Calculate().getHoursDay(stamp, 3, _weeks[1]+1 , _year))),
                 Calculate().toDoubleWithTwoDecimal(Calculate()
                      .toDoubleWithTwoDecimal(
                          Calculate().getHoursDay(stamp, 3, _weeks[2]+1 , _year))),
                 Calculate().toDoubleWithTwoDecimal(Calculate()
                      .toDoubleWithTwoDecimal(
                          Calculate().getHoursDay(stamp, 3, _weeks[3]+1 , _year))),
                          Calculate().toDoubleWithTwoDecimal(Calculate()
                      .toDoubleWithTwoDecimal(
                          Calculate().getHoursDay(stamp, 3, _weeks[4]+1 , _year)))
              ),




              _worktimeData('DO',  Calculate().toDoubleWithTwoDecimal(Calculate()
                      .toDoubleWithTwoDecimal(
                          Calculate().getHoursDay(stamp, 4, _weeks[0]+1 , _year))),  Calculate().toDoubleWithTwoDecimal(Calculate()
                      .toDoubleWithTwoDecimal(
                          Calculate().getHoursDay(stamp, 4, _weeks[1]+1 , _year))),  Calculate().toDoubleWithTwoDecimal(Calculate()
                      .toDoubleWithTwoDecimal(
                          Calculate().getHoursDay(stamp, 4, _weeks[2]+1 , _year))),  Calculate().toDoubleWithTwoDecimal(Calculate()
                      .toDoubleWithTwoDecimal(
                          Calculate().getHoursDay(stamp, 4, _weeks[3]+1 , _year))),
                          Calculate().toDoubleWithTwoDecimal(Calculate()
                      .toDoubleWithTwoDecimal(
                          Calculate().getHoursDay(stamp, 4, _weeks[4]+1 , _year)))),




              _worktimeData('FR',  Calculate().toDoubleWithTwoDecimal(Calculate()
                      .toDoubleWithTwoDecimal(
                          Calculate().getHoursDay(stamp, 5, _weeks[0]+1 , _year))), Calculate().toDoubleWithTwoDecimal(Calculate()
                      .toDoubleWithTwoDecimal(
                          Calculate().getHoursDay(stamp, 5, _weeks[1]+1 , _year))), Calculate().toDoubleWithTwoDecimal(Calculate()
                      .toDoubleWithTwoDecimal(
                          Calculate().getHoursDay(stamp, 5, _weeks[2]+1 , _year))), Calculate().toDoubleWithTwoDecimal(Calculate()
                      .toDoubleWithTwoDecimal(
                          Calculate().getHoursDay(stamp, 5, _weeks[3]+1 , _year))),
                          Calculate().toDoubleWithTwoDecimal(Calculate()
                      .toDoubleWithTwoDecimal(
                          Calculate().getHoursDay(stamp, 5, _weeks[4]+1 , _year)))),
            ];

            return Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: Color.fromARGB(80, 43, 181, 216).withOpacity(0.1),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Divider(
                      color: Colors.transparent,
                    ),
                    Center(
                      child: Wrap(children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (_monthvalue == 1) {
                                  _monthvalue = 12;
                                  _year--;
                                } else
                                  _monthvalue--;
                              });
                            },
                            icon: Icon(Icons.arrow_back_ios)),
                        Text(' $_monthname $_year', style: TextStyle(height: 2)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                if (_monthvalue == 12 || _monthvalue == 0) {
                                  _monthvalue = 1;
                                  _year++;
                                } else
                                  _monthvalue++;
                              });
                            },
                            icon: Icon(Icons.arrow_forward_ios))
                      ]),
                    ),
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
                              dataSource: datas,
                              xValueMapper: (_worktimeData worktime, _) =>
                                  worktime.day,
                              yValueMapper: (_worktimeData worktime, _) =>
                                  worktime.worktime,
                              name: '$_monthname W1',
                              // Enable data label
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true)),
                          LineSeries<_worktimeData, String>(
                              animationDuration: 6000,
                              animationDelay: 6000,
                              dataSource: datas,
                              xValueMapper: (_worktimeData worktime, _) =>
                                  worktime.day,
                              yValueMapper: (_worktimeData worktime, _) =>
                                  worktime.worktime1,
                              name: '$_monthname W2',
                              // Enable data label
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true)),

                          LineSeries<_worktimeData, String>(
                              animationDuration: 8000,
                              animationDelay: 8000,
                              dataSource: datas,
                              xValueMapper: (_worktimeData worktime, _) =>
                                  worktime.day,
                              yValueMapper: (_worktimeData worktime, _) =>
                                  worktime.worktime2,
                              name: '$_monthname W3',
                              // Enable data label
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true)),
                          LineSeries<_worktimeData, String>(
                              animationDuration: 10000,
                              animationDelay: 10000,
                              dataSource: datas,
                              xValueMapper: (_worktimeData worktime, _) =>
                                  worktime.day,
                              yValueMapper: (_worktimeData worktime, _) =>
                                  worktime.worktime3,
                              name: '$_monthname W4',
                              // Enable data label
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true)),
                                   LineSeries<_worktimeData, String>(
                              animationDuration: 4000,
                              animationDelay: 4000,
                              dataSource: datas,
                              xValueMapper: (_worktimeData worktime, _) =>
                                  worktime.day,
                              yValueMapper: (_worktimeData worktime, _) =>
                                  worktime.worktime,
                              name: '$_monthname W5',
                              // Enable data label
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true))
                        ]),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              width: 150,
              height: 150,
              child: CircularProgressIndicator(),
            );
          }
        },
      )),
    );
  }
}

class _worktimeData {
  _worktimeData(
      this.day, this.worktime, this.worktime1, this.worktime2, this.worktime3,this.worktime4);
  final String day;
  final double worktime;
  final double worktime1;
  final double worktime2;
  final double worktime3;
  final double worktime4;
}




  /* Container(
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

        ), */
