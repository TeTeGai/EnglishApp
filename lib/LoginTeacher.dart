import 'package:do_an/Teacher/TeacherHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'HomePage.dart';
import 'Login.dart';
class LoginTeacher extends StatelessWidget {
  const LoginTeacher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return loginTeacher();
  }
}
class loginTeacher extends StatefulWidget {
  const loginTeacher({Key? key}) : super(key: key);

  @override
  _loginTeacherState createState() => _loginTeacherState();
}
bool textpass = true;
late String email;
late String pass;

class _loginTeacherState extends State<loginTeacher> {
  @override
  Widget build(BuildContext context) {
        return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Teacher Login",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 400,
                width: MediaQuery.of(context).size.width - 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    TextFormField(
                        onChanged: (value) {
                          setState(() {
                            email = value;
                            print(email);
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                        ),
                        validator: (value) {
                          validator: (value) => value!.isEmpty ? 'Email cannot be blank' : null;
                        }),
                    TextFormField(
                        onChanged: (value) {
                          setState(() {
                            pass = value;
                            print(pass);
                          });
                        },
                        obscureText: textpass,
                        decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                textpass = !textpass;
                              });
                              FocusScope.of(context).unfocus();
                            },
                            child: Icon(
                              Icons.visibility,
                            ),
                          ),
                        ),
                        validator: (value) {
                          validator: (value) => value!.isEmpty ? 'Email cannot be blank' : null;
                        }),

                    Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.blue,
                        child: FlatButton(
                            onPressed: () async {
                              try {
                                UserCredential firebaseauth = await FirebaseAuth
                                    .instance
                                    .signInWithEmailAndPassword(
                                    email: email, password: pass).then((value) {
                                      Navigator.push(context, MaterialPageRoute(
                                      builder: (context)=>TeacherHomePage()));
                                      return value;
                                });
                                print(firebaseauth);
                              } on PlatformException catch (e) {

                              }
                              Fluttertoast.showToast(
                                msg: "Dang nhap thanh cong",
                                fontSize: 20,
                              );

                            },
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Or login with Google?",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=>Login()));
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 20, color: Colors.blue),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

