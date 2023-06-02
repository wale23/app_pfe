import 'dart:convert';
import 'dart:io';

import 'package:app_pfe/models/User.dart';
import 'package:app_pfe/providers/add_reclamation_provider.dart';
import 'package:app_pfe/ressources/dimensions/constants.dart';
import 'package:app_pfe/services/api_constants.dart';
import 'package:app_pfe/services/call_api.dart';
import 'package:app_pfe/services/reclamations_services.dart';
import 'package:app_pfe/views/user/description_screen.dart';
import 'package:app_pfe/views/user/subject_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddReclamation extends StatefulWidget {
  const AddReclamation({Key? key}) : super(key: key);

  @override
  State<AddReclamation> createState() => _AddReclamationState();
}

class _AddReclamationState extends State<AddReclamation> {
  String priority = "Faible";
  String dep = "stock";

  TextEditingController subjectController = TextEditingController();
  TextEditingController descController = TextEditingController();
  List<File> _selectedImages = [];
  User? selectedUSer;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  List<User> users = [];
  bool firstLoading = false;
  Future getUsers(int id) async {
    setState(() {
      firstLoading = true;
    });
    dynamic url = ApiConstants.users + "/$id";
    var response = await CallApi().getData(url);
    var result = jsonDecode(utf8.decode(response.bodyBytes));
    List<User> usersList = [];
    for (var data in result) {
      usersList.add(User.fromJson(data));
    }
    setState(() {
      users = usersList;
      firstLoading = false;
    });
  }

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

  Widget field({required TextEditingController controller, required String label, VoidCallback? onTap}) {
    return Container(
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey))),
      child: TextFormField(
        onTap: onTap != null ? () => onTap() : null,
        readOnly: true,
        style: TextStyle(fontSize: 18),
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return "Champ obligatoire";
          } else if (label == "Email") {
            bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
            if (!emailValid) {
              return "Format invalide d'email";
            }
          }
        },
        cursorColor: Colors.black,
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.arrow_right),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1),
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1),
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers(user['id']);
  }

  var user = GetStorage().read('user');
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReclamationProvider(),
      child: Consumer<ReclamationProvider>(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Color(0xfffafafa),
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
                              subjectController.text, descController.text, priority, dep, _selectedImages, selectedUSer!.id!);
                          setState(() {
                            descController.clear();
                            subjectController.clear();

                            loading = false;
                          });
                        }
                      },
                      child: Text("Enregistrer", style: TextStyle(color: Colors.green, fontSize: 17))),
              backgroundColor: Colors.white,
              elevation: 0.5,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.green,
                ),
              ),
            ),
            body: firstLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: Constants.screenHeight,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "Sujet : ",
                                    style: TextStyle(fontSize: 17),
                                  )),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: Constants.screenWidth * 0.01),
                                      child: field(
                                          label: "Sujet",
                                          controller: model.subjectController,
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => ChangeNotifierProvider.value(
                                                          value: model,
                                                          child: SubjectScreen(),
                                                        )));
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(child: Text("Description : ", style: TextStyle(fontSize: 17))),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: Constants.screenWidth * 0.01),
                                      child: field(
                                          label: "Sujet",
                                          controller: model.descriptionController,
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => ChangeNotifierProvider.value(
                                                          value: model,
                                                          child: DescriptionScreen(),
                                                        )));
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(child: Text("Priorité : ", style: TextStyle(fontSize: 17))),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: Constants.screenWidth * 0.01),
                                      child: Container(
                                        height: Constants.screenHeight * 0.08,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border(
                                              top: BorderSide(
                                                color: Colors.grey,
                                              ),
                                              bottom: BorderSide(
                                                color: Colors.grey,
                                              )),
                                          color: Colors.white,
                                        ),
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          value: priority,
                                          underline: SizedBox(
                                            height: 0,
                                          ),
                                          items: const [
                                            DropdownMenuItem(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Faible',
                                                  style:
                                                      TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black38),
                                                ),
                                              ),
                                              value: 'Faible',
                                            ),
                                            DropdownMenuItem(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Moyenne',
                                                  style:
                                                      TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black38),
                                                ),
                                              ),
                                              value: 'Moyenne',
                                            ),
                                            DropdownMenuItem(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Haute',
                                                  style:
                                                      TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black38),
                                                ),
                                              ),
                                              value: 'Haute',
                                            ),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              priority = value!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(child: Text("Département : ", style: TextStyle(fontSize: 17))),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: Constants.screenWidth * 0.01),
                                      child: Container(
                                        height: Constants.screenHeight * 0.08,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                            color: Colors.grey,
                                          )),
                                          color: Colors.white,
                                        ),
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          value: dep,
                                          underline: SizedBox(
                                            height: 0,
                                          ),
                                          items: const [
                                            DropdownMenuItem(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Stock',
                                                  style:
                                                      TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black38),
                                                ),
                                              ),
                                              value: 'stock',
                                            ),
                                            DropdownMenuItem(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Prod',
                                                  style:
                                                      TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black38),
                                                ),
                                              ),
                                              value: 'prod',
                                            ),
                                            DropdownMenuItem(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Qualité',
                                                  style:
                                                      TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black38),
                                                ),
                                              ),
                                              value: 'qualité',
                                            ),
                                            DropdownMenuItem(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Planning',
                                                  style:
                                                      TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black38),
                                                ),
                                              ),
                                              value: 'planning',
                                            ),
                                            DropdownMenuItem(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Logistique',
                                                  style:
                                                      TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black38),
                                                ),
                                              ),
                                              value: 'logistique',
                                            ),
                                            DropdownMenuItem(
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Achat',
                                                  style:
                                                      TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black38),
                                                ),
                                              ),
                                              value: 'achat',
                                            ),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              dep = value!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  height: Constants.screenHeight * 0.06,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[200],
                                  ),
                                  child: DropdownButton<User>(
                                    isExpanded: true,
                                    value: selectedUSer,
                                    hint: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Selectionner destinataire"),
                                    ),
                                    underline: SizedBox(
                                      height: 0,
                                    ),
                                    items: users.map<DropdownMenuItem<User>>((User user) {
                                      return DropdownMenuItem<User>(
                                        key: Key(user.id.toString()),
                                        value: user,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(user.full_name!),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedUSer = value!;
                                      });
                                    },
                                  ),
                                ),
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
        },
      ),
    );
  }
}
