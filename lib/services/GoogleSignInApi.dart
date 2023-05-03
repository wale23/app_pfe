import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final _googlesSignIn = GoogleSignIn();
  static GoogleSignInAccount? getUserData() => _googlesSignIn.currentUser;
  static Future<GoogleSignInAccount?> login() => _googlesSignIn.signIn();
  static Future logout() => _googlesSignIn.disconnect();
}

