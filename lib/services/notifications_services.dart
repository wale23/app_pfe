import 'dart:convert';
import 'dart:ui';

import 'package:app_pfe/models/notification.dart';
import 'package:app_pfe/services/api_constants.dart';
import 'package:app_pfe/services/call_api.dart';
import 'package:get_storage/get_storage.dart';

class NotificationsServices {
  static var user = GetStorage().read("user");
  static Future<bool> deleteNotifications(data, VoidCallback test) async {
    var body = jsonEncode(data);
    try {
      var response = await CallApi().postData(ApiConstants.deleteNotif, body);
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

  static Future<List<FirebaseNotification>> myNotifications() async {
    try {
      dynamic url = ApiConstants.myNotifications + "/${user["id"]}";
      var response = await CallApi().getData(url);

      if (response.statusCode == 200) {
        var result = jsonDecode(utf8.decode(response.bodyBytes));
        List<FirebaseNotification> listOfCompanies = [];
        for (var data in result) {
          listOfCompanies.add(FirebaseNotification.fromJson(data));
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
