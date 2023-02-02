import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an/Bien/Tuvung.dart';
import 'package:do_an/Provider/MyProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:translator/translator.dart';

import 'ColorScheme.dart';
import 'package:flutter/material.dart';

import 'Dictionary.dart';
import 'HomePage.dart';
import 'Login.dart';
import 'QuizPage.dart';
import 'TestPage.dart';
import 'Widgets/app_button.dart';

class VocabularyPage extends StatelessWidget {
  const VocabularyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: lightBlue,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              bottom: TabBar(
                labelColor: Colors.black,
                  tabs: [
                Tab(
                  text: "Test",
                ),
                Tab(
                  text: "Trans",
                ),
              ]),
              actions: [
                IconButton(
                  // onPressed: () => Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => new Dictionary())),
                    onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context) => Dictionary(),)),
                    icon: Icon(Icons.search))
              ],
            ),
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
            resizeToAvoidBottomInset: false,
            body: TabBarView(
              children: [
                vocabularyPage(),
                Trans(),
              ],
            ),
          )),
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

      child: Scaffold(
        // backgroundColor: lightBlue,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: testList(),
        )
      ),
    );
  }
}
//
// class Quizpage extends StatefulWidget {
//   const Quizpage({Key? key}) : super(key: key);
//
//   @override
//   _QuizpageState createState() => _QuizpageState();
// }
//
// class _QuizpageState extends State<Quizpage> {
//   Stream ? quizStream;
//
//   MyProvider myProvider = new MyProvider();
//
//   Widget quizList()
//   {
//     return Container(
//       child:
//       StreamBuilder (
//         stream: FirebaseFirestore.instance.collection('QuizImg').snapshots(),
//         builder: (  context,AsyncSnapshot snapshot)
//         {
//           if (!snapshot.hasData){
//             print('test phrase');
//             return Text("Loading.....");
//           }
//           else
//           {
//             return GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//                 shrinkWrap: true,
//                 physics: ClampingScrollPhysics(),
//                 itemCount: snapshot.data!.docs.length,
//                 itemBuilder: (context,index) {
//                   DocumentSnapshot doc = snapshot.data!.docs[index];
//                   return Test1(
//                     noOfQuestions: snapshot.data!.docs.length,
//                     imageUrl: doc['quizImage'],
//                     title: doc['Title'],
//                     id: doc["quizImgID"],
//                   );
//                 });
//           }
//         },
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: Scaffold(
//         // backgroundColor: lightBlue,
//           body:  quizList()
//       ),
//     );
//   }
// }


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
//
// class Test1 extends StatelessWidget {
//   final String imageUrl, title, id;
//   final int noOfQuestions;
//
//   Test1(
//       {required this.title,
//         required this.imageUrl,
//         required this.id,
//         required this.noOfQuestions,});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: (){
//         Navigator.push(context, MaterialPageRoute(
//             builder: (context)=>QuizImg(id)));
//       },
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Container(
//             width: 180,
//             height: 170,
//             child: DecoratedBox(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(20)),
//                   color: Colors.brown,
//                   image: DecorationImage(
//                     image: NetworkImage(imageUrl),
//                   )),
//             ),
//           ),
//           Text(title)
//         ],
//       ),
//     );
//   }
// }



class Trans extends StatefulWidget {
  const Trans({Key? key}) : super(key: key);

  @override
  _TransState createState() => _TransState();
}

String output = "hello";
final input = TextEditingController();

class _TransState extends State<Trans> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                obscureText: false,
                controller: input,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Input",
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                trans();
              },
              child: Text("Translate"),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  output.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 30),
                )),
              ),
            ),
          ],
        ));
  }

  Future<void> trans() async {
    GoogleTranslator _googleTranslator = new GoogleTranslator();
    String c1 = input.text;
    var tranlation = {await c1.translate(to: 'vi')};

    setState(() {
      var h = tranlation.toList();
      output = h[0].toString();
    });
  }
}
