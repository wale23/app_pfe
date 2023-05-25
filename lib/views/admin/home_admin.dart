import 'package:app_pfe/views/admin/profile.dart';
import 'package:app_pfe/views/admin/reclamations_view.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'notifications.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  List pages = [
    AdminReclamationsView(),
    NotifAdmin(),
    ProfileAdmin(),
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: index,
        onTap: (i) {
          setState(() {
            index = i;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: new Icon(UniconsLine.ticket),
            label: 'Reclamations',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.notifications_active),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.settings),
            label: 'Paramètres',
          ),
        ],
      ),
    );
  }
}
