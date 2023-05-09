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
}

final csvFilesProvider =
    StateNotifierProvider<CsvFilesNotifier, List<PlatformFile>>(
        (ref) => CsvFilesNotifier());
