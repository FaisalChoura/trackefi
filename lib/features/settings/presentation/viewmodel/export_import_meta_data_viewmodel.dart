import 'package:Trackefi/features/settings/domain/model/import_settings.dart';
import 'package:Trackefi/features/settings/domain/usecase/generate_all_meta_data_export_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExportImportMetaDataViewModel
    extends StateNotifier<List<CsvImportSettings>> {
  final GenerateAllMetaDataReportUseCase _generateAllMetaDataReportUseCase;
  ExportImportMetaDataViewModel(this._generateAllMetaDataReportUseCase)
      : super([]);

  Future<Map> generateJson() async {
    return await _generateAllMetaDataReportUseCase.execute();
  }
}

final exportImportMetaDataViewModelProvider =
    StateNotifierProvider((ref) => ExportImportMetaDataViewModel(
          ref.watch(generateAllMetaDataReportUseCaseProvider),
        ));
