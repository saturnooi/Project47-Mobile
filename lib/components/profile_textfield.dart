import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final String text;

  const ProfileTextField({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileTextStringField extends StatelessWidget {
  final String text;

  const ProfileTextStringField({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: SizedBox(
        height: 150, // Set the height of the SizedBox
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8.0), // Set padding for the Container
            child: Text(
              text,
              textAlign: TextAlign.justify, // Align the text to justify
              style: const TextStyle(
                  fontSize: 16), // Set the font size of the text
            ),
          ),
        ),
      ),
    );
  }
}
