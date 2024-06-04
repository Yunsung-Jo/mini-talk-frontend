class AppException implements Exception {
  final String? _message, _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix: $_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([super.message = "Error During Communication"]);
}

class BadRequestException extends AppException {
  BadRequestException([super.message = "Bad Request Exception"]);
}
