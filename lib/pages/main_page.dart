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
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int currentPage = 0;
  int privillage = 0;
  List<Widget> pages = [
    Homepage(),
    QueuePage(),
    DisplayDataScreen(),
    ProfilePage(userId: 1)
  ];

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
                builder: (context) => Appointment(),
              ),
            );
          },
          child: Icon(Icons.add),
          // Set the background color of the FloatingActionButton to transparent
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
    ;
  }
}





// class Homepage extends StatelessWidget {
//   const Homepage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ElevatedButton(
//         onPressed: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (BuildContext context) {
//                 return const LearnFlutterPage();
//               },
//             ),
//           );
//         },
//         child: const Text("Learn Flutter"),
//       ),
//     );
//   }
// }
