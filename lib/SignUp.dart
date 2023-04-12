import 'dart:convert';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Menu.dart';
import 'User.dart';
import 'button.dart';
import 'hashMdp.dart';
class signUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  CountryCode? _selectedCountry;

  final _formKey = GlobalKey<FormState>();
  User user = User("", "", "", "", "");
  bool passToggle = false;
  String url = "http://192.168.1.166:8080/register";

  Future createaccount(User user) async {
    try {
      user.password = hashPassword(user.password); // Hacher le mot de passe
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': user.name,
          'email': user.email,
          'password': user.password,
          'company': user.company,
          'phone': user.phone
        }),
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
                      Text(
                        "Create Your Free Account",
                        style: TextStyle(
                            color: Colors.black,
                            height: 2,
                            fontWeight: FontWeight.w600,
                            fontSize: 27),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: TextEditingController(text: user.name),
                        onChanged: (val) {
                          user.name = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        style: TextStyle(fontSize: 25, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Enter you name",
                          focusedBorder: OutlineInputBorder(),
                          labelText: "Full name",
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 22),
                          errorStyle:
                              TextStyle(fontSize: 20, color: Colors.red),
                          // border: OutlineInputBorder(borderSide: BorderSide.none)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
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
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 22),
                          errorStyle:
                              TextStyle(fontSize: 20, color: Colors.red),
                        ),
                      ),
                      SizedBox(
                        height: 10,
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
                        style: TextStyle(fontSize: 25, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Enter you password",
                          focusedBorder: OutlineInputBorder(),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                passToggle = !passToggle;
                              });
                            },
                            child: Icon(passToggle
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          labelText: "Password",
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 22),
                          errorStyle:
                              TextStyle(fontSize: 20, color: Colors.red),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: TextEditingController(text: user.phone),
                        onChanged: (val) {
                          user.phone = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter phone';
                          }
                          if (value.length < 8) {
                            return "Please enter valid phone";
                          }
                          return null;
                        },
                        style: TextStyle(fontSize: 30, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Enter you phone number",
                          focusedBorder: OutlineInputBorder(),
                          labelText: "Phone number",
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 22),
                          errorStyle:
                              TextStyle(fontSize: 20, color: Colors.red),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: TextEditingController(text: user.company),
                        onChanged: (val) {
                          user.company = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your company';
                          }
                          return null;
                        },
                        style: TextStyle(fontSize: 30, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Enter you company name",
                          focusedBorder: OutlineInputBorder(),
                          labelText: "Commpany name",
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 22),
                          errorStyle:
                              TextStyle(fontSize: 20, color: Colors.red),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Country', //${_selectedCountry?.name ?? ''}',
                        style: TextStyle(color: Colors.black, fontSize: 22),
                      ),
                      CountryListPick(
                        theme: CountryTheme(
                          isShowFlag: true,
                          isShowTitle: true,
                          isShowCode: false,
                          isDownIcon: true,
                          showEnglishName: true,
                        ),
                        onChanged: (CountryCode? code) {
                          setState(() {
                            _selectedCountry = code;
                          });
                        },
                        initialSelection: _selectedCountry?.code ?? 'TN',
                      ),
                      SizedBox(height: 10.0),
                      Center(
                          child: Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                createaccount(user);
                              }
                            },
                            style: buttonPrimary,
                            child: Text("Sign up",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 23)),
                          ),
                        ],
                      ))
                    ]))));
  }
}
