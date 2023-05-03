import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:app_pfe/models/comment.dart';
import 'package:app_pfe/models/reclamation.dart';
import 'package:app_pfe/services/api_constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'call_api.dart';

class ReclamationsServices {
  var user = GetStorage().read('user');

  Future<List<Reclamation>> getReclamations([String? type]) async {
    try {
      dynamic url =
          type != null ? ApiConstants.reclamations + "/${user["id"]}/$type" : ApiConstants.reclamations + "/${user["id"]}";
      var response = await CallApi().getData(url);

      print(response.statusCode);
      if (response.statusCode == 200) {
        var result = jsonDecode(utf8.decode(response.bodyBytes));
        print(result);
        List<Reclamation> listOfCompanies = [];
        for (var data in result) {
          listOfCompanies.add(Reclamation.fromJson(data));
        }
        return listOfCompanies;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<Reclamation>> archived() async {
    try {
      dynamic url = ApiConstants.archived + "/${user["id"]}";
      var response = await CallApi().getData(url);

      print(response.statusCode);
      if (response.statusCode == 200) {
        var result = jsonDecode(utf8.decode(response.bodyBytes));
        print(result);
        List<Reclamation> listOfCompanies = [];
        for (var data in result) {
          listOfCompanies.add(Reclamation.fromJson(data));
        }
        return listOfCompanies;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  static Future<bool> deleteReclamation(data, VoidCallback test) async {
    var body = jsonEncode(data);
    try {
      var response = await CallApi().postData(ApiConstants.delete, body);
      if (response.statusCode == 200) {
        test();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<bool> archiveReclamation(bool archive, data, VoidCallback test) async {
    var body = jsonEncode(data);
    try {
      var response = await CallApi().postData(ApiConstants.archive + "/$archive", body);
      if (response.statusCode == 200) {
        test();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future<bool> changeStatus(String status, int id, VoidCallback test) async {
    try {
      var response = await CallApi().getData(ApiConstants.changeStatus + "/$id/$status");
      if (response.statusCode == 200) {
        test();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Future createReclamation(String subject, String desc, int priority, List<File> images) async {
    if (images.isEmpty) {
      try {
        Map<String, dynamic> data = {
          "subject": subject,
          "user_id": GetStorage().read('user')['id'],
          "priority": priority,
          "description": desc,
          "subject": subject,
          "images": []
        };
        var body = jsonEncode(data);
        print(priority);
        dynamic url = ApiConstants.addReclamation;
        var response = await CallApi().postData(url, body);

        print(response.statusCode);

        var result = jsonDecode(response.body);
        print(result);
      } catch (e) {
        print(e.toString());
      }
    } else {
      try {
        final request = http.MultipartRequest('POST', Uri.parse(ApiConstants.baseUrl + ApiConstants.upload));
        for (var i = 0; i < images.length; i++) {
          final file = await images[i].path;
          request.files.add(await http.MultipartFile.fromPath('images', file));
        }
        final response = await request.send();
        if (response.statusCode == 200) {
          var responseBody = await response.stream.bytesToString();
          print(jsonDecode(responseBody));
          try {
            Map<String, dynamic> data = {
              "subject": subject,
              "user_id": GetStorage().read('user')['id'],
              "priorirty": priority,
              "description": desc,
              "subject": subject,
              "images": jsonDecode(responseBody)
            };
            var body = jsonEncode(data);

            dynamic url = ApiConstants.addReclamation;
            var response = await CallApi().postData(url, body);

            print(response.statusCode);

            var result = jsonDecode(response.body);
            print(result);
          } catch (e) {
            print(e.toString());
          }
        } else {
          throw Exception('Failed to upload images: ${response.statusCode}');
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<List<Comments>> getComments(int id) async {
    try {
      dynamic url = ApiConstants.comments + "/${id}";
      var response = await CallApi().getData(url);

      print(response.statusCode);
      if (response.statusCode == 200) {
        var result = jsonDecode(utf8.decode(response.bodyBytes));
        print(result);
        List<Comments> listOfCompanies = [];
        for (var data in result) {
          listOfCompanies.add(Comments.fromJson(data));
        }
        return listOfCompanies;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  static Future createComment(String comment, int reclamationId, VoidCallback test) async {
    try {
      dynamic url = ApiConstants.comment;
      Map<String, dynamic> data = {
        "user_id": GetStorage().read('user')['id'],
        'comment': comment,
        'reclamation_id': reclamationId
      };
      var body = jsonEncode(data);
      var response = await CallApi().postData(url, body);
      print(response.body);
      test();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<Reclamation>> getReclamationsAdmin() async {
    try {
      dynamic url = ApiConstants.all;
      var response = await CallApi().getData(url);

      print(response.statusCode);
      if (response.statusCode == 200) {
        var result = jsonDecode(utf8.decode(response.bodyBytes));
        print(result);
        List<Reclamation> listOfCompanies = [];
        for (var data in result) {
          listOfCompanies.add(Reclamation.fromJson(data));
        }
        return listOfCompanies;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List<Reclamation>> getReclamationsAdminByStatus(String status) async {
    try {
      dynamic url = ApiConstants.bystatus + "/$status";
      var response = await CallApi().getData(url);

      print(response.statusCode);
      if (response.statusCode == 200) {
        var result = jsonDecode(utf8.decode(response.bodyBytes));
        print(result);
        List<Reclamation> listOfCompanies = [];
        for (var data in result) {
          listOfCompanies.add(Reclamation.fromJson(data));
        }
        return listOfCompanies;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
