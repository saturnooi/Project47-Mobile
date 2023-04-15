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
          color: Color.fromARGB(255, 107, 180, 239),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(width: 15),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileTextFieldName extends StatelessWidget {
  final String text;

  const ProfileTextFieldName({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 107, 180, 239),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(width: 15),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileTextFieldNamePrefix extends StatelessWidget {
  final String text;

  const ProfileTextFieldNamePrefix({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 107, 180, 239),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(width: 15),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
              ),
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
          color: Color.fromARGB(255, 107, 180, 239),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: SizedBox(
        height: 150, // Set the height of the SizedBox
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8.0), // Set padding for the Container
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                textAlign: TextAlign.justify, // Align the text to justify
                style: const TextStyle(
                    fontSize: 15), // Set the font size of the text
              ),
            ),
          ),
        ),
      ),
    );
  }
}
