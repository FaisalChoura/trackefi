import 'package:Trackefi/features/reports/domain/model/transaction.dart';

class TransactionEvent {
  TransactionEventType type;
  Transaction originTransaction;
  Transaction? updatedTransaction;

  TransactionEvent(this.type, this.originTransaction, this.updatedTransaction);
}

enum TransactionEventType { remove }
