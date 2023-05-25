import 'package:app_pfe/models/User.dart';
import 'package:app_pfe/services/auth_services.dart';
import 'package:app_pfe/services/facebook_auth_services.dart';
import 'package:app_pfe/services/google_auth_services.dart';
import 'package:app_pfe/views/admin/home_admin.dart';
import 'package:app_pfe/views/user/home_user.dart';
import 'package:app_pfe/views/widgets/button.dart';
import 'package:app_pfe/views/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _signUpState();
}

class _signUpState extends State<SignUp> {


  final _formKey = GlobalKey<FormState>();
  bool passToggle = false;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool loading = false;
  bool superLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.lightGreen, //change your color here
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 10, right: 40),
            child: Form(
                key: _formKey,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Image.asset("images/img_3.png", height: 100, width: 150),
                  Text(
                    "Créez votre compte",
                    style: TextStyle(color: Colors.black, height: 2, fontWeight: FontWeight.w600, fontSize: 27),
                  ),
                  InputField(label: "Nom et prénom", textInputType: TextInputType.text, controller: fullNameController),
                  InputField(label: "Numéro portable", textInputType: TextInputType.number, controller: phoneController),
                  InputField(label: "Email", textInputType: TextInputType.emailAddress, controller: emailController),
                  InputField(label: "Mot de passe", textInputType: TextInputType.visiblePassword, controller: passwordController),
                  loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Center(
                          child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  AuthServices()
                                      .SignUp(
                                          user: User(
                                    full_name: fullNameController.text,
                                    company: companyController.text,
                                    phone_number: phoneController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    type: "normal",
                                    role_id: 2,
                                  ))
                                      .then((value) {
                                    setState(() {
                                      loading = false;
                                    });

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
                                }
                              },
                              style: buttonPrimary,
                              child: Text("Sign up", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
                            ),
                          ],
                        )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        "Connectez-vous en utilisant",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 20),
                      ),
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
                                AuthServices()
                                    .SignUp(
                                        user: User(
                                            full_name: value.full_name,
                                            company: null,
                                            phone_number: null,
                                            password: null,
                                            type: "google",
                                            email: value.email,
                                            role_id: 2))
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
                              });
                            },
                            icon: Image.asset(
                              "images/google.png",
                            )),
                        IconButton(
                            onPressed: () {
                              FaceBookApis.getDataFromFacebook().then((value) {
                                AuthServices()
                                    .SignUp(
                                        user: User(
                                            full_name: value.full_name,
                                            company: null,
                                            phone_number: null,
                                            password: null,
                                            type: "facebook",
                                            email: value.email,
                                            role_id: 2))
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
                              });
                            },
                            icon: Image.asset(
                              "images/facebook.png",
                            )),
                      ],
                    ),
                  ),
                ]))));
  }
}
