import 'dart:convert';
import 'dart:io';

import 'package:Trackefi/core/domain/errors/exceptions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReadFileFromLocalUseCase {
  Future<Map?> execute(bool allowMultiple) async {
    final result =
        await FilePicker.platform.pickFiles(allowMultiple: allowMultiple);
    if (result == null) {
      return null;
    }
    _checkFileType(result.files, 'json');

    if (result.files[0].path == null) {
      return null;
    }

    final file = File(result.files[0].path!);
    const jsonDecoder = JsonDecoder();
    final contents = await file.readAsString();
    final map = jsonDecoder.convert(contents);

    return map;
  }

  void _checkFileType(List<PlatformFile> files, String fileType) {
    for (var file in files) {
      if (file.extension != fileType) {
        throw WrongFileTypeException();
      }
    }
  }
}

final readFileFromUseCaseProvider =
    Provider((ref) => ReadFileFromLocalUseCase());
