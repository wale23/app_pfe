import 'package:app_pfe/providers/add_reclamation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({Key? key}) : super(key: key);

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.green),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ReclamationProvider>(
          builder: (context, model, child) {
            return TextFormField(
              controller: model.subjectController,
              textInputAction: TextInputAction.newline,
              autofocus: true,
              enabled: true,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Tapez pour ajouter le sujet...",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
