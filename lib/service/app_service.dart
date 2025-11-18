import 'dart:async';

class AppService {
  Future<String> getErrorTextInfo() async {
    await Future.delayed(Duration(milliseconds: 100));
    return 'Please check your network connection and try again.';
  }

  Future<void> checkLicenseUser({required dynamic msgError}) async {
    await Future.delayed(Duration(milliseconds: 100));
  }

}
