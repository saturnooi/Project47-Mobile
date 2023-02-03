import 'package:dental_clinic/learn.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import "package:flutter/material.dart";

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return const LearnFlutterPage();
              },
            ),
          );
        },
        child: const Text("Learn Flutter"),
      ),
    );
  }
}
