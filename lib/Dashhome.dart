import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:timestamp/Calculate.dart';
import 'responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:week_of_year/week_of_year.dart';
import 'dart:async';
String? _monthvalue = DateTime.now().month.toString();
String? _yearvalue = DateTime.now().year.toString();
String _holidays = '0';
int _week = DateTime.now().weekOfYear;
int _year = DateTime.now().year;
String _roottime = '0';
String _jobhour = '0';
String _targettime = '0';
String _balanceperiod = '0';
String __alltargettime = '0';
String _sick = '0';
class Dashhome extends StatefulWidget {
  const Dashhome({super.key});
  @override
  State<Dashhome> createState() => _DashhomeState();
}
class _DashhomeState extends State<Dashhome> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
  }
  double _wrapspacing = 50;
  double _containerwidth = 180;
  double _containerheight = 180;
  double _circuleradius = 60;
  double _circulerwidth = 10;
  double _circulerheight = 20;
  double _textsize = 1.2;
  double _iconsize = 35;
  double _gridpadding = 40;
  int _crossAxisCount = 3;
  double _crossAxisSpacing = 10;
  double _mainAxisSpacing = 10;
  double _childAspectRatio = 1;
  List<String> _circulerTitel = [
    "Stammzeit",
    "Normalzeit",
    "Sollzeit",
    "Saldo Periode",
    "Saldo Gesamt",
    "Krank",
    "Urlaub",
  ];
  List<Color> _circulerColor = [
    Color.fromARGB(255, 1, 245, 131).withOpacity(0.5),
    Color.fromARGB(255, 1, 245, 131).withOpacity(0.5),
    Color.fromARGB(255, 1, 245, 131).withOpacity(0.5),
    Color.fromARGB(255, 1, 245, 131).withOpacity(0.5),
    Color.fromARGB(255, 1, 245, 131).withOpacity(0.5),
    Color.fromARGB(255, 243, 11, 3).withOpacity(0.5),
    Color.fromARGB(255, 4, 155, 214).withOpacity(0.5)
  ];
  List<Icon> _circulerIcon = [
    Icon(Icons.person),
    Icon(Icons.calendar_month),
    Icon(Icons.lock_clock),
    Icon(Icons.timer),
    Icon(Icons.home_filled),
    Icon(Icons.sick),
    Icon(Icons.holiday_village),
    Icon(Icons.list)
  ];
  @override
  Widget build(BuildContext context) {
    List<String> _stunden = [];
    List<String> _stundenn = [
      "\nStunden",
      "\nTage",
    ];
/*     if (Responsive.isMobile(context)) {
      setState(() {
        _wrapspacing = 10;
        _containerwidth = 130;
        _containerheight = 130;
        _circuleradius = 45;
        _circulerwidth = 3;
        _textsize = 0.8;
        _iconsize = 15;
        _gridpadding = 10;
        _crossAxisCount = 3;
        _crossAxisSpacing = 5;
        _mainAxisSpacing = 5;
        double _circulerheight = 10;
      });
    } */
    return Center(
        child: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
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
              _stunden.clear();
              // Get the data from the snapshot
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              List items = data['stunden'];
              List stamp = data['stamps'];
              Map contracts = data['contracts'];
              List holidays = data['holidays'];
              List competime = ['2000-01-01'];
              competime.addAll(data['comptime']);
              List vacation = ['2000-01-01'];
              vacation.addAll(data['vacation']);
              print(vacation);
              List sick = data['sick'];
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
              List<double> _circulerpercent = [];
              List stamps =
                  Calculate().getMonth(data['stamps'], _monthvalue, _yearvalue);
              _roottime = Calculate().getRootTime(start, end, workingHours);
              _jobhour = Calculate().getJobHour(stamps);
              _targettime = Calculate().doubleToTimeString(Calculate()
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
                      sick));
              _balanceperiod = Calculate().doubleToTimeString(Calculate()
                      .convertTimeToDouble(Calculate().getJobHour(stamps)) -
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
                      sick));
              __alltargettime = Calculate().doubleToTimeString(Calculate()
                      .convertTimeToDouble(Calculate().getJobHour(stamp)) -
                  Calculate().getAllTargetTime(days, holidays, start, end,
                      workingHours, workingDays, competime, vacation, sick));
              _sick = (sick.length).toString();
              _holidays = (Calculate().getHolidays(start, end, workingDays)-
                      vacation.length)
                  .toStringAsFixed(2);
              _stunden.add(_roottime + _stundenn[0]);
              _stunden.add(_jobhour + _stundenn[0]);
              _stunden.add(_targettime + _stundenn[0]);
              _stunden.add(_balanceperiod + _stundenn[0]);
              _stunden.add(__alltargettime + _stundenn[0]);
              _stunden.add(_sick + _stundenn[1]);
              _stunden.add(_holidays + _stundenn[1]);
              _circulerpercent.add(double.parse(_roottime) / 40);
              _circulerpercent.add(Calculate().convertTimeToDouble(_jobhour) /
                  Calculate().convertTimeToDouble(_targettime));
              _circulerpercent.add(Calculate().convertTimeToDouble(_jobhour) /
                  Calculate().convertTimeToDouble(_targettime));
              _circulerpercent.add(0.5);
              _circulerpercent
                  .add(Calculate().convertTimeToDouble(__alltargettime) / 100);
              _circulerpercent.add(1);
              _circulerpercent.add(1- vacation.length/(Calculate().getHolidays(start, end, workingDays)
                     ));
              List<_StundenData> datas = [
                _StundenData(
                    'MO',
                    Calculate().toDoubleWithTwoDecimal(Calculate()
                        .toDoubleWithTwoDecimal(Calculate()
                            .getHoursDay(stamp, 1, _week + 1, _year)))),
                _StundenData(
                    'DI',
                    Calculate().toDoubleWithTwoDecimal(
                        Calculate().getHoursDay(stamp, 2, _week + 1, _year))),
                _StundenData(
                    'MI',
                    Calculate().toDoubleWithTwoDecimal(
                        Calculate().getHoursDay(stamp, 3, _week + 1, _year))),
                _StundenData(
                    'DO',
                    Calculate().toDoubleWithTwoDecimal(
                        Calculate().getHoursDay(stamp, 4, _week + 1, _year))),
                _StundenData(
                    'FR',
                    Calculate().toDoubleWithTwoDecimal(
                        Calculate().getHoursDay(stamp, 5, _week + 1, _year))),
                _StundenData(
                    'SA',
                    Calculate().toDoubleWithTwoDecimal(
                        Calculate().getHoursDay(stamp, 6, _week + 1, _year))),
                _StundenData(
                    'SO',
                    Calculate().toDoubleWithTwoDecimal(
                        Calculate().getHoursDay(stamp, 7, _week + 1, _year))),
              ];
              return Column(
                children: [
                  Wrap(
                      runSpacing: 20,
                      spacing: _wrapspacing,
                      alignment: WrapAlignment.center,
                      children: List.generate(
                        _circulerTitel.length,
                        (index) => Container(
                            width: _containerwidth,
                            height: _containerheight,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24.0),
                              color: Color.fromARGB(80, 43, 181, 216)
                                  .withOpacity(0.1),
                            ),
                            child: Center(
                              child: CircularPercentIndicator(
                                progressColor: _circulerColor[index],
                                radius: _circuleradius,
                                animation: true,
                                animationDuration: 3000,
                                lineWidth: _circulerwidth,
                                percent: _circulerpercent[index],
                                header: Column(
                                  children: [
                                    new Text(
                                      _circulerTitel[index],
                                      textScaleFactor: _textsize,
                                    ),
                                    Divider(
                                      height: 2,
                                      color: Colors.transparent,
                                    )
                                  ],
                                ),
                                center: Column(
                                  children: [
                                    Divider(
                                      height: _circulerheight,
                                      color: Colors.transparent,
                                    ),
                                    _circulerIcon[index],
                                    Text(
                                      _stunden[index],
                                      textScaleFactor: _textsize,
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            )),
                      )),
                  Divider(
                    color: Colors.transparent,
                  ),
                  Center(
                    child: Wrap(children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (_week == 1) {
                                _week = 52;
                                _year--;
                              } else
                                _week--;
                            });
                          },
                          icon: Icon(Icons.arrow_back_ios)),
                      Text('KW $_week $_year', style: TextStyle(height: 2)),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (_week == 52 || _week == 0) {
                                _week = 1;
                                _year++;
                              } else
                                _week++;
                            });
                          },
                          icon: Icon(Icons.arrow_forward_ios))
                    ]),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: Color.fromARGB(80, 43, 181, 216).withOpacity(0.1),
                    ),
                    width: 500,
                    height: 350,
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
                        BarSeries<_StundenData, String>(
                            animationDuration: 3000,
                            animationDelay: 1000,
                            dataSource: datas,
                            width: 0.7,
                            xValueMapper: (_StundenData sales, _) => sales.year,
                            yValueMapper: (_StundenData sales, _) =>
                                sales.sales,
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true))
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Container(
                width: 150,
                height: 150,
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    ));
  }
}
class _StundenData {
  _StundenData(this.year, this.sales);
  final String year;
  final double sales;
}
