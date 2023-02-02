import 'package:do_an/HomePage.dart';
import 'package:do_an/LoginTeacher.dart';
import 'package:do_an/Provider/MyProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'ColorScheme.dart';
import 'Register.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return register();
  }
}

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  _registerState createState() => _registerState();
}

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
bool textpass = true;
late String email;
late String pass;




class _registerState extends State<register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('asset/img/splash.png'),
                        fit: BoxFit.contain)),
              ),
              Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "WHERE YOU LOVE LEARNING",
                        style: TextStyle(fontSize: 27),
                      ),
                      Text(
                        "Distant Learning & Home \n Shooling Made Easy",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "Book Filtered Top Rated proffesional  \n Tutors form the confort \n Of your home in just a few clicks",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                      Center(
                            child: InkWell(
                              onTap: () async {
                                await signInWithGoogle();
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context)=>homePage()));
                              },
                              child: Ink(
                                color: Colors.blue,
                                child: Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      Icon(Icons.android,color: Colors.teal,), // <-- Use 'Image.asset(...)' here
                                      SizedBox(width: 12),
                                      Text('Sign in with Google',style: TextStyle(color: Colors.white),),
                                    ],
                                  ),
                                ),
                              ),
                            )
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Text(
                        //         "Or you are Teacher?",
                        //         textAlign: TextAlign.center,
                        //         style: TextStyle(fontSize: 18),
                        //       ),
                        //       SizedBox(
                        //         width: 10,
                        //       ),
                        //       GestureDetector(
                        //         onTap: () {
                        //           Navigator.push(context, MaterialPageRoute(
                        //               builder: (context)=>LoginTeacher()));
                        //         },
                        //         child: Text(
                        //           "Login",
                        //           style: TextStyle(fontSize: 20, color: Colors.blue),
                        //         ),
                        //       ),
                        //   ],
                        // )
                      ),


                    ]))
            ],
          )),
    );
  }
   }


final FirebaseAuth _auth = FirebaseAuth.instance;
Future<void> signInWithGoogle() async {
  GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
  GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount!.authentication;
  AuthCredential authCredential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken);

  final UserCredential authResult =
  await _auth.signInWithCredential(authCredential);
  final User? user = authResult.user;
  MyProvider myProvider = MyProvider();
  myProvider.addUserData(
      currentUser: user!,
      userName: user.displayName,
      userImage: user.photoURL,
      userEmail: user.email);
}