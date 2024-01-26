

 class Failure implements Exception {
  final String? message;
  final String? errorCode;
  final String? error;
  const Failure({ this.error, this.message,  this.errorCode});
}
