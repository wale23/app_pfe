import 'package:app_pfe/models/reclamation.dart';
import 'package:app_pfe/ressources/dimensions/constants.dart';
import 'package:app_pfe/services/reclamations_services.dart';
import 'package:app_pfe/views/user/reclamation_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:unicons/unicons.dart';

class FinishedReclamationsAdmin extends StatefulWidget {
  const FinishedReclamationsAdmin({Key? key}) : super(key: key);

  @override
  State<FinishedReclamationsAdmin> createState() => _FinishedReclamationsState();
}

class _FinishedReclamationsState extends State<FinishedReclamationsAdmin> {
  int pageIndex = 0;
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
            "Reclamations terminés",
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
                          Icons.menu,
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
                            color: pageIndex == 1 ? Colors.green : Colors.white,
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            )),
                        height: Constants.screenHeight * 0.04,
                        width: Constants.screenWidth * 0.1,
                        child: Icon(
                          UniconsLine.chart_line,
                          color: pageIndex == 1 ? Colors.white : Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pageIndex == 1
                  ? Center(
                      child: Text("Statistiques"),
                    )
                  : Expanded(
                      child: FutureBuilder(
                          future: ReclamationsServices().getReclamationsAdminByStatus("Terminé"),
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
                                                          child: Icon(
                                                            UniconsLine.comment,
                                                            color: Colors.grey,
                                                          )),
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
                                                                    color: reclamations[index].priority == "moyenne"
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
                                                                  child: Text("${reclamations[index].user!.full_name}"),
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
          ),
        ));
  }
}
