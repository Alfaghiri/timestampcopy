import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timestamp/Calculate.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:timestamp/home_screen.dart';
import 'package:timestamp/responsive.dart';
class DashCalender extends StatefulWidget {
  const DashCalender({super.key});
  @override
  State<DashCalender> createState() => _DashCalender();
}
class _DashCalender extends State<DashCalender> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double _timeIntervalHeight = MediaQuery.of(context).size.height / 10;
    double _containerheight = MediaQuery.of(context).size.height;
    double _padding = MediaQuery.of(context).size.width * 0.009;
    if (selectedmenu != 1) {
      setState(() {
        _timeIntervalHeight = MediaQuery.of(context).size.height / 20;
        _containerheight = MediaQuery.of(context).size.height / 2;
      });
    }
    return StreamBuilder<DocumentSnapshot>(
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
            List stamps = data['stamps'];
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
            final List<Meeting> meetings = <Meeting>[];
            for (int i = 0; i < stamps.length; i++) {
              if (i % 2 == 0) {
                String start = Calculate().getTime(stamps[i]);
                String end = Calculate().getTime(stamps[i + 1]);
                meetings.add(Meeting(
                    '$start -- $end',
                    DateTime.parse(stamps[i]),
                    DateTime.parse(stamps[i + 1]),
                    Color.fromARGB(255, 86, 181, 219),
                    false));
              }
            }
            for (int i = 0; i < holidays.length; i++) {
              DateTime _startdate =
                  DateTime.parse(holidays[i].toString().substring(0, 10));
              DateTime _enddate =
                  DateTime.parse(holidays[i].toString().substring(0, 10))
                      .add(Duration(hours: 23));
              String _titel = holidays[i].toString().substring(11);
              meetings.add(Meeting(_titel, _startdate, _enddate,
                  Color.fromARGB(255, 9, 145, 15), false));
            }
            for (int i = 0; i < competime.length; i++) {
              DateTime _startdate = DateTime.parse(competime[i]);
              DateTime _enddate =
                  DateTime.parse(competime[i]).add(Duration(hours: 23));
              meetings.add(Meeting('Zeitausgleich', _startdate, _enddate,
                  Color.fromARGB(255, 7, 190, 160), false));
            }
            for (int i = 0; i < vacation.length; i++) {
              DateTime _startdate = DateTime.parse(vacation[i]);
              DateTime _enddate =
                  DateTime.parse(vacation[i]).add(Duration(hours: 23));
              meetings.add(Meeting('Urlaub', _startdate, _enddate,
                  Color.fromARGB(216, 36, 8, 194), false));
            }
            for (int i = 0; i < sick.length; i++) {
              DateTime _startdate = DateTime.parse(sick[i]);
              DateTime _enddate =
                  DateTime.parse(sick[i]).add(Duration(hours: 23));
              meetings.add(Meeting('Krank', _startdate, _enddate,
                  Color.fromARGB(215, 226, 65, 65), false));
            }
            List<Meeting> _getDataSource() {
              return meetings;
            }
            return Container(
                height: _containerheight,
                padding: EdgeInsets.only(
                    bottom: 50, top: 40, left: _padding, right: _padding),
                child: SfCalendar(
                  firstDayOfWeek: 1,
                  showDatePickerButton: true,
                  view: CalendarView.workWeek,
                  allowedViews: <CalendarView>[
                    CalendarView.day,
                    CalendarView.week,
                    CalendarView.workWeek,
                    if (MediaQuery.of(context).size.width >= 700)
                      CalendarView.month,
                  ],
                  dataSource: MeetingDataSource(_getDataSource()),
                  monthViewSettings: const MonthViewSettings(
                    appointmentDisplayCount: 2,
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.appointment,
                  ),
                  timeSlotViewSettings: TimeSlotViewSettings(
                      timeInterval: Duration(hours: 3),
                      timeIntervalHeight: _timeIntervalHeight),
                ));
          } else {
            return Container(
              width: 150,
              height: 150,
              child: CircularProgressIndicator(),
            );
          }
        });
  }
  String _getDatumFormat(DateTime d) {
    String newDatum = d.toString().substring(10).substring(1, 6);
    return newDatum;
  }
}
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }
  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }
  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }
  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }
  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }
  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }
  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }
    return meetingData;
  }
}
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);
  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;
  /// From which is equivalent to start time property of [Appointment].
  DateTime from;
  /// To which is equivalent to end time property of [Appointment].
  DateTime to;
  /// Background which is equivalent to color property of [Appointment].
  Color background;
  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
