import 'package:intl/intl.dart';


class ConvertDateString {
  String stringFormat = 'dd/MM/yyyy HH:mm';

  String dateToString(DateTime date){
    DateFormat dateFormat = DateFormat(stringFormat);
    return dateFormat.format(date);
  }

  DateTime stringToDate(String dateString) {
    DateFormat dateFormat = DateFormat(stringFormat);
    return dateFormat.parse(dateString);
  }
}