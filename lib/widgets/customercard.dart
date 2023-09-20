import 'package:flutter/material.dart';
import 'package:taskmanagementapp/functions.dart';
import 'package:taskmanagementapp/resourse/Assets.dart';

import '../resourse/colors.dart';

class CustomCard extends StatelessWidget {
  final ImageProvider leadingImage;
  final String mainTitle;
  final String subTitle1;
  final String docoid;
  CustomCard({
    required this.leadingImage,
    required this.mainTitle,
    required this.subTitle1,
    required this.docoid,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Card(
      color: Col.bodyBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4.0,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: width * 0.2,
              height: height * 0.07,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Col.secondarybackground,
                    spreadRadius: 2,
                    // blurRadius: 4,
                    // offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Image(
                image: leadingImage,
                // fit: BoxFit.cover,
                height: 10,
                width: 10,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mainTitle,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Col.whiteColor),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    subTitle1,
                    style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: Col.graytext),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) {
                  return Container(
                    height: 100.0, // Set the desired height
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            print(docoid);
                            updateDataInFirestore(docoid, "completed")
                                .then((value) {
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                            "Mark as Complete",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            deleteDataInFirestore(docoid).then((value) {
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                            "Delete",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage(Assets.menu),
                width: 20.0,
                height: 40.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
