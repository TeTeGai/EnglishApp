

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an/Bien/Khoahoc.dart';
import 'package:do_an/Bien/Tuvung.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class MyProvider extends ChangeNotifier {

  // List<Khoahoc> _dsKhoahoc = [];
  // late Khoahoc _khoahoc;
  //
  // Future<void> getKhoahoc() async {
  //   List<Khoahoc> _newdsKhoahoc = [];
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
  //       .instance
  //       .collection("EnglishApp")
  //       .doc("Khoahoc")
  //       .collection("Toiec")
  //       .get();
  //   querySnapshot.docs.forEach((element) {
  //     _khoahoc = Khoahoc(
  //         chitiet: element.data()["Chi tiet"],
  //         giatien: element.data()["Gia tien"],
  //         hinh: element.data()["Hinh"],
  //         loai: element.data()["Loai"],
  //         ten: element.data()["Ten"]);
  //     print(_khoahoc.ten);
  //     _newdsKhoahoc.add(_khoahoc);
  //     _dsKhoahoc = _newdsKhoahoc;
  //   });
  // }

  // get throwKHList {
  //   return _dsKhoahoc;
  // }

  Future<void> addQuiz(Map<String, dynamic> quizData, String quizID) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizID)
        .set(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addQuestion(questionData, String quizID) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizID)
        .collection("QNA")
        .add(questionData)
        .catchError((e) {
      print(e);
    });
  }

  Future<void> addClass(Map<String, dynamic> classData, String classID) async {
    await FirebaseFirestore.instance
        .collection("Class")
        .doc(classID)
        .set(classData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addWishlist(Map<String, dynamic> wishlistData, String ID) async {
    await FirebaseFirestore.instance
        .collection("WishList")
        .doc(ID)
        .set(wishlistData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addDetails(DetailsData, String classID) async {
    await FirebaseFirestore.instance
        .collection("Class")
        .doc(classID)
        .collection("ROOM")
        .add(DetailsData)
        .catchError((e) {
      print(e);
    });
  }

  getQuizData() async
  {
    return await FirebaseFirestore.instance.collection("Quiz").snapshots();
  }

  getTestQuiz(String quizID) async
  {
    return await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizID)
        .collection("QNA")
        .get();
  }

  getclassRoom(String classID) async
  {
    return await FirebaseFirestore.instance
        .collection("Class")
        .doc(classID)
        .collection("ROOM")
        .get();
  }

  void addUserData({
    required User currentUser,
     String? userName,
     String? userImage,
     String? userEmail,
  }) async {
    await FirebaseFirestore.instance
        .collection("usersData")
        .doc(currentUser.uid)
        .set(
      {
        "userName": userName,
        "userEmail": userEmail,
        "userImage": userImage,
        "userUid": currentUser.uid,
      },
    );
  }
}
