import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';
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
      return exchange(code: code, redirectUri: redirectUri);
    } on PlatformException catch (e) {
      throw (e.message);
    }
  }

  Future<dynamic> exchange(
    {@required String code, @required String redirectUri}) async {
    try {
      http.Response response = await http.post(
        Uri.encodeFull('https://chaira.udla.edu.co/ChairaApi/oauth2/token'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'code': code,
          'redirect_uri': redirectUri,
          'client_id': this.clientId,
          'client_secret': this.clientSecret,
          'grant_type': 'authorization_code'
        })
      );
      Map<dynamic, dynamic> json = jsonDecode(response.body);
      return json['access_token'];
    } catch (e) {
      return '[Exchange WebAuthentication Error]: ${e.message}';
    }
  }
}
