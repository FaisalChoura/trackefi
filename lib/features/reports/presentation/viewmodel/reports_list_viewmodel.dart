import 'package:expense_categoriser/features/reports/domain/domain_modulde.dart';
import 'package:expense_categoriser/features/reports/domain/model/report.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/get_all_reports_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/remove_report_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportsListViewModel =
    StateNotifierProvider<ReportsListViewModel, AsyncValue<List<Report>>>(
        (ref) => ReportsListViewModel(
              ref.watch(
                getAllReportsUseCaseProvider,
              ),
              ref.watch(removeReportUseCaseProvider),
            ));

class ReportsListViewModel extends StateNotifier<AsyncValue<List<Report>>> {
  ReportsListViewModel(
    this._getAllReportsUseCase,
    this._removeReportUseCase,
  ) : super(const AsyncValue.data([])) {
    getList();
  }

  final GetAllReportsUseCase _getAllReportsUseCase;
  final RemoveReportUseCase _removeReportUseCase;

  void getList() async {
    state = const AsyncValue.loading();
    final reports = await _getAllReportsUseCase.execute();
    state = AsyncValue.data(reports);
  }

  void removeReport(int id) {
    _removeReportUseCase.execute(id);
  }
}
