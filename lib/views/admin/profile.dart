import 'package:app_pfe/services/auth_services.dart';
import 'package:flutter/material.dart';

class ProfileAdmin extends StatefulWidget {
  const ProfileAdmin({Key? key}) : super(key: key);

  @override
  State<ProfileAdmin> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            AuthServices().logOut(context);
          },
          child: Text("Deconnecter"),
        ),
      ),
    );
  }
}
