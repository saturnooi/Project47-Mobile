import 'package:dental_clinic/api.dart';
import 'package:dental_clinic/pages/queue_page.dart';
import 'package:dental_clinic/pages/service_page.dart';
import 'package:flutter/material.dart';
import 'package:dental_clinic/pages/appointment.dart';
import 'package:dental_clinic/pages/dentist_page.dart';
import 'package:dental_clinic/pages/blog_page.dart';
import 'package:dental_clinic/pages/review_page.dart';

class HomeFunction extends StatelessWidget {
  const HomeFunction({Key? key, required this.userId}) : super(key: key);

  final int userId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QueuePage(
                          userId: this.userId,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      Icon(
                        Icons.calendar_month_outlined,
                        size: 50,
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
                Text(
                  'Queue',
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Appointment(
                          userId: this.userId,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      Icon(
                        Icons.add_circle_outline,
                        size: 50,
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
                Text(
                  'Booking',
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DisplayDataScreen(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      const Icon(
                        Icons.newspaper_outlined,
                        size: 50,
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
                const Text(
                  'Blog',
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Dentist_Information(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Icon(
                        Icons.person_pin_outlined,
                        size: 50,
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
                const Text(
                  'Doctor',
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Service(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Icon(
                        Icons.description_outlined,
                        size: 50,
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
                const Text(
                  'Service',
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Review(),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Icon(
                        Icons.comment_outlined,
                        size: 50,
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
                const Text(
                  'Review',
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
