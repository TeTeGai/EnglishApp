import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an/Provider/MyProvider.dart';
import 'package:do_an/Widgets/Test.dart';
import 'package:do_an/resultTestPage.dart';
import 'package:flutter/material.dart';

import 'Bien/Kiemtra.dart';

class TestPage extends StatefulWidget {

  final String quizId;
  TestPage(this.quizId);


  @override
  _TestPageState createState() => _TestPageState(this.quizId);
}
int total=0;
int correct =0;
int incorrect =0;
int not = 0;
bool isLoading = true;
late Stream infoStream;
class _TestPageState extends State<TestPage> {
  final String quizId;
  _TestPageState(this.quizId);
  MyProvider myProvider = new MyProvider();
   QuerySnapshot? querySnapshot;
  late final String option, description,correctAnser,optionSelected;

  getTestQuiz(String quizID) async
  {
    return await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizID)
        .collection("QNA")
        .get();
  }

  @override
  void initState() {
    getTestQuiz(widget.quizId).then((value)
    {
      querySnapshot=value;
       correct =0;
       incorrect =0;
      isLoading = false ;
      total= querySnapshot!.docs.length;
      not = querySnapshot!.docs.length;
      setState(() {
      });
      print("init don $total ${widget.quizId} ");

    });

    super.initState();
  }

  Kiemtra getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot) {
    Kiemtra kiemtra = new Kiemtra();

    kiemtra.Question = questionSnapshot["question"];

    /// shuffling the options
    List<String> options = [
      questionSnapshot["option1"],
      questionSnapshot["option2"],
      questionSnapshot["option3"],
      questionSnapshot["option4"]
    ];
    options.shuffle();

    kiemtra.Option1 = options[0];
    kiemtra.Option2 = options[1];
    kiemtra.Option3 = options[2];
    kiemtra.Option4 = options[3];
    kiemtra.correctOption = questionSnapshot["option1"];
    kiemtra.Answer = false;

    print(kiemtra.correctOption.toLowerCase());

    return kiemtra;
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
      body: isLoading
          ? Container(
        child: Center(child: CircularProgressIndicator()),
      )
          :  SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              // InfoHeader(
              //   length: querySnapshot.docs.length,
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              querySnapshot?.docs == null
                  ? Container(
                child: Center(child: Text("No Data"),),
              )
                  : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: querySnapshot!.docs.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context,index){
                    return Play(
                      kiemtra: getQuestionModelFromDatasnapshot(
                          querySnapshot!.docs[index]),
                      index: index,
                    );
                  })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context)=> ResultTest(
              correct: correct, incorrect: incorrect, total: total)));
    }
      ),
  
    );
  }
}

class Play extends StatefulWidget {
  final Kiemtra kiemtra;
  final int index;
  Play({required this.kiemtra, required this.index});

  @override
  _PlayState createState() => _PlayState();
}

class _PlayState extends State<Play> {
   String optionSelected = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.kiemtra.Question,style: TextStyle(fontSize: 18),),
          SizedBox(height: 10,),
          GestureDetector(
            onTap: (){
              if(!widget.kiemtra.Answer)
                {
                  if(widget.kiemtra.Option1 == widget.kiemtra.correctOption)
                    {

                      setState(() {
                        optionSelected = widget.kiemtra.Option1;
                      widget.kiemtra.Answer =true;
                      correct = correct +1;
                      not = not + 1;
                      });
                    }
                  else{
                    setState(() {

                      optionSelected = widget.kiemtra.Option1;
                      widget.kiemtra.Answer =true;
                      incorrect = incorrect +1;
                      not = not - 1;
                    });

                  }
                }
            },
            child: Test(
                option: "A",
                description: widget.kiemtra.Option1,
                correctAnswer: widget.kiemtra.correctOption,
                optionSelected: optionSelected),
          ),
          GestureDetector(
            onTap: (){
              if(!widget.kiemtra.Answer)
              {
                if(widget.kiemtra.Option2 == widget.kiemtra.correctOption)
                {
                  setState(() {
                    optionSelected = widget.kiemtra.Option2;
                    widget.kiemtra.Answer =true;
                    correct = correct +1;
                    not = not + 1;
                  });
                }
                else{
                  setState(() {
                    optionSelected = widget.kiemtra.Option2;
                    widget.kiemtra.Answer =true;
                    incorrect = incorrect +1;
                    not = not - 1;
                  });
                }
              }
            },
            child: Test(
                option: "B",
                description: widget.kiemtra.Option2,
                correctAnswer: widget.kiemtra.correctOption,
                optionSelected: optionSelected),
          ),
          GestureDetector(
            onTap: (){
              if(!widget.kiemtra.Answer)
              {
                if(widget.kiemtra.Option3 == widget.kiemtra.correctOption)
                {
                  setState(() {
                    optionSelected = widget.kiemtra.Option3;
                    widget.kiemtra.Answer =true;
                    correct = correct +1;
                    not = not + 1;
                  });
                }
                else{
                  setState(() {
                    optionSelected = widget.kiemtra.Option3;
                    widget.kiemtra.Answer =true;
                    incorrect = incorrect +1;
                    not = not - 1;
                  });

                }
              }
            },
            child: Test(
                option: "C",
                description: "${widget.kiemtra.Option3}",
                correctAnswer: widget.kiemtra.correctOption,
                optionSelected: optionSelected),
          ),
          GestureDetector(
            onTap: (){
              if(!widget.kiemtra.Answer)
              {
                if(widget.kiemtra.Option4 == widget.kiemtra.correctOption)
                {
                  setState(() {
                    optionSelected = widget.kiemtra.Option4;
                    widget.kiemtra.Answer =true;
                    correct = correct +1;
                    not = not + 1;
                  });
                }
                else{
                  setState(() {
                    optionSelected = widget.kiemtra.Option4;
                    widget.kiemtra.Answer =true;
                    incorrect = incorrect +1;
                    not = not - 1;
                  });

                }
              }
            },
            child: Test(
                option: "D",
                description: widget.kiemtra.Option4,
                correctAnswer: widget.kiemtra.correctOption,
                optionSelected: optionSelected),
          ),
        ],
      ),
    );
  }
}

class InfoHeader extends StatefulWidget {
  final int length;

  InfoHeader({required this.length});

  @override
  _InfoHeaderState createState() => _InfoHeaderState();
}

class _InfoHeaderState extends State<InfoHeader> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: infoStream,
        builder: (context, snapshot){
          return Container(
            height: 40,
            margin: EdgeInsets.only(left: 14),
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: <Widget>[
                NoOfQuestionTile(
                  text: "Total",
                  number: widget.length,
                ),
                NoOfQuestionTile(
                  text: "Correct",
                  number: correct,
                ),
                NoOfQuestionTile(
                  text: "Incorrect",
                  number: incorrect,
                ),
                NoOfQuestionTile(
                  text: "NotAttempted",
                  number: not,
                ),
              ],
            ),
          ) ;
        }
    );
  }
}