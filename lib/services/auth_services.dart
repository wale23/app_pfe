import 'dart:convert';

import 'package:app_pfe/models/ApiResponse.dart';
import 'package:app_pfe/models/User.dart';
import 'package:app_pfe/services/api_constants.dart';
import 'package:app_pfe/services/call_api.dart';
import 'package:app_pfe/views/auth/sign_in/SignIn.dart' as signin;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  void saveUserLocally(User currentUser) {
    var user = GetStorage();
    user.write('user', currentUser.toJson());
    user.write("auth", 1);
  }

  Future<ApiResponse> SignUp({required User user}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      var body = jsonEncode(user.toJson());
      http.Response response = await CallApi().postData(ApiConstants.register, body);
      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        User user = User.fromJson(result);
        saveUserLocally(user);
        apiResponse.responseMessage = user.role_id.toString();
        apiResponse.responseStatus = true;
      } else {
        apiResponse.responseMessage = result['message'];
        apiResponse.responseStatus = false;
      }
      return apiResponse;
    } catch (e) {
      apiResponse.responseStatus = false;
      return apiResponse;
    }
  }

  Future<ApiResponse> SignIn({required User user}) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      var body = jsonEncode(user.toJson());
      http.Response response = await CallApi().postData(ApiConstants.login, body);
      var result = jsonDecode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200) {
        User user = User.fromJson(result);
        saveUserLocally(user);
        apiResponse.responseMessage = user.role_id.toString();
        apiResponse.responseStatus = true;
      } else if (response.statusCode == 400) {
        apiResponse.responseMessage = result['error'];
        apiResponse.responseStatus = false;
      } else {
        apiResponse.responseMessage = result['error'];
        apiResponse.responseStatus = false;
      }
      return apiResponse;
    } catch (e) {
      apiResponse.responseStatus = false;
      apiResponse.responseMessage = e.toString();
      return apiResponse;
    }
  }

  Future<ApiResponse> ResetPassword({required String email}) async {
    ApiResponse apiResponse = ApiResponse();

    http.Response response = await CallApi().getData(ApiConstants.resetPassword + "/${email}");
    var result = jsonDecode(utf8.decode(response.bodyBytes));

    apiResponse.responseMessage = result['message'];
    if (response.statusCode == 200) {
      apiResponse.responseStatus = true;
    } else {
      apiResponse.responseStatus = false;
    }
    return apiResponse;
  }

  Future<ApiResponse> CheckOtp({required int code}) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      http.Response response = await CallApi().getData(ApiConstants.checkOtp + "/${code}");
      var result = jsonDecode(utf8.decode(response.bodyBytes));
      print(result);
      apiResponse.responseMessage = result['message'];
      if (response.statusCode == 200) {
        apiResponse.responseStatus = true;
      } else {
        apiResponse.responseStatus = false;
        apiResponse.responseMessage = result['message'];
      }
      return apiResponse;
    } catch (e) {
      apiResponse.responseStatus = false;
      apiResponse.responseMessage = e.toString();
      return apiResponse;
    }
  }

  Future<ApiResponse> ChangePassword({required data}) async {
    ApiResponse apiResponse = ApiResponse();
    var body = jsonEncode(data);
    try {
      http.Response response = await CallApi().postData(ApiConstants.changePassword, body);
      var result = jsonDecode(utf8.decode(response.bodyBytes));
      apiResponse.responseMessage = result['message'];
      if (response.statusCode == 200) {
        apiResponse.responseStatus = true;
      } else {
        apiResponse.responseStatus = false;
        apiResponse.responseMessage = result['message'];
      }
      return apiResponse;
    } catch (e) {
      apiResponse.responseStatus = false;
      apiResponse.responseMessage = e.toString();
      return apiResponse;
    }
  }

  logOut(BuildContext context) {
    GetStorage().remove("user");
    Get.to(signin.SignIn());
  }
}
