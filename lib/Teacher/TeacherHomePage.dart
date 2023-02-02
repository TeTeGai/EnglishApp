import 'package:do_an/Details.dart';
import 'package:do_an/HomePage1.dart';
import 'package:do_an/Teacher/TeacherHomePage1.dart';
import 'package:flutter/material.dart';
import 'package:do_an/ColorScheme.dart';

import '../SeeallPage.dart';
import 'TeacherVocabularyPage.dart';


class TeacherHomePage extends StatelessWidget {
  const TeacherHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homePage(),
      routes: {
        '/SeeallPage': (context) => SeeallPage(),
      },
    );
  }
}

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int _currentIndex = 0;
  final List _chil = [
    TeacherHomePage1(),
    TeacherVocabularyPage(),
  ];
  void ontapBotbar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightBlue,
        resizeToAvoidBottomInset: false,
        body: _chil[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: ontapBotbar,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              title: Text("Book"),
            ),

          ],
        ));
  }

  InkWell tutorWidget(
      String img, String name, String subj, String grade, String price) {
    return InkWell(
      // onTap: (){
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => Details()),
      //   );
      // },
      child: Container(
        margin: EdgeInsets.only(top: 20),
        height: 130,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: lightBlue.withOpacity(0.5)),
        child: Row(
          children: [
            Container(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(30)),
                    child: Container(
                      height: 120,
                      width: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('asset/img/iconBgNew.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 130,
                    padding: EdgeInsets.only(left: 5, top: 5),
                    child: Stack(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          child: RotatedBox(
                            quarterTurns: 2,
                            child: Icon(
                              Icons.star,
                              color: darkBlue,
                              size: 60,
                            ),
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          child: Center(
                            child: Text("4.5"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 50,
                    child: Container(
                      width: 100,
                      height: 130,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('asset/img/$img.png'),
                              fit: BoxFit.cover)),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("GRADE $grade"),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text("$name"),
                    Text("$subj\n"),
                    Text("$price")
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openSeeallPage() {
    Navigator.pushNamed(context, '/SeeallPage');
  }

  void openDetails() {
    Navigator.pushNamed(context, '/Details');
  }
}
