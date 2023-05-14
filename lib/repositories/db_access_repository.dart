import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

abstract class DbAccessRepository<T> {
  DbAccessRepository(this.schema);
  CollectionSchema<T> schema;
  Isar? isar;

  Future<bool> checkDbConnection() async {
    if (isar == null) {
      final dir = await getApplicationDocumentsDirectory();
      isar ??= await Isar.open(
        [this.schema],
        directory: dir.path,
      );
    }
    return true;
  }
}
