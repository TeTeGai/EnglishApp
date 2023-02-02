import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an/Bien/Tuvung.dart';
import 'package:do_an/CreateQuiz.dart';
import 'package:do_an/Provider/MyProvider.dart';
import 'package:do_an/Teacher/TeacherHomePage.dart';
import 'package:do_an/Widgets/app_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:translator/translator.dart';


import 'package:flutter/material.dart';

import '../ColorScheme.dart';
import '../Login.dart';
import '../TestPage.dart';


class TeacherVocabularyPage extends StatelessWidget {
  const TeacherVocabularyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  vocabularyPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class vocabularyPage extends StatefulWidget {
  const vocabularyPage({Key? key}) : super(key: key);

  @override
  _vocabularyPageState createState() => _vocabularyPageState();
}

class _vocabularyPageState extends State<vocabularyPage> {
  Stream ? quizStream;

  MyProvider myProvider = new MyProvider();

  Widget testList()
  {
    return Container(
      child:
      StreamBuilder (
        stream: FirebaseFirestore.instance.collection('Quiz').snapshots(),
        builder: (  context,AsyncSnapshot snapshot)
        {
          if (!snapshot.hasData){
            print('test phrase');
            return Text("Loading.....");
          }
          else
          {
            return ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,index) {
                  DocumentSnapshot doc = snapshot.data!.docs[index];
                  return Test(
                    noOfQuestions: snapshot.data!.docs.length,
                    imageUrl: doc['quizImgUrl'],
                    title: doc['Title'],
                    description: doc['quizDesc'],
                    id: doc["quizID"],

                  );
                });
          }

        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      child:  Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: lightBlue,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
              ),drawer: Drawer(

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

              body: testList(),
          floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context)=> CreateQuiz()));
        }
    ),
          ),

    );
  }
}


class Test extends StatelessWidget {
  final String imageUrl, title, description, id;
  final int noOfQuestions;

  Test(
      {required this.title,
        required this.imageUrl,
        required this.description,
        required this.id,
        required this.noOfQuestions,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ()
        {
          Navigator.push(context, MaterialPageRoute(
              builder: (context)=>TestPage(id)));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          height: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  color: Colors.black26,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 4,),
                        Text(
                          description,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}


