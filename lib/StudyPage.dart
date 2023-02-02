import 'dart:math';

import 'package:do_an/Bien/Cautienganh.dart';
import 'package:do_an/Bien/Tuvung(Card).dart';
import 'package:do_an/Controller/Quotes.dart';
import 'package:do_an/HomePage.dart';
import 'package:do_an/HomePage1.dart';
import 'package:do_an/Widgets/app_button.dart';
import 'package:english_words/english_words.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:do_an/ColorScheme.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'Controller/Restart.dart';
import 'Dictionary.dart';
import 'Login.dart';

class StudyPage extends StatelessWidget {
  const StudyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
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
          body:  studyPage(),

    );
  }
}

class studyPage extends StatefulWidget {
  const studyPage({Key? key}) : super(key: key);

  @override
  _studyPageState createState() => _studyPageState();
}

class _studyPageState extends State<studyPage> {
  int _currentIdex=0;
  PageController  _pageController = PageController();
  List<CardEnglish> words = [];
  List<int> fixedListRandom ({int len=1, int max = 120, int min =1})
  {
    if(len>max || len <min)
     {
       return [];
     }
    Random random = new Random();
    List<int> newList = [];
    int count =1;
    while(count <= len)
    {
      int val = random.nextInt(max);
      if(newList.contains(val))
        {
          continue;
        }
      else{
        newList.add(val);
        count++;
      }
    }
    return newList;
  }
  getCard()
  {
    List<String> newlist = [];
    List<int> rans = fixedListRandom(len: 5,max: nouns.length);
    rans.forEach((index) {
      newlist.add(nouns[index]);
    });
    words = newlist.map((e) => getQuote(e)).toList();
  }
  CardEnglish getQuote(String noun)
  {
    Quote? qoute;
    qoute = Quotes().getbyNoun(noun);
    return CardEnglish(noun: noun, quote: qoute?.content, id: qoute?.id);
  }
  @override
  void initState() {
    // TODO: implement initState
    _pageController =PageController(viewportFraction: 0.9);
    getCard();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
      body: Container(
            height: size.height,
            padding: EdgeInsets.all(10),
             child: Column(
               children: [
                 Container(child: Text('"It doesn’t matter how slowly you go as long as you do not stop."',
                   style: TextStyle(fontSize: 20),)),
                 SizedBox(height: 20,),
                 Container(
                   padding: EdgeInsets.all(5),
                   height: size.height *1/1.8,
                   child: PageView.builder(
                     controller:  _pageController,
                     onPageChanged: (value) {
                       setState(() {
                         _currentIdex = value;
                       });
                     },
                     itemCount: words.length,
                     itemBuilder:(context, index) {
                       String? firstword = words[index].noun != null  ? words[index].noun : '';
                       firstword =firstword!.substring(0,1);

                       String? leftword = words[index].noun != null  ? words[index].noun : '';
                       leftword =leftword!.substring(1,leftword!.length);
                       String quotesdefault = "Think of all the beauty still left around you and be happy";
                       String qoute = words[index].quote !=null ? words[index].quote! : quotesdefault;
                       return Container(
                         margin: EdgeInsets.all(10),
                         decoration: BoxDecoration(
                           color: lightBlue,
                           borderRadius: BorderRadius.circular(10),
                         ),
                         child: SingleChildScrollView(
                           child: Column(
                             children: [
                              RichText(text: TextSpan(
                                text: firstword,style: TextStyle(
                                  fontSize: 90,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.lightBlue,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black38,
                                      offset: Offset(3,6),
                                      blurRadius: 6
                                    )
                                  ]),
                                children: [
                                  TextSpan(
                                    text:  leftword,style: TextStyle(
                                  fontSize: 56,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.lightBlue,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black38,
                                        offset: Offset(3,6),
                                        blurRadius: 6
                                    )
                                  ]),
                                  )
                                ]
                              )),
                               Padding(
                                 padding: EdgeInsets.all( 20),
                                 child: Text('"$qoute"',
                                   style: TextStyle(color: Colors.lightBlue,fontSize: 30,letterSpacing: 2)),
                               )
                             ],
                           ),
                         ),
                       );
                     },
                   ),
                 ),
                 Container(
                   height: 12,
                   child: ListView.builder(
                     scrollDirection: Axis.horizontal,
                     itemCount: 5,
                     itemBuilder: (context, index) {
                     return buildIndicator(index ==_currentIdex , size);

                   },),
                 ),

               ],

             ),




      ) ,
      floatingActionButton: FloatingActionButton(
    child: Icon(Icons.rotate_left),
    onPressed: (){
      setState(() {
        getCard();
      });
    }
    ),
    );
  }
  Widget buildIndicator(bool isCheck,Size size)
  {
    return Container(
      height: 8,
      margin: EdgeInsets.symmetric(horizontal: 19),
      width: isCheck? size.width *1/5 : 24,
      decoration: BoxDecoration(
        color: isCheck? Colors.yellow: Colors.blueGrey,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(2,3),
            blurRadius: 3
          )
        ]
      ),
    );
  }
}
