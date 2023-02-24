import 'package:flutter/material.dart';

class HomeInfo extends StatelessWidget {
  const HomeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            const Text('Hello world!!'),
            const Text('This is dart'),
          ],
        ),
        Image.asset(
          'images/google.png',
          width: 100,
          height: 100,
        ),
      ],
    );
  }
}
