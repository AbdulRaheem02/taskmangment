import 'package:flutter/material.dart';

import '../resourse/colors.dart';

class CircularButtonCard extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final bool color;

  CircularButtonCard({
    required this.onPressed,
    required this.buttonText,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Card(
      elevation: 0, // Card elevation (shadow)
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: width * 0.4, // Adjust the width as needed
          height: height * 0.06, // Adjust the height as needed
          decoration: BoxDecoration(
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(15),
            color: color ? Col.bodyBackground : null, // Button background color
          ),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                color:
                    color ? Col.whiteColor : Col.bodyBackground, // Text color
              ),
            ),
          ),
        ),
      ),
    );
  }
}
