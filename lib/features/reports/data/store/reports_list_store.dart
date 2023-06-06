import 'package:expense_categoriser/features/reports/domain/model/report.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportsListStore extends StateNotifier<List<Report>> {
  ReportsListStore() : super([]);

  void setReports(List<Report> reports) {
    state = reports;
  }

  void addReport(Report report) {
    state = [...state, report];
  }

  void removeReport(Report report) {
    state = state.where((f) => f.id != report.id).toList();
  }
}
