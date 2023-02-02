import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an/BookPage.dart';
import 'package:do_an/HomePage.dart';
import 'package:do_an/Widgets/GoogleLogin.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'Bien/Khoahoc.dart';
import 'ColorScheme.dart';
import 'Detail.dart';

import 'DetailBook.dart';
import 'Login.dart';
import 'Provider/MyProvider.dart';
import 'Widgets/app_button.dart';

class SeeallPage3 extends StatelessWidget {
  const SeeallPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: seeallPage3(),
    );
  }
}

class seeallPage3 extends StatefulWidget {
  const seeallPage3({Key? key}) : super(key: key);

  @override
  _seeallPageState3 createState() => _seeallPageState3();
}

MyProvider myProvider = new MyProvider();
Widget Booklist()
{
  return Container(
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

class _seeallPageState3 extends State<seeallPage3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
          },
        ),

      ),
      body: SingleChildScrollView(
          child: Booklist()
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
                                image: NetworkImage(Hinh), fit: BoxFit.cover)),
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
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("$Ten\n"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
