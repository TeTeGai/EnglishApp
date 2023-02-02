import 'package:flutter/material.dart';

class PersionPage extends StatelessWidget {
  const PersionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: persionPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class persionPage extends StatefulWidget {
  const persionPage({Key? key}) : super(key: key);

  @override
  _persionPageState createState() => _persionPageState();
}

class _persionPageState extends State<persionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("asset/img/boy1.png"))),
              ),
            ),
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 3 / 4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.blue),
            child: Center(
                child: Text(
              "Đổi thông tin",
              style: TextStyle(fontSize: 20, color: Colors.white),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 3 / 4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.blue),
              child: Center(
                  child: Text(
                "Đổi mật khẩu",
                style: TextStyle(fontSize: 20, color: Colors.white),
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 3 / 4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.red),
              child: Center(
                  child: Text(
                "Đăng xuất",
                style: TextStyle(fontSize: 20, color: Colors.white),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
