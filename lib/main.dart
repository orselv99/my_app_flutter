import 'package:flutter/material.dart';
import 'package:my_app_flutter/page/login.dart';
import 'package:my_app_flutter/page/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPage(),
      routes: <String, WidgetBuilder>{'/loginPage': ((context) => LoginPage())},
    );
  }
}
