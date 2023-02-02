import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Login.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

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

// void valtion()
// {
//   final FormState? _form = _formkey.currentState;
//   if(_form!.validate())
//   {print("Yes");}
//   else {print("No");}
// }

class _Tao extends State<register> {
  void Taotk() async {
    final FormState? _form = _formkey.currentState;
    if (_form!.validate()) {
      try {
        UserCredential firebaseauth = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: pass);
        print(firebaseauth);
      } on PlatformException catch (e) {
        print(e.message.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class _registerState extends State<register> {
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
                      "Đăng ký tài khoản",
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Username",
                      ),
                      validator: (value) {
                        if (value!.length < 6) {
                          return "Username Is To Short";
                        } else if (value.length == "") {
                          return "Please Fill Username";
                        }
                      },
                    ),
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
                          String p =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regExp = new RegExp(p);
                          if (value!.length == "") {
                            return "Please Fill Email";
                          } else if (!regExp.hasMatch(value)) {
                            return "Email is Invaild";
                          }
                          return "";
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
                          if (value!.length < 6) {
                            return "Pasword Is To Short";
                          } else if (value.length == "") {
                            return "Please Fill Pasword";
                          }
                        }),
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: "Password 2",
                          suffixIcon: GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                            },
                            child: Icon(Icons.visibility),
                          ),
                        ),
                        validator: (value) {
                          if (value!.length < 6) {
                            return "Pasword Is To Short";
                          } else if (value.length == "") {
                            return "Please Fill Pasword";
                          }
                        }),
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: "Phone",
                        ),
                        validator: (value) {
                          if (value!.length == "") {
                            return "Please Fill Phone";
                          }
                        }),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.blue,
                        child: FlatButton(
                            onPressed: () async {
                              try {
                                UserCredential firebaseauth = await FirebaseAuth
                                    .instance
                                    .createUserWithEmailAndPassword(
                                        email: email, password: pass);
                                print(firebaseauth);
                              } on PlatformException catch (e) {
                                print(e.message.toString());
                              }
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(color: Colors.white),
                            ))),
                    Row(
                      children: [
                        Text("I have Already an Account!"),
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
                        )
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
