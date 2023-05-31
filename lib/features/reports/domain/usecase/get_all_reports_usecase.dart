import 'package:expense_categoriser/features/reports/domain/model/report.dart';
import 'package:expense_categoriser/features/reports/domain/repository/reports_repositry.dart';

class GetAllReportsUseCase {
  final ReportsRepository _reportsRepository;

  const GetAllReportsUseCase(this._reportsRepository);

  Future<List<Report>> execute() async {
    return await _reportsRepository.getAllReports();
  }
}
