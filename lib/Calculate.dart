/* 
 @authors:
 Abdul Wahhab Alfaghiri Al Anzi   01524445
 Nouzad Mohammad                  00820679
*/
import 'package:week_of_year/week_of_year.dart';
import 'package:intl/intl.dart';
class Calculate {
//berechnet die Dauer zwischen zwei Daten und Zeiten im Format "hh:mm"
  String getDuration(String startTime, String endTime) {
    DateTime start = DateTime.parse(startTime);
    DateTime end = DateTime.parse(endTime);
    // Calculate the difference between the two DateTime objects
    Duration difference = start.difference(end);
    String hours = difference.inHours.toString().padLeft(2, '0');
    String minutes =
        difference.inMinutes.remainder(60).toString().padLeft(2, '0');
    return hours + ":" + minutes;
  }
//gibt den Wochentag für ein bestimmtes Datum und eine bestimmte Uhrzeit im
//format 'Montag' 'Dienstag'
  String getDayOfWeek(String time) {
    DateTime day = DateTime.parse(time);
    int weekday = day.weekday;
    switch (weekday) {
      case 1:
        return 'Montag';
      case 2:
        return 'Dienstag';
      case 3:
        return 'Mittwoch';
      case 4:
        return 'Donnerstag';
      case 5:
        return 'Freitag';
      case 6:
        return 'Samsatg';
      case 7:
        return 'Sonntag';
      default:
        return 'Unknown';
    }
  }
  String getmonthname(int month) {
    switch (month) {
      case 1:
        return 'Jänner';
      case 2:
        return 'Februar';
      case 3:
        return 'März';
      case 4:
        return 'April';
      case 5:
        return 'Mai';
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
        return 'Dezember';
      default:
        return 'Unknown';
    }
  }
  double getvacation(List vacatin, int month, int year) {
    double days = 0;
    for (int i = 0; i < vacatin.length; i++) {
      DateTime vac = DateTime.parse(vacatin[i]);
      if (vac.month == month && vac.year == year) {
        days++;
      }
    }
    return days;
  }
//wandelt eine doppelt genaue Zahl in eine Zahl mit zwei Dezimalstellen um.
  double toDoubleWithTwoDecimal(double value) {
    return double.parse(value.toStringAsFixed(2));
  }
// gibt eine Liste mit Zeitstempeln zurück, die im angegebenen Monat und
//Jahr liegen.
  List<String> getMonth(List stamps, String? Month, String? year) {
    List<String> items = [];
    for (int i = 0; i < stamps.length; i++) {
      DateTime stamp = DateTime.parse(stamps[i]);
      if (stamp.month.toString() == Month && stamp.year.toString() == year)
        items.add(stamps[i]);
    }
    return items;
  }
//gibt die Wochennummer im Jahr für ein bestimmtes Datum und eine bestimmte
//Uhrzeit zurück.
  String getWeek(String time) {
    DateTime times = DateTime.parse(time);
    return times.weekOfYear.toString();
  }
//gibt nur die Stunden im Format "HH:mm" einer Zeit zurück.
  String getHour(String time) {
    return time.substring(10, 16);
  }
//gibt das Datum im Format "dd.MM.yyyy" für eine gegebene Zeit zurück.
  String getDate(String time) {
    String day = time.substring(8, 10);
    String month = time.substring(5, 7);
    String year = time.substring(0, 4);
    return day + "." + month + "." + year;
  }
//gibt die Uhrzeit im Format "HH:mm" einer gegebenen Zeit zurück.
  String getTime(String time) {
    String newtime = time.substring(11, 16);
    return newtime;
  }
  List<String> dateTimeListToStringList(List<DateTime> dateTimes) {
    List<String> stringList = [];
    for (DateTime dateTime in dateTimes) {
      stringList.add(dateTime.toIso8601String().substring(0, 10));
    }
    return stringList;
  }
//berechnet die Dauer in Tagen zwischen zwei Daten und Zeiten.
  int getDurationinDays(String start, String end) {
    DateTime startDate = DateTime.parse(start);
    DateTime endDate = DateTime.parse(end);
    Duration duration = endDate.difference(startDate);
    int days = duration.inDays;
    return days;
  }
//gibt eine Liste von DateTime-Objekten zurück, die zwischen zwei Daten und
//Zeiten liegen, die als Strings im Format "yyyy-MM-dd HH:mm:ss"
//übergeben werden.
  List<DateTime> getDatesBetween(
      List<DateTime> stamps, String start, String end) {
    List<DateTime> newstamps = [];
    for (int i = 0; i < stamps.length; i++) {
      if ((stamps[i].isAfter(DateTime.parse(start).add(Duration(days: -1))) &&
          stamps[i].isBefore(DateTime.parse(end).add(Duration(days: 1))))) {
        newstamps.add(stamps[i]);
      }
    }
    return newstamps;
  }
//gibt eine Liste von DateTime-Objekten für jeden Tag zwischen zwei Daten und
//Zeiten zurück, die als Strings im Format "yyyy-MM-dd HH:mm:ss" übergeben
//werden.
  List<DateTime> getDaysBetween(String start, String end) {
    DateTime startDate = DateTime.parse(start);
    DateTime endDate = DateTime.parse(end);
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }
//gibt eine Liste von DateTime-Objekten für jeden Tag im angegebenen Monat
//und Jahr zurück.
  List<DateTime> daysInMonth(int month, int year) {
    var firstDayOfMonth = DateTime(year, month);
    var lastDayOfMonth = DateTime(year, month + 1, 0);
    var daysInMonth = <DateTime>[];
    var currentDay = firstDayOfMonth;
    while (currentDay.isBefore(lastDayOfMonth)) {
      daysInMonth.add(currentDay);
      currentDay = currentDay.add(Duration(days: 1));
    }
    daysInMonth.add(currentDay);
    return daysInMonth;
  }
  List<int> getWeeksOfMonth(int month, int year) {
    var firstDayOfMonth = DateTime(year, month);
    var lastDayOfMonth = DateTime(year, month + 1, 0);
    var currentDay = firstDayOfMonth;
    var weeks = <int>[];
    while (currentDay.month == month) {
      if (!weeks.contains(currentDay.weekOfYear)) {
        weeks.add(currentDay.weekOfYear);
      }
      currentDay = currentDay.add(Duration(days: 1));
    }
    return weeks;
  }
//wird verwendet, um einen String von Tagen im Format "Mo, Tu, We, Th, Fr, Sa,
//Su" in eine Liste von Integers zu konvertieren, wo jeder Integer den
//Wochentag darstellt.
  List<int> splitToList(String days) {
    List<String> list = days.split(',');
    List<int> newlist = [];
    for (int i = 0; i < list.length; i++) {
      switch (list[i]) {
        case 'Mo':
          newlist.add(1);
          break;
        case 'Tu':
          newlist.add(2);
          break;
        case 'We':
          newlist.add(3);
          break;
        case 'Th':
          newlist.add(4);
          break;
        case 'Fr':
          newlist.add(5);
          break;
        case 'Sa':
          newlist.add(6);
          break;
        case 'Su':
          newlist.add(7);
          break;
      }
    }
    return newlist;
  }
//gibt das Datum im Format "yyyy-MM-dd" für einen bestimmten Wochentag
//(angegeben als Integer) in einer bestimmten Woche (angegeben als Integer)
//und Jahr (angegeben als Integer) zurück.
  String getSpecifiedDayDateFromWeekAndYear(int week, int year, int day) {
    DateTime firstDayOfFirstWeek =
        DateTime(year).subtract(Duration(days: DateTime(year).weekday - 1));
    DateTime specifiedWeek =
        firstDayOfFirstWeek.add(Duration(days: (week - 1) * 7 + (day - 1)));
    return "${specifiedWeek.year.toString().padLeft(4, '0')}-${specifiedWeek.month.toString().padLeft(2, '0')}-${specifiedWeek.day.toString().padLeft(2, '0')}";
  }
//berechnet die Dauer in Stunden zwischen zwei Daten und Zeiten in einer Liste
//von Zeitstempeln für einen bestimmten Tag einer bestimmten Woche und Jahr.
  double getHoursDay(List stamp, int day, int week, int year) {
    List<String> stamps = [];
    for (int i = 0; i < stamp.length; i++) {
      if (stamp[i].toString().substring(0, 10) ==
          getSpecifiedDayDateFromWeekAndYear(week, year, day)) {
        stamps.add(stamp[i]);
      }
    }
    if (stamps.length > 1) {
      return convertTimeToDouble(getDuration(stamps[1], stamps[0]));
    } else {
      return 0;
    }
  }
  String getMonthFromWeekNumberAndYear(int week, int year) {
    DateTime firstDayOfFirstWeek =
        DateTime(year).subtract(Duration(days: DateTime(year).weekday - 1));
    DateTime specifiedWeek =
        firstDayOfFirstWeek.add(Duration(days: (week - 1) * 7));
    return specifiedWeek.month.toString();
  }
  int getWeekNumber(int weekNum, int month, int year) {
    DateTime date = DateTime(year, month);
    int weekOfMonth = 1;
    while (date.month == month) {
      if (date.weekday == DateTime.monday) {
        if (weekOfMonth == weekNum) {
          return date.weekday;
        }
        weekOfMonth++;
      }
      date = date.add(Duration(days: 1));
    }
    return -1;
  }
  //gibt eine Liste von DateTime-Objekten für bestimmte Wochentage in einem
  //bestimmten Datumsbereich zurück, wobei Feiertage von der Liste entfernt
  //werden.
  List<DateTime> weekdaysInRange(
    String days,
    DateTime start,
    DateTime end,
    List holidays,
  ) {
    var weekdays = <DateTime>[];
    var currentDay = start;
    List<int> workdays = splitToList(days);
    while (currentDay.isBefore(end.add(Duration(days: 1)))) {
      for (int i = 0; i < workdays.length; i++) {
        if (currentDay.weekday == workdays[i]) {
          weekdays.add(currentDay);
        }
      }
      currentDay = currentDay.add(Duration(days: 1));
    }
    List<DateTime> newweekdays = removeHolidays(weekdays, holidays);
    return newweekdays;
  }
  List<DateTime> jobsdays(String days, DateTime start, DateTime end,
      List holidays, List comptime, List vacation, List sick) {
    var weekdays = <DateTime>[];
    var currentDay = start;
    List<int> workdays = splitToList(days);
    while (currentDay.isBefore(end.add(Duration(days: 1)))) {
      for (int i = 0; i < workdays.length; i++) {
        if (currentDay.weekday == workdays[i]) {
          weekdays.add(currentDay);
        }
      }
      currentDay = currentDay.add(Duration(days: 1));
    }
    List<DateTime> n = removeHolidays(weekdays, holidays);
    List<DateTime> n1 = removeHolidays(n, comptime);
    List<DateTime> n2 = removeHolidays(n1, vacation);
    List<DateTime> n3 = removeHolidays(n2, sick);
    return n3;
  }
// prüft, ob das aktuelle Datum und die Uhrzeit innerhalb eines bestimmten
//Datumsbereichs liegen.
  bool isDateInRange(String startDate, String endDate) {
    DateTime dateTime = DateTime.now();
    DateTime start = DateTime.parse(startDate);
    DateTime end = DateTime.parse(endDate);
    return dateTime.isAfter(start) && dateTime.isBefore(end);
  }
//gibt die Arbeitszeit für den aktuellen Datumsbereich zurück.
  String getRootTime(List start, List end, List<int> wHours) {
    String _rootTime = "";
    for (int i = 0; i < start.length; i++) {
      if (isDateInRange(start[i], end[i])) {
        _rootTime = wHours[i].toString();
      }
    }
    return _rootTime;
  }
//konvertiert eine Liste von Datumsangaben im Format "yyyy-MM-dd" in eine
//Liste von DateTime-Objekten.
  List<DateTime> getDatesFromStringList(List dateStrings) {
    List<DateTime> dateList = [];
    for (String dateString in dateStrings) {
      List<String> dateAndEvent = dateString.split(" ");
      String date = dateAndEvent[0];
      DateTime dateTime = DateTime.parse(date);
      dateList.add(dateTime);
    }
    return dateList;
  }
// entfernt Feiertage aus einer Liste von Daten.
  List<DateTime> removeHolidays(List<DateTime> dates, List holidays) {
    List<DateTime> newlist = getDatesFromStringList(holidays);
    return dates.where((date) => !newlist.contains(date)).toList();
  }
//berechnet die geplante Arbeitszeit für einen bestimmten Monat und Jahr.
  double getTargetTime(
      List day,
      List holidays,
      String? month,
      String? year,
      List start,
      List end,
      List<int> wHours,
      List<int> wDays,
      List comptime,
      List vacation,
      List sick) {
    double days = 0;
    int mon = int.parse(month.toString());
    int yy = int.parse(year.toString());
    for (int i = 0; i < start.length; i++) {
      String dayy = day[i];
      List<DateTime> daysinmonth1 = daysInMonth(mon, yy);
      List<DateTime> daysinmonth =
          getDatesBetween(daysinmonth1, start[i], end[i]);
      if (daysinmonth.isNotEmpty) {
        List<DateTime> newmonthlist = jobsdays(
            dayy,
            daysinmonth[0],
            daysinmonth[daysinmonth.length - 1],
            holidays,
            comptime,
            vacation,
            sick);
        days += newmonthlist.length * wHours[i] / wDays[i];
      }
    }
    return days;
  }
  List<String> getcomptime(
    List day,
    List holidays,
    DateTime start,
    DateTime end,
  ) {
    List<String> newlist = [];
    for (int i = 0; i < day.length; i++) {
      List<String> datelist = dateTimeListToStringList(
          weekdaysInRange(day[i], start, end, holidays));
      newlist.addAll(datelist);
    }
    return newlist;
  }
//berechnet die geplante Arbeitszeit für den Zeitraum zwischen dem aktuellen
//Datum und einem vorher definierten Datum.
  double getAllTargetTime(
      List day,
      List holidays,
      List start,
      List end,
      List<int> wHours,
      List<int> wDays,
      List comptime,
      List vacation,
      List sick) {
    double days = 0;
    String datetime = DateTime.now().toString();
    for (int i = 0; i < start.length; i++) {
      String dayy = day[i];
      List<DateTime> daysinmonth1 = getDaysBetween(start[i], datetime);
      List<DateTime> daysinmonth =
          getDatesBetween(daysinmonth1, start[i], end[i]);
      if (daysinmonth.isNotEmpty) {
        List<DateTime> newmonthlist = jobsdays(
            dayy,
            daysinmonth[0],
            daysinmonth[daysinmonth.length - 1],
            holidays,
            comptime,
            vacation,
            sick);
        days += newmonthlist.length * wHours[i] / wDays[i];
      }
    }
    return days;
  }
// berechnet die Anzahl der Arbeitsstunden, die auf Feiertagen geleistet werden.
  double getHolidays(List start, List end, List<int> workingDays) {
    double holidays = 0;
    for (int i = 0; i < start.length; i++) {
      int duration = getDurationinDays(start[i], end[i]);
      holidays += (workingDays[i] * 5 / 365) * duration;
    }
    return holidays;
  }
//nimmt eine Liste mit Zeitstempeln als Argument und berechnet die Gesamtdauer
//der Arbeitszeit, indem sie die Dauer zwischen jedem ungeraden und dem
//davorliegenden geraden Zeitstempel berechnet und diese Dauern in einer Liste
//speichert. Dann addiert die Methode die Minuten aller Dauern in dieser Liste
//zusammen und berechnet daraus die Gesamtstunden und Minuten.
  String getJobHour(List stamp) {
    int hour = 0;
    List<int> hourr = [];
    int hourrr = 0;
    List<int> minn = [];
    int min = 0;
    List<String> hours = [];
    for (int i = 0; i < stamp.length; i++) {
      if (i % 2 != 0) {
        hours.add(getDuration(stamp[i], stamp[i - 1]));
      }
    }
    for (int i = 0; i < hours.length; i++) {
      hourr.add(int.parse(hours[i].substring(0, 2)) * 60);
      minn.add(int.parse(hours[i].substring(3, 5)));
    }
    for (int i = 0; i < hourr.length; i++) {
      hour += hourr[i] + minn[i];
      hourrr = hour ~/ 60;
      min = hour % 60;
    }
    return hourrr.toString().padLeft(2, '0') +
        ":" +
        min.toString().padLeft(2, '0');
  }
//
  double convertTimeToDouble(String time) {
    List<String> timeParts = time.split(':');
    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);
    return hours + (minutes / 60);
  }
  String doubleToTimeString(double time) {
    if (time >= 0) {
      int hours = time.floor();
      int minutes = ((time - hours) * 60).round();
      return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";
    } else {
      time = time.abs();
      int hours = time.floor();
      int minutes = ((time - hours) * 60).round();
      return "-${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";
    }
  }
}
