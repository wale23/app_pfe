import 'package:app_pfe/models/User.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FaceBookApis {
  static Future<User> getDataFromFacebook() async {
    try {
      final result = await FacebookAuth.i.login(permissions: ["public_profile", "email"]);
      if (result.status == LoginStatus.success) {
        final requestData = await FacebookAuth.i.getUserData(fields: "name,email,picture");
        print(requestData);
        return User(full_name: requestData['name'], email: requestData['email']);
      }
      return User.fromJson({});
    } catch (e) {
      print(e.toString());
      return User.fromJson({});
    }
  }
}
