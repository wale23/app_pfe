import 'package:app_pfe/User.dart';
import 'package:flutter/material.dart';
import 'button.dart';
import 'forgotPasswordScreen2.dart';

class forgotPasswordScreen1 extends StatefulWidget {
  @override
  _forgotPasswordScreen1State createState() => _forgotPasswordScreen1State();
}

class _forgotPasswordScreen1State extends State<forgotPasswordScreen1> {
  final _formKey = GlobalKey<FormState>();
  User user = User("", "", "", "", "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 110),
          child: Column(
        children: [
          Text(
            "Reset your Password",
            style: TextStyle(
                fontSize: 40,
                color: Colors.black,
                height: 3,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Enter your email adress and we will send you instructions to reset your password",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.grey, fontSize: 25, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: TextEditingController(text: user.email),
              onChanged: (val) {
                user.email = val;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter email';
                }
                if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                    .hasMatch(value)) {
                  return 'Please enter valid email';
                }
                return null;
              },
              style: TextStyle(fontSize: 25, color: Colors.black),
              decoration: InputDecoration(
                hintText: "Enter you email Adress",
                focusedBorder: OutlineInputBorder(),
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.black, fontSize: 22),
                errorStyle: TextStyle(fontSize: 20, color: Colors.red),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Center(
              child: Column(children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => forgotPasswordScreen2()));
              },
              style: buttonPrimary,
              child: Text("Continue",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
            ),
            SizedBox(
              height: 5,
            ),
            TextButton(
              onPressed: () {},
              child: Text("Back to App ",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 24)),
            )
          ]))
        ],
      )),
    );
  }
}
