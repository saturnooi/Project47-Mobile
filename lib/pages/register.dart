import 'package:flutter/material.dart';
import 'package:dental_clinic/register_page/register_page1.dart';
import 'package:dental_clinic/register_page/register_page2.dart';
import 'package:dental_clinic/register_page/register_page3.dart';
import 'package:dental_clinic/components/register_textfield.dart';
import 'package:postgres/postgres.dart';
import 'dart:math';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var pages = [register1(), register2(), register3()];
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final repeatpassController = TextEditingController();
  // final prenameController = TextEditingController();
  // final firstnameController = TextEditingController();
  final fullnameController = TextEditingController();
  final idcardController = TextEditingController();
  final careerController = TextEditingController();
  final birthController = TextEditingController();
  final telController = TextEditingController();
  final diseaseController = TextEditingController();
  final allergyController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _insertPatient() async {
    final String username = usernameController.text;
    final String pass = passwordController.text;
    final String email = emailController.text;
    final String fullname = fullnameController.text;
    final String id_card = idcardController.text;
    final String tel = telController.text;
    final String disease = diseaseController.text;
    final String allergy = allergyController.text;
    final String career = careerController.text;

    final conn = PostgreSQLConnection(
      'localhost',
      5432,
      'clinic',
      username: 'postgres',
      password: '1234',
      // useSSL: true,
    );
    await conn.open();

    int randomId = 0;
    bool isIdUnique = false;
    while (!isIdUnique) {
      randomId = Random().nextInt(99999); // generate random ID
      final result = await conn.query(
          'SELECT COUNT(*) FROM patient WHERE id = @id',
          substitutionValues: {'id': randomId});
      final count = result[0][0] as int;
      isIdUnique = count == 0;
    }

    if (isIdUnique == true) {
      await conn.query(
        'INSERT INTO patient (id, username, pass,fullname, id_card, birthdate, career, email, phone_number, drug_allergy, underlying_disease) VALUES (@id, @username, @pass, @fullname, @id_card, @birthdate, @career, @email, @phone_number, @drug_allergy, @underlying_disease )',
        substitutionValues: {
          'id': randomId,
          'username': username,
          'pass': pass,
          'fullname': fullname,
          'id_card': id_card,
          'birthdate': selectedDate.toIso8601String(),
          'career': career,
          'email': email,
          'phone_number': tel,
          'drug_allergy': allergy,
          'underlying_disease': disease,
        },
      );
    }

    await conn.close();
  }

  @override
  void initState() {
    super.initState();
  }

  late PostgreSQLConnection _connection;

  Future<void> _connectToDatabase() async {
    _connection = PostgreSQLConnection(
      'localhost',
      5432,
      'clinic',
      username: 'postgres',
      password: '1234',
    );

    await _connection.open();
  }

  @override
  final formKey = GlobalKey<FormState>();

  Future sign_up() async {
    String url = "";
  }

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
      body: SingleChildScrollView(
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
              // const SizedBox(
              //   height: 20,
              // ),
              // RegisterTextField(
              //   controller: prenameController,
              //   hintText: 'Mr.',
              //   obscureText: false,
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // RegisterTextField(
              //   controller: firstnameController,
              //   hintText: 'first name',
              //   obscureText: false,
              // ),
              const SizedBox(
                height: 20,
              ),
              RegisterTextField(
                controller: fullnameController,
                hintText: 'full name',
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              RegisterTextField(
                controller: idcardController,
                hintText: 'card id',
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () => _selectDate(context),
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined),
                      const SizedBox(width: 8.0),
                      Text(
                        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RegisterTextField(
                controller: careerController,
                hintText: 'career',
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              RegisterTextField(
                controller: telController,
                hintText: 'tel.',
                obscureText: false,
              ),
              const SizedBox(
                height: 30,
              ),
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
                onPressed: () {
                  _insertPatient();
                  Navigator.of(context).pop();
                },
                child: const Text("Create Account"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
