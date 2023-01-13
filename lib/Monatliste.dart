// ignore_for_file: prefer_const_constructors
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timestamp/Calculate.dart';
import 'package:timestamp/Dashhome.dart';
import 'package:timestamp/responsive.dart';
double _top = 10;
double _right = 10;
double _left = 10;
double _bottom = 10;
String? _monthvalue = DateTime.now().month.toString();
String? _yearvalue = DateTime.now().year.toString();
String _holidays = '0';
class Monatliste extends StatefulWidget {
  const Monatliste({super.key});
  @override
  State<Monatliste> createState() => _Monatliste();
}
class _Monatliste extends State<Monatliste> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double fontstyle = MediaQuery.of(context).size.width * 0.02;
    double fontstyle1 = MediaQuery.of(context).size.width * 0.025;
    double textheight = MediaQuery.of(context).size.width * 0.002;
    if (Responsive.isDesktop(context)) {
      setState(() {
        _top = 0;
        _right = MediaQuery.of(context).size.width * 0.2;
        _left = MediaQuery.of(context).size.width * 0.2;
        _bottom = MediaQuery.of(context).size.width * 0.02;
        fontstyle = MediaQuery.of(context).size.width * 0.015;
        fontstyle1 = MediaQuery.of(context).size.width * 0.015;
        textheight = MediaQuery.of(context).size.width * 0.001;
      });
    }
    if (Responsive.isTablet(context)) {
      setState(() {
        _top = MediaQuery.of(context).size.width * 0.02;
        _right = MediaQuery.of(context).size.width * 0.05;
        _left = MediaQuery.of(context).size.width * 0.05;
        _bottom = MediaQuery.of(context).size.width * 0.02;
      });
    }
    if (Responsive.isMobile(context)) {
      setState(() {
        _top = MediaQuery.of(context).size.width * 0.1;
        _right = MediaQuery.of(context).size.width * 0.02;
        _left = MediaQuery.of(context).size.width * 0.02;
        _bottom = MediaQuery.of(context).size.width * 0.02;
        textheight = MediaQuery.of(context).size.width * 0.004;
      });
    }
    final TextStyle textStyle =
        TextStyle(fontSize: fontstyle, height: textheight);
    final TextStyle textStyletitel =
        TextStyle(fontSize: fontstyle1, height: textheight);
    return Center(
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
          Map contracts = data['contracts'];
          List holidays = data['holidays'];
          List competime = ['2000-01-01'];
          competime.addAll(data['comptime']);
          List vacation = ['2000-01-01'];
          vacation.addAll(data['vacation']);
          List sick = ['2000-01-01'];
          sick.addAll(data['sick']);
          List start = [];
          List end = [];
          List days = [];
          List<int> workingDays = [];
          List<int> workingHours = [];
          for (int i = 0; i < contracts.length; i++) {
            start.add(contracts[(i + 1).toString()]['start']);
            end.add(contracts[(i + 1).toString()]['end']);
            days.add(contracts[(i + 1).toString()]['days']);
            workingDays.add(contracts[(i + 1).toString()]['workingDays']);
            workingHours.add(contracts[(i + 1).toString()]['workingHours']);
          }
         
          List items =
              Calculate().getMonth(data['stamps'], _monthvalue, _yearvalue);
          return Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(_left, _top, _right, _bottom),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: [
                            Column(
                              children: [
                                Text('Monat', style: textStyletitel),
                                DropdownButton(
                                  value: _monthvalue,
                                  dropdownColor: Colors.black.withOpacity(0.8),
                                  // ignore: prefer_const_literals_to_create_immutables
                                  items: [
                                    DropdownMenuItem(
                                      value: '1',
                                      child: Text('Jänner'),
                                    ),
                                    DropdownMenuItem(
                                      value: '2',
                                      child: Text('Februar'),
                                    ),
                                    DropdownMenuItem(
                                      value: '3',
                                      child: Text('März'),
                                    ),
                                    DropdownMenuItem(
                                      value: '4',
                                      child: Text('April'),
                                    ),
                                    DropdownMenuItem(
                                      value: '5',
                                      child: Text('Mai'),
                                    ),
                                    DropdownMenuItem(
                                      value: '6',
                                      child: Text('Juni'),
                                    ),
                                    DropdownMenuItem(
                                      value: '7',
                                      child: Text('Juli'),
                                    ),
                                    DropdownMenuItem(
                                      value: '8',
                                      child: Text('August'),
                                    ),
                                    DropdownMenuItem(
                                      value: '9',
                                      child: Text('September'),
                                    ),
                                    DropdownMenuItem(
                                      value: '10',
                                      child: Text('Oktober'),
                                    ),
                                    DropdownMenuItem(
                                      value: '11',
                                      child: Text('November'),
                                    ),
                                    // ...
                                    DropdownMenuItem(
                                      value: '12',
                                      child: Text('Dezember'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _monthvalue = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(width: 30),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Jahr', style: textStyletitel),
                                DropdownButton(
                                  value: _yearvalue,
                                  dropdownColor: Colors.black.withOpacity(0.8),
                                  // ignore: prefer_const_literals_to_create_immutables
                                  items: [
                                    DropdownMenuItem(
                                      value: '2019',
                                      child: Text('2019'),
                                    ),
                                    DropdownMenuItem(
                                      value: '2020',
                                      child: Text('2020'),
                                    ),
                                    DropdownMenuItem(
                                      value: '2021',
                                      child: Text('2021'),
                                    ),
                                    DropdownMenuItem(
                                      value: '2022',
                                      child: Text('2022'),
                                    ),
                                    DropdownMenuItem(
                                      value: '2023',
                                      child: Text('2023'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _yearvalue = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    Text(data['firstName'] + ' ' + data['secondName'],
                        style: textStyletitel),
                    Divider(),
                    Table(columnWidths: {
                      0: FixedColumnWidth(
                          MediaQuery.of(context).size.width * 0.18),
                      1: FlexColumnWidth(),
                    }, children: [
                      TableRow(
                        children: [
                          Text('Normalzeit:', style: textStyletitel),
                          Text(Calculate().getJobHour(items),
                              style: textStyletitel),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text('Sollzeit:', style: textStyletitel),
                          Text(
                              Calculate().doubleToTimeString(Calculate()
                                  .getTargetTime(
                                      days,
                                      holidays,
                                      _monthvalue,
                                      _yearvalue,
                                      start,
                                      end,
                                      workingHours,
                                      workingDays,
                                      competime,
                                      vacation,
                                      sick)),
                              style: textStyletitel),
                        ],
                      ),
                      TableRow(
                        children: [
                          Text('Saldo Periode:', style: textStyletitel),
                          Text(
                              Calculate().doubleToTimeString(Calculate()
                                      .convertTimeToDouble(
                                          Calculate().getJobHour(items)) -
                                  Calculate().getTargetTime(
                                      days,
                                      holidays,
                                      _monthvalue,
                                      _yearvalue,
                                      start,
                                      end,
                                      workingHours,
                                      workingDays,
                                      competime,
                                      vacation,
                                      sick)),
                              style: textStyletitel),
                        ],
                      ),
                    ]),
                    Divider(),
                    Table(children: [
                      TableRow(
                        children: [
                          Text('Tag', style: textStyletitel),
                          Text('Datum', style: textStyletitel),
                          Text('kom.', style: textStyletitel),
                          Text('geh.', style: textStyletitel),
                          Text('Stunden', style: textStyletitel),
                        ],
                      ),
                    ]),
                    Divider(),
                    Table(children: [
                      TableRow(
                        children: [
                          /////Tag/////
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0; i < items.length; i++)
                                if (i % 2 == 0)
                                  Text(
                                    Calculate().getDayOfWeek(
                                      items[i],
                                    ),
                                    style: textStyle,
                                  )
                            ],
                          ),
                          /////Datum/////
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0; i < items.length; i++)
                                if (i % 2 == 0)
                                  Text(
                                    Calculate().getDate(items[i]),
                                    style: textStyle,
                                  ),
                            ],
                          ),
                          /////kommen/////
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0; i < items.length; i++)
                                if (i % 2 == 0)
                                  Text(
                                    Calculate().getHour(items[i]),
                                    style: textStyle,
                                  )
                            ],
                          ),
                          /////gehen/////
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0; i < items.length; i++)
                                if (i % 2 != 0)
                                  Text(
                                    Calculate().getHour(items[i]),
                                    style: textStyle,
                                  )
                            ],
                          ),
                          /////Stunden/////
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0; i < items.length; i++)
                                if (i % 2 != 0)
                                  Text(
                                    Calculate()
                                        .getDuration(items[i], items[i - 1]),
                                    style: textStyle,
                                  )
                            ],
                          ),
                        ],
                      ),
                    ]),
                    Divider(),
                    Table(children: [
                      TableRow(
                        children: [
                          Text(''),
                          Text(''),
                          Text(''),
                          Text(''),
                          Text(
                            Calculate().getJobHour(items),
                            style: textStyletitel,
                          )
                        ],
                      ),
                    ]),
                  ],
                ),
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
    ));
  }
}
/* Container(
            padding: EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Wrap(spacing: 100, children: [
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: Color.fromARGB(80, 43, 181, 216).withOpacity(0.1),
                    ),
                    child: Center(
                      child: CircularPercentIndicator(
                        radius: 55.0,
                        lineWidth: 10.0,
                        percent: 1,
                        header: new Text("Überstunden Gesamt \n"),
                        center: new ListView(
                          padding: EdgeInsets.all(20),
                          children: [
                            new Icon(
                              Icons.work_history,
                              size: 30.0,
                              color: Colors.blueAccent.withOpacity(0.5),
                            ),
                            Text(
                              "112 \n Stunden",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        backgroundColor: Colors.grey,
                        progressColor: Colors.blueAccent.withOpacity(0.5),
                      ),
                    ),
                  ),
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: Color.fromARGB(80, 43, 181, 216).withOpacity(0.1),
                    ),
                    child: Center(
                      child: CircularPercentIndicator(
                        radius: 55.0,
                        lineWidth: 10.0,
                        percent: 57 / 112,
                        header: new Text("Überstunden Rest \n"),
                        center: new ListView(
                          padding: EdgeInsets.all(20),
                          children: [
                            new Icon(
                              Icons.punch_clock,
                              size: 30.0,
                              color: Colors.blueAccent.withOpacity(0.5),
                            ),
                            Text(
                              " 57 \n Stunden",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        backgroundColor: Colors.grey,
                        progressColor: Colors.blueAccent.withOpacity(0.5),
                      ),
                    ),
                  ),
                ]),
                Divider(),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    color: Color.fromARGB(80, 43, 181, 216).withOpacity(0.1),
                  ),
                  width: 800,
                  height: 500,
                  child: SfCartesianChart(
                    plotAreaBorderWidth: 0,
                    borderWidth: 2,
                    primaryXAxis: CategoryAxis(title: AxisTitle(text: "")),
                    primaryYAxis:
                        CategoryAxis(title: AxisTitle(text: "Stunden")),
                    legend: Legend(isVisible: false),
                    plotAreaBackgroundColor: Color.fromARGB(0, 96, 125, 139),
                    plotAreaBorderColor: Colors.blueAccent,
                    tooltipBehavior: TooltipBehavior(enable: true),
                    title: ChartTitle(text: ""),
                    series: <ChartSeries>[
                      BarSeries<_SalesData, String>(
                          animationDuration: 5000,
                          dataSource: data,
                          width: 0.7,
                          xValueMapper: (_SalesData sales, _) => sales.year,
                          yValueMapper: (_SalesData sales, _) => sales.sales,
                          dataLabelSettings: DataLabelSettings(isVisible: true))
                    ],
                  ),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    color: Color.fromARGB(80, 43, 181, 216).withOpacity(0.1),
                  ),
                  child: Wrap(
                    children: [
                      Text(
                        "Zeitausgleich beantragen",
                        textScaleFactor: 2,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add,
                          )),
                    ],
                  ),
                )
                /* SfSparkBarChart.custom(
                  labelStyle: TextStyle(fontStyle: FontStyle.italic),
                  axisCrossesAt: 40,
                  trackball: SparkChartTrackball(
                    width: 4,
                  ),
                  labelDisplayMode: SparkChartLabelDisplayMode.all,
                  xValueMapper: (int index) => data[index].year,
                  yValueMapper: (int index) => data[index].sales,
                  dataCount: 7,
                ), */
                /*    SfSparkLineChart(
                  data: [10, 9, 8.5, 5, 3],
                  labelDisplayMode: SparkChartLabelDisplayMode.all,
                ) */
              ],
            )*/
