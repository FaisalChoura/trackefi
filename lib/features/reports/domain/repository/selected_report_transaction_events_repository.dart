import 'package:Trackefi/features/reports/domain/model/transaction_event.dart';

abstract class SelectedReportTransactionEventsRepository {
  void addEvent(TransactionEvent event);
}
