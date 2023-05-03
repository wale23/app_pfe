import 'dart:io';

import 'package:app_pfe/ressources/dimensions/constants.dart';
import 'package:app_pfe/services/reclamations_services.dart';
import 'package:app_pfe/views/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddReclamation extends StatefulWidget {
  const AddReclamation({Key? key}) : super(key: key);

  @override
  State<AddReclamation> createState() => _AddReclamationState();
}

class _AddReclamationState extends State<AddReclamation> {
  TextEditingController subjectController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priority = TextEditingController();
  List<File> _selectedImages = [];
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  Future<void> _showOptions(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  _getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  _getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getImage(ImageSource source) async {
    File? _image;
    final picker = ImagePicker();
    if (source == ImageSource.camera) {
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      if (image != null) {
        setState(() {
          _image = File(image.path);
          _selectedImages.add(_image!);
        });
      }
    } else {
      try {
        final List<XFile> selectedImages = await picker.pickMultiImage(imageQuality: 50);
        setState(() {
          _selectedImages = selectedImages.map((e) => File(e.path)).toList();
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _showOptions(context);
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: loading
            ? CircularProgressIndicator()
            : TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    ReclamationsServices.createReclamation(
                        subjectController.text, descController.text, int.tryParse(priority.text)!, _selectedImages);
                    setState(() {
                      descController.clear();
                      subjectController.clear();
                      priority.clear();
                      loading = false;
                    });
                  }
                },
                child: Text("Ajouter")),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.green,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: Constants.screenHeight,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  InputField(label: "Sujet", textInputType: TextInputType.text, controller: subjectController),
                  InputField(
                    label: "Priorité",
                    textInputType: TextInputType.number,
                    controller: priority,
                  ),
                  InputField(
                    label: "Description",
                    textInputType: TextInputType.text,
                    controller: descController,
                    lines: 3,
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: _selectedImages.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          color: Colors.blueGrey,
                          child: Image.file(
                            _selectedImages[index],
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
