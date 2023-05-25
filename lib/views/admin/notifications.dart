import 'package:flutter/material.dart';

class NotifAdmin extends StatefulWidget {
  const NotifAdmin ({Key? key}) : super(key: key);

  @override
  State<NotifAdmin> createState() => _NotifAdminState();
}

class _NotifAdminState extends State<NotifAdmin> {
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