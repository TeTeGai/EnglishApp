
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an/DetailBook.dart';
import 'package:do_an/SeeallPage2.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'ColorScheme.dart';
import 'Dictionary.dart';
import 'HomePage.dart';
import 'Login.dart';
import 'SeeallPage3.dart';
import 'Widgets/app_button.dart';


class BookPage extends StatelessWidget {
  const BookPage({Key? key}) : super(key: key);

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
      body: bookPage(),
    );
  }
}


class bookPage extends StatefulWidget {
  const bookPage({Key? key}) : super(key: key);

  @override
  _bookPageState createState() => _bookPageState();
}



Widget Booklist()
{
  return Container(
    height: 310,
    child:
    StreamBuilder (
      stream: FirebaseFirestore.instance.collection('Book').snapshots(),
      builder: ( context,AsyncSnapshot  snapshot)
      {
        if (!snapshot.hasData){
          print('test phrase');
          return Text("Loading.....");
        }
        else{
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index) {
                DocumentSnapshot doc = snapshot.data!.docs[index];
                return SP(
                  Ten: doc['Ten'],
                  Hinh: doc['Hinh'],
                  Id: doc['Id'],
                  Data: doc['Data'],
                  Link: doc['Link'],
                );
              });
        }
      },
    ),
  );
}

Widget Booklist2()
{
  return Container(
    height:310,
    child:
    StreamBuilder (
      stream: FirebaseFirestore.instance.collection('Book2').snapshots(),
      builder: ( context,AsyncSnapshot  snapshot)
      {
        if (!snapshot.hasData){
          print('test phrase');
          return Text("Loading.....");
        }
        else{
          return ListView.builder(
            scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index) {
                DocumentSnapshot doc = snapshot.data!.docs[index];
                return SP(
                  Ten: doc['Ten'],
                  Hinh: doc['Hinh'],
                  Id: doc['Id'],
                  Data: doc['Data'],
                  Link: doc['Link'],
                );
              });
        }
      },
    ),
  );
}

class _bookPageState extends State<bookPage> {


  //
  // @override
  // void initState() {
  //   SPProvider sspProvider = Provider.of(context, listen: false);
  //   sspProvider.dsSPRauData();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
     // spProvider = Provider.of(context);
    User? user = FirebaseAuth.instance.currentUser;
    String? userProfile;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Expanded(
                  child: ListView(
                      children: [
                        Container(
                           padding: EdgeInsets.all(10),
                          child: Text('"The more that you read, the more things you will know.The more that you learn, the more places you’ll go."',style: TextStyle(fontSize: 20),),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage("https://png.pngtree.com/thumb_back/fh260/back_our/20190617/ourmid/pngtree-bird-book-tree-small-fresh-poster-banner-image_125954.jpg"))),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Top rate Turors"),
                            FlatButton(
                                onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SeeallPage3(),));
                                },
                                child: Text(
                                  "See all",
                                )),
                          ],
                        ),

                        Column(
                          children: [
                            Booklist2(),
                          ],
                        ),


                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Top rate Turors"),
                            FlatButton(
                                onPressed: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SeeallPage2(),));
                                },
                                child: Text(
                                  "See all",
                                )),

                          ],
                        ),

                        Column(
                          children: [
                            Booklist(),
                          ],
                        ),





                      ],
                    ),

                ),
          ],
        ),
      );
  }

}

class SP extends StatelessWidget {
  final String Ten, Hinh,Id,Link,Data;


    SP(
      {required this.Ten,
        required this.Hinh,
        required this.Id,
        required this.Link,
        required this.Data,
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ()
        {
          Navigator.push(context, MaterialPageRoute(
              builder: (context)=>ProductOverview(Ten,Hinh,Id,Link,Data)));
        },
        child: Container(
          margin: EdgeInsets.only(left: 10,right: 10),
          height: 300,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(Hinh,),
             Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(Ten,textAlign: TextAlign.center,),
                    ],
                  ),

            ],
          ),
        ));
  }
}
