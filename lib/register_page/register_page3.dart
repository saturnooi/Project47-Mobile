import 'package:flutter/material.dart';
import 'package:dental_clinic/components/register_textfield.dart';

class register3 extends StatefulWidget {
  const register3({super.key});

  @override
  State<register3> createState() => _register3State();
}

class _register3State extends State<register3> {
  final diseaseController = TextEditingController();
  final allergyController = TextEditingController();

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
                controller: diseaseController,
                hintText: 'underlying disease',
                obscureText: false,
              ),
              const SizedBox(
                height: 30,
              ),
              RegisterTextField(
                controller: allergyController,
                hintText: 'allergy',
                obscureText: false,
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Create Account"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
