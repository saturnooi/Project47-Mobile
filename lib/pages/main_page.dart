import 'package:dental_clinic/learn.dart';
import 'package:dental_clinic/components/homepage_function.dart';
import 'package:dental_clinic/components/blog_slide.dart';
import "package:flutter/material.dart";
import 'package:dental_clinic/components/homepage_info.dart';

import 'package:dental_clinic/pages/main_page.dart';
import 'package:dental_clinic/pages/blog_page.dart';
import 'package:dental_clinic/pages/profile_page.dart';
import 'package:dental_clinic/pages/queue_page.dart';
import 'package:dental_clinic/pages/appointment.dart';
import 'package:dental_clinic/pages/home_page.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({Key? key, required this.userId}) : super(key: key);

  final int userId;

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int currentPage = 0;
  int privillage = 0;
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      Homepage(
        userId: widget.userId,
      ),
      QueuePage(
        userId: widget.userId,
      ),
      DisplayDataScreen(),
      ProfilePage(
        userId: widget.userId,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Queue',
          ),
          NavigationDestination(
            icon: Icon(Icons.newspaper),
            label: "Blog",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
      ),
      floatingActionButton: CustomPaint(
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Appointment(
                  userId: widget.userId,
                ),
              ),
            );
          },
          child: Icon(Icons.add),
          // Set the background color of the FloatingActionButton to transparent
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
