import 'package:app_pfe/models/reclamation.dart';
import 'package:app_pfe/ressources/dimensions/constants.dart';
import 'package:app_pfe/services/reclamations_services.dart';
import 'package:app_pfe/views/user/reclamation_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:unicons/unicons.dart';

class MyAllReclamations extends StatefulWidget {
  const MyAllReclamations({Key? key}) : super(key: key);

  @override
  State<MyAllReclamations> createState() => _MyAllReclamationsState();
}

class _MyAllReclamationsState extends State<MyAllReclamations> {
  List<int> idsToDelete = [];
  bool multiSelection = false;
  int pageIndex = 0;

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
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  ReclamationsServices.archiveReclamation(true, {'ids': idsToDelete}, () {
                                    setState(() {});
                                  }).then((value) {
                                    Navigator.pop(context);
                                    multiSelection = false;
                                    idsToDelete.clear();
                                  });
                                },
                                leading: Icon(
                                  Icons.warning,
                                  color: Colors.blueAccent,
                                ),
                                title: Text(
                                  "Ajouter à l'archive",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  ReclamationsServices.deleteReclamation({'ids': idsToDelete}, () {
                                    setState(() {});
                                  }).then((value) {
                                    Navigator.pop(context);
                                    multiSelection = false;
                                    idsToDelete.clear();
                                  });
                                },
                                leading: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                title: Text(
                                  'Supprimer',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.more_horiz_rounded,
                    color: Colors.green,
                  ))
              : IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.green,
                  ),
                ),
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
                    color: Colors.green,
                  ),
                )
              : Text(
                  "Tous les Reclamations",
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                ),
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          if (pageIndex != 0) {
                            setState(() {
                              pageIndex = 0;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: pageIndex == 0 ? Colors.green : Colors.white,
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                              )),
                          height: Constants.screenHeight * 0.04,
                          width: Constants.screenWidth * 0.1,
                          child: Icon(
                            Icons.arrow_outward,
                            color: pageIndex == 0 ? Colors.white : Colors.green,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (pageIndex != 1) {
                            setState(() {
                              pageIndex = 1;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: pageIndex == 1 ? Colors.red : Colors.white,
                              border: Border.all(color: Colors.green),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              )),
                          height: Constants.screenHeight * 0.04,
                          width: Constants.screenWidth * 0.1,
                          child: Icon(
                            Icons.arrow_downward,
                            color: pageIndex == 1 ? Colors.white : Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                pageIndex == 1
                    ? Center(
                        child: Text("Reclamations reçues"),
                      )
                    : Expanded(
                        child: FutureBuilder(
                            future: ReclamationsServices().getReclamations(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                List<Reclamation> reclamations = [];
                                List data = snapshot.data;
                                for (var reclamation in data) {
                                  reclamations.add(reclamation);
                                }
                                if (snapshot.data.length != 0) {
                                  return ListView.builder(
                                      itemCount: reclamations.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            if (multiSelection) {
                                              if (idsToDelete.contains(reclamations[index].id)) {
                                                idsToDelete.remove(reclamations[index].id);
                                              } else {
                                                idsToDelete.add(reclamations[index].id!);
                                              }
                                              setState(() {});
                                            } else {
                                              Get.to(ReclamationDetails(
                                                reclamation: reclamations[index],
                                              ));
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border(
                                                    top: BorderSide(color: Colors.black.withOpacity(0.1)),
                                                    bottom: BorderSide(color: Colors.black.withOpacity(0.1))),
                                              ),
                                              child: Container(
                                                color: Colors.grey.withOpacity(0.2),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                                                  UniconsLine.comment,
                                                                  color: Colors.grey,
                                                                )
                                                              : Icon(
                                                                  UniconsLine.check,
                                                                  color: Colors.green,
                                                                ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(4.0),
                                                                    child: Text('#${reclamations[index].id}'),
                                                                  ),
                                                                  Expanded(
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.all(4.0),
                                                                      child: Text(
                                                                          overflow: TextOverflow.ellipsis,
                                                                          '${reclamations[index].subject}'),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "${reclamations[index].priority}",
                                                                    style: TextStyle(
                                                                      color: reclamations[index].priority == "Moyenne"
                                                                          ? Colors.orange
                                                                          : (reclamations[index].priority == "Haute"
                                                                              ? Colors.red
                                                                              : Colors.green),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Text(DateFormat('dd MMM HH:mm')
                                                                            .format(reclamations[index].date!)),
                                                                        Icon(
                                                                          UniconsLine.clock,
                                                                          color: Colors.red.withOpacity(0.3),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    UniconsLine.headphones,
                                                                    color: Colors.red.withOpacity(0.3),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(4.0),
                                                                    child: Text("${reclamations[index].sender.full_name}"),
                                                                  ),
                                                                  Padding(
                                                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                                                      child: Text(
                                                                        "${reclamations[index].status}",
                                                                        style: TextStyle(
                                                                          color: reclamations[index].status == "En cours"
                                                                              ? Colors.green
                                                                              : (reclamations[index].status == "Aucune"
                                                                                  ? Colors.blueAccent
                                                                                  : Colors.red),
                                                                        ),
                                                                      )),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
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
                                              style: TextStyle(
                                                  fontSize: 20, fontFamily: "NunitoBold", color: Colors.black.withOpacity(0.5)),
                                            )
                                          ],
                                        ));
                                      });
                                }
                              } else {
                                return Center(child: Lottie.asset("images/loading.json", height: Constants.screenHeight * 0.1));
                              }
                            }),
                      ),
              ],
            )));
  }
}
