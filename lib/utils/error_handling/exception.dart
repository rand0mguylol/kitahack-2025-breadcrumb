class InvalidFormException implements Exception {
  final String message;
  final String? details;

  InvalidFormException(this.message, [this.details]);
}

class CustomException implements Exception {
  final String message;
  final String code;
  final String? details;
  String displayMessage;

  CustomException(
      {required this.message,
      required this.code,
      this.details,
      this.displayMessage = 'Something went wrong'});

  factory CustomException.notFound(
      {required String message,
      required String code,
      String? details,
      String displayMessage = 'Something went wrong'}) {
    return NotFoundException(
        message: message,
        code: code,
        details: details,
        displayMessage: displayMessage);
  }
}

class NotFoundException extends CustomException {
  NotFoundException(
      {required super.message,
      required super.code,
      super.details,
      super.displayMessage});
}
