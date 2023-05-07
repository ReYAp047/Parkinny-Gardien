import 'package:easy_park_gardien/screens/fail_page.dart';
import 'package:easy_park_gardien/screens/login_screen.dart';
import 'package:easy_park_gardien/screens/scan_page.dart';
import 'package:easy_park_gardien/screens/success_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controller App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScanPage();
  }
}
