import 'package:expense_categoriser/core/domain/errors/exceptions.dart';
import 'package:expense_categoriser/features/csv_files/domain/enum/date_format.dart';

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
}
