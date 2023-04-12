

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matcher/matcher.dart';

class forgotPasswordScreen2 extends StatefulWidget {
  @override
  _forgotPasswordScreen2State createState() => _forgotPasswordScreen2State();
}

class _forgotPasswordScreen2State extends State<forgotPasswordScreen2> {
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 110),
        child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              SizedBox(height: 30.0),
          Image.asset("images/logoEmail.png", height: 100, width: 150),
          Text(
          "Check Your Email",
          style: TextStyle(
              fontSize: 40,
              color: Colors.black,
              height: 2.3,
              fontWeight: FontWeight.w400),
        ),
        Text(
          "Please check the email address      for instructions to reset your password ",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.grey, fontSize: 25, fontWeight: FontWeight.w500),
        ),
            SizedBox(
              height: 20,
            ),
    Center(
    child: Column(children: [
    OutlinedButton(
    onPressed: () {},
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: Colors.black,width:1),
    backgroundColor: Colors.white,
    ),
    child: Text("Resent email",
    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 23,color: Colors.black)),
    ),
        ]),)
          ]
    )
    )
    )
    );
  }}