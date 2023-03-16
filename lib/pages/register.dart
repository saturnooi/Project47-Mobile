import 'package:flutter/material.dart';
import 'package:dental_clinic/register_page/register_page1.dart';
import 'package:dental_clinic/register_page/register_page2.dart';
import 'package:dental_clinic/register_page/register_page3.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var pages = [register1(), register2(), register3()];

  @override
  final formKey = GlobalKey<FormState>();

  Future sign_up() async {
    String url = "";
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: PageView(
          children: pages,
        ),
      ),
    );
  }
}
