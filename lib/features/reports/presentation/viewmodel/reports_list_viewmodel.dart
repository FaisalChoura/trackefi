import 'package:expense_categoriser/features/reports/domain/domain_modulde.dart';
import 'package:expense_categoriser/features/reports/domain/model/report.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/get_all_reports_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reportsListViewModel =
    StateNotifierProvider<ReportsListViewModel, AsyncValue<List<Report>>>(
        (ref) => ReportsListViewModel(ref.watch(
              getAllReportsUseCaseProvider,
            )));

class ReportsListViewModel extends StateNotifier<AsyncValue<List<Report>>> {
  ReportsListViewModel(this._getAllReportsUseCase)
      : super(const AsyncValue.data([])) {
    _init();
  }

  final GetAllReportsUseCase _getAllReportsUseCase;

  void _init() async {
    state = const AsyncValue.loading();
    final reports = await _getAllReportsUseCase.execute();
    state = AsyncValue.data(reports);
  }
}
