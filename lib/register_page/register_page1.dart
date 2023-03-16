import 'package:flutter/material.dart';
import 'package:dental_clinic/components/register_textfield.dart';

class register1 extends StatefulWidget {
  const register1({super.key});

  @override
  State<register1> createState() => _register1State();
}

class _register1State extends State<register1> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final repeatpassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
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
                controller: usernameController,
                hintText: 'username',
                obscureText: false,
              ),
              const SizedBox(
                height: 30,
              ),
              RegisterTextField(
                controller: emailController,
                hintText: 'email',
                obscureText: false,
              ),
              const SizedBox(
                height: 30,
              ),
              RegisterTextField(
                controller: passwordController,
                hintText: 'password',
                obscureText: true,
              ),
              const SizedBox(
                height: 30,
              ),
              RegisterTextField(
                controller: repeatpassController,
                hintText: 'repeat password',
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
