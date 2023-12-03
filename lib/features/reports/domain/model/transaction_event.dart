import 'package:Trackefi/features/reports/domain/model/report_category_snapshot.dart';

class TransactionEvent {
  TransactionEventType type;
  Transaction originTransaction;
  Transaction? updatedTransaction;

  TransactionEvent(this.type, this.originTransaction, this.updatedTransaction);
}

enum TransactionEventType { remove }
