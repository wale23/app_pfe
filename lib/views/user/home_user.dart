import 'dart:io';

import 'package:app_pfe/services/LocalNotificationApi.dart';
import 'package:app_pfe/views/user/my_reclamations_view.dart';
import 'package:app_pfe/views/user/profile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import 'notifications.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({Key? key}) : super(key: key);

  @override
  State<HomeUser> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeUser> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.getToken().then((userToken) {});
    FirebaseMessaging.onMessage.listen((event) {
      NotificationConfig().showNotification(event.notification!.title!, event.notification!.body!);
    });
  }

  List pages = [
    MyReclamationsView(),
    NotifUser(),
    ProfileUser(),
  ];
  int index = 0;
  Future<bool> avoidReturnButton() async {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text("vous etes sur de sortir ?"),
            actions: [Negative(context), Positive()],
          );
        });
    return true;
  }

  Widget Positive() {
    return Container(
      decoration: BoxDecoration(color: Colors.blueAccent),
      child: TextButton(
          onPressed: () {
            exit(0);
          },
          child: const Text(
            " Oui",
            style: TextStyle(
              color: Color(0xffEAEDEF),
            ),
          )),
    );
  } // fermeture de l'application

  Widget Negative(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.pop(context); // fermeture de dialog
        },
        child: Text(" Non"));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => avoidReturnButton(),
      child: Scaffold(
        body: pages[index],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          currentIndex: index,
          onTap: (i) {
            setState(() {
              index = i;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: new Icon(UniconsLine.ticket),
              label: 'Reclamations',
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.notifications_active),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.settings),
              label: 'Paramètres',
            ),
          ],
        ),
      ),
    );
  }
}
