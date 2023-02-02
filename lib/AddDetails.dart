import 'package:flutter/material.dart';

import 'Provider/MyProvider.dart';
import 'Teacher/TeacherHomePage.dart';

class AddDetails extends StatefulWidget {
  final String classId;
  AddDetails(this.classId);
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddDetails> {
  final _formkey = GlobalKey<FormState>();
  String className="", classDesc="", classImg="", classTime="",classUrl="",
      classFullname="",option1="",option2="",option3="", classTitle="";
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
        "className": className,
        "classDesc":classDesc,
        "classImg":classImg,
        "classTime":classTime,
        "classUrl":classUrl,
        "classFullname":classFullname,
        "option1":option1,
        "option2":option2,
        "option3":option3,
        "classTitle": classTitle,
      };
      print("${widget.classId}");
      myProvider.addDetails(questionMap, widget.classId).then((value) {
        className = "";
        classDesc= "";
        classImg= "";
        classTime= "";
        classUrl= "";
        classFullname ="";
        option1="";
        option2="";
        option3="";
        classTitle="";
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
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) => value!.isEmpty ? 'Class Name cannot be blank' : null,
                    decoration: InputDecoration(
                      hintText: "Class Name",
                    ),
                    onChanged: (value) {
                      className   = value;
                    },
                  ),
                  TextFormField(
                    validator: (value) => value!.isEmpty ? 'Class FullName cannot be blank' : null,
                    decoration: InputDecoration(
                      hintText: "Class FullName",
                    ),
                    onChanged: (value) {
                      classFullname   = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) => value!.isEmpty ? 'Class Desc cannot be blank' : null,
                    decoration: InputDecoration(
                      hintText: "Class Desc ",
                    ),
                    onChanged: (value) {
                      classDesc= value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) => value!.isEmpty ? 'Class Img cannot be blank' : null,
                    decoration: InputDecoration(
                      hintText: "Class Img",
                    ),
                    onChanged: (value) {
                      classImg = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) => value!.isEmpty ? 'Class Title cannot be blank' : null,
                    decoration: InputDecoration(
                      hintText: "Class Title",
                    ),
                    onChanged: (value) {
                      classTitle = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) => value!.isEmpty ? 'Class Time cannot be blank' : null,
                    decoration: InputDecoration(
                      hintText: "Class Time",
                    ),
                    onChanged: (value) {
                      classTime = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) => value!.isEmpty ? 'Option1 cannot be blank' : null,
                    decoration: InputDecoration(
                      hintText: "Option1",
                    ),
                    onChanged: (value) {
                      option1   = value;
                    },
                  ),
                  TextFormField(
                    validator: (value) => value!.isEmpty ? 'Option2 cannot be blank' : null,
                    decoration: InputDecoration(
                      hintText: "Option2",
                    ),
                    onChanged: (value) {
                      option2   = value;
                    },
                  ),
                  TextFormField(
                    validator: (value) => value!.isEmpty ? 'Option3 cannot be blank' : null,
                    decoration: InputDecoration(
                      hintText: "Option3",
                    ),
                    onChanged: (value) {
                      option3   = value;
                    },
                  ),
                  TextFormField(
                    validator: (value) => value!.isEmpty ? 'Class Url cannot be blank' : null,
                    decoration: InputDecoration(
                      hintText: "Class Url",
                    ),
                    onChanged: (value) {
                      classUrl = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      uploadQuizData();
                      Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => new TeacherHomePage()));
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
            ),
          ), )

    );
  }
}
