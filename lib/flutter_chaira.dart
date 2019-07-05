import 'dart:async';

import 'package:flutter/services.dart';

class FlutterChaira {
  static const MethodChannel _channel = const MethodChannel('flutter_chaira');

  static Future<String> get bundleIdentifier async {
    final String bundleIdentifier =
        await _channel.invokeMethod('bundleIdentifier');
    return bundleIdentifier;
  }
}
