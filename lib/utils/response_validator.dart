class HTTPResponseValidator {
  static bool isValidStatusCode(int statusCode) {
    if (statusCode >= 200 && statusCode < 300) {
      return true;
    } else {
      throw HTTPExeption(statusCode);
    }
  }
}

class HTTPExeption implements Exception {
  final int statusCode;
  HTTPExeption(this.statusCode);

  @override
  String toString() {
    String message;

    switch (statusCode) {
      case 400:
        message = 'Bad requset';
        break;
      case 401:
        message = 'Unauthorized';
        break;
      case 403:
        message = 'Forbidden';
        break;
      case 409:
        message = 'Conflict';
        break;
      case 500:
        message = 'Internal Server Error';
        break;
      default:
        message = "Unknown Error";
    }
    return 'HTTPException: Status COde $statusCode, msg:$message';
  }
}
