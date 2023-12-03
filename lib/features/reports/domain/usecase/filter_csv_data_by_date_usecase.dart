import 'package:Trackefi/core/domain/helpers/helpers.dart';
import 'package:Trackefi/features/settings/domain/model/import_settings.dart';
import 'package:Trackefi/features/reports/domain/model/report_settings.dart';

class FilterCsvDataByDateUseCase {
  List<List<dynamic>> execute(List<List<dynamic>> data,
      CsvImportSettings importSettings, ReportSettings reportSettings) {
    List<List<dynamic>> filteredList = [];

    if (reportSettings.fromDate == null || reportSettings.toDate == null) {
      return data;
    }

    for (var i = 1; i < data.length; i++) {
      final row = data[i];
      final dateString = TrHelpers.formatDate(
        row[importSettings.fieldIndexes.dateField],
        importSettings.dateSeparator,
        importSettings.dateFormat,
      );

      final date = DateTime.parse(dateString);

      if (date.isAfter(reportSettings.fromDate!) &&
          date.isBefore(reportSettings.toDate!)) {
        filteredList.add(row);
      }
    }
    return filteredList;
  }
}
