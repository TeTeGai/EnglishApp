import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Bien/Khoahoc.dart';
import 'ColorScheme.dart';
import 'Provider/MyProvider.dart';
class Detail extends StatefulWidget {
  final String classID;
  Detail(this.classID);

  @override
  _DetailState createState() => _DetailState();
}
int total=0;
int correct =0;
int incorrect =0;
int not = 0;
bool isLoading = true;
class _DetailState extends State<Detail> {
  MyProvider myProvider = new MyProvider();
   QuerySnapshot? querySnapshot = null;
  Khoahoc khoahoc = new Khoahoc();
  @override
  void initState() {
    super.initState();
    myProvider.getclassRoom(widget.classID).then((value)
    {

      querySnapshot=value;
      correct =0;
      incorrect =0;
      isLoading = false ;
      total= querySnapshot!.docs.length;
      setState(() {
      });
      print("init don $total ${widget.classID} ");
    });
    super.initState();
  }

  // Widget quizList()
  // {
  //   return Container(
  //     child:
  //     StreamBuilder (
  //       stream: FirebaseFirestore.instance.collection('Quiz').doc().collection("ROOM").snapshots(),
  //       builder: (BuildContext  context,AsyncSnapshot<QuerySnapshot> snapshot)
  //       {
  //         return ListView.builder(
  //             shrinkWrap: true,
  //             physics: ClampingScrollPhysics(),
  //             itemCount: snapshot.data!.docs.length,
  //             itemBuilder: (context,index) {
  //               DocumentSnapshot doc = snapshot.data!.docs[index];
  //               return Data(index: index,khoahoc: getClasslFromDatasnapshot(querySnapshot.docs[index]),);
  //             });
  //       },
  //     ),
  //   );
  // }

  Khoahoc getClasslFromDatasnapshot(
      DocumentSnapshot questionSnapshot) {
    khoahoc.name = questionSnapshot["className"];
    khoahoc.img = questionSnapshot["classImg"];
    khoahoc.desc = questionSnapshot["classDesc"];
    khoahoc.time = questionSnapshot["classTime"];
    khoahoc.url = questionSnapshot["classUrl"];
    khoahoc.fullname = questionSnapshot["classFullname"];
    khoahoc.title = questionSnapshot["classTitle"];
    khoahoc.option1 = questionSnapshot["option1"];
    khoahoc.option2 = questionSnapshot["option2"];
    khoahoc.option3 = questionSnapshot["option3"];
    return khoahoc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
        child: Container(
          child: Column(
            children: [

              querySnapshot?.docs == null
                  ? Container(
                child: Center(child: Text("No Data"),),
              ) : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: querySnapshot!.docs.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context,index){
                    return Data(khoahoc: getClasslFromDatasnapshot( querySnapshot!.docs[index]), index: index);
                  })
            ],
          ),
        ),
      ),


    );
  }
}

class Data extends StatefulWidget {
  final Khoahoc khoahoc;
  final int index;
  Data({required this.khoahoc,required this.index});

  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 200,
                height: 200,
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 200,
                          height: 240,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('asset/img/iconBg.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        )),
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 170,
                          height: 200,
                          decoration: BoxDecoration(
                            // image: DecorationImage(image: NetworkImage("")),
                            image: DecorationImage(
                              image: NetworkImage(widget.khoahoc.img),
                              fit: BoxFit.contain,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: 150,
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.khoahoc.name,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          widget.khoahoc.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: darkBlue,
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
          SizedBox(height: 20,),

          Container(
            child: SingleChildScrollView(
                child: Container(
                  child: Column(

                    children: [
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //      Text("Về giảng viên"),
                      //       Text("Thời gian"),
                      //     ]
                      // ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                persion(widget.khoahoc.fullname, false),
                              ],
                            ),
                          ),

                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                time(widget.khoahoc.time, true),
                              ],
                            ),
                          ),
                        ]
                      ),

                      SizedBox(height: 10,),
                      Column(
                        children: [
                          Align(alignment: Alignment.topLeft, child: Text("Thông tin về khóa học",style: TextStyle(fontSize: 20),)),
                          SizedBox(height: 10,),
                          Align(alignment: Alignment.topLeft, child: Text(widget.khoahoc.desc)),
                          SizedBox(height: 20,),
                          Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  container(widget.khoahoc.option1, lightBlue, darkBlue, "icon1.png"),
                                  container(widget.khoahoc.option2, yellow, darkBlue, "icon2.png"),
                                  container(widget.khoahoc.option3, pink, darkBlue, "icon3.png"),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height:20),
                          GestureDetector(
                            onTap: ()
                            {
                              _launchrUrl(widget.khoahoc.url);
                            },
                            child: Container(
                              
                      color: Colors.white,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.only(bottom: 20, right: 30, left: 30),
                        decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: darkBlue
                        ),
                        child: Center(
                            child: Text("Go to Class", style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'circe',
                                fontWeight: FontWeight.w700,
                                fontSize: 18
                            ),),
                        ),)),
                          )
                        ],
                      )
                    ]
                    ),
                ),
              )
            ),

        ],
      ),
    );
  }
}
Container persion(String time, bool isSelected) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
    margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: (isSelected) ? pink : lightBlue.withOpacity(0.5),
    ),
    child: Row(
      children: [
        Icon(
          Icons.person,
          size: 20,
          color: Colors.grey,
        ),
        SizedBox(
          width: 3,
        ),
        Text(
          time,
          style: TextStyle(fontSize: 15),
        ),
      ],
    ),
  );
}

Container time(String time, bool isSelected) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
    margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: (isSelected) ? pink : lightBlue.withOpacity(0.5),
    ),
    child: Row(
      children: [
        Icon(
          Icons.watch_later,
          size: 13,
          color: Colors.grey,
        ),
        SizedBox(
          width: 3,
        ),
        Text(
          time,
          style: TextStyle(fontSize: 13),
        ),
      ],
    ),
  );
}

Container container(String text, Color color, Color textcolor, String img) {
  return Container(
    height: 100,
    margin: EdgeInsets.only(right: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: color,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                text,
                style: TextStyle(
                    color: textcolor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
              Container(
                height: 90,
                width: 70,
                decoration: BoxDecoration(
                  // image: DecorationImage(image: NetworkImage("")),
                  image: DecorationImage(
                    image: AssetImage('asset/img/$img'),
                    fit: BoxFit.contain,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Future<void> _launchrUrl(String urlString) async {
  if(await canLaunch(urlString))
    {
      await launch(urlString);
    }
  else
    {
      throw 'Could not launch';
    }
}
