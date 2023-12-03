import 'package:Trackefi/features/settings/domain/model/import_settings.dart';
import 'package:Trackefi/features/settings/domain/usecase/generate_all_meta_data_export_usecase.dart';
import 'package:Trackefi/features/settings/domain/usecase/generate_file_from_data_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExportImportMetaDataViewModel
    extends StateNotifier<List<CsvImportSettings>> {
  final GenerateAllMetaDataReportUseCase _generateAllMetaDataReportUseCase;
  final GenerateFileFromDataUseCase _generateFileFromDataUseCase;
  ExportImportMetaDataViewModel(
      this._generateAllMetaDataReportUseCase, this._generateFileFromDataUseCase)
      : super([]);

  Future<Map> generateJson() async {
    return await _generateAllMetaDataReportUseCase.execute();
  }

  Future<bool> generateFileFromJson(Map json) async {
    return await _generateFileFromDataUseCase.execute(json);
  }
}

final exportImportMetaDataViewModelProvider =
    StateNotifierProvider((ref) => ExportImportMetaDataViewModel(
          ref.watch(generateAllMetaDataReportUseCaseProvider),
          ref.watch(generateFileFromDataUseCaseProvider),
        ));
