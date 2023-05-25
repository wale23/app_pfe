import 'package:flutter/material.dart';

class NotifUser extends StatefulWidget {
  const NotifUser({Key? key}) : super(key: key);

  @override
  State<NotifUser> createState() => _NotifUserState();
}

class _NotifUserState extends State<NotifUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        Text("Notifications"),
      ),

    );
  }
}