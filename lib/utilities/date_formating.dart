import 'package:intl/intl.dart';

String dateFormating({required year, required month, required day}) {
  DateTime date = DateTime(year, month, day);
  return DateFormat.yMMMd().format(date);
}
