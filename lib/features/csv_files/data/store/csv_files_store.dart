import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CsvFilesStore extends StateNotifier<List<PlatformFile>> {
  CsvFilesStore() : super([]);

  void addFiles(List<PlatformFile> files) {
    state = [...state, ...files];
  }

  removeFile(PlatformFile file) {
    state = state.where((f) => f.path != file.path).toList();
  }
}
