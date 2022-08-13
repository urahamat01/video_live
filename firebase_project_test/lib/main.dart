import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_project_test/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'home_page_screen.dart';

Future<void> _backgroundHandler(RemoteMessage message) async {
  // IsolateNameServer.lookupPortByName('main_port')?.send(message);

  // final Database db = await CtsIShoutDatabase().initDB();
  // await db.insert('notification', message.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace);
  // return Future<void>.value();
  final db = DatabaseHelper.getDB();
  db.insert("notification_message", message.notification!.title,
      conflictAlgorithm: ConflictAlgorithm.replace);

  print(
      '---------------------------Execute: onBackgroundMessage()---------------------------');
  print(message.notification!.title ?? '');
  print(message.notification!.body ?? '');
  return Future<void>.value();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const HomePageScreen(),
    );
  }
}
