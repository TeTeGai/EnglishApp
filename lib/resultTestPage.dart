import 'package:flutter/material.dart';

class ResultTest extends StatefulWidget {
  final int correct, incorrect , total;


  ResultTest({required this.correct, required this.incorrect,required this.total});

  @override
  _ResultTestState createState() => _ResultTestState();
}

class _ResultTestState extends State<ResultTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("${widget.correct}/ ${widget.total}", style: TextStyle(fontSize: 25),),
                SizedBox(height: 5,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    "you answered ${widget.correct} answers correctly and ${widget.incorrect} answeres incorrectly",
                    textAlign: TextAlign.center,),

                ),
                SizedBox(height: 24,),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Text("Go to Test", style: TextStyle(color: Colors.white, fontSize: 19),),
                  ),
                )
              ],),
          ),
        ),

    );
  }
}
