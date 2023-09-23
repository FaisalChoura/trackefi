import 'package:Trackefi/core/domain/errors/exceptions.dart';
import 'package:Trackefi/features/csv_files/domain/enum/date_format.dart';
import 'package:intl/intl.dart';

class TrHelpers {
  static String dateString(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  static String formatDate(
      String date, String dateSeparator, DateFormatEnum dateFormat) {
    try {
      List<String> dateChunks = date.split(dateSeparator);
      String formatedDate = '';
      if (dateFormat == DateFormatEnum.ddmmyyyy) {
        formatedDate = "${dateChunks[2]}-${dateChunks[1]}-${dateChunks[0]}";
      } else if (dateFormat == DateFormatEnum.mmddyyyy) {
        formatedDate = "${dateChunks[2]}-${dateChunks[0]}-${dateChunks[1]}";
      } else if (dateFormat == DateFormatEnum.yyyymmdd) {
        formatedDate = "${dateChunks[0]}-${dateChunks[1]}-${dateChunks[2]}";
      } else {
        throw 'WrongDateFormat';
      }
      return formatedDate;
    } catch (e) {
      throw IncorrectDateFormatException();
    }
  }

  static String simpleDateFormatter(DateTime date) {
    final DateFormat formatter = DateFormat('yMMMMd');
    final String formatted = formatter.format(date);
    return formatted;
  }
}
