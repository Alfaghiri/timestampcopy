/* 
 @authors:
 Abdul Wahhab Alfaghiri Al Anzi   01524445
 Nouzad Mohammad                  00820679
*/
import 'package:flutter/material.dart';
import 'MenuController.dart';
import 'responsive.dart';
import 'package:provider/provider.dart';
class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          Builder(
              builder: ((context) => IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: (() {
                    Scaffold.of(context).openDrawer();
                  })))),
      ],
    );
  }
}
/* return Scaffold(
      drawer: Sidebar(),
      body: Container(
          child: Column(
        children: [
          if (!Responsive.isDesktop(context))
            Container(
                color: Colors.blueGrey,
                child: Row(
                  children: [
                    Builder(
                        builder: ((context) => IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: (() {
                              Scaffold.of(context).openDrawer();
                            })))),
                    Spacer(),
                    Text(
                      "Dashboard",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    if (!Responsive.isMobile(context))
                      Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
                  ],
                )),
          Divider(
            height: 100,
            color: Colors.transparent,
          ),
          /*   SfCalendar(
              view: CalendarView.workWeek,
              timeSlotViewSettings: TimeSlotViewSettings(
                  startHour: 7,
                  endHour: 20,
                  nonWorkingDays: <int>[DateTime.friday, DateTime.saturday])) */
        ],
      )),
    ); */
