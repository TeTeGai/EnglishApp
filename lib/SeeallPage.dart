import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an/HomePage.dart';
import 'package:do_an/Widgets/GoogleLogin.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'Bien/Khoahoc.dart';
import 'ColorScheme.dart';
import 'Detail.dart';

import 'Login.dart';
import 'Provider/MyProvider.dart';
import 'Widgets/app_button.dart';

class SeeallPage extends StatelessWidget {
  const SeeallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: seeallPage(),
    );
  }
}

class seeallPage extends StatefulWidget {
  const seeallPage({Key? key}) : super(key: key);

  @override
  _seeallPageState createState() => _seeallPageState();
}

List<Khoahoc> khoahocList = [];
Stream ? quizStream;

MyProvider myProvider = new MyProvider();

Widget khoahoclist()
{
  return Container(
    child:
    StreamBuilder (
      stream: FirebaseFirestore.instance.collection('Class').snapshots(),
      builder: ( context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot)
      {
        return ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index) {
              DocumentSnapshot doc = snapshot.data!.docs[index];
              return classroom(
                  title: doc['Title'],
                  imageUrl: doc['classImgUrl'],
                  description: doc['classDesc'],
                  id: doc['classID'],
                  time: doc['classTime'],
                  noOfQuestions: snapshot.data!.docs.length);
            });
      },
    ),
  );
}

class _seeallPageState extends State<seeallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(
      //
      //   child: Container(
      //     color: lightBlue,
      //     child: Column(
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 70),
      //           child: Text("English APP",style: TextStyle(fontSize: 50,color: Colors.blueGrey),),
      //         ),
      //         app_button(label: "Home", onTap: (){
      //           Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => new homePage()));
      //         }),
      //         SizedBox(height: 20,),
      //         app_button(label: "Logout", onTap: () async {
      //           GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signOut();
      //           Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => new Login()));
      //         }),
      //       ],
      //     ),
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: lightBlue,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 30,

          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => new homePage()));
          },
        ),

      ),
      body: SingleChildScrollView(
          child: khoahoclist()
      ),
    );
  }
}

class classroom extends StatelessWidget {
  final String imageUrl, title, description, id,time;
  final int noOfQuestions;

  classroom(
      {required this.title,
        required this.imageUrl,
        required this.description,
        required this.id,
        required this.time,
        required this.noOfQuestions,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()
        {
          Navigator.push(context, MaterialPageRoute(
              builder: (context)=>Detail(id)));
        },
        child: Container(
          margin: EdgeInsets.only(top: 20),
          height: 130,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: lightBlue.withOpacity(0.5)),
          child: Row(
            children: [
              Container(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(30)),
                      child: Container(
                        height: 120,
                        width: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('asset/img/iconBgNew.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      left: 50,
                      child: Container(
                        width: 100,
                        height: 130,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(imageUrl), fit: BoxFit.cover)),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(time),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("$title\n"),
                      Text("$description\n"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
