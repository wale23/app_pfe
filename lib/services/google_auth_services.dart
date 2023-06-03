import 'package:app_pfe/models/User.dart';

import 'GoogleSignInApi.dart';

class GoogleAuthServices {
  Future<User> getDataFromGoogle() async {
    try {
      SignOutGoogle();
      final data = await GoogleSignInApi.login();
      print("${data}here data");
      return User(
        full_name: data!.displayName,
        email: data.email,
      );
    } catch (e) {
      print("error here" + e.toString());
      return User();
    }
  }

  void SignOutGoogle() async {
    try {
      final data = await GoogleSignInApi.logout();
      print("-----${data}");
    } catch (e) {
      print(e.toString());
    }
  }
}
