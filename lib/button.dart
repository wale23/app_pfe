import 'package:flutter/material.dart';


final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
  minimumSize: Size(200, 50),
  primary: Colors.lightGreen,
  elevation: 0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
        Radius.circular(20)),
  ),
);