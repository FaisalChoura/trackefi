import 'dart:io';
import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenerateFileFromDataUseCase {
  Future<bool> execute(Map json) async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory == null) {
      // User canceled the picker
    }
    final path = "$selectedDirectory\\meta_data.json";
    final file = File(path);

    try {
      const jsonEncoder = JsonEncoder();
      final stringifiedMap = jsonEncoder.convert(json);
      await file.writeAsString(stringifiedMap);
      return true;
    } catch (e) {
      // TODO handle error
      return false;
    }
  }
}

final generateFileFromDataUseCaseProvider =
    Provider((ref) => GenerateFileFromDataUseCase());
