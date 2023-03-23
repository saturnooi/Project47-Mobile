import 'package:flutter/material.dart';

class BlogSlide extends StatefulWidget {
  final List<String> imageUrls;

  BlogSlide({required this.imageUrls});

  @override
  _BlogSlideState createState() => _BlogSlideState();
}

class _BlogSlideState extends State<BlogSlide> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.imageUrls.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Image.asset(
                widget.imageUrls[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
