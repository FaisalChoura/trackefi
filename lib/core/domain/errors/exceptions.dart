abstract class BaseException implements Exception {
  String stringValue = 'BaseException';

  @override
  String toString() {
    return stringValue;
  }
}

class NoCsvFileImportedException extends BaseException {
  @override
  String get stringValue {
    return 'NoCsvFileImportedException';
  }
}

class IncorrectAmountMappingException extends BaseException {
  @override
  String get stringValue {
    return 'IncorrectAmountMappingException';
  }
}

class IncorrectFeildSeparatorException extends BaseException {
  @override
  String get stringValue {
    return 'IncorrectFeildSeparatorException';
  }
}
