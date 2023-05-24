import 'exceptions.dart';

class ErrorObject {
  String title;
  String message;
  ErrorObject({required this.title, required this.message});

  factory ErrorObject.exceptionToErrorObjectMapper(String exceptionType) {
    if (exceptionType == (NoCsvFileImportedException).toString()) {
      return ErrorObject(title: 'No CSV file found!', message: 'test');
    }
    return ErrorObject(title: 'Uknown!', message: 'test');
  }
}
