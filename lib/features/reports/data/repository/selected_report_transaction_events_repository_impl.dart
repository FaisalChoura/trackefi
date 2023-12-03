import 'package:Trackefi/features/reports/data/store/selected_report_transaction_events.dart';
import 'package:Trackefi/features/reports/domain/model/transaction_event.dart';
import 'package:Trackefi/features/reports/domain/repository/selected_report_transaction_events_repository.dart';

class SelectedReportTransactionEventsRepositoryImpl
    implements SelectedReportTransactionEventsRepository {
  SelectedReportTransactionEventsRepositoryImpl(this._store);
  SelectedReportTransactionEventsStore _store;

  @override
  void addEvent(TransactionEvent event) {
    _store.addEvent(event);
  }
}
