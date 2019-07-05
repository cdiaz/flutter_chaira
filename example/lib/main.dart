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
  bool isLoggedIn = false;
  var profileData;

  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      this.profileData = profileData;
    });
  }

  void login() async {
    _chaira.authorize().then((accessToken) {
      this.getUserProfile(accessToken);
    }).catchError((err) => print('Error: $err'));
  }

  void getUserProfile(token) async {
    _chaira.getUserProfile(token: token).then((profile) {
      onLoginStatusChanged(true, profileData: profile);
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
          child: isLoggedIn
            ? displayUserProfile(profileData)
            : displayLoginButton(),
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

  displayUserProfile(userProfile) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 180.0,
          width: 180.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                userProfile['FOTO'],
              ),
            ),
          ),
        ),
        SizedBox(height: 28.0),
        Text(
          userProfile['NOMBRE'],
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        Text(
          userProfile['CORREO'],
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        Text(
          "id: ${userProfile['ID_USUARIO']}",
          style: TextStyle(fontSize: 16.0),
        )
      ],
    );
  }
}
