import 'package:do_an/AddQuestion.dart';
import 'package:do_an/Controller/Quotes.dart';
import 'package:do_an/CreateQuiz.dart';
import 'package:do_an/Bien/Tuvung.dart';
import 'package:do_an/Login.dart';
import 'package:do_an/PDFPage.dart';
import 'package:do_an/Provider/MyProvider.dart';

import 'package:do_an/QuizPage.dart';
import 'package:do_an/Register.dart';
import 'package:do_an/VocabularyPage.dart';
import 'package:do_an/Widgets/GoogleLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:do_an/ColorScheme.dart';
import 'package:provider/provider.dart';
import 'Controller/GG.dart';
import 'CreateClass.dart';
import 'Dictionary.dart';
import 'HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Quotes().getAll();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<MyProvider>(
            create: (BuildContext context) => MyProvider(),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false, // Bỏ chữ demo góc trên màn hình

            home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context,snapshot) {
                if (snapshot.hasData) {
                  return homePage();
                }
                else{
                  return Login();
                }
              },),

            )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      body: SafeArea(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Trung.com",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "Skip",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('asset/img/splash.png'),
                    fit: BoxFit.contain)),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "WHERE YOU LOVE LEARNING",
                style: TextStyle(fontSize: 27),
              ),
              Text(
                "Distant Learning & Home \n Shooling Made Easy",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "Book Filtered Top Rated proffesional  \n Tutors form the confort \n Of your home in just a few clicks",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 15,
                        color: Colors.black.withOpacity(0.1),
                      )),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: darkBlue,
                    ),
                    child: IconButton(
                        onPressed: openHomePage,
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )),
                  ),
                ),
              )
            ],
          ))
        ],
      )),
    );
  }

  void openHomePage() {
    Navigator.pushNamed(context, '/HomePage');
  }
}
