import 'package:Trackefi/features/settings/domain/model/import_settings.dart';
import 'package:Trackefi/features/settings/domain/usecase/create_data_from_import_file_usecase.dart';
import 'package:Trackefi/features/settings/domain/usecase/generate_all_meta_data_export_usecase.dart';
import 'package:Trackefi/features/settings/domain/usecase/generate_file_from_data_usecase.dart';
import 'package:Trackefi/features/settings/domain/usecase/read_file_from_local_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExportImportMetaDataViewModel
    extends StateNotifier<List<CsvImportSettings>> {
  final GenerateAllMetaDataReportUseCase _generateAllMetaDataReportUseCase;
  final GenerateFileFromDataUseCase _generateFileFromDataUseCase;
  final CreateDataFromImportFileUseCase _createDataFromImportFileUseCase;
  final ReadFileFromLocalUseCase _readFileFromLocalUseCase;
  ExportImportMetaDataViewModel(
    this._generateAllMetaDataReportUseCase,
    this._generateFileFromDataUseCase,
    this._createDataFromImportFileUseCase,
    this._readFileFromLocalUseCase,
  ) : super([]);

  Future<Map> generateJson() async {
    return await _generateAllMetaDataReportUseCase.execute();
  }

  Future<bool> generateFileFromJson(Map json) async {
    return await _generateFileFromDataUseCase.execute(json);
  }

  Future<Map?> readJsonFile() async {
    return await _readFileFromLocalUseCase.execute(false);
  }

  Future<bool> createDataFromFile(Map json) async {
    return await _createDataFromImportFileUseCase.execute(json);
  }
}

final exportImportMetaDataViewModelProvider =
    StateNotifierProvider((ref) => ExportImportMetaDataViewModel(
          ref.watch(generateAllMetaDataReportUseCaseProvider),
          ref.watch(generateFileFromDataUseCaseProvider),
          ref.watch(createDataFromImportFileUseCaseProvider),
          ref.watch(readFileFromUseCaseProvider),
        ));
