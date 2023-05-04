import 'package:app_pfe/views/user/my_reclamations_view.dart';
import 'package:app_pfe/views/user/profile.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({Key? key}) : super(key: key);

  @override
  State<HomeUser> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeUser> {
  List pages = [
    MyReclamationsView(),
    Center(
      child: Text("notifications"),
    ),
    ProfileUser()
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
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
            icon: new Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
