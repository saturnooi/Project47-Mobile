import 'package:flutter/material.dart';
import 'package:dental_clinic/learn.dart';
import 'package:dental_clinic/components/homepage_function.dart';
import 'package:dental_clinic/components/blog_slide.dart';
import "package:flutter/material.dart";
import 'package:dental_clinic/components/homepage_info.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key, required this.userId}) : super(key: key);

  final int userId;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.0, // Set aspect ratio to 1:1 for a square shape
              child: Image.asset(
                'images/318155147_157128447061141_6356677895157760046_n.jpg', // Replace with your image URL
                fit: BoxFit.cover, // Scale and crop the image to fit the box
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: HomeFunction(
                userId: widget.userId,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // BlogSlide(
            //   imageUrls: [
            //     'images/promotion/328826896_971407020562041_1061909101623740239_n.jpg',
            //     'images/promotion/333850256_1376115003210566_6169689804045578564_n.jpg',
            //     'images/promotion/335158455_537778948344332_5717943067385041327_n.jpg',
            //     'images/promotion/334163536_174009198739350_8560160510853555590_n.jpg',
            //   ],
            // ),
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: HomeInfo(),
            ),
          ],
        ),
      ),
    );
  }
}
