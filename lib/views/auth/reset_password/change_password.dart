import 'package:app_pfe/ressources/dimensions/constants.dart';
import 'package:app_pfe/services/auth_services.dart';
import 'package:app_pfe/views/auth/sign_in/SignIn.dart';
import 'package:app_pfe/views/widgets/button.dart';
import 'package:app_pfe/views/widgets/input_field.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  final int code;
  final String email;
  const ChangePassword({Key? key, required this.code, required this.email}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
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
                  "Entrez votre nouveau mot de passe",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 25, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Constants.screenHeight * 0.1, horizontal: Constants.screenWidth * 0.02),
                  child: InputField(
                      label: "Mot de passe", textInputType: TextInputType.visiblePassword, controller: passwordController),
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
                              AuthServices().ChangePassword(data: {
                                "code": widget.code,
                                "email": widget.email,
                                "password": passwordController.text
                              }).then((value) {
                                setState(() {
                                  loading = false;
                                });
                                if (value.responseStatus!) {
                                  final snackBar = SnackBar(
                                    content: Text("Mot de passe modifié "),
                                    backgroundColor: (Colors.green),
                                    action: SnackBarAction(
                                      label: 'Fermer',
                                      textColor: Colors.white,
                                      onPressed: () {},
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(builder: (context) => SignIn()), (Route<dynamic> route) => false);
                                } else {
                                  final snackBar = SnackBar(
                                    content: Text("Erreur au cours de changement"),
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
