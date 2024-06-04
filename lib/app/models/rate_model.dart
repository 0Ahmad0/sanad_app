class RateLesson {
  String? idUser;
  List<int?> selectOptionIndexes;
  int degree ;

  RateLesson({
    required this.idUser,
    required this.selectOptionIndexes,
    required this.degree,
  });

  factory RateLesson.fromJson(json) {
    List<int?> itemList = [];

    for (int i = 0; i < json['selectOptionIndexes'].length; i++) {
      int? temp = int.tryParse('${json['selectOptionIndexes'][i]}');
      itemList.add(temp);
    }
    return RateLesson(
      idUser: json['idUser'],
      selectOptionIndexes: itemList,
      degree: json["degree"],
    );
  }


  Map<String, dynamic> toJson() => {
    'idUser': idUser,
    'selectOptionIndexes': selectOptionIndexes,
    'degree': degree
  };
}
