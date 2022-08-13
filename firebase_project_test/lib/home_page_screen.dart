import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  String notificationMsg = "Waiting for notification first one";

  @override
  initState() {
    super.initState();
    FirebaseMessaging.instance.getInitialMessage();

    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        setState(() {
          notificationMsg =
              "${value.notification!.title}  ${value.notification!.body} I am coming from terminated state";
        });
      }
    });
    FirebaseMessaging.onMessage.listen((event) {
      setState(() {
        notificationMsg =
            "${event.notification!.title}  ${event.notification!.body} I am coming from forground";
      });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      setState(() {
        notificationMsg =
            "${event.notification!.title}  ${event.notification!.body} I am coming from Background";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Title')),
      body: Container(
          child: Center(
        child: Text(
          notificationMsg,
          textAlign: TextAlign.center,
        ),
      )),
    );
  }
}
