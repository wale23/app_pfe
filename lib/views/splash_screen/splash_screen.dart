import 'dart:async';

import 'package:app_pfe/views/admin/home_admin.dart';
import 'package:app_pfe/views/auth/sign_in/SignIn.dart';
import 'package:app_pfe/views/home_page/home_page.dart';
import 'package:app_pfe/views/user/home_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

import '../../ressources/dimensions/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplasScreenState createState() => _SplasScreenState();
}

class _SplasScreenState extends State<SplashScreen> {
  var seen = GetStorage().read("seen");
  var auth = GetStorage().read("auth");
  var user = GetStorage().read("user");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 4), () {
      if (seen == 1) {
        if (auth == 1) {
          if (user['role_id'] == 2) {
            Get.to(HomeUser());
          } else {
            Get.to(HomeAdmin());
          }
        } else {
          Get.to(SignIn());
        }
      } else {
        Get.to(HomePage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Lottie.asset(
                "images/loading.json",
                height: Constants.screenWidth * 0.2,
              )
            ],
          ),
        ));
  }
}
