import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

@embedded
class Transaction {
  late String id;
  String categorySnapshotId;
  String name;
  late DateTime date;
  double amount;
  double? originalAmount;
  bool isIncome;
  String currencyId;
  String? originalCurrencyId;
  String? originFileName;
  Transaction({
    this.name = '',
    this.amount = 0,
    String dateString = '1995-01-01',
    this.isIncome = false,
    this.currencyId = '',
    this.categorySnapshotId = '',
  }) {
    id = const Uuid().v4();
    date = DateTime.parse(dateString);
  }
}
