import 'package:expense_categoriser/features/categories/domain/model/category.dart';
import 'package:expense_categoriser/features/reports/domain/model/report.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class DBManager {
  late Isar isar;

  DBManager._();
  static DBManager? _instance;
  static DBManager get isntance => _instance ??= DBManager._();

  initDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [
        CategorySchema,
        ReportSchema,
      ],
      directory: dir.path,
    );
  }
}
