import 'package:Trackefi/features/reports/domain/model/report.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportsListStore extends StateNotifier<List<Report>> {
  ReportsListStore() : super([]);

  void setReports(List<Report> reports) {
    state = reports;
  }

  void addReport(Report report) {
    state = [...state, report];
  }

  void removeReport(int id) {
    state = state.where((f) => f.id != id).toList();
  }
}
