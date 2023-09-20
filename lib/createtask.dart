import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:taskmanagementapp/functions.dart';
import 'package:taskmanagementapp/resourse/Assets.dart';
import 'package:taskmanagementapp/resourse/colors.dart';
import 'package:taskmanagementapp/widgets/cardbutton.dart';
import 'package:taskmanagementapp/widgets/customercard.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'widgets/mainpagecontainer.dart';
import 'package:firebase_core/firebase_core.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController duedate = TextEditingController();
  String? timedue;
  int? randomInt;
  DateTime? enddate;
  List<Map> data = [
    {"image": Assets.aftari2, "subtitle": "13 tasks", "title": "Aftaari Itmes"},
    {
      "image": Assets.Honda2,
      "subtitle": "13 tasks",
      "title": "Honda City Fixes"
    }
  ];
  bool button1 = true;
  var _selectedValue;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Col.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Center(
                        child: Image.asset(
                          Assets.close,
                        ),
                      ),
                      Container(
                        child: Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Center(
                              child: Text(
                                "Create New Task",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Expanded(
                  child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      color: Col.bodyBackground,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                            50.0), // Adjust the radius as needed
                        topRight: Radius.circular(
                            50.0), // Adjust the radius as needed
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Container(
                            width: width * 0.8,
                            height: height * 0.08,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Col
                                  .greyColor, // Background color of the circle
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  Assets
                                      .imageupload, // Replace with your image path
                                  width:
                                      30.0, // Adjust the image size as needed
                                  height: 30.0,
                                  fit: BoxFit
                                      .contain, // Adjust the image fit as needed
                                ),
                                SizedBox(
                                    width:
                                        8.0), // Add some spacing between image and text
                                Text(
                                  'Upload image',
                                  style: TextStyle(
                                    color: Colors.white, // Text color
                                    fontSize:
                                        16.0, // Adjust the font size as needed
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            children: [
                              Text(
                                _selectedValue.toString() == "null"
                                    ? "${formatDate(DateTime.now(), [
                                            M
                                          ])} , ${DateTime.now().day}         ${formatDate(DateTime.now(), [
                                            D
                                          ])}"
                                    : "${formatDate(_selectedValue, [
                                            M
                                          ])} , ${_selectedValue.day}         ${formatDate(_selectedValue, [
                                            D
                                          ])}",
                                style: TextStyle(
                                  color: Colors.white, // Text color
                                  fontSize:
                                      25.0, // Adjust the font size as needed
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          SizedBox(
                            height: height * 0.15,
                            child: DatePicker(
                              DateTime.now(),
                              initialSelectedDate: DateTime.now(),

                              selectionColor: Col.datepickersecondary,
                              selectedTextColor: Colors.white,
                              deactivatedColor: Col.whiteColor,
                              // activeTextStyle: TextStyle(
                              //   color: Colors
                              //       .white, // Set the text color for active (unselected) items
                              // ),
                              onDateChange: (date) {
                                // New date selected
                                setState(() {
                                  print(date.day);
                                  print(date.month);

                                  _selectedValue = date;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            children: [
                              Text(
                                'Title',
                                style: TextStyle(
                                    fontSize: 18.0, // Customize the font size
                                    fontWeight: FontWeight.bold,
                                    color: Col
                                        .greyColor //// Customize the font weight
                                    ),
                              ),
                            ],
                          ),
                          // Add spacing between the title and text field
                          TextField(
                            controller: title,
                            style: TextStyle(
                              color:
                                  Colors.white, // Set the text color to white
                            ),
                            decoration: InputDecoration(
                              hintText: '',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .grey), // Customize the border color
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Col
                                        .whiteColor), // Customize the border color when focused
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Text(
                                'Time',
                                style: TextStyle(
                                    fontSize: 18.0, // Customize the font size
                                    fontWeight: FontWeight.bold,
                                    color: Col
                                        .greyColor //// Customize the font weight
                                    ),
                              ),
                            ],
                          ),
                          // Add spacing between the title and text field
                          InkWell(
                            onTap: () async {
                              final selectedTimeRange =
                                  await showTimeRangePicker(
                                context: context,
                                // start: TimeOfDay(hour: 0, minute: 0),
                                // end: TimeOfDay(hour: 23, minute: 59),
                                interval: Duration(minutes: 1),
                                // initialRange: initialTimeRange,
                                use24HourFormat: false, // Use AM/PM format
                              );
                              print(selectedTimeRange);
                              if (selectedTimeRange != null) {
                                print("_selectedValue{$_selectedValue}");
                                final DateTime selectedDate = _selectedValue
                                            .toString() ==
                                        "null"
                                    ? DateTime.now()
                                    : _selectedValue; // Replace with your selected date

                                final startTimeFormatted =
                                    DateFormat('hh:mm a').format(
                                  DateTime(
                                    selectedDate.year,
                                    selectedDate.month,
                                    selectedDate.day,
                                    selectedTimeRange.startTime.hour,
                                    selectedTimeRange.startTime.minute,
                                  ),
                                );

                                final endTimeFormatted =
                                    DateFormat('hh:mm a').format(
                                  DateTime(
                                    selectedDate.year,
                                    selectedDate.month,
                                    selectedDate.day,
                                    selectedTimeRange.endTime.hour,
                                    selectedTimeRange.endTime.minute,
                                  ),
                                );
                                // final startTimeFormatted =
                                //     DateFormat('hh:mm a').format(
                                //   DateTime(
                                //       2023,
                                //       1,
                                //       1,
                                //       selectedTimeRange.startTime.hour,
                                //       selectedTimeRange.startTime.minute),
                                // );
                                // final endTimeFormatted =
                                //     DateFormat('hh:mm a').format(
                                //   DateTime(
                                //       2023,
                                //       1,
                                //       1,
                                //       selectedTimeRange.endTime.hour,
                                //       selectedTimeRange.endTime.minute),
                                // );
                                enddate = DateTime(
                                  selectedDate.year,
                                  selectedDate.month,
                                  selectedDate.day,
                                  selectedTimeRange.endTime.hour,
                                  selectedTimeRange.endTime.minute,
                                );
                                ;
                                final random = Random();

                                randomInt = random.nextInt(500) + 1;

                                duedate.text =
                                    "$startTimeFormatted - $endTimeFormatted";
                                timedue =
                                    "$startTimeFormatted - $endTimeFormatted";
                                print(
                                    'Selected Time Range: $startTimeFormatted - $endTimeFormatted');
                              }
                              // duedate.text = selectedTimeRange
                              //     .toString()
                              //     .replaceAll(RegExp(r'[a-zA-Z,()]'), '')
                              //     .substring(1);
                              // "${result.startTime.hour.toString()} ${result.startTime.minute.toString()}               ${result.endTime.hour.toString()} ${result.endTime.minute.toString()} "
                              //     .toString();
                              // timedue = selectedTimeRange
                              //     .toString()
                              //     .replaceAll(RegExp(r'[a-zA-Z,()]'), '')
                              //     .substring(1);
                            },
                            child: IgnorePointer(
                              ignoring: true,
                              child: TextField(
                                controller: duedate,
                                style: TextStyle(
                                  color: Colors
                                      .white, // Set the text color to white
                                ),
                                decoration: InputDecoration(
                                  hintText: '',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors
                                            .grey), // Customize the border color
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Col
                                            .whiteColor), // Customize the border color when focused
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Text(
                                'Description',
                                style: TextStyle(
                                    fontSize: 18.0, // Customize the font size
                                    fontWeight: FontWeight.bold,
                                    color: Col
                                        .greyColor // Customize the font weight
                                    ),
                              ),
                            ],
                          ),

                          TextField(
                            maxLines: 2,
                            controller: desc,
                            style: TextStyle(
                              color:
                                  Colors.white, // Set the text color to white
                            ),
                            decoration: InputDecoration(
                              hintText: '',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .grey), // Customize the border color
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Col
                                        .whiteColor), // Customize the border color when focused
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.09,
                          ),
                          InkWell(
                            onTap: () {
                              addDataToFirestore(
                                      title.text,
                                      timedue.toString(),
                                      desc.text.toString(),
                                      _selectedValue.toString() == "null"
                                          ? "${formatDate(DateTime.now(), [
                                                  M
                                                ])} , ${DateTime.now().day}         ${formatDate(DateTime.now(), [
                                                  D
                                                ])}"
                                          : "${formatDate(_selectedValue, [
                                                  M
                                                ])} , ${_selectedValue.day}         ${formatDate(_selectedValue, [
                                                  D
                                                ])}",
                                      randomInt!)
                                  .then((value) async {
                                scheduleNotification(enddate!, randomInt!,
                                    title.text, desc.text);
                                await fetchData();
                                Navigator.pop(context);
                              });
                            },
                            child: Container(
                              width: width * 0.8,
                              height: height * 0.08,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Col
                                    .whiteColor, // Background color of the circle
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Create',
                                    style: TextStyle(
                                      color: Col.bodyBackground, // Text color
                                      fontSize:
                                          16.0, // Adjust the font size as needed
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                        ],
                      ),
                    ),
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

Future<void> addDataToFirestore(
    String title, var time, String description, var date, int channelid) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('task').add({
      'title': title,
      'time': time,
      'date': date,
      'description': description,
      'status': "incomplete",
      "channelid": channelid
    });
    print('Data added to Firestore successfully.');
  } catch (e) {
    print('Error adding data to Firestore: $e');
  }
}
