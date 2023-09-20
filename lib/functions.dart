import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:taskmanagementapp/Homepage.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> updateDataInFirestore(
  String documentId,
  String status,
) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference documentReference =
        firestore.collection('task').doc(documentId);
    await documentReference.update({'status': status});
    print('Data updated in Firestore successfully.');
    await fetchData();
  } catch (e) {
    print('Error updating data in Firestore: $e');
  }
}

Future<void> deleteDataInFirestore(String documentId) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference documentReference =
        firestore.collection('task').doc(documentId);
    await documentReference.delete();
    print('Data deleted from Firestore successfully.');
    await fetchData();
  } catch (e) {
    print('Error deleting data from Firestore: $e');
  }
}

Future<void> fetchData() async {
  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('task').get();
  items.clear();
  completeitems.clear();

  querySnapshot.docs.forEach((document) {
    var data = document.data() as Map<String, dynamic>;
    print(document.id);
    String title = data['title'];
    String time = data['time'].toString();
    String description = data['description'];
    int channelid = data['channelid'];

    String status = data['status'];

    String docid = document.id.toString();
    if (status.toString().toLowerCase() == "completed") {
      completeitems.add(DataItem(
          title: title,
          time: time,
          description: description,
          docid: docid,
          channelid: channelid));
    } else {
      items.add(DataItem(
          title: title,
          time: time,
          description: description,
          docid: docid,
          channelid: channelid));
    }
  });
  print(items);
}

class DataItem {
  final String title;
  final String time;
  final String description;
  final String docid;
  final int channelid;

  DataItem(
      {required this.docid,
      required this.title,
      required this.time,
      required this.channelid,
      required this.description});
}

Future<void> scheduleNotification(
    DateTime notificationTime, int channelid, String title, String des) async {
  final AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    importance: Importance.max,
    priority: Priority.high,
  );
  print("notificationTime{$notificationTime}");
  final NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  // Initialize the time zone database
  tz.initializeTimeZones();

  // Create a TZDateTime object using the desired time zone
  final scheduledDate = tz.TZDateTime(
    tz.local, // Specify the time zone (e.g., tz.local)
    notificationTime.year,
    notificationTime.month,
    notificationTime.day,
    notificationTime.hour,
    notificationTime.minute,
    notificationTime.second,
  );

  // Format the notificationTime to the desired format
  final formattedTime =
      DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(scheduledDate);

  await flutterLocalNotificationsPlugin.zonedSchedule(
    channelid,
    title, // Use the provided title parameter
    des, // Use the provided description parameter
    scheduledDate, // Use the TZDateTime
    platformChannelSpecifics,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    androidAllowWhileIdle: true,
    matchDateTimeComponents: DateTimeComponents.time,
  );

  print('Notification scheduled for: $scheduledDate');
}
