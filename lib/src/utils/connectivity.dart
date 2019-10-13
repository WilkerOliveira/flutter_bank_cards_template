import 'dart:io';

class Connectivity {

  static Future<bool> hasInternetConnection() async {

    try {
      final result = await InternetAddress.lookup('google.com');

      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;

    } on SocketException catch(_) {
      return false;
    }

  }

}