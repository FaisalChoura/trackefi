import 'package:Trackefi/features/reports/data/data_module.dart';
import 'package:Trackefi/features/reports/domain/model/report.dart';
import 'package:Trackefi/features/reports/domain/repository/selected_report_store_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final setSelectedReportUseCaseProvider = Provider<SetSelectedReportUseCase>(
    (ref) => SetSelectedReportUseCase(
        ref.watch(selectedReportStoreRepositoryProvider)));

class SetSelectedReportUseCase {
  SetSelectedReportUseCase(this._selectedReportStoreRepository);

  final SelectedReportStoreRepository _selectedReportStoreRepository;

  void execute(Report report) async {
    _selectedReportStoreRepository.updateReport(report);
  }
}
