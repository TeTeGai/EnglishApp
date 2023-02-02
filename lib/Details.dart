import 'package:do_an/Bien/Khoahoc.dart';
import 'package:flutter/material.dart';
import 'package:do_an/ColorScheme.dart';
import 'package:provider/provider.dart';

import 'Provider/MyProvider.dart';

class Details extends StatelessWidget {
  int selectDate = DateTime.now().day;

  final String classID;
  Details(this.classID);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe7f4f5),
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
          Row(
            children: [
              Container(
                width: 200,
                height: 200,
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 200,
                          height: 240,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('asset/img/iconBg.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        )),
                    Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: 170,
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage("")),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                  child: Container(
                padding: EdgeInsets.all(20),
                width: 190,
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Thanh",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "Toiec 400+",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: darkBlue,
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
          Expanded(
              child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Row(
                        children: [
                          Text("Về giảng viên"),
                        ],
                      )),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          container("Thanh", Colors.black, darkBlue),
                          container("Thanh", Colors.black, darkBlue),
                          container("Thanh", Colors.black, darkBlue),
                          container("Thanh", Colors.black, darkBlue),
                          container("Thanh", Colors.black, darkBlue),
                          container("Thanh", Colors.black, darkBlue),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Thời gian"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [for (int i = 0; i < 7; i++) datewidget(i)],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            time("11:00 AM", false),
                            time("12:00 PM", false),
                            time("1:00 PM", false),
                            time("2:00 PM", false),
                          ],
                        ),
                        Row(
                          children: [
                            time("3:00 PM", true),
                            time("4:00 PM", false),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 3 / 4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue),
                    child: Center(
                        child: Text(
                      "Thêm vào thư viện",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}

Container time(String time, bool isSelected) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
    margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: (isSelected) ? pink : lightBlue.withOpacity(0.5),
    ),
    child: Row(
      children: [
        Icon(
          Icons.watch_later,
          size: 13,
          color: Colors.grey,
        ),
        SizedBox(
          width: 3,
        ),
        Text(
          time,
          style: TextStyle(fontSize: 11),
        ),
      ],
    ),
  );
}

String day(int week) {
  List day = ['', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  return day[week];
}

InkWell datewidget(int i) {
  DateTime date = DateTime.now().add(Duration(days: i));
  return InkWell(
    onTap: () {},
    child: Container(
      margin: EdgeInsets.all(2),
      height: 70,
      width: 47,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        // color: (selectDate == date.day)?yellow:lightBlue.withOpacity(0.5),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              day(date.weekday),
              style: TextStyle(fontSize: 13),
            ),
            Text(date.day.toString())
          ],
        ),
      ),
    ),
  );
}

Container container(String text, Color color, Color textcolor) {
  return Container(
    height: 100,
    margin: EdgeInsets.only(right: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: color,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                text,
                style: TextStyle(
                    color: textcolor,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        )
      ],
    ),
  );
}
