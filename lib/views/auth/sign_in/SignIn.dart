import 'dart:io';

import 'package:app_pfe/models/User.dart';
import 'package:app_pfe/ressources/dimensions/constants.dart';
import 'package:app_pfe/services/auth_services.dart';
import 'package:app_pfe/services/facebook_auth_services.dart';
import 'package:app_pfe/services/google_auth_services.dart';
import 'package:app_pfe/views/admin/home_admin.dart';
import 'package:app_pfe/views/auth/sign_up/SignUp.dart';
import 'package:app_pfe/views/user/home_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignIn extends StatefulWidget {
  @override
  _signInemailState createState() => _signInemailState();
}

class _signInemailState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  bool passToggle = false;
  bool loading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
      onWillPop: avoidReturnButton,
      child: Scaffold(
          body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 40),
          child: Form(
            key: _formKey,
            child: Container(
              height: Constants.screenHeight * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          "Connectez-vous en utilisant",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                onPressed: () {
                                  GoogleAuthServices().getDataFromGoogle().then((value) {
                                    if (value.full_name != null) {
                                      AuthServices().SignIn(user: User(email: value.email, type: "google")).then((value2) {
                                        if (!value2.responseStatus!) {
                                          AuthServices()
                                              .SignUp(
                                                  user: User(
                                                      full_name: value.full_name, email: value.email, role_id: 2, type: "google"))
                                              .then((value) {
                                            if (value.responseStatus!) {
                                              if (value.responseMessage == "2") {
                                                Get.to(HomeUser());
                                              } else {
                                                Get.to(HomeAdmin());
                                              }
                                            } else {
                                              final snackBar = SnackBar(
                                                content: Text(value.responseMessage!),
                                                backgroundColor: (Colors.red),
                                                action: SnackBarAction(
                                                  label: 'fermer',
                                                  textColor: Colors.white,
                                                  onPressed: () {},
                                                ),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            }
                                          });
                                        } else {
                                          if (value2.responseStatus!) {
                                            if (value2.responseMessage == "2") {
                                              Get.to(HomeUser());
                                            } else {
                                              Get.to(HomeAdmin());
                                            }
                                          }
                                        }
                                      });
                                    } else {
                                      final snackBar = SnackBar(
                                        content: Text("Compte invalide"),
                                        backgroundColor: (Colors.red),
                                        action: SnackBarAction(
                                          label: 'fermer',
                                          textColor: Colors.white,
                                          onPressed: () {},
                                        ),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }
                                  });
                                },
                                icon: Image.asset(
                                  "images/google.png",
                                )),
                            IconButton(
                                onPressed: () {
                                  FaceBookApis.getDataFromFacebook().then((value) {
                                    if (value.full_name != null) {
                                      AuthServices()
                                          .SignIn(
                                              user: User(
                                        email: value.email,
                                        type: "facebook",
                                      ))
                                          .then((value2) {
                                        if (!value2.responseStatus!) {
                                          AuthServices()
                                              .SignUp(
                                                  user: User(
                                                      full_name: value.full_name,
                                                      email: value.email,
                                                      role_id: 2,
                                                      type: "facebook"))
                                              .then((value) {
                                            if (value.responseStatus!) {
                                              if (value.responseMessage == "2") {
                                                Get.to(HomeUser());
                                              } else {
                                                Get.to(HomeAdmin());
                                              }
                                            } else {
                                              final snackBar = SnackBar(
                                                content: Text(value.responseMessage!),
                                                backgroundColor: (Colors.red),
                                                action: SnackBarAction(
                                                  label: 'fermer',
                                                  textColor: Colors.white,
                                                  onPressed: () {},
                                                ),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            }
                                          });
                                        } else {
                                          if (value2.responseStatus!) {
                                            if (value2.responseMessage == "2") {
                                              Get.to(HomeUser());
                                            } else {
                                              Get.to(HomeAdmin());
                                            }
                                          } else {}
                                        }
                                      });
                                    } else {
                                      final snackBar = SnackBar(
                                        content: Text("compte invalide"),
                                        backgroundColor: (Colors.red),
                                        action: SnackBarAction(
                                          label: 'fermer',
                                          textColor: Colors.white,
                                          onPressed: () {},
                                        ),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    }
                                  });
                                },
                                icon: Image.asset(
                                  "images/facebook.png",
                                )),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUp()));
                          },
                          child: Text("S'inscrire? ",
                              style: TextStyle(color: Colors.lightGreen, fontWeight: FontWeight.bold, fontSize: 24)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
