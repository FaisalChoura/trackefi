import 'dart:convert';
import 'dart:io';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReadFileFromLocalUseCase {
  Future<Map?> execute(bool allowMultiple) async {
    const XTypeGroup jsonTypeGroup = XTypeGroup(
      label: 'JSONs',
      extensions: <String>['json'],
    );
    final List<XFile> files = await openFiles(acceptedTypeGroups: <XTypeGroup>[
      jsonTypeGroup,
    ]);
    if (files.isEmpty) {
      return null;
    }

    final file = File(files[0].path);
    const jsonDecoder = JsonDecoder();
    final contents = await file.readAsString();
    final map = jsonDecoder.convert(contents);

    return map;
  }
}

final readFileFromUseCaseProvider =
    Provider((ref) => ReadFileFromLocalUseCase());
