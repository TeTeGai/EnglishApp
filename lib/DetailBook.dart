import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an/ColorScheme.dart';
import 'package:do_an/PDFPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/MyProvider.dart';

enum SinginCharacter { fill, outline }

class ProductOverview extends StatefulWidget {
  final String Ten, Hinh, Id,Link,Data;



  ProductOverview(this.Ten, this.Hinh, this.Id,this.Link,this.Data);

  @override
  _ProductOverviewState createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {


  Widget bonntonNavigatorBar({
    Color? iconColor,
    Color? backgroundColor,
    Color? color,
    String? title,
    IconData? iconData,
    Function? onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: (){},
        child: Container(
          padding: EdgeInsets.all(20),
          color: backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 20,
                color: iconColor,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                title!,
                style: TextStyle(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // bottomNavigationBar: Row(
      //   children: [
      //     bonntonNavigatorBar(
      //         iconColor: Colors.black,
      //         title: "READ",
      //         iconData: Icons.shop_outlined,
      //         onTap: ()
      //         {
      //           Navigator.of(context).push(MaterialPageRoute(builder: (context) => PDFPage(),));
      //         }
      //         ),
      //   ],
      // ),
      appBar: AppBar(
        backgroundColor: lightBlue,
        iconTheme: IconThemeData(color: Colors.blue),
        centerTitle: true,
        title: Text(
          "Book information", style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Center(child: Text(widget.Ten,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,),),),
            Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                        height: 250,
                        padding: EdgeInsets.all(10),
                        child: Image.network(
                          widget.Hinh,
                        )),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      child: Text(
                        "Introduce",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          // color: textColor,
                          fontWeight: FontWeight.w600,fontSize: 20
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 3,
                                backgroundColor: Colors.green[700],
                              ),
                            ],
                          ),
          ],
        ),
    ),
                    Column(
                      children: [
                        Text(
                            widget.Data,style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Container(
                      constraints: BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                      margin: EdgeInsets.all(10),
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PDFPage(widget.Link),));
                        },
                        color: lightBlue,
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Continue',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
    ]
    )
    )
    ]
    ),
      )
    );
  }
}