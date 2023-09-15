import 'package:expense_categoriser/features/csv_files/domain/enum/date_format.dart';
import 'package:expense_categoriser/features/csv_files/domain/enum/expense_sign.dart';
import 'package:expense_categoriser/features/csv_files/domain/enum/numbering_style.dart';

class CsvImportSettings {
  String fieldDelimiter = ',';
  String endOfLine = '\n';
  NumberingStyle numberStyle = NumberingStyle.eu;
  DateFormatEnum dateFormat = DateFormatEnum.ddmmyyyy;
  String dateSeparator = '/'; // field needs to be parsed
  FieldIndexes fieldIndexes = FieldIndexes();
  ExpenseSignEnum expenseSign = ExpenseSignEnum.negative;
  String currencyId = '';
}

class FieldIndexes {
  int dateField = 0;
  int amountField = 1;
  int descriptionField = 2;

  FieldIndexes(
      {this.descriptionField = 2, this.dateField = 0, this.amountField = 1});

  factory FieldIndexes.fromMap(Map<int, UsableCsvFields> map) {
    final fieldIndexes = FieldIndexes();
    for (var key in map.keys) {
      switch (map[key]) {
        case UsableCsvFields.amount:
          fieldIndexes.amountField = key;
          break;
        case UsableCsvFields.date:
          fieldIndexes.dateField = key;
          break;
        case UsableCsvFields.description:
          fieldIndexes.descriptionField = key;
          break;
        default:
      }
    }
    return fieldIndexes;
  }

  Map<int, UsableCsvFields> toMap() {
    Map<int, UsableCsvFields> map = {};
    map[dateField] = UsableCsvFields.date;
    map[amountField] = UsableCsvFields.amount;
    map[descriptionField] = UsableCsvFields.description;

    return map;
  }
}

/// Fields that are read and supported in the application
enum UsableCsvFields { date, amount, description }
