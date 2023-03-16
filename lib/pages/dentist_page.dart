import 'package:flutter/material.dart';

class Dentist_Information extends StatefulWidget {
  const Dentist_Information({super.key});

  @override
  State<Dentist_Information> createState() => _Dentist_InformationState();
}

class _Dentist_InformationState extends State<Dentist_Information> {
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
      body: Scaffold(),
    );
  }
}
