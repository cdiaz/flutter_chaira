import 'package:flutter/material.dart';

import 'package:flutter_chaira/flutter_chaira.dart';

final String clientId = '<your ClientId>';
final String clientSecret = '<your ClientSecret>';

final Chaira _chaira =
    new Chaira(clientId: clientId, clientSecret: clientSecret);

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  void login() async {
    _chaira.authorize().then((code) {
      print(code);
    }).catchError((err) => print('Error: $err'));
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
          child: displayLoginButton(),
        ),
      ),
    );
  }

  displayLoginButton() {
    return OutlineButton(
        shape: StadiumBorder(),
        highlightedBorderColor: Colors.green,
        textColor: Colors.green,
        child: Text(
          'Iniciar sesión',
          style: new TextStyle(
            fontSize: 17.5,
            color: Colors.green,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
        borderSide: BorderSide(
            color: Colors.green, style: BorderStyle.solid, width: 1.8),
        onPressed: login);
  }
}
