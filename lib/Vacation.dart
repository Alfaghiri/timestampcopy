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
import 'package:week_of_year/week_of_year.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
int _year = DateTime.now().year;
String _allbalnce = '0';
String _holidays = '0';
String _holidaysrest = '0';
String _consum = '0';
class Vacation extends StatefulWidget {
  const Vacation({super.key});
  @override
  State<Vacation> createState() => _Vacation();
}
class _Vacation extends State<Vacation> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    DateTimeRange? dateRange =
        DateTimeRange(start: DateTime.now(), end: DateTime.now());
    var _startrange = dateRange.start;
    var _endrange = dateRange.end;
    return Center(
        child: StreamBuilder<DocumentSnapshot>(
            // Get a stream of document snapshots using the user's UID
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user!.uid)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                List vacation=data['vacation'];
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
                  workingHours
                      .add(contracts[(i + 1).toString()]['workingHours']);
                }
                List<double> _circulerpercent = [];
                List<double> _balance = [];
                for (int i = 1; i < 13; i++) {
                  _balance.add(Calculate().getvacation(vacation, i, _year));
                }
                _holidays = (Calculate().getHolidays(start, end, workingDays))
                    .toStringAsFixed(2);
                _holidaysrest =
                    (Calculate().getHolidays(start, end, workingDays) -
                            vacation.length)
                        .toStringAsFixed(2);
                _consum = vacation.length.toString();
                @override
                List<_StundenData> datas = [
                  _StundenData('Jänner', _balance[0]),
                  _StundenData('Februar', _balance[1]),
                  _StundenData('März ', _balance[2]),
                  _StundenData('April', _balance[3]),
                  _StundenData('Mai', _balance[4]),
                  _StundenData('Juni', _balance[5]),
                  _StundenData('Juli', _balance[6]),
                  _StundenData('August', _balance[7]),
                  _StundenData('September', _balance[8]),
                  _StundenData('Oktober', _balance[9]),
                  _StundenData('November', _balance[10]),
                  _StundenData('Dezember', _balance[11])
                ];
                return Container(
                    padding: EdgeInsets.only(top: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Wrap(spacing: 50,runSpacing: 20,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center, children: [
                          Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24.0),
                              color: Color.fromARGB(80, 43, 181, 216)
                                  .withOpacity(0.1),
                            ),
                            child: Center(
                              child: CircularPercentIndicator(
                                radius: 55.0,
                                lineWidth: 10.0,
                                percent: 1,
                                header: new Text("Gesamt \n"),
                                center: new ListView(
                                  padding: EdgeInsets.all(20),
                                  children: [
                                    new Icon(
                                      Icons.holiday_village,
                                    ),
                                    Text(
                                      "$_holidays \n Tage",
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                backgroundColor: Colors.grey,
                                progressColor:
                                    Colors.blueAccent.withOpacity(0.5),
                              ),
                            ),
                          ),
                          Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24.0),
                              color: Color.fromARGB(80, 43, 181, 216)
                                  .withOpacity(0.1),
                            ),
                            child: Center(
                              child: CircularPercentIndicator(
                                radius: 55.0,
                                lineWidth: 10.0,
                                percent: (double.parse(_consum)/double.parse(_holidays)),
                                header: new Text("Verbrauch \n"),
                                center: new ListView(
                                  padding: EdgeInsets.all(20),
                                  children: [
                                    new Icon(
                                      Icons.beach_access,
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      "$_consum \n Tage",
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                backgroundColor: Colors.grey,
                                progressColor:
                                    Colors.blueAccent.withOpacity(0.5),
                              ),
                            ),
                          ),
                          Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24.0),
                              color: Color.fromARGB(80, 43, 181, 216)
                                  .withOpacity(0.1),
                            ),
                            child: Center(
                              child: CircularPercentIndicator(
                                radius: 55.0,
                                lineWidth: 10.0,
                                percent: 1-(double.parse(_consum)/double.parse(_holidays)),
                                header: new Text("Rest \n"),
                                center: new ListView(
                                  padding: EdgeInsets.all(20),
                                  children: [
                                    new Icon(
                                      Icons.beach_access,
                                    ),
                                    Text(
                                      "$_holidaysrest \n Tage",
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                backgroundColor: Colors.grey,
                                progressColor:
                                    Colors.blueAccent.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ]),
                        Divider(),
                        Center(
                          child: Wrap(children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _year--;
                                  });
                                },
                                icon: Icon(Icons.arrow_back_ios)),
                            Text('$_year', style: TextStyle(height: 2)),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    _year++;
                                  });
                                },
                                icon: Icon(Icons.arrow_forward_ios))
                          ]),
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: Color.fromARGB(80, 43, 181, 216)
                                .withOpacity(0.1),
                          ),
                          width: 800,
                          height: 500,
                          child: SfCartesianChart(
                            plotAreaBorderWidth: 0,
                            borderWidth: 2,
                            primaryXAxis:
                                CategoryAxis(title: AxisTitle(text: "")),
                            primaryYAxis:
                                CategoryAxis(title: AxisTitle(text: "Stunden")),
                            legend: Legend(isVisible: false),
                            plotAreaBackgroundColor:
                                Color.fromARGB(0, 96, 125, 139),
                            plotAreaBorderColor: Colors.blueAccent,
                            tooltipBehavior: TooltipBehavior(enable: true),
                            title: ChartTitle(text: ""),
                            series: <ChartSeries>[
                              BarSeries<_StundenData, String>(
                                  animationDuration: 5000,
                                  dataSource: datas,
                                  width: 0.7,
                                  xValueMapper: (_StundenData sales, _) =>
                                      sales.year,
                                  yValueMapper: (_StundenData sales, _) =>
                                      sales.sales,
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true))
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          padding: EdgeInsets.only(top: 5, left: 20, right: 20),
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: Color.fromARGB(80, 43, 181, 216)
                                .withOpacity(0.1),
                          ),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                "Urlaubs beantragen",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                  onPressed: () async {
                                    DateTimeRange? newDateRange =
                                        await showDateRangePicker(
                                      context: context,
                                      initialDateRange: dateRange,
                                      firstDate: DateTime
                                          .now(), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime.now()
                                          .add(Duration(days: 100)),
                                      builder: (context, child) {
                                        return Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 50,
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.1),
                                              child: Container(
                                                height: 500,
                                                width: 400,
                                                child: child,
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    );
                                    if (newDateRange == null) return;
                                    setState(() {
                                      _startrange = newDateRange.start;
                                      _endrange = newDateRange.end;
                                    });
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(user!.uid)
                                        .update({
                                      'vacation': FieldValue.arrayUnion(
                                          Calculate().getcomptime(days,
                                              holidays, _startrange, _endrange))
                                    });
                                    print(_startrange);
                                    print(_endrange);
                                  },
                                  icon: Icon(
                                    Icons.add,
                                  )),
                            ],
                          ),
                        )
                      ],
                    ));
              } else {
                return Text('');
              }
            }));
  }
}
class _StundenData {
  _StundenData(this.year, this.sales);
  final String year;
  final double sales;
}
