class Tuvung {
  final String id;
  final String question;
  final List<String> answers;
  final String correctanswers;

  Tuvung({
    required this.id,
    required this.question,
    required this.answers,
    required this.correctanswers,
  });

  List<Tuvung> tuvung = [
    Tuvung(
        id: "1",
        question: "tahnh",
        answers: ['1', '2', '3', '4'],
        correctanswers: "Thanh"),
    Tuvung(
        id: "2",
        question: "tahnh",
        answers: ['1', '2', '3', '4'],
        correctanswers: "Thanh"),
    Tuvung(
        id: "3",
        question: "tahnh",
        answers: ['1', '2', '3', '4'],
        correctanswers: "Thanh"),
    Tuvung(
        id: "4",
        question: "tahnh",
        answers: ['1', '2', '3', '4'],
        correctanswers: "Thanh"),
    Tuvung(
        id: "5",
        question: "tahnh",
        answers: ['1', '2', '3', '4'],
        correctanswers: "Thanh")
  ];
}
