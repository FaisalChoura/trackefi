
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CsvFilesNotifier extends StateNotifier<List<PlatformFile>> {
  CsvFilesNotifier() : super([]);

  addFile(PlatformFile file) {
    state = [...state, file];
  }

  addFiles(List<PlatformFile> files) {
    state = [...state, ...files];
  }

  removeFile(PlatformFile file) {
    state = state.where((f) => f.path != file.path).toList();
  }
}

final csvFilesProvider =
    StateNotifierProvider<CsvFilesNotifier, List<PlatformFile>>(
        (ref) => CsvFilesNotifier());
