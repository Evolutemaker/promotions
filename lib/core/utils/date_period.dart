import 'package:intl/intl.dart';

String datePeriod(DateTime startDate, DateTime endDate) {
  final formatter = DateFormat('dd.MM.yyyy');
  final startStr = formatter.format(startDate);
  final endStr = formatter.format(endDate);
  return '$startStr - $endStr';
}