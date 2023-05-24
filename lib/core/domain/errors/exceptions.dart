abstract class BaseException implements Exception {
  String stringValue = 'BaseException';

  @override
  String toString() {
    return stringValue;
  }
}

class NoCsvFileImportedException extends BaseException {
  @override
  String stringValue = 'NoCsvFileImportedException';
}
