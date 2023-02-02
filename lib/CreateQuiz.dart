import 'package:do_an/AddQuestion.dart';
import 'package:do_an/Provider/MyProvider.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({Key? key}) : super(key: key);

  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formkey = GlobalKey<FormState>();
  late  String quizImageUrl, quizTitle, quizDescription, quizID;
  bool _isloading = false;
  MyProvider myProvider = new MyProvider();
  createQuizOne() async {
    quizID = randomAlphaNumeric(16);
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isloading = true;
      });

      Map<String, String> quizMap = {
        "quizImgUrl": quizImageUrl,
        "Title": quizTitle,
        "quizDesc": quizDescription,
        "quizID":quizID
      };
      await myProvider.addQuiz(quizMap, quizID).then((value) {
        setState(() {
          _isloading = false;
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => AddQuestion(quizID)));
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
        child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextFormField(
              validator: (value) => value!.isEmpty ? 'Email cannot be blank' : null,
              decoration: InputDecoration(
                hintText: "Quiz Image Url",
              ),
              onChanged: (value) {
                quizImageUrl = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) => value!.isEmpty ? 'Email cannot be blank' : null,
              decoration: InputDecoration(
                hintText: "Quiz Title",
              ),
              onChanged: (value) {
                quizTitle = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) => value!.isEmpty ? 'Email cannot be blank' : null,
              decoration: InputDecoration(
                hintText: "Quiz Description",
              ),
              onChanged: (value) {
                quizDescription = value;
              },
            ),
            SizedBox(
              height: 10,
            ),
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
      ), )

    );
  }
}
