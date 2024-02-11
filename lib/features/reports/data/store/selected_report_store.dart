import 'package:Trackefi/features/reports/domain/model/report.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedReportStore extends Notifier<Report> {
  @override
  build() {
    return Report(0, 0, []);
  }

  updateReport(Report report) {
    state = report;
  }
}
