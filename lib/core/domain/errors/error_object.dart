import 'exceptions.dart';

class ErrorObject {
  String title;
  String message;
  ErrorObject({required this.title, required this.message});

  factory ErrorObject.exceptionToErrorObjectMapper(String exceptionType) {
    String title = exceptionType;
    String message = 'Uknown error';
    if (exceptionType == (NoCsvFileImportedException).toString()) {
      title = 'No CSV file found!';
    }
    if (exceptionType == (IncorrectAmountMappingException).toString()) {
      title = "Incorrect mapped item for amount feild";
      message =
          'You have mapped a field that cannot be assigned to amount, please re-import your csv';
    }
    return ErrorObject(title: title, message: message);
  }
}
