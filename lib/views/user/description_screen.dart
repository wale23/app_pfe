import 'package:app_pfe/providers/add_reclamation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DescriptionScreen extends StatefulWidget {
  const DescriptionScreen({Key? key}) : super(key: key);

  @override
  State<DescriptionScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<DescriptionScreen> {
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
              controller: model.descriptionController,
              textInputAction: TextInputAction.newline,
              autofocus: true,
              enabled: true,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Tapez pour ajouter la description...",
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
