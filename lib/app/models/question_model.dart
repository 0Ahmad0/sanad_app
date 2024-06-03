class Question {
  String text;
  List<String> options;
  int correctOptionIndex;

  Question({
    required this.text,
    required this.options,
    required this.correctOptionIndex,
  });

  factory Question.fromJson(json) {
    List<String> itemList = [];

    for (int i = 0; i < json['options'].length; i++) {
      String temp = '${json['options'][i]}';
      itemList.add(temp);
    }
    return Question(
      text: json['text'],
      options: itemList,
      correctOptionIndex: json["correctOptionIndex"],
    );
  }


  Map<String, dynamic> toJson() => {
    'text': text,
    'options': options,
    'correctOptionIndex': correctOptionIndex
  };
}
