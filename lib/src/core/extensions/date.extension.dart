import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toDDMMYYYY() {
    final date = toLocal();
    return DateFormat('dd.MM.yyyy').format(date);
  }
}
