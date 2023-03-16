import 'package:dental_clinic/pages/home_page.dart';
import 'package:dental_clinic/pages/blog_page.dart';
import 'dart:math' as math;
import 'package:dental_clinic/pages/profile_page.dart';
import 'package:dental_clinic/pages/queue_page.dart';
import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'package:dental_clinic/pages/appointment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: Rootpage(),
    );
  }
}

class Rootpage extends StatefulWidget {
  const Rootpage({super.key});

  @override
  State<Rootpage> createState() => _RootpageState();
}

class _RootpageState extends State<Rootpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginPage(),
    );
  }
}
