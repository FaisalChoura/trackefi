import 'package:expense_categoriser/features/csv_files/domain/domain_module.dart';
import 'package:expense_categoriser/features/csv_files/domain/usecase/import_files_usecase.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final csvFilesViewModelProvider =
    StateNotifierProvider<CsvFilesViewModel, AsyncValue<List<PlatformFile>>>(
        (ref) => CsvFilesViewModel(ref.watch(importFilesUseCaseProvider)));

class CsvFilesViewModel extends StateNotifier<AsyncValue<List<PlatformFile>>> {
  final ImportFilesUseCase _importFilesUseCase;

  CsvFilesViewModel(
    this._importFilesUseCase,
  ) : super(const AsyncValue.data([]));

  void importFiles() async {
    final files = await _importFilesUseCase.execute();
    _addFiles(files);
  }

  void _addFiles(List<PlatformFile> files) {
    state = AsyncValue.data([...state.value ?? [], ...files]);
  }

  removeFile(PlatformFile file) {
    state = AsyncValue.data(
        _currentStateValue.where((f) => f.path != file.path).toList());
  }

  List<PlatformFile> get _currentStateValue {
    return state.value ?? [];
  }
}
