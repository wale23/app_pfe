import 'package:app_pfe/models/reclamation.dart';
import 'package:app_pfe/ressources/dimensions/constants.dart';
import 'package:app_pfe/services/reclamations_services.dart';
import 'package:app_pfe/views/user/reclamation_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:unicons/unicons.dart';

class MyAllReclamationsAdmin extends StatefulWidget {
  const MyAllReclamationsAdmin({Key? key}) : super(key: key);

  @override
  State<MyAllReclamationsAdmin> createState() => _MyAllReclamationsState();
}

class _MyAllReclamationsState extends State<MyAllReclamationsAdmin> {
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
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.green,
            ),
          ),
          title: Text(
            "Tous les Reclamations",
            style: TextStyle(color: Colors.black54, fontSize: 15),
          ),
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: FutureBuilder(
                future: ReclamationsServices().getReclamationsAdmin(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<Reclamation> reclamations = [];
                    List<Reclamation> data = snapshot.data;
                    for (var reclamation in data) {
                      reclamations.add(reclamation);
                    }
                    if (snapshot.data.length != 0) {
                      return ListView.builder(
                          itemCount: reclamations.length,
                          itemBuilder: (context, index) {
                            if (reclamations[index].status == 'Aucune') {
                              return InkWell(
                                onTap: () {
                                  Get.to(ReclamationDetails(
                                    reclamation: reclamations[index],
                                  ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(color: Colors.black.withOpacity(0.1)),
                                          bottom: BorderSide(color: Colors.black.withOpacity(0.1))),
                                    ),
                                    child: Slidable(
                                      key: const ValueKey(0),
                                      startActionPane: ActionPane(
                                        // A motion is a widget used to control how the pane animates.
                                        motion: const ScrollMotion(),

                                        children: [
                                          SlidableAction(
                                            onPressed: null,
                                            backgroundColor: Colors.green,
                                            foregroundColor: Colors.white,
                                            icon: UniconsLine.cancel,
                                            label: 'Annuler',
                                          ),
                                          SlidableAction(
                                            onPressed: (ctx) {
                                              ReclamationsServices.changeStatus("En cours", reclamations[index].id!, () {
                                                setState(() {});
                                              });
                                              final snackBar = SnackBar(
                                                content: Text("Statut changé avec succès"),
                                                backgroundColor: (Colors.green),
                                                action: SnackBarAction(
                                                  label: 'fermer',
                                                  textColor: Colors.white,
                                                  onPressed: () {},
                                                ),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            },
                                            backgroundColor: Colors.red.withOpacity(0.7),
                                            foregroundColor: Colors.white,
                                            icon: UniconsLine.ticket,
                                            label: 'Commencer',
                                          ),
                                        ],
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
                                                          Padding(
                                                            padding: const EdgeInsets.all(4.0),
                                                            child: Text('lawrene'),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                    DateFormat('dd MMM HH:mm').format(reclamations[index].date!)),
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
                                                            child: Text('${reclamations[index].user!.full_name}'),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(reclamations[index].status!),
                                                            ],
                                                          ),
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
                                ),
                              );
                            } else if (reclamations[index].status == 'En cours') {
                              return InkWell(
                                onTap: () {
                                  Get.to(ReclamationDetails(
                                    reclamation: reclamations[index],
                                  ));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(color: Colors.black.withOpacity(0.1)),
                                          bottom: BorderSide(color: Colors.black.withOpacity(0.1))),
                                    ),
                                    child: Slidable(
                                      key: const ValueKey(0),
                                      startActionPane: ActionPane(
                                        // A motion is a widget used to control how the pane animates.
                                        motion: const ScrollMotion(),

                                        children: [
                                          SlidableAction(
                                            onPressed: null,
                                            backgroundColor: Colors.green,
                                            foregroundColor: Colors.white,
                                            icon: UniconsLine.cancel,
                                            label: 'Annuler',
                                          ),
                                          SlidableAction(
                                            onPressed: (ctx) {
                                              ReclamationsServices.changeStatus("Terminé", reclamations[index].id!, () {
                                                setState(() {});
                                              });
                                              final snackBar = SnackBar(
                                                content: Text("Statut changé avec succès"),
                                                backgroundColor: (Colors.green),
                                                action: SnackBarAction(
                                                  label: 'fermer',
                                                  textColor: Colors.white,
                                                  onPressed: () {},
                                                ),
                                              );
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                            },
                                            backgroundColor: Colors.red.withOpacity(0.7),
                                            foregroundColor: Colors.white,
                                            icon: UniconsLine.ticket,
                                            label: 'Terminer',
                                          ),
                                        ],
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
                                                          Padding(
                                                            padding: const EdgeInsets.all(4.0),
                                                            child: Text('lawrene'),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                    DateFormat('dd MMM HH:mm').format(reclamations[index].date!)),
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
                                                            child: Text('${reclamations[index].user!.full_name}'),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(reclamations[index].status!),
                                                            ],
                                                          ),
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
                                ),
                              );
                            } else {
                              return InkWell(
                                onTap: () {
                                  Get.to(ReclamationDetails(
                                    reclamation: reclamations[index],
                                  ));
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
                                                        Padding(
                                                          padding: const EdgeInsets.all(4.0),
                                                          child: Text('lawrene'),
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
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          UniconsLine.headphones,
                                                          color: Colors.red.withOpacity(0.3),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.all(4.0),
                                                          child: Text('${reclamations[index].user!.full_name}'),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(reclamations[index].status!),
                                                          ],
                                                        ),
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
                            }
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
                })));
  }
}
