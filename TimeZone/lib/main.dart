import 'package:flutter/material.dart';
import './Pages/homePage.dart';
import 'Pages/loading.dart';
import 'Pages/location.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoadingPage(),
        '/home': (context) => Home(),
        '/location': (context) => ChooseLocation(),
      },
    ),
  );
}
