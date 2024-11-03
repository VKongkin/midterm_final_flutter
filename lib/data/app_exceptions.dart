class AppException implements Exception{
  final _message;
  final _prefix;

  AppException([this._prefix, this._message]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class NoInternetConnectionException extends AppException{
  NoInternetConnectionException([String? message]): super(message, "No Internet Connection");
}

class RequestTimeOutException extends AppException{
  RequestTimeOutException([String? message]): super(message, "Request Time Out");
}

class InternalServerException extends AppException{
  InternalServerException([String? message]): super(message, "Internal Server Error");
}
class UnAuthorization extends AppException{
  UnAuthorization([String? message]): super(message, "Username or Password Incorrect!");
}