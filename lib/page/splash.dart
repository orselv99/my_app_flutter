import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPage createState() => _SplashPage();
}

class _SplashPage extends State<SplashPage> {
  var _state = '';
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 1),
        () => {
              setState(() {
                _state = 'connect to server';
              })
            });

    Timer(
        Duration(seconds: 2),
        () => {
              setState(() {
                _state = 'check new updates';
              })
            });

    Timer(
        Duration(seconds: 3),
        () => {
              setState(() {
                _state = 'almost done!';
              })
            });

    Timer(
        Duration(seconds: 4),
        () => {
              setState(() {
                _state = 'welcome 😊';
              })
            });

    Timer(Duration(seconds: 5),
        () => {Navigator.of(context).pushReplacementNamed('/loginPage')});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(_state)),
    );
  }
}
