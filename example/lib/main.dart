import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_chaira/flutter_chaira.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _bundleIdentifier = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String bundleIdentifier;
    try {
      bundleIdentifier = await FlutterChaira.bundleIdentifier;
    } on PlatformException {
      bundleIdentifier = 'Failed to get applicationId.';
    }
    if (!mounted) return;

    setState(() {
      _bundleIdentifier = bundleIdentifier;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Chaira'),
          backgroundColor: Colors.green[900],
        ),
        body: Center(
          child: Text('applicationId: $_bundleIdentifier\n'),
        ),
      ),
    );
  }
}
