import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../core/utils/color_manager.dart';
import 'question_model.dart';
import 'rate_model.dart';
enum StatusLesson{
  accepted,
  rejected,
  pending
}
class LessonModel {
  String? id;
  String? idUser;
  String? name;
  String? description;
  String? fileName;
  String? filePath;
  String? videoName;
  String? videoPath;
  List<String> imagesPath;
  List<Question> questions;
  Map<String,RateLesson> mapRateLessons;
  String? status;
  DateTime? dateTime;

  StatusLesson get statusEnum=>StatusLesson.values.firstWhereOrNull((element)=>element.name.toLowerCase().contains(status?.toLowerCase()??''))
  ??StatusLesson.pending;

      String get statusAr{
    switch(statusEnum){
      case StatusLesson.accepted:
        return 'مقبول';
      case StatusLesson.rejected:
        return 'مرفوض';
      default:
        return  'معلق';
    }
  }
  Color get statusColor{

      switch(statusEnum){
    case StatusLesson.accepted:
       return ColorManager.successColor;
        case StatusLesson.rejected:
          return ColorManager.errorColor;
  default:
      return  ColorManager.greyColor;
  }
  }

  initRateLesson()=> RateLesson(idUser: idUser, selectOptionIndexes: questions.map((_)=>null).toList(), degree: 0);
  handleRateLesson(){
    mapRateLessons.forEach((key,value){
      for(int i=(mapRateLessons[key]?.selectOptionIndexes.length??0)-1;i<questions.length;i++)
        mapRateLessons[key]?.selectOptionIndexes.add(null);
    });
  }

  answerQuestion(String idUser,int questionIndex,int selectOptionIndex){
    if(!mapRateLessons.containsKey(idUser))
      mapRateLessons[idUser]=initRateLesson();

    handleRateLesson();

    List<int?> tempSelectOptionIndexes=[];
    for(int i=0;i<(mapRateLessons[idUser]?.selectOptionIndexes?.length??0);i++)
      tempSelectOptionIndexes.add(
          i==questionIndex?
          selectOptionIndex
              : mapRateLessons[idUser]?.selectOptionIndexes[i]);
    mapRateLessons[idUser]?.selectOptionIndexes= tempSelectOptionIndexes;

    // mapRateLessons[idUser]?.selectOptionIndexes[questionIndex]=selectOptionIndex;
  }
  removeAnswer(String idUser,int questionIndex,int selectOptionIndex){
    if(!mapRateLessons.containsKey(idUser))
      mapRateLessons[idUser]=initRateLesson();
    handleRateLesson();
    mapRateLessons[idUser]?.selectOptionIndexes[questionIndex]=null;
  }
  int? getSelectOptionByQuestion(String idUser,int questionIndex){
    if(!mapRateLessons.containsKey(idUser))
      mapRateLessons[idUser]=initRateLesson();
    handleRateLesson();

    return  mapRateLessons[idUser]?.selectOptionIndexes[questionIndex];
  }
  int? getRateByUser(String idUser){
    if(!mapRateLessons.containsKey(idUser))
      mapRateLessons[idUser]=initRateLesson();
    handleRateLesson();
    int rate=0;
    for(int i=0;i<questions.length;i++){
      if(mapRateLessons[idUser]?.selectOptionIndexes[i]==questions[i].correctOptionIndex)
        rate++;
    }


    return rate ;
  }
  LessonModel({
    this.id,
    this.name,
    this.description,
    this.filePath,
    this.fileName,
    this.videoPath,
    this.videoName,
    this.imagesPath=const[],
    this.questions=const[],
    this.mapRateLessons=const{},
    this.status,
    this.idUser,
    this.dateTime,
  });

  factory LessonModel.fromJson(json) {
    var data = json.runtimeType.toString()=='_JsonQueryDocumentSnapshot'?json.data():json;
    List<String> itemList = [];

    for (int i = 0; i < json['imagesPath'].length; i++) {
      String temp = '${json['imagesPath'][i]}';
      itemList.add(temp);
    }
//questions
    List<Question> itemList2 = [];

    for (int i = 0; i < json['questions'].length; i++) {
      Question temp = Question.fromJson(json['questions'][i]);
      itemList2.add(temp);
    }

    Map? map=data['mapRateLessons']?.map((key,value)=>MapEntry(key,RateLesson.fromJson(value) ));
    Map<String,RateLesson> itemMap =  {};
    itemMap.addEntries(map?.map((key,value)=>MapEntry(key as String, value as RateLesson)).entries??[]);
    return LessonModel(
      id: json['id'],
      name: json["name"],
      description: json["description"],
      filePath: json["filePath"],
      fileName: data["fileName"],
      imagesPath: itemList,
      questions: itemList2,
      mapRateLessons: itemMap,
      videoPath: json["videoPath"],
      videoName: data["videoName"],
      status: json["status"],
      idUser: data["idUser"],
      dateTime: data["dateTime"]?.toDate(),
    );
  }

  factory LessonModel.init() {
    return LessonModel(
      id: "",
      name: '',
      status: StatusLesson.pending.name,
      dateTime: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> itemList = [];
    for (Question item in questions) {
      itemList.add(item.toJson());
    }
    Map<String, dynamic> itemMap =mapRateLessons.map((key,value)=>MapEntry(key, value.toJson()));
    return  {
      'id': id,
      'name': name,
      'description': description,
      'filePath': filePath,
      'fileName': fileName,
      'videoPath': videoPath,
      'videoName': videoName,
      'imagesPath': imagesPath,
      'questions': itemList,
      'mapRateLessons': itemMap,
      'status': status,
      'idUser': idUser,
      'dateTime': dateTime==null?null:Timestamp.fromDate(dateTime!),
    };
  }
}

//LessonsModel
class LessonsModel {
  List<LessonModel> items;

  LessonsModel({required this.items});

  factory LessonsModel.fromJson(json) {

    List<LessonModel> itemList = [];

    for (int i = 0; i < json.length; i++) {
      LessonModel temp = LessonModel.fromJson(json[i]);
      temp.id = json[i].id;
      itemList.add(temp);
    }
    return LessonsModel(items: itemList);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> itemList = [];
    for (LessonModel item in items) {
      itemList.add(item.toJson());
    }
    return {
      'items': itemList,
    };
  }
}
