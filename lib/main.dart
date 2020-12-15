import 'package:flutter/material.dart';
import 'package:recruitment_task/pages/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netguru\'s Core Values ',
      theme: ThemeData(
        brightness: Brightness.light,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 28,
        ),
        fontFamily: 'ArchitectsDaughter-Regular',
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 44.0,
            color: Colors.black,
          ),
          headline2: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Roboto',
            color: Colors.white,
          ),
          headline3: TextStyle(
            fontSize: 12,
            fontFamily: 'Roboto',
            color: Colors.white,
          ),
        ),
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 28,
        ),
        fontFamily: 'ArchitectsDaughter-Regular',
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 44.0,
            color: Colors.white,
          ),
          headline2: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Roboto',
            color: Colors.white,
          ),
          headline3: TextStyle(
            fontSize: 12,
            fontFamily: 'Roboto',
            color: Colors.white,
          ),
        ),
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}
