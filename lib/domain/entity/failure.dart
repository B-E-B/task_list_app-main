class Failure {
  final String message;
  final Object? exception;
  final StackTrace? stackTrace;

  Failure({
    required this.message,
    this.exception,
    this.stackTrace,
  });

  @override
  String toString() {
    return message;
  }
}
