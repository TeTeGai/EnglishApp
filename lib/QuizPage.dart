import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an/Controller/Progressbar.dart';
import 'package:flutter/material.dart';

import 'Bien/QuizHinh.dart';

class QuizImg extends StatefulWidget {
  final String id;
  QuizImg(this.id);

  @override
  _QuizImgState createState() => _QuizImgState();
}



class _QuizImgState extends State<QuizImg> {
 late int _currentTime ;
  late Timer timer;
 late final String hinh1,hinh2,hinh3,hinh4;
  getTestQuiz(String quizID) async
 {
   return await FirebaseFirestore.instance
       .collection("QuizImg")
       .doc(quizID)
       .collection("Question")
       .get();
 }
 QuizHinh getQuestionModelFromDatasnapshot(
     DocumentSnapshot questionSnapshot) {
   QuizHinh quizHinh = new QuizHinh();

   quizHinh.Question = questionSnapshot["quesiton"];

   /// shuffling the options
   List<String> options = [
     questionSnapshot["img1"],
     questionSnapshot["img2"],
     questionSnapshot["img3"],
     questionSnapshot["img4"]
   ];
   options.shuffle();

   hinh1 = quizHinh.Option1 = options[0];
   hinh2 = quizHinh.Option2 = options[1];
   hinh3 = quizHinh.Option3 = options[2];
   hinh4 = quizHinh.Option4 = options[3];
   quizHinh.correctOption = questionSnapshot["img1"];
   quizHinh.Answer = false;

   print(quizHinh.correctOption.toLowerCase());

   return quizHinh;
 }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentTime = 10;
    timer= Timer.periodic(Duration(seconds: 1), (timer) {
      print(_currentTime);
      _currentTime -= 1;
    });
    if(_currentTime==0)
      {
        timer.cancel();
      }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 25,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: _currentTime/10,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text("Thuứ 2 là ngày bao nhiêu"),
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 180,
                    height: 170,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.brown,
                          image: DecorationImage(
                            image: NetworkImage(hinh1),
                          )),
                    ),
                  ),
                  Container(
                    width: 180,
                    height: 180,
                    color: Colors.lightBlue,
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 180,
                    height: 180,
                    color: Colors.lightBlue,
                  ),
                  Container(
                    width: 180,
                    height: 180,
                    color: Colors.lightBlue,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

