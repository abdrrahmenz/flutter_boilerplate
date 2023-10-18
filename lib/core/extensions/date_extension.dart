import 'package:intl/intl.dart';

extension IndonesianDateFormatter on DateTime {
  String get fullDate => DateFormat('EEEE, d MMMM y', 'id_ID').format(this);
  String get formatMonth => DateFormat('MMMM', 'id_ID').format(this);
  String get formatMonthYear => DateFormat('MMMM y', 'id_ID').format(this);
  String get time => DateFormat('HH:mm', 'id_ID').format(this);
  String get fullDateTime =>
      DateFormat('EEEE, d MMMM y HH:mm', 'id_ID').format(this);

  DateTime toGMTPlus7() {
    return add(const Duration(hours: 7));
  }

  String toFormattedString() {
    DateTime adjustedDateTime = toGMTPlus7();
    final today = DateTime.now();
    if (adjustedDateTime.year == today.year &&
        adjustedDateTime.month == today.month &&
        adjustedDateTime.day == today.day) {
      return '${adjustedDateTime.hour.toString().padLeft(2, '0')}:${adjustedDateTime.minute.toString().padLeft(2, '0')}';
    } else {
      return '${adjustedDateTime.day.toString().padLeft(2, '0')} ${_getMonthName(adjustedDateTime.month)}';
    }
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return 'Mei';
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
        return 'Desember';
      default:
        return '';
    }
  }
}
