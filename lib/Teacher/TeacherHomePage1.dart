import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an/CreateClass.dart';
import 'package:do_an/Provider/MyProvider.dart';
import 'package:do_an/Widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:do_an/ColorScheme.dart';
import 'package:do_an/SeeallPage.dart';
import 'package:do_an/Bien/Khoahoc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Detail.dart';
import '../Login.dart';
import 'TeacherHomePage.dart';


class TeacherHomePage1 extends StatelessWidget {
  const TeacherHomePage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: homePage1(),
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
      builder: ( context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot)
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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(

        builder: (context, snapshot) {

          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: lightBlue,
            drawer: Drawer(

              child: Container(
                color: lightBlue,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 70),
                      child: Text("English APP",style: TextStyle(fontSize: 50,color: Colors.blueGrey),),
                    ),
                    app_button(label: "Home", onTap: (){
                      Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => new TeacherHomePage()));
                    }),
                    SizedBox(height: 20,),
                    app_button(label: "Logout", onTap: () async {
                      GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signOut();
                      Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => new Login()));
                    }),
                  ],
                ),
              ),
            ),
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
            ),
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
                                  onPressed: openSeeallPage,
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
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context)=> CreateClass()));
                }
            ),
          );
        });
  }

  void openSeeallPage() {
    Navigator.pushNamed(context, '/SeeallPage');
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
                    Container(
                      height: 130,
                      padding: EdgeInsets.only(left: 5, top: 5),
                      child: Stack(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            child: RotatedBox(
                              quarterTurns: 2,
                              child: Icon(
                                Icons.star,
                                color: darkBlue,
                                size: 60,
                              ),
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            child: Center(
                              child: Text("4.5"),
                            ),
                          ),
                        ],
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
