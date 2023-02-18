import 'package:flutter/material.dart';
import 'package:dental_clinic/components/register_textfield.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class register2 extends StatefulWidget {
  const register2({super.key});

  @override
  State<register2> createState() => _register2State();
}

class _register2State extends State<register2> {
  final prenameController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final idcardController = TextEditingController();
  final birthController = TextEditingController();
  final telController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              Text(
                'Register',
                style: TextStyle(
                  color: Colors.cyan[300],
                  fontSize: 50,
                ),
              ),
              const SizedBox(height: 30),
              RegisterTextField(
                controller: prenameController,
                hintText: 'Mr.',
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              RegisterTextField(
                controller: firstnameController,
                hintText: 'first name',
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              RegisterTextField(
                controller: lastnameController,
                hintText: 'last name',
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              RegisterTextField(
                controller: idcardController,
                hintText: 'card id',
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              RegisterTextField(
                controller: birthController,
                hintText: 'date of birth',
                obscureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              RegisterTextField(
                controller: telController,
                hintText: 'tel.',
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Next"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
