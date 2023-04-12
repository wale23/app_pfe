import 'dart:convert';
import 'forgotPasswordScreen1.dart';
import 'package:app_pfe/User.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'button.dart';
import 'Menu.dart';

class signInemail extends StatefulWidget {
  @override
  _signInemailState createState() => _signInemailState();
}

class _signInemailState extends State<signInemail> {
  final _formKey = GlobalKey<FormState>();
  bool passToggle = false;

  User user = User("","","","","");
  String url = "http://192.168.1.166:8080/login";

  Future checkAccount(User user) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'email': user.email, 'password': user.password}),
      );
      final responseData = json.decode(response.body);
      if (responseData["success"] == false) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(responseData["message"])));
      }

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => menu()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Invalid email or password. Please try again.')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('An error occurred. Please try again later.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      padding: const EdgeInsets.only(left: 10, right: 40),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.0),
            Image.asset("images/img_3.png", height: 100, width: 150),
            //SizedBox(height:height*0.04,),
            Text(
              "Sign in",
              style: TextStyle(
                  color: Colors.black,
                  height: 2,
                  fontWeight: FontWeight.w600,
                  fontSize: 27),
            ),
            Text(
              "to access App",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: TextEditingController(text: user.email),
              onChanged: (val) {
                user.email = val;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter email';
                }
                if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value))
                {return 'Please enter valid email';
                }
                return null;
              },
              style: TextStyle(fontSize: 25, color: Colors.black),
              decoration: InputDecoration(
                hintText: "Enter you email Adress",
                focusedBorder: OutlineInputBorder(),
                labelText: "Email",
                labelStyle: TextStyle(color: Colors.black,fontSize: 22),
                errorStyle: TextStyle(fontSize: 20, color: Colors.red),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            TextFormField(
              controller: TextEditingController(text: user.password),
              onChanged: (val) {
                user.password = val;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter password';
                }
                return null;
              },
              style: TextStyle(fontSize: 30, color: Colors.black),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      passToggle = !passToggle;
                    });
                  },
                  child: Icon(
                      passToggle ? Icons.visibility : Icons.visibility_off),
                ),
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.black,fontSize: 22),
                errorStyle: TextStyle(fontSize: 20, color: Colors.red),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        checkAccount(user);
                      }
                    },
                    style: buttonPrimary,
                    child: Text("Sign In",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => forgotPasswordScreen1()));
                    },
                    child: Text("Forgot Password? ",
                        style: TextStyle(
                            color: Colors.lightGreen,
                            fontWeight: FontWeight.bold,
                            fontSize: 24)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text("Sign in using",style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 20),)
          ],
        ),
      ),
    ));
  }
}
