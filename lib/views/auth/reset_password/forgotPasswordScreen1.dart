import 'package:app_pfe/ressources/dimensions/constants.dart';
import 'package:app_pfe/services/auth_services.dart';
import 'package:app_pfe/views/auth/reset_password/otp_screen.dart';
import 'package:app_pfe/views/widgets/input_field.dart';
import 'package:flutter/material.dart';

import '../../widgets/button.dart';

class forgotPasswordScreen1 extends StatefulWidget {
  @override
  _forgotPasswordScreen1State createState() => _forgotPasswordScreen1State();
}

class _forgotPasswordScreen1State extends State<forgotPasswordScreen1> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  bool loading = false;
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
          padding: const EdgeInsets.only(left: 10, right: 40, top: 100),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Réinitialisez votre mot de passe",
                  style: TextStyle(fontSize: 20, color: Colors.black, height: 3, fontWeight: FontWeight.w500),
                ),
                Text(
                  "Entrez votre adresse e-mail et nous vous enverrons des instructions pour réinitialiser votre mot de passe",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 25, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Constants.screenHeight * 0.1, horizontal: Constants.screenWidth * 0.02),
                  child: InputField(label: "Email", textInputType: TextInputType.emailAddress, controller: emailController),
                ),
                loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Center(
                        child: Column(children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              AuthServices().ResetPassword(email: emailController.text).then((value) {
                                setState(() {
                                  loading = false;
                                });
                                if (value.responseStatus!) {
                                  final snackBar = SnackBar(
                                    content: Text(value.responseMessage!),
                                    backgroundColor: (Colors.green),
                                    action: SnackBarAction(
                                      label: 'Fermer',
                                      textColor: Colors.white,
                                      onPressed: () {},
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => OtpScreen(
                                            email: emailController.text,
                                          )));
                                } else {
                                  final snackBar = SnackBar(
                                    content: Text(value.responseMessage!),
                                    backgroundColor: (Colors.red),
                                    action: SnackBarAction(
                                      label: 'Fermer',
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
                          child: Text("Continuer", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ]))
              ],
            ),
          )),
    );
  }
}
