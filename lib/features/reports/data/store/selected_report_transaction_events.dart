import 'package:Trackefi/features/reports/domain/model/transaction_event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedReportTransactionEventsStore
    extends Notifier<List<TransactionEvent>> {
  @override
  build() {
    return [];
  }

  addEvent(TransactionEvent event) {
    state = [...state, event];
  }
}
