import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an/HomePage.dart';
import 'package:do_an/StudyPage.dart';
import 'package:do_an/Teacher/TeacherVocabularyPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:do_an/ColorScheme.dart';
import 'package:do_an/SeeallPage.dart';
import 'package:do_an/Bien/Khoahoc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'Detail.dart';
import 'Dictionary.dart';
import 'Login.dart';
import 'Provider/MyProvider.dart';
import 'Widgets/app_button.dart';

class HomePage1 extends StatelessWidget {
  const HomePage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
        home: Scaffold(
          drawer: Drawer(
            child: Container(
              color: lightBlue,
              child: Column(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text("${user!.displayName}",style: TextStyle(fontSize: 20,color: Colors.blueGrey),),
                    accountEmail: Text("${user!.email}",style: TextStyle(fontSize: 18,color: Colors.blueGrey)),
                    currentAccountPicture:  CircleAvatar(
                      backgroundImage: NetworkImage(
                          "${user!.photoURL}"),
                    ),
                    decoration: BoxDecoration(
                      color: lightBlue,
                    ),
                  ),
                  app_button(label: "Home", onTap: (){
                    Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => new homePage()));
                  }),
                  SizedBox(height: 20,),
                  app_button(label: "Dictionary", onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => new Dictionary()));
                  }),
                  SizedBox(height: 20,),
                  app_button(label: "Logout", onTap: () async {
                    GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signOut();
                    Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => new Login()));
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 80),
                    child: Text("English APP",style: TextStyle(fontSize: 50,color: Colors.blueGrey),),
                  ),
                ],
              ),
            ),
          ),
          appBar: AppBar(
            backgroundColor: lightBlue,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            actions: [
              IconButton(
                // onPressed: () => Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => new Dictionary())),
                  onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context) => Dictionary(),)),
                  icon: Icon(Icons.search))
            ],
          ),
          body: homePage1(),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          '/SeeallPage': (context) => SeeallPage(),
          // '/Detail':(context)=>Details()},
        });
  }
}

class homePage1 extends StatefulWidget {
  const homePage1({Key? key}) : super(key: key);

  @override
  _homePage1State createState() => _homePage1State();
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
      builder: ( context,AsyncSnapshot  snapshot)
      {
        if (!snapshot.hasData){
          print('test phrase');
          return Text("Loading.....");
        }
        else{
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
        }

      },
    ),
  );
}

class _homePage1State extends State<homePage1> {


  String? userProfile;
  // Future<void> inputData() async {
  //
  //   setState(() {
  //     final User? user = _ath.currentUser;
  //     userProfile = user!.displayName;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(

        builder: (context, snapshot) {

          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: lightBlue,

            body: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("asset/img/searchBg.png"))),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "Nice to meet you",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Expanded(child: Container()),
                        Container(
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [

                              Expanded(
                                child: Center(child: Text("How are you today",style: TextStyle(fontSize: 30, color: Colors.teal),))
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.all(30),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Top rate Turors"),
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                  return SeeallPage();
                                },));
                              },
                              child: Text(
                                "See all",
                              )),
                        ],
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          children: [
                           khoahoclist()
                          ],
                        ),
                      ))
                    ],
                  ),
                )),
              ],
            ),
          );
        });
  }


  void openDetails() {
    Navigator.pushNamed(context, '/Details');
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
                      Text("$title\n",style: TextStyle(fontSize: 18),),
                      Text("$description\n",style: TextStyle(fontSize: 15)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
