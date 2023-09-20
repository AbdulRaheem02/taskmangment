import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskmanagementapp/createtask.dart';
import 'package:taskmanagementapp/model.dart';
import 'package:taskmanagementapp/resourse/Assets.dart';
import 'package:taskmanagementapp/resourse/colors.dart';
import 'package:taskmanagementapp/widgets/cardbutton.dart';
import 'package:taskmanagementapp/widgets/customercard.dart';

import 'functions.dart';
import 'widgets/mainpagecontainer.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');

const String portName = 'notification_send_port';
List<DataItem> items = [];
List<DataItem> completeitems = [];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map> data = [
    {"image": Assets.aftari2, "subtitle": "13 tasks", "title": "Aftaari Itmes"},
    {
      "image": Assets.Honda2,
      "subtitle": "13 tasks",
      "title": "Honda City Fixes"
    }
  ];
  bool button1 = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isAndroidPermissionGranted();
    _requestPermissions();
    fetchData().then((value) {
      setState(() {});
    });
  }

  bool _notificationsEnabled = false;

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted = await androidImplementation?.requestPermission();
      setState(() {
        _notificationsEnabled = granted ?? false;
      });
    }
  }

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;

      setState(() {
        _notificationsEnabled = granted;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Col.bodyBackground,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // PaddedElevatedButton(
                  //   buttonText: 'Check pending notifications',
                  //   onPressed: () async {
                  //     await _checkPendingNotificationRequests();
                  //   },
                  // ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      Container(
                        width: width * 0.1,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Col.bodyBackground,
                        ),
                        child: Center(
                          child: SvgPicture.asset(Assets.drawer2,
                              semanticsLabel: 'Acme Logo'),
                        ),
                      ),
                      Container(
                        child: Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Center(
                              child: Text(
                                "Schedule",
                                style: TextStyle(
                                    color: Col.whiteColor, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    "Hi Abdul Raheem.",
                    style: TextStyle(
                        color: Col.whiteColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    "Good Morning",
                    style: TextStyle(
                        color: Col.graytext.withOpacity(0.8), fontSize: 15),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  SizedBox(
                    height: height * 0.25,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              CircularCard(
                                backgroundImage:
                                    AssetImage(data[index]['image'].toString()),
                                title: 'Iftaari Items',
                                subtitle: '13 tasks',
                              ),
                              SizedBox(
                                width: width * 0.08,
                              ),
                            ],
                          );
                        }),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Col.whiteColor,
                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(vertical: 5),
                    // Container background color
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircularButtonCard(
                          onPressed: () {
                            // Add your button click logic here
                            print('Button Clicked');
                            button1 = true;
                            setState(() {});
                          },
                          color: button1,
                          buttonText: 'Task List',
                        ),
                        CircularButtonCard(
                          color: button1 ? false : true,
                          onPressed: () {
                            // Add your button click logic here
                            button1 = false;
                            setState(() {});
                            print('Button Clicked');
                          },
                          buttonText: 'Completed',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount:
                            button1 ? items.length : completeitems.length,
                        itemBuilder: ((context, index) {
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
                                      image: AssetImage(Assets.document),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          button1
                                              ? '${items[index].title}'
                                              : '${completeitems[index].title}',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Col.whiteColor),
                                        ),
                                        SizedBox(height: 8.0),
                                        Text(
                                          button1
                                              ? '${items[index].time.toString()
                                                  // .replaceAll(RegExp(r'[a-zA-Z:,()]'), '')
                                                  }'
                                              : '${completeitems[index].time
                                              // .replaceAll(RegExp(r'[a-zA-Z:,()]'), '')
                                              }',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.bold,
                                              color: Col.graytext),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                button1
                                    ? InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (_) {
                                              return Container(
                                                height:
                                                    100.0, // Set the desired height
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        print(
                                                            '${items[index].docid}');
                                                        updateDataInFirestore(
                                                                '${items[index].docid}',
                                                                "completed")
                                                            .then((value) {
                                                          Navigator.pop(
                                                              context);
                                                          setState(() {});
                                                        });
                                                      },
                                                      child: Text(
                                                        "Mark as Complete",
                                                        style: TextStyle(
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        deleteDataInFirestore(
                                                                items[index]
                                                                    .docid)
                                                            .then(
                                                                (value) async {
                                                          await flutterLocalNotificationsPlugin
                                                              .resolvePlatformSpecificImplementation<
                                                                  AndroidFlutterLocalNotificationsPlugin>()
                                                              ?.deleteNotificationChannel(
                                                                  items[index]
                                                                      .channelid
                                                                      .toString());
                                                          Navigator.pop(
                                                              context);
                                                          setState(() {});
                                                        });
                                                      },
                                                      child: Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                      )
                                    : Container(),
                              ],
                            ),
                          );
                        })),
                  ),
                  SizedBox(
                    height: height * 0.08,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: height * 0.15,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: width,
                            height: height * 0.1,
                            decoration: BoxDecoration(
                              color: Col.bodyBackground,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(0,
                                      3), // Adjust the shadow position as needed
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Image.asset(
                                    Assets.home,
                                    height: height * 0.03,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 50),
                                  child: Image.asset(
                                    Assets.profile,
                                    height: height * 0.03,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 55,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CreateTask()),
                                );
                              },
                              child: Container(
                                width: 50.0,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors
                                      .white, // Background color of the circle
                                ),
                                child: Center(
                                    child: Icon(
                                  Icons.add,
                                  color: Colors.black,
                                )),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PaddedElevatedButton extends StatelessWidget {
  const PaddedElevatedButton({
    required this.buttonText,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(buttonText),
        ),
      );
}
