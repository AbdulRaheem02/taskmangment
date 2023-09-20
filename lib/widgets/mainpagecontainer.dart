import 'package:flutter/material.dart';

import '../resourse/colors.dart';

class CircularCard extends StatelessWidget {
  final ImageProvider backgroundImage;
  final String title;
  final String subtitle;

  CircularCard({
    required this.backgroundImage,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.7, // Adjust the width as needed
      height: height * 0.22, // Adjust the height as needed
      decoration: BoxDecoration(
          // shape: BoxShape.circle,
          borderRadius: BorderRadius.circular(20),
          color: Col.whiteColor),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          width: width * 0.65, // Adjust the width as needed
          height: height * 0.2, // Adjust the height as needed
          decoration: BoxDecoration(
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: Col.graytext,
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
