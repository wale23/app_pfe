import 'dart:io';

import 'package:app_pfe/ressources/dimensions/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AdminReclamationsView extends StatefulWidget {
  const AdminReclamationsView({Key? key}) : super(key: key);

  @override
  State<AdminReclamationsView> createState() => _ReclamationsViewState();
}

class _ReclamationsViewState extends State<AdminReclamationsView> {
  var user = GetStorage().read('user');
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          automaticallyImplyLeading: false,
          title: Text(
            "Les Reclamations",
            style: TextStyle(color: Colors.black54),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              width: double.infinity,
              height: Constants.screenHeight * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.lightGreen,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage("images/avatar.png"),
                    ),
                  ),
                  Text(
                    "${user['full_name']}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                //  Get.to(MyAllReclamationsAdmin());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(5)),
                  child: const ListTile(
                    leading: Icon(
                      Icons.star,
                      color: Colors.green,
                    ),
                    title: Text(
                      'Tous les reclamations',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.grey.withOpacity(0.05), borderRadius: BorderRadius.circular(5)),
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    leading: Icon(Icons.list_alt),
                    title: Text(
                      'Toutes catégories',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ListTile(
                            title: Text('Les reclamations en cours'),
                            onTap: () {
                              // Get.to(InProgressReclamationsAdmin());
                            },
                          ),
                          Container(
                            color: Colors.black12,
                            height: 2,
                            width: Constants.screenWidth * 0.9,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ListTile(
                            onTap: () {
                              //  Get.to(FinishedReclamationsAdmin());
                            },
                            title: Text('Les reclamations fermées'),
                          ),
                          Container(
                            color: Colors.black12,
                            height: 2,
                            width: Constants.screenWidth * 0.9,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ListTile(
                            onTap: () {
                              // Get.to(PendingReclamationsAdmin());
                            },
                            title: Text('Les reclamations en attente'),
                          ),
                          Container(
                            color: Colors.black12,
                            height: 2,
                            width: Constants.screenWidth * 0.9,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
