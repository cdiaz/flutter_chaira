import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class Chaira {
  final String clientId;
  final String clientSecret;
  final String platformName = Platform.isAndroid ? 'android' : 'ios';
  static const MethodChannel _channel = const MethodChannel('flutter_chaira');

  Chaira({this.clientId, this.clientSecret});

  Future<dynamic> authorize() async {
    dynamic bundleIdentifier = await _channel.invokeMethod('bundleIdentifier');
    try {
      String redirectUri = '$bundleIdentifier://chaira/$platformName/callback';
      String authorizeUrl =
          'https://chaira.udla.edu.co/ChairaApi/oauth2/auth?response_type=code&client_id=${this.clientId}&redirect_uri=$redirectUri&state=123456';
      String code = await _channel
          .invokeMethod('showUrl', {'url': Uri.encodeFull(authorizeUrl)});
      return code;
    } on PlatformException catch (e) {
      throw (e.message);
    }
  }
}
