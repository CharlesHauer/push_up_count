import 'package:flutter/material.dart';
import 'package:push_up_count/components/stat_filter_button_component.dart';
import 'package:push_up_count/utils/convert_date_string.dart';
import '../models/push_up_add.dart';
import '../models/push_up_session_model.dart';

class ControlerStats extends StatelessWidget {
  final List<PushUpSession> repository;
  final String axe;
  ControlerStats({super.key, required this.repository, required this.axe});

  List<PushUpAdd> listStats = [];

  bool sameWeek(DateTime date1, DateTime date2) {
    int year1 = date1.year;
    int year2 = date2.year;

    int day1 = date1.day;
    int day2 = date2.day;
    int week1 = date1.weekday;

    return year1 == year2 && day2 <= (day1 + 7 - week1) && day2 >= day1 - week1;
  }

  void createListWeek() {
    DateTime act = DateTime.now();
    List<int> count = [0,0,0,0,0,0,0];
    List<PushUpSession> actWeek = [];
    for (var element in repository) {

      if (sameWeek(ConvertDateString().stringToDate(element.sessionDate), act)) {
        actWeek.add(element);
      }
    }
    for (var element in actWeek) {
      if (ConvertDateString().stringToDate(element.sessionDate).weekday == DateTime.monday) {
        count[0] += element.numberPushUp;
      }
      if (ConvertDateString().stringToDate(element.sessionDate).weekday == DateTime.tuesday) {
        count[1] += element.numberPushUp;
      }
      if (ConvertDateString().stringToDate(element.sessionDate).weekday == DateTime.wednesday) {
        count[2] += element.numberPushUp;
      }
      if (ConvertDateString().stringToDate(element.sessionDate).weekday == DateTime.thursday) {
        count[3] += element.numberPushUp;
      }
      if (ConvertDateString().stringToDate(element.sessionDate).weekday == DateTime.friday) {
        count[4] += element.numberPushUp;
      }
      if (ConvertDateString().stringToDate(element.sessionDate).weekday == DateTime.saturday) {
        count[5] += element.numberPushUp;
      }
      if (ConvertDateString().stringToDate(element.sessionDate).weekday == DateTime.sunday) {
        count[6] += element.numberPushUp;
      }
    }
    listStats.add(PushUpAdd('MON', count[0]));
    listStats.add(PushUpAdd('TUE', count[1]));
    listStats.add(PushUpAdd('WED', count[2]));
    listStats.add(PushUpAdd('THU', count[3]));
    listStats.add(PushUpAdd('FRI', count[4]));
    listStats.add(PushUpAdd('SAT', count[5]));
    listStats.add(PushUpAdd('SUN', count[6]));

  }

  void createListMonth() {
    int nbday = getNumberOfDaysInMonth();
    print(nbday);
  }

  int getNumberOfDaysInMonth() {
    DateTime now = DateTime.now();
    DateTime firstDayOfNextMonth = DateTime(now.year, now.month + 1, 1);
    DateTime lastDayOfMonth = firstDayOfNextMonth.subtract(const Duration(days: 1));
    return lastDayOfMonth.day;
  }


  @override
  Widget build(BuildContext context) {
    createListMonth();
    createListWeek();
    return StatsFilterButton(chartData: listStats);
  }
}
