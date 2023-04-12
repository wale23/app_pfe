import 'package:flutter/material.dart';



class menu extends StatefulWidget {
  @override
  _menuState createState() => _menuState();
}

class _menuState extends State<menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("Welcome app!",textAlign: TextAlign.center,style: TextStyle(fontSize: 50,color: Colors.black),),
      ),
      );

  }
}
