import 'package:app_pfe/models/reclamation.dart';
import 'package:app_pfe/ressources/dimensions/constants.dart';
import 'package:app_pfe/services/reclamations_services.dart';
import 'package:app_pfe/views/user/reclamation_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:unicons/unicons.dart';

class ReclamationsRecap extends StatefulWidget {
  const ReclamationsRecap({Key? key}) : super(key: key);

  @override
  State<ReclamationsRecap> createState() => _ReclamationsRecapState();
}

class _ReclamationsRecapState extends State<ReclamationsRecap> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: Scaffold(
        body: FutureBuilder(
            future: ReclamationsServices().getReclamationsAdmin(),
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
                            print(GetStorage().read("user")['role_id']);
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
                                          child: Icon(
                                            UniconsLine.user,
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
                                                      child:
                                                          Text(overflow: TextOverflow.ellipsis, '${reclamations[index].subject}'),
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
                                                          : (reclamations[index].priority == "Haute" ? Colors.red : Colors.green),
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
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: Text(
                                                        "de ${reclamations[index].sender.full_name} à ${reclamations[index].receiver.full_name}"),
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
                              style: TextStyle(fontSize: 20, fontFamily: "NunitoBold", color: Colors.black.withOpacity(0.5)),
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
    );
  }
}
