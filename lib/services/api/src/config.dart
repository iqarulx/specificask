import 'dart:io';

class Config {
  static String apiUrl = "https://sridemoapps.in/subha2022/specific_ask/API";
  // static String apiUrl =
  //     "https://sridemoapps.in/sridemoapps.in/arul2024/specific_ask/API";
}

class HttpOverridesImpl extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
