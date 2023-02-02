
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GG extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: Container(
          height: 60,
          width: 80,
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8))
          ),
          child: TextButton(
            onPressed: ()=>signInWithGoogle(),
            child: Text("Google",style: TextStyle(color: Colors.black),),
          ),
        ),
      ),
    );
  }
}
Future<UserCredential> signInWithGoogle() async {
  final GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();

  final GoogleSignInAuthentication googleAuth = await googleuser!.authentication;

  final
  OAuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken
  );
  // Fluttertoast.showToast(msg: "Account created");
  return await FirebaseAuth.instance.signInWithCredential(credential);


}