import 'package:flutter/material.dart';

import 'Provider/MyProvider.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;
  AddQuestion(this.quizId);
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formkey = GlobalKey<FormState>();
  String question="", option1="", option2="", option3="",option4="";
  bool _isloading = false;
  MyProvider myProvider = new MyProvider();
  uploadQuizData()
  {

    if(_formkey.currentState!.validate())
      {
        setState(() {
          _isloading = true;
        });
        Map<String,String> questionMap = {
          "question": question,
          "option1":option1,
          "option2":option2,
          "option3":option3,
          "option4":option4,
        };
        print("${widget.quizId}");
        myProvider.addQuestion(questionMap, widget.quizId).then((value) {
          question = "";
          option1= "";
          option2= "";
          option3= "";
          option4= "";
          setState(() {
            _isloading = false;
          });
          });
      }
    else{
      print("error is happening ");
    }
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
        body: _isloading
            ? Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
            : Form(
          key: _formkey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TextFormField(
                  validator: (value) => value!.isEmpty ? 'Email cannot be blank' : null,
                  decoration: InputDecoration(
                    hintText: "Question",
                  ),
                  onChanged: (value) {
                    question = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => value!.isEmpty ? 'Email cannot be blank' : null,
                  decoration: InputDecoration(
                    hintText: "Option 1 (Correct Answer)",
                  ),
                  onChanged: (value) {
                    option1 = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => value!.isEmpty ? 'Email cannot be blank' : null,
                  decoration: InputDecoration(
                    hintText: "Option 2",
                  ),
                  onChanged: (value) {
                    option2 = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => value!.isEmpty ? 'Email cannot be blank' : null,
                  decoration: InputDecoration(
                    hintText: "Option 3",
                  ),
                  onChanged: (value) {
                    option3 = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) => value!.isEmpty ? 'Email cannot be blank' : null,
                  decoration: InputDecoration(
                    hintText: "Option 4",
                  ),
                  onChanged: (value) {
                    option4 = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    uploadQuizData();
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 3 / 4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red),
                    child: Center(
                        child: Text(
                          "Add",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )),
                  ),
                ),
              ],
            ),
          ), )

    );
  }
}
