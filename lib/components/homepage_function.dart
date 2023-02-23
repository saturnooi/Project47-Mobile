import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class HomeFunction extends StatelessWidget {
  const HomeFunction({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            OutlinedButton(
              onPressed: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.calendar_month_outlined,
                    size: 50,
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Queue',
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            OutlinedButton(
              onPressed: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.add_circle_outline,
                    size: 50,
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Booking',
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            OutlinedButton(
              onPressed: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.newspaper_outlined,
                    size: 50,
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Blog',
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            OutlinedButton(
              onPressed: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.person_pin_outlined,
                    size: 50,
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Doctor',
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            OutlinedButton(
              onPressed: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.description_outlined,
                    size: 50,
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Service',
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            OutlinedButton(
              onPressed: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    Icons.comment_outlined,
                    size: 50,
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Review',
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
