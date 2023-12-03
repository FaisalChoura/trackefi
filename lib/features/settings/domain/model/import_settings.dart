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
  FieldIndexes fieldIndexes = FieldIndexes();
  @enumerated
  ExpenseSignEnum expenseSign = ExpenseSignEnum.negative;
  String currencyId = '';
  bool excludeIncome = false;
  List<String> firstTwoLinesOfFile = [];

  @ignore // is not stored in db
  bool shouldSaveSettings = false;

  CsvImportSettings();

  Map toJson() {
    final json = {};
    json['id'] = id;
    json['name'] = name;
    json['fieldDelimiter'] = fieldDelimiter;
    json['endOfLine'] = endOfLine;
    json['numberStyle'] = numberStyle.index;
    json['dateFormat'] = dateFormat.index;
    json['dateSeparator'] = dateSeparator;
    json['fieldIndexes'] = fieldIndexes.toJson();
    json['expenseSign'] = expenseSign.index;
    json['firstTwoLinesOfFile'] = firstTwoLinesOfFile;
    return json;
  }

  factory CsvImportSettings.fromJson(Map json) {
    final importSettings = CsvImportSettings();
    importSettings.id = json['id'] ?? Isar.autoIncrement;
    importSettings.name = json['name'] ?? '';
    importSettings.fieldDelimiter = json['fieldDelimiter'] ?? '';
    importSettings.endOfLine = json['endOfLine'] ?? '\n';
    importSettings.numberStyle = json['numberStyle'] != null
        ? NumberingStyle.values[json['numberStyle']]
        : NumberingStyle.eu;
    importSettings.dateFormat = json['dateFormat'] != null
        ? DateFormatEnum.values[json['dateFormat']]
        : DateFormatEnum.ddmmyyyy;
    importSettings.dateSeparator = json['dateSeparator'] ?? '/';
    importSettings.fieldIndexes = json['fieldIndexes'] != null
        ? FieldIndexes.fromJson(json['fieldIndexes'])
        : FieldIndexes();
    importSettings.expenseSign = json['expenseSign'] != null
        ? ExpenseSignEnum.values[json['expenseSign']]
        : ExpenseSignEnum.negative;
    importSettings.currencyId = json['currencyId'] ?? '';
    importSettings.excludeIncome = json['excludeIncome'] ?? false;
    importSettings.firstTwoLinesOfFile = json['firstTwoLinesOfFile'] != null
        ? (json['firstTwoLinesOfFile'] as List)
            .map((e) => e.toString())
            .toList()
        : [];
    return importSettings;
  }
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

  Map<String, int> toJson() {
    final json = <String, int>{};
    json['descriptionField'] = descriptionField;
    json['amountField'] = amountField;
    json['dateField'] = dateField;
    return json;
  }

  factory FieldIndexes.fromJson(Map json) {
    return FieldIndexes(
      descriptionField: json['descriptionField'],
      amountField: json['amountField'],
      dateField: json['dateField'],
    );
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
