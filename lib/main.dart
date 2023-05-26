import 'dart:io';

import 'package:app_pfe/views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'services/api_constants.dart';

void main() async {
  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class UploadImages extends StatefulWidget {
  const UploadImages({Key? key}) : super(key: key);

  @override
  State<UploadImages> createState() => _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> {
  List<File> _selectedImages = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final ImagePicker _picker = ImagePicker();
            try {
              final List<XFile> selectedImages = await _picker.pickMultiImage(imageQuality: 50);
              setState(() {
                _selectedImages = selectedImages.map((e) => File(e.path)).toList();
              });
            } catch (e) {
              print(e);
            }
          },
          child: Icon(Icons.add),
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  try {
                    final request = http.MultipartRequest('POST', Uri.parse(ApiConstants.baseUrl + ApiConstants.upload));
                    for (var i = 0; i < _selectedImages.length; i++) {
                      final file = await _selectedImages[i].path;
                      request.files.add(await http.MultipartFile.fromPath('images', file));
                    }
                    final response = await request.send();
                    if (response.statusCode == 200) {
                      var responseBody = await response.stream.bytesToString();
                    } else {
                      throw Exception('Failed to upload images test: ${response.statusCode}');
                    }
                  } catch (e) {
                    print(e.toString());
                  }
                },
                child: Text("Ajouter")),
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
                    child: Stack(
                      fit: StackFit.expand,
                      alignment: Alignment.center,
                      children: [
                        Image.file(
                          _selectedImages[index],
                          fit: BoxFit.cover,
                        ),
                        Text(_selectedImages[index].path.split(".").last)
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
