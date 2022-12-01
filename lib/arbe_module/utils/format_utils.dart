import 'package:intl/intl.dart';

String formatDate(DateTime input) {
  DateTime dateTime = input.toLocal();
  final dateFormat = DateFormat('dd MMMM, yyyy HH:mm:ss');
  return dateFormat.format(dateTime);
}

String formatShortDate(DateTime input) {
  DateTime dateTime = input.toLocal();
  final dateFormat = DateFormat('dd/MM/yyyy');
  return dateFormat.format(dateTime);
}

String thousandFormat(int input) {
  if (input < 100) return input.toString();

  return NumberFormat('#,##,000').format(input);
}
