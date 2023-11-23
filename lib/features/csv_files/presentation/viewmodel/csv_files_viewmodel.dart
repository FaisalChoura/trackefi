import 'package:Trackefi/core/domain/errors/exceptions.dart';
import 'package:Trackefi/features/csv_files/domain/domain_module.dart';
import 'package:Trackefi/features/csv_files/domain/model/csv_file_data.dart';
import 'package:Trackefi/features/csv_files/domain/usecase/import_files_usecase.dart';
import 'package:Trackefi/features/csv_files/domain/usecase/remove_file_usecase.dart';
import 'package:Trackefi/features/csv_files/domain/usecase/update_file_usecase.dart';
import 'package:Trackefi/features/reports/domain/domain_modulde.dart';
import 'package:Trackefi/features/reports/domain/enum/csv_file_chunk_size_enum.dart';
import 'package:Trackefi/features/reports/domain/usecase/convert_csv_file_usecase.dart';
import 'package:Trackefi/features/settings/domain/model/import_settings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final csvFilesViewModelProvider =
    StateNotifierProvider<CsvFilesViewModel, AsyncValue<void>>((ref) =>
        CsvFilesViewModel(
            ref.watch(importFilesUseCaseProvider),
            ref.watch(removeFilesUseCaseProvider),
            ref.watch(updateFileUseCaseProvider),
            ref.watch(convertCsvFileUseCaseProvider)));

class CsvFilesViewModel extends StateNotifier<AsyncValue<void>> {
  final ImportFilesUseCase _importFilesUseCase;
  final RemoveFileUseCase _removeFileUseCase;
  final UpdateFileUseCase _updateFileUseCase;
  final ConvertCsvFileUseCase _convertCsvFileUseCase;

  CsvFilesViewModel(this._importFilesUseCase, this._removeFileUseCase,
      this._updateFileUseCase, this._convertCsvFileUseCase)
      : super(const AsyncValue.data(null));

  Future<FilePickerResult?> getFiles() async {
    try {
      final result = await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result != null) {
        _checkFileType(result.files);
      }
      return result;
    } catch (e, s) {
      state = AsyncValue.error(e, s);
      return null;
    }
  }

  void importFiles(List<CsvFileData> files) async {
    _importFilesUseCase.execute(files);
  }

  void removeFile(CsvFileData fileData) async {
    _removeFileUseCase.execute(fileData);
  }

  void updateFile(CsvFileData fileData) async {
    _updateFileUseCase.execute(fileData);
  }

  void _checkFileType(List<PlatformFile> files) {
    for (var file in files) {
      if (file.extension != 'csv') {
        throw WrongFileTypeException();
      }
    }
  }

  Future<HeaderFirstRowData> getHeaderAndFirstRow(CsvFileData file) async {
    final data = await _convertCsvFileUseCase
        .execute([file], CsvFileChunkSizeEnum.small);
    final headerRow = data[0]![0].map((e) => e.toString()).toList();
    final firstRow = data[0]![1].map((e) => e.toString()).toList();
    return HeaderFirstRowData(headerRow, firstRow);
  }
}
