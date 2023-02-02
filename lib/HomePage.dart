import 'package:do_an/BookPage.dart';
import 'package:do_an/Details.dart';
import 'package:do_an/HomePage1.dart';
import 'package:flutter/material.dart';
import 'package:do_an/ColorScheme.dart';
import 'VocabularyPage.dart';
import 'StudyPage.dart';
import 'PersionPage.dart';
import 'SeeallPage.dart';
import 'HomePage1.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  bool isBottomBarVisible = true;
  PageController? _pageController ;
  int _currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }
  final List<Widget> _chil = [
    HomePage1(),
    BookPage(),
    VocabularyPage(),
    StudyPage(),
  ];
  void ontapBotbar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  void onTabTapped(int index) {
    this._pageController!.animateToPage(index,duration: const Duration(milliseconds: 500),curve: Curves.easeInOut);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightBlue,
        resizeToAvoidBottomInset: false,
        body: PageView(
          children:  _chil,
          onPageChanged: ontapBotbar,
          controller: _pageController,
        )


        ,
        bottomNavigationBar:  isBottomBarVisible ? new BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: onTabTapped,
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
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              title: Text("Book"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.computer),
              title: Text("Study"),
            ),
          ],
        ):Container());
  }

}
