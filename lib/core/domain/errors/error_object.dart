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
          'You have mapped a field that cannot be assigned to amount or you have set the wrong number style, please re-import your csv';
    }
    if (exceptionType == (IncorrectFeildSeparatorException).toString()) {
      title = "Incorrect field separator";
      message =
          'You have set a wrong feild separator in the settings please enter the correct one and retry';
    }
    if (exceptionType == (IncorrectDateFormatException).toString()) {
      title = "Incorrect date format";
      message =
          'The date format is either incorrect or unsupported. Please check your date separator and format in the csv settigns';
    }
    return ErrorObject(title: title, message: message);
  }
}
