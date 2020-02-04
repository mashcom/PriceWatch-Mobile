import 'package:flutter/material.dart';
import 'product.dart';
import 'dart:convert';
import 'scanner_page.dart';
import 'single_product_page.dart';
import 'tabs_page.dart';
import 'splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Price Watch',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: "AirbnbCereal",
        platform: TargetPlatform.iOS,
        primaryTextTheme: TextTheme(
          headline: TextStyle(fontWeight: FontWeight.w700),
        ),
        accentColor: Colors.indigoAccent,
      ),
      home: SplashScreen(),

    );
  }
}
