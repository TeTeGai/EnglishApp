import 'dart:math';
import 'package:do_an/Bien/Cautienganh.dart';
import 'package:do_an/Bien/Cctienganh.dart';

class Quotes{
  static Quotes _instance = Quotes._internal();
  static List<Quote> datas=[];
  Quotes._internal();
  factory Quotes() => _instance;
  getAll()
  {
    datas =allquotes.map((e) => Quote.fromJson(e)).toList();
  }
  static List<Quote> covert(List<dynamic> quotes)
  {
    return quotes.map((e) => Quote.fromJson(e)).toList();
  }
  Quote? getbyNoun(String word)
  {
    List<Quote> quotes= datas.where((element) {
      String content = element.getContent() ?? "";
      return content.contains(word);
    }).toList();
    Random random = Random();
    return quotes.isEmpty? null: quotes[random.nextInt(quotes.length)];
  }
  int _getRandomIndex()
  {
    return new Random.secure().nextInt(allquotes.length);
  }
}