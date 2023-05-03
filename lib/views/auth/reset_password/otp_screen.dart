import 'package:app_pfe/ressources/dimensions/constants.dart';
import 'package:app_pfe/services/auth_services.dart';
import 'package:app_pfe/views/auth/reset_password/change_password.dart';
import 'package:app_pfe/views/widgets/button.dart';
import 'package:app_pfe/views/widgets/input_field.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  const OtpScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();
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
                  "Entrez le code que vous avez reçu sur votre mail",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 25, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Constants.screenHeight * 0.1, horizontal: Constants.screenWidth * 0.02),
                  child:
                      InputField(label: "Code de verification", textInputType: TextInputType.number, controller: codeController),
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
                              if (codeController.text.length != 4) {
                                final snackBar = SnackBar(
                                  content: Text("Le code doit etre sur 4 chiffres"),
                                  backgroundColor: (Colors.red),
                                  action: SnackBarAction(
                                    label: 'Fermer',
                                    textColor: Colors.white,
                                    onPressed: () {},
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              } else {
                                setState(() {
                                  loading = true;
                                });
                                AuthServices().CheckOtp(code: int.tryParse(codeController.text)!).then((value) {
                                  setState(() {
                                    loading = false;
                                  });
                                  if (!value.responseStatus!) {
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
                                  } else {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => ChangePassword(
                                              email: widget.email,
                                              code: int.tryParse(codeController.text)!,
                                            )));
                                  }
                                });
                              }
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
