import 'package:doctorspot/homePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Map<int, Color> color = {
    50: Color.fromRGBO(21, 37, 56, .1),
    100: Color.fromRGBO(21, 37, 56, .2),
    200: Color.fromRGBO(21, 37, 56, .3),
    300: Color.fromRGBO(21, 37, 56, .4),
    400: Color.fromRGBO(21, 37, 56, .5),
    500: Color.fromRGBO(21, 37, 56, .6),
    600: Color.fromRGBO(21, 37, 56, .7),
    700: Color.fromRGBO(21, 37, 56, .8),
    800: Color.fromRGBO(21, 37, 56, .9),
    900: Color.fromRGBO(21, 37, 56, 1),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'roboto',
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                primary: MaterialColor(0xFF152538, color))),
      ),
      home: Scaffold(body: HomePage()),
    );
  }
}
