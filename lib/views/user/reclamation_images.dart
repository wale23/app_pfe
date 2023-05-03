import 'package:app_pfe/models/reclamation.dart';
import 'package:app_pfe/services/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ReclamationImage extends StatelessWidget {
  final Reclamation reclamation;
  const ReclamationImage({Key? key, required this.reclamation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
          "#${reclamation.id}",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        automaticallyImplyLeading: false,
      ),
      body: reclamation.images!.isEmpty
          ? Column(
              children: [
                Center(
                  child: Lottie.asset("images/empty.json"),
                ),
                Text(
                  "pas des images",
                  style: TextStyle(fontSize: 20, fontFamily: "NunitoBold", color: Colors.black.withOpacity(0.5)),
                )
              ],
            )
          : SingleChildScrollView(
              child: Column(
                children: reclamation.images!.map((e) => Image.network(ApiConstants.baseUrl + 'images/$e')).toList(),
              ),
            ),
    );
  }
}
