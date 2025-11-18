class AnalyticsService {
  static dynamic logError({
    required String errorMessage,
    required String errorDetails,
    String? stackTrace,
  }) {
    print('Logging Error to Firebase Analytics:');
    print('Error Message: $errorMessage');
    print('Error Details: $errorDetails');
    if (stackTrace != null) {
      print('Stack Trace: $stackTrace');
    }
  }
}