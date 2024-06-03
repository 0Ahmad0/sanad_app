import 'package:get/get.dart';
import 'package:sanad_app/app/models/question_model.dart';
enum StatusLesson{
  accepted,
  rejected,
  pending
}
class LessonModel {
  String? id;
  String? name;
  String? description;
  String? filePath;
  String? videoPath;
  List<String> imagesPath;
  List<Question> questions;
  String? status;

  StatusLesson get statusEnum=>StatusLesson.values.firstWhereOrNull((element)=>element.name.toLowerCase().contains(status?.toLowerCase()??''))
  ??StatusLesson.pending;

  LessonModel({
    this.id,
    this.name,
    this.description,
    this.filePath,
    this.videoPath,
    this.imagesPath=const[],
    this.questions=const[],
    this.status,
  });

  factory LessonModel.fromJson(json) {
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
    return LessonModel(
      id: json['id'],
      name: json["name"],
      description: json["description"],
      filePath: json["filePath"],
      imagesPath: itemList,
      questions: itemList2,
      videoPath: json["videoPath"],
      status: json["status"],
    );
  }

  factory LessonModel.init() {
    return LessonModel(
      id: "",
      name: '',
      status: StatusLesson.pending.name,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> itemList = [];
    for (Question item in questions) {
      itemList.add(item.toJson());
    }
    return  {
      'id': id,
      'name': name,
      'description': description,
      'filePath': filePath,
      'videoPath': videoPath,
      'imagesPath': imagesPath,
      'questions': itemList,
      'status': status,
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
