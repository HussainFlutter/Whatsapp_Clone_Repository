

abstract class Failure implements Exception {
  final String? message;
  final String? errorCode;
  const Failure({required this.message, required this.errorCode});
}
