import 'package:app_pfe/models/comment.dart';
import 'package:app_pfe/models/reclamation.dart';
import 'package:app_pfe/ressources/dimensions/constants.dart';
import 'package:app_pfe/services/reclamations_services.dart';
import 'package:app_pfe/views/user/reclamation_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class ReclamationDetails extends StatefulWidget {
  final Reclamation reclamation;
  const ReclamationDetails({Key? key, required this.reclamation}) : super(key: key);

  @override
  State<ReclamationDetails> createState() => _ReclamationDetailsState();
}

class _ReclamationDetailsState extends State<ReclamationDetails> {
  String value = "";
  var user = GetStorage().read("user");
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.to(ReclamationImage(reclamation: widget.reclamation));
              },
              icon: Icon(
                Icons.attach_file,
                color: Colors.green,
              ))
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.green,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "#${widget.reclamation.id}",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Container(
              height: Constants.screenHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Sujet : ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.green,
                        ),
                        Expanded(
                          child: Text(
                            "${widget.reclamation.subject}",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Priority : ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.green,
                        ),
                        Expanded(
                          child: Text(
                            "${widget.reclamation.priority}",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Status : ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.arrow_forward_ios,
                          color: widget.reclamation.status == "En cours"
                              ? Colors.green
                              : (widget.reclamation.status == "Aucune" ? Colors.blueAccent : Colors.red),
                        ),
                        Expanded(
                          child: Text(
                            "${widget.reclamation.status}",
                            style: TextStyle(
                              color: widget.reclamation.status == "En cours"
                                  ? Colors.green
                                  : (widget.reclamation.status == "Aucune" ? Colors.blueAccent : Colors.red),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Expanded(
                    child: FutureBuilder(
                        future: ReclamationsServices().getComments(widget.reclamation.id!),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            List<Comments> comments = [];
                            List<Comments> data = snapshot.data;
                            for (var commented in data) {
                              comments.add(commented);
                            }

                            if (snapshot.data.length != 0) {
                              return ListView.builder(
                                  itemCount: comments.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[200],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.account_circle),
                                              SizedBox(width: 10),
                                              Text('${comments[index].user!.full_name}'),
                                              Spacer(),
                                              Text("${DateFormat("yyyy/MM/dd HH:mm").format(comments[index].date!)}"),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Text("${comments[index].comment}"),
                                        ],
                                      ),
                                    );
                                  });
                            } else {
                              return Container();
                            }
                          } else {
                            return Center(child: Lottie.asset("images/loading.json", height: Constants.screenHeight * 0.1));
                          }
                        }),
                  )
                ],
              ),
            )),
            if (user['role_id'] != 1)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          value = val;
                        });
                      },
                      style: TextStyle(fontSize: 18),
                      controller: commentController,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        hintText: "Commentaire",
                        filled: true,
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Colors.lightGreen.withOpacity(0.5),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.lightGreen,
                            width: 2.0,
                          ),
                        ),
                      ),
                    )),
                    IconButton(
                        onPressed: widget.reclamation.status != "En cours" || value.isEmpty
                            ? null
                            : () {
                                ReclamationsServices.createComment(commentController.text, widget.reclamation.id!, () {
                                  setState(() {
                                    value = "";
                                    commentController.clear();
                                  });
                                });
                              },
                        icon: Icon(
                          Icons.send,
                          color: Colors.green,
                        ))
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
