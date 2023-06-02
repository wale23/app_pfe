import 'package:app_pfe/models/notification.dart';
import 'package:app_pfe/ressources/dimensions/constants.dart';
import 'package:app_pfe/services/notifications_services.dart';
import 'package:app_pfe/views/user/reclamation_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:unicons/unicons.dart';

class NotifUser extends StatefulWidget {
  const NotifUser({Key? key}) : super(key: key);

  @override
  State<NotifUser> createState() => _NotifUserState();
}

class _NotifUserState extends State<NotifUser> {
  List<int> idsToDelete = [];
  bool multiSelection = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        automaticallyImplyLeading: false,
        leading: multiSelection
            ? IconButton(
                onPressed: () {
                  NotificationsServices.deleteNotifications({'ids': idsToDelete}, () {
                    setState(() {});
                  }).then((value) {
                    multiSelection = false;
                  });
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ))
            : null,
        title: multiSelection
            ? IconButton(
                onPressed: () {
                  setState(() {
                    multiSelection = false;
                    idsToDelete.clear();
                  });
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              )
            : Text(
                "Mes notifications",
                style: TextStyle(color: Colors.black54, fontSize: 15),
              ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: FutureBuilder(
          future: NotificationsServices.myNotifications(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<FirebaseNotification> reclamations = [];
              List<FirebaseNotification> data = snapshot.data;
              for (var reclamation in data) {
                reclamations.add(reclamation);
              }
              if (reclamations.isNotEmpty) {
                return ListView.builder(
                    itemCount: reclamations.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: Constants.screenHeight * 0.17,
                        child: InkWell(
                          onTap: () {
                            if (multiSelection) {
                              if (idsToDelete.contains(reclamations[index].id)) {
                                idsToDelete.remove(reclamations[index].id);
                              } else {
                                idsToDelete.add(reclamations[index].id);
                              }
                              setState(() {});
                            } else {
                              Get.to(ReclamationDetails(reclamation: reclamations[index].reclamation));
                            }
                          },
                          onLongPress: () {
                            if (!multiSelection) {
                              idsToDelete.add(reclamations[index].id!);
                              setState(() {
                                multiSelection = true;
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(color: Colors.black.withOpacity(0.1)),
                                  bottom: BorderSide(color: Colors.black.withOpacity(0.1)),
                                ),
                              ),
                              child: Container(
                                color: Colors.grey.withOpacity(0.2),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      color: Colors.green,
                                      width: Constants.screenWidth * 0.02,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: !idsToDelete.contains(reclamations[index].id!)
                                                      ? Icon(
                                                          UniconsLine.user,
                                                          color: Colors.grey,
                                                        )
                                                      : Icon(
                                                          UniconsLine.check,
                                                          color: Colors.green,
                                                        ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text("${reclamations[index].sender.full_name}"),
                                              )
                                            ],
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            '${reclamations[index].notification}',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Row(
                                                      children: [
                                                        Text(DateFormat('dd MMM HH:mm').format(reclamations[index].date!)),
                                                        Icon(
                                                          UniconsLine.clock,
                                                          color: Colors.red.withOpacity(0.3),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Center(
                          child: Column(
                        children: [
                          Lottie.asset("images/empty.json"),
                          Text(
                            "pas de reclamations",
                            style: TextStyle(fontSize: 20, fontFamily: "NunitoBold", color: Colors.black.withOpacity(0.5)),
                          )
                        ],
                      ));
                    });
              }
            } else {
              return Center(child: Lottie.asset("images/loading.json", height: Constants.screenHeight * 0.1));
            }
          },
        ),
      ),
    );
  }
}
