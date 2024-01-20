import 'dart:convert';
import 'dart:typed_data';

import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenerateFileFromDataUseCase {
  Future<bool> execute(Map json) async {
    final FileSaveLocation? result =
        await getSaveLocation(suggestedName: 'meta_data.json');

    if (result == null) {
      // Operation was canceled by the user.
      return false;
    }

    try {
      const jsonEncoder = JsonEncoder();
      final stringifiedMap = jsonEncoder.convert(json);

      final Uint8List fileData = Uint8List.fromList(stringifiedMap.codeUnits);
      const String mimeType = 'text/plain';
      final XFile textFile =
          XFile.fromData(fileData, mimeType: mimeType, name: 'meta_data.json');
      await textFile.saveTo(result.path);

      return true;
    } catch (e) {
      rethrow;
    }
  }
}

final generateFileFromDataUseCaseProvider =
    Provider((ref) => GenerateFileFromDataUseCase());
