import 'package:do_an/AddDetails.dart';
import 'package:do_an/AddQuestion.dart';
import 'package:do_an/Provider/MyProvider.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class CreateClass extends StatefulWidget {
  const CreateClass({Key? key}) : super(key: key);

  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateClass> {
  final _formkey = GlobalKey<FormState>();
  late  String classImageUrl, classTitle, classDescription, classID, classTime;
  bool _isloading = false;
  MyProvider myProvider = new MyProvider();
  createQuizOne() async {
    classID = randomAlphaNumeric(16);
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isloading = true;
      });

      Map<String, String> quizMap = {
        "classImgUrl": classImageUrl,
        "Title": classTitle,
        "classDesc": classDescription,
        "classID":classID,
        "classTime":classTime
      };
      await myProvider.addClass(quizMap, classID).then((value) {
        setState(() {
          _isloading = false;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => AddDetails(classID)));
        });
      });
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
                    validator: (value) => value!.isEmpty ? 'Class Image Url cannot be blank' : null,
                    decoration: InputDecoration(
                      hintText: "Class Image Url",
                    ),
                    onChanged: (value) {
                      classImageUrl = value;
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
                    validator: (value) => value!.isEmpty ? 'Class Description cannot be blank' : null,
                    decoration: InputDecoration(
                      hintText: "Class Description",
                    ),
                    onChanged: (value) {
                      classDescription = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) => value!.isEmpty ? 'Class Time cannot be blank' : null,
                    decoration: InputDecoration(
                      hintText: "Class Time ",
                    ),
                    onChanged: (value) {
                      classTime = value;
                    },
                  ),
                  SizedBox(height: 40,),
                  GestureDetector(
                    onTap: () {
                      createQuizOne();
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 3 / 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red),
                      child: Center(
                          child: Text(
                            "Make",
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
