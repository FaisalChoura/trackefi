import 'package:expense_categoriser/features/csv_files/domain/domain_module.dart';
import 'package:expense_categoriser/features/csv_files/domain/model/csv_file_data.dart';
import 'package:expense_categoriser/features/csv_files/domain/usecase/import_files_usecase.dart';
import 'package:expense_categoriser/features/csv_files/domain/usecase/remove_file_usecase.dart';
import 'package:expense_categoriser/features/reports/domain/domain_modulde.dart';
import 'package:expense_categoriser/features/reports/domain/usecase/convert_csv_file_usecase.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final csvFilesViewModelProvider =
    Provider<CsvFilesViewModel>((ref) => CsvFilesViewModel(
          ref.watch(importFilesUseCaseProvider),
          ref.watch(removeFilesUseCaseProvider),
          ref.watch(convertCsvFileUseCaseProvider),
        ));

class CsvFilesViewModel {
  final ImportFilesUseCase _importFilesUseCase;
  final RemoveFileUseCase _removeFileUseCase;
  final ConvertCsvFileUseCase _convertCsvFileUseCase;

  CsvFilesViewModel(
    this._importFilesUseCase,
    this._removeFileUseCase,
    this._convertCsvFileUseCase,
  );

  Future<FilePickerResult?> getFiles() async {
    return await FilePicker.platform.pickFiles();
  }

  void importFiles(List<CsvFileData> files) async {
    _importFilesUseCase.execute(files);
  }

  void removeFile(CsvFileData fileData) async {
    _removeFileUseCase.execute(fileData);
  }

  Future<List<String>> getHeaderRow(CsvFileData file) async {
    final data = await _convertCsvFileUseCase.execute([file]);
    return data[0]![0].map((e) => e.toString()).toList();
  }
}
