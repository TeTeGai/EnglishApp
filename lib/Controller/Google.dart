import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Google with ChangeNotifier{
  var googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;
  login()  async {
    this.googleSignInAccount = await googleSignIn.signIn();
}
  logout()  async {
    this.googleSignInAccount = await googleSignIn.signOut();
  }
}