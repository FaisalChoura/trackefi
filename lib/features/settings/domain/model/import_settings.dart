import 'package:Trackefi/features/csv_files/domain/enum/date_format.dart';
import 'package:Trackefi/features/csv_files/domain/enum/expense_sign.dart';
import 'package:Trackefi/features/csv_files/domain/enum/numbering_style.dart';
import 'package:isar/isar.dart';

part 'import_settings.g.dart';

@collection
class CsvImportSettings {
  Id id = Isar.autoIncrement;
  String name = '';
  String fieldDelimiter = ',';
  String endOfLine = '\n';
  @enumerated
  NumberingStyle numberStyle = NumberingStyle.eu;
  @enumerated
  DateFormatEnum dateFormat = DateFormatEnum.ddmmyyyy;
  String dateSeparator = '/'; // field needs to be parsed
  @enumerated
  FieldIndexes fieldIndexes = FieldIndexes();
  @enumerated
  ExpenseSignEnum expenseSign = ExpenseSignEnum.negative;
  String currencyId = '';
  bool excludeIncome = false;
  List<String> firstTwoLinesOfFile = [];
}

@embedded
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
enum UsableCsvFields { none, date, amount, description }

@embedded
class HeaderFirstRowData {
  List<String> headerRow;
  List<String> firstRow;

  HeaderFirstRowData([this.headerRow = const [], this.firstRow = const []]);
}
