import 'exceptions.dart';

class ErrorObject {
  String title;
  String message;
  ErrorObject({required this.title, required this.message});

  factory ErrorObject.exceptionToErrorObjectMapper(
      String exceptionType, StackTrace s) {
    String title = exceptionType;
    String message = s.toString();
    if (exceptionType == (NoCsvFileImportedException).toString()) {
      title = 'No CSV file found!';
      message = 'Please import a CSV file before generating a report';
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
    if (exceptionType == (WrongFileTypeException).toString()) {
      title = "File is not a CSV";
      message = 'Only CSV files are supported, please reimport a CSV file';
    }
    return ErrorObject(title: title, message: message);
  }
}

class HandleableUerError {
  String title;
  String message;
  HandleableUerError(this.title, this.message);
}
