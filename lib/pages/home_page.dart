import 'package:dental_clinic/learn.dart';
import 'package:dental_clinic/components/homepage_function.dart';
import 'package:dental_clinic/components/blog_slide.dart';
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
            const SizedBox(
              height: 30,
            ),
            BlogSlide(
              imageUrls: [
                'https://www.seraclinics.com/wp-content/uploads/2023/02/FD202.png',
                'https://www.storynow.co/wp-content/uploads/2022/07/DMC-PR-News-02-628x628.jpg',
                'https://www.rcskinclinic.com/getattachment/news-activities/%E0%B8%AA%E0%B8%B2%E0%B8%82%E0%B8%B2%E0%B8%97%E0%B8%B5%E0%B9%88%E0%B9%80%E0%B8%9B%E0%B8%B4%E0%B8%94%E0%B9%83%E0%B8%AB%E0%B9%89%E0%B8%9A%E0%B8%A3%E0%B8%B4%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B8%8A%E0%B9%88%E0%B8%A7%E0%B8%87%E0%B8%9B%E0%B8%B5%E0%B9%83%E0%B8%AB%E0%B8%A1%E0%B9%88-2019/news-clinic-close-New-year62-detail-(4).jpg.aspx',
                'https://www.slcclinic.com/uploads/images/211224150018W474-940p.jpg',
              ],
            ),
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
