import 'package:flutter/material.dart';
import 'package:projeto_mobile/ui/home.dart';

void main() {
  runApp(MyApp());
}

Map<int, Color> color = {
  50: Color.fromRGBO(23, 104, 172, .1),
  100: Color.fromRGBO(23, 104, 172, .2),
  200: Color.fromRGBO(23, 104, 172, .3),
  300: Color.fromRGBO(23, 104, 172, .4),
  400: Color.fromRGBO(23, 104, 172, .5),
  500: Color.fromRGBO(23, 104, 172, .6),
  600: Color.fromRGBO(23, 104, 172, .7),
  700: Color.fromRGBO(23, 104, 172, .8),
  800: Color.fromRGBO(23, 104, 172, .9),
  900: Color.fromRGBO(23, 104, 172, 1),
};

MaterialColor myColor = MaterialColor(0xFF1768AC, color);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: myColor,
      ),
      home: HomeScreen(),
    );
  }
}
