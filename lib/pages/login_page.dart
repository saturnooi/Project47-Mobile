import 'package:dental_clinic/pages/main_page.dart';
import 'package:dental_clinic/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:dental_clinic/pages/main_page.dart';
import 'package:dental_clinic/components/my_button.dart';
import 'package:dental_clinic/components/my_textfield.dart';
import 'package:dental_clinic/components/square_tile.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _errorMessage;

  Future<void> _handleLogin() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final conn = PostgreSQLConnection(
      'localhost',
      5432,
      'clinic',
      username: 'postgres',
      password: '1234',
    );
    await conn.open();

    final results = await conn.query(
      'SELECT * FROM patient WHERE username = @username',
      substitutionValues: {'username': username},
    );
    if (results.isEmpty) {
      setState(() {
        _errorMessage = 'Invalid username or password.';
      });
      return;
    }

    final user = results.first.toColumnMap();
    if (user['pass'] != password) {
      setState(() {
        _errorMessage = 'Invalid username or password.';
      });
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Mainpage(
          userId: user['id'],
        ),
      ),
    );

    await conn.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[300],
      body: Form(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // logo
              const Text("We\nSmile",
                  style: TextStyle(color: Colors.white, fontSize: 50)),

              const SizedBox(height: 50),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: _usernameController,
                    obscureText: false,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      hintText: "Username",
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username.';
                      }
                      return null;
                    },
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password.';
                      }
                      return null;
                    },
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // sign in button
              GestureDetector(
                onTap: () {
                  _handleLogin();
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 60),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: const Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.cyan,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\' have an account?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 1),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Register(),
                        ),
                      );
                    },
                    child: const Text(
                      "Register Now",
                      style: TextStyle(color: Colors.cyan),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
