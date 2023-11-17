import 'package:Trackefi/features/reports/domain/model/report.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedReportStore extends Notifier<Report?> {
  @override
  build() {
    return null;
  }

  updateReport(Report report) {
    state = report;
  }
}
