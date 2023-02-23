import 'package:dental_clinic/learn.dart';
import 'package:dental_clinic/components/homepage_function.dart';

import "package:flutter/material.dart";

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_left),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_active))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.0, // Set aspect ratio to 1:1 for a square shape
              child: Image.network(
                'https://img.freepik.com/free-vector/people-sitting-hospital-corridor-waiting-doctor-patient-clinic-visit-flat-vector-illustration-medicine-healthcare_74855-8507.jpg?w=360', // Replace with your image URL
                fit: BoxFit.cover, // Scale and crop the image to fit the box
              ),
            ),
            HomeFunction(),
          ],
        ),
      ),
    );
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
