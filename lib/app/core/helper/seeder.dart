import 'dart:io';
import 'dart:math';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sanad_app/app/models/lesson_model.dart';


import '../../controller/firebase/firebase_constants.dart';
import '../../controller/firebase/firebase_fun.dart';
import '../../models/question_model.dart';
import '../../models/user_model.dart';

import '../utils/app_constant.dart';


class Seeder{


  static Future<void> admin() async {

    try {
      // ConstantsWidgets.showLoading();
      for(UserModel userModel in adminsData){
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: userModel.email!, password: userModel.password!)
            .timeout(FirebaseFun.timeOut);
        if(userCredential.user!=null){
          userModel.uid=userCredential.user!.uid;

          await FirebaseFirestore.instance
              .collection(FirebaseConstants.collectionUser)
              .doc(userModel.uid)
              .set(userModel.toJson());
        }
      }
      // ConstantsWidgets.closeDialog();
    } on FirebaseException catch (e) {
      String errorMessage = FirebaseFun.findTextToast(e.code);
      // ConstantsWidgets.closeDialog();
      // ConstantsWidgets.TOAST(null, textToast: errorMessage, state: false);
      throw Exception(errorMessage);
    }on Exception catch (e) {
      throw Exception();
    }
  }


  static Future<void> user() async {

    try {
      //ConstantsWidgets.showLoading();
      for(UserModel userModel in usersData){
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: userModel.email!, password: userModel.password!)
            .timeout(FirebaseFun.timeOut);
        if(userCredential.user!=null){
          userModel.uid=userCredential.user!.uid;

          await FirebaseFirestore.instance
              .collection(FirebaseConstants.collectionUser)
              .doc(userModel.uid)
              .set(userModel.toJson());
        }
      }
      // ConstantsWidgets.closeDialog();
    } on FirebaseException catch (e) {
      String errorMessage = FirebaseFun.findTextToast(e.code);
      // ConstantsWidgets.closeDialog();
      // ConstantsWidgets.TOAST(null, textToast: errorMessage, state: false);
      throw Exception(errorMessage);
    }on Exception catch (e) {
      throw Exception();
    }
  }
  static Future<void> lesson() async {
    final random = Random();
    UserModel user = usersData.first;
    UserModel admin = adminsData.first;
    try {
      //ConstantsWidgets.showLoading();

      for(LessonModel lesson in lessons){
      DateTime now = DateTime.now();
      DateTime dateTime = now.add(Duration(days: random.nextInt(60) - 30));

      int indexFile=random.nextInt(2);
      int indexVideo=random.nextInt(2);
      lesson.id=_generateUid(lesson.name??"");
      lesson.dateTime=dateTime;
      lesson.idUser=admin.uid;
      lesson.fileName=[null,fileName][indexFile];
      lesson.filePath=[null,filePath][indexFile];
      lesson.videoName=[null,videoName][indexVideo];
      lesson.videoPath=[null,videoPath][indexVideo];
      lesson.imagesPath=  List.generate(random.nextInt(5), (_)=>imagePath??'');
      lesson.questions=List.generate([0,1,2,3,3,3][random.nextInt(5)], (_)=>_getRandomItem(questions) as Question);
      if(lesson.questions.length>=3){
        for(int i=0;i<lesson.questions.length;i++)
          if([true,false,true][random.nextInt(3)])
             lesson.answerQuestion(user.uid??'', i, random.nextInt(4));
      }
      await FirebaseFun.addLesson(lesson:lesson);
    }



      // ConstantsWidgets.closeDialog();
    } on FirebaseException catch (e) {
      String errorMessage = FirebaseFun.findTextToast(e.code);
      // ConstantsWidgets.closeDialog();
      // ConstantsWidgets.TOAST(null, textToast: errorMessage, state: false);
      throw Exception(errorMessage);
    }on Exception catch (e) {
      throw Exception();
    }
  }
  static Future<void> requestLesson() async {
    final random = Random();


    try {
      //ConstantsWidgets.showLoading();

      int index=0;
      for(LessonModel lesson in lessonRequests){
        DateTime now = DateTime.now();
        DateTime dateTime = now.add(Duration(days: random.nextInt(60) - 30));
        UserModel user = index%3==0?usersData.first:usersData[random.nextInt(usersData.length)];
        int indexFile=random.nextInt(2);
        int indexVideo=random.nextInt(2);
        lesson.id=_generateUid(lesson.name??"");
        lesson.dateTime=dateTime;
        lesson.idUser=user.uid;
        lesson.status=(_getRandomItem(StatusLesson.values) as StatusLesson).name;
        if( lesson.status==StatusLesson.accepted.name){
          lesson.fileName=[null,fileName][indexFile];
          lesson.filePath=[null,filePath][indexFile];
          lesson.videoName=[null,videoName][indexVideo];
          lesson.videoPath=[null,videoPath][indexVideo];
          lesson.imagesPath=  List.generate(random.nextInt(5), (_)=>imagePath??'');
          lesson.questions=List.generate(random.nextInt(4), (_)=>_getRandomItem(questions) as Question);
          if(lesson.questions.length>=3){
            for(int i=0;i<lesson.questions.length;i++)
              if([true,false,true][random.nextInt(3)])
                lesson.answerQuestion(user.uid??'', i, random.nextInt(4));
          }
        }

        await FirebaseFun.addLesson(lesson:lesson);
        index++;
      }



      // ConstantsWidgets.closeDialog();
    } on FirebaseException catch (e) {
      String errorMessage = FirebaseFun.findTextToast(e.code);
      // ConstantsWidgets.closeDialog();
      // ConstantsWidgets.TOAST(null, textToast: errorMessage, state: false);
      throw Exception(errorMessage);
    }on Exception catch (e) {
      throw Exception();
    }
  }






  static  Future<void> file() async {

    try {
      // ConstantsWidgets.showLoading();
      videoName=_xVideo.name;
      videoPath="https://firebasestorage.googleapis.com/v0/b/ah-chat-a7da9.appspot.com/o/test.mp4?alt=media&token=7c160712-a785-480e-8c27-27c5cfb0835e";

      imageName= _xImage.name;
      imagePath="https://firebasestorage.googleapis.com/v0/b/ah-chat-a7da9.appspot.com/o/%D8%B5%D9%88%D8%B1%D8%A9%20%D8%AA%D8%AF%D9%84%20%D8%B9%D9%84%D9%89%20%D8%A7%D9%86%D9%87%20%D9%84%D8%A7%20%D9%8A%D9%88%D8%AC%D8%AF%20%D8%A8%D9%8A%D8%A7%D9%86%D8%A7%D8%AA%20%D9%88%D8%AA%D9%83%D9%88%D9%86%20%D8%A7%D9%84%D8%B5%D9%88%D8%B1%D8%A9%20%D8%B9%D8%B5%D8%B1%D8%A8%D8%A9.png?alt=media&token=d65447df-9557-4430-b007-c1621dd8950f";

      fileName=_xAudio.name;
      filePath="https://firebasestorage.googleapis.com/v0/b/ah-chat-a7da9.appspot.com/o/test_sound.mp3?alt=media&token=b0fa7c02-94a2-468a-a187-5d9645d92f20";

      // fileData.url=await FirebaseFun.uploadImage(image:_xFile,folder:'');
      // imageData.url=await FirebaseFun.uploadImage(image:_xImage,folder:'');
      // ConstantsWidgets.closeDialog();
    } on FirebaseException catch (e) {
      String errorMessage = FirebaseFun.findTextToast(e.code);
      // ConstantsWidgets.closeDialog();
      // ConstantsWidgets.TOAST(null, textToast: errorMessage, state: false);
      throw Exception(errorMessage);
    }on Exception catch (e) {
      throw Exception();
    }
  }

  static String? fileName;
  static String? filePath;
  static String? videoName;
  static String? videoPath;
  static String? imagePath;
  static String? imageName;
  static XFile _xAudio = XFile("assets/sounds/test_sound.mp3");
  static XFile _xVideo = XFile("assets/test.mp4");
  static XFile _xImage = XFile("assets/images/logo.png");
  static List<UserModel> adminsData=[
    // UserModel(email: 'admin@gmail.com', name: 'Admin Acc', password: '1234sS@4321', typeUser: AppConstants.collectionAdmin),
    UserModel(
    userName: "admin",gender: "ذكر",
      email: 'admin@gmail.com', name: 'مدير التطبيق', password: '12345678', typeUser: AppConstants.collectionAdmin),

  ];
 static List<UserModel> usersData=[

    UserModel(
        userName: "user",gender: "ذكر",
        email: 'user@gmail.com', name: 'طالب معلوماتية', password: '12345678',phoneNumber: "0599555440", typeUser: AppConstants.collectionUser),
    UserModel(
        userName: "user2",gender: "أنثى",
        email: 'user2@gmail.com', name: 'Ahmad T1', password: '12345678',phoneNumber: "0599555440", typeUser: AppConstants.collectionUser),
    UserModel(
        userName: "user3",gender: "ذكر",
        email: 'user3@gmail.com', name: 'Ahmad T2', password: '12345678',phoneNumber: "0599555440", typeUser: AppConstants.collectionUser),
    UserModel(
        userName: "user4",gender: "ذكر",
        email: 'user4@gmail.com', name: 'Ahmad T3', password: '12345678',phoneNumber: "0599555440", typeUser: AppConstants.collectionUser),
    UserModel(
        userName: "user5",gender: "ذكر",
        email: 'user5@gmail.com', name: 'Ahmad T4', password: '12345678',phoneNumber: "0599555440", typeUser: AppConstants.collectionUser),
    UserModel(
        userName: "user6",gender: "ذكر",
        email: 'user6@gmail.com', name: 'Ahmad T5', password: '12345678',phoneNumber: "0599555440", typeUser: AppConstants.collectionUser),
    // UserModel(email: 'user7@gmail.com', name: 'Ahmad T6', password: '12345678',phoneNumber: "0599555440", typeUser: AppConstants.collectionUser),
    // UserModel(email: 'user8@gmail.com', name: 'Ahmad T7', password: '12345678',phoneNumber: "0599555440", typeUser: AppConstants.collectionUser),
    // UserModel(email: 'user9@gmail.com', name: 'Ahmad T8', password: '12345678',phoneNumber: "0599555440", typeUser: AppConstants.collectionUser),
    // UserModel(email: 'user10@gmail.com', name: 'Ahmad T9', password: '12345678',phoneNumber: "0599555440", typeUser: AppConstants.collectionUser),

  ];

  static List<String> images = [
    "https://firebasestorage.googleapis.com/v0/b/enjaz-app-9d39e.firebasestorage.app/o/Americas.png?alt=media&token=e044fcd7-0f89-4a13-8b7f-239d91fdb268",
    "https://firebasestorage.googleapis.com/v0/b/enjaz-app-9d39e.firebasestorage.app/o/aaa.jpg?alt=media&token=11dda076-2185-485d-a48b-7cbaa8244661",
    "https://firebasestorage.googleapis.com/v0/b/enjaz-app-9d39e.firebasestorage.app/o/d.jpg?alt=media&token=b90fd08b-35b1-4339-bfde-9042e9455d76",
    "https://firebasestorage.googleapis.com/v0/b/enjaz-app-9d39e.firebasestorage.app/o/earth-5660940_960_720.png?alt=media&token=eb5e4f74-179b-4932-93c9-c7da1181744c",
    "https://firebasestorage.googleapis.com/v0/b/enjaz-app-9d39e.firebasestorage.app/o/globe-1348777_1280.webp?alt=media&token=cfff61f7-6aaf-4ce1-b7e3-8aaa35be264d",
    "https://firebasestorage.googleapis.com/v0/b/enjaz-app-9d39e.firebasestorage.app/o/qq.jpg?alt=media&token=db68f16d-4011-43b6-91ff-3f34d41593a0",
    "https://firebasestorage.googleapis.com/v0/b/enjaz-app-9d39e.firebasestorage.app/o/qqq.jpg?alt=media&token=d5a20b83-2a53-4f3d-b639-2f904f2f8cfc",
    "https://firebasestorage.googleapis.com/v0/b/enjaz-app-9d39e.firebasestorage.app/o/ss.jpg?alt=media&token=c6be1bd0-8008-4a58-aecb-74a42ab9d363",
    "https://firebasestorage.googleapis.com/v0/b/enjaz-app-9d39e.firebasestorage.app/o/%D8%B5%D9%88%D8%B1%D8%A9%20%D8%AA%D8%AF%D9%84%20%D8%B9%D9%84%D9%89%20%D8%A7%D9%86%D9%87%20%D9%84%D8%A7%20%D9%8A%D9%88%D8%AC%D8%AF%20%D8%A8%D9%8A%D8%A7%D9%86%D8%A7%D8%AA%20%D9%88%D8%AA%D9%83%D9%88%D9%86%20%D8%A7%D9%84%D8%B5%D9%88%D8%B1%D8%A9%20%D8%B9%D8%B5%D8%B1%D8%A8%D8%A9.png?alt=media&token=924e3c79-df11-4ed2-801b-9cdc8dbdea1f",
  ];
  static List<LessonModel> lessons = [
    LessonModel(
      name: "مقدمة إلى البرمجة بلغة Dart",
      description: "في هذا الدرس، سنتعرف على لغة Dart، الأساس الذي يعتمد عليه فريم وورك Flutter. سنتناول أساسيات اللغة مثل المتغيرات، العمليات، والتحكم في التدفق، بالإضافة إلى التعرف على كيفية تشغيل كود Dart في بيئة التطوير.",
      status:  StatusLesson.accepted.name,

    ),
    LessonModel(
      name: "مقدمة إلى Flutter",
      description: "سيقدم هذا الدرس لمحة عامة عن إطار العمل Flutter، وكيفية تثبيته وتجهيزه للعمل. سنتعرف على بنية التطبيقات في Flutter، وما يميزه عن أطر العمل الأخرى لتطوير التطبيقات المتعددة المنصات.",
      status: StatusLesson.accepted.name,

    ),
    LessonModel(
      name: "المكونات الأساسية في Flutter",
      description: "سنتعرف في هذا الدرس على أهم المكونات الأساسية في Flutter مثل الـ Widgets، وكيفية استخدامها لبناء الواجهات الرسومية. سنستعرض الفرق بين الـ StatelessWidget و StatefulWidget، وأهمية كل منهما في تطوير التطبيقات.",
      status:  StatusLesson.accepted.name,

    ),
    LessonModel(
      name: "إدارة الحالة في Flutter",
      description: "إدارة الحالة من المفاهيم الأساسية في Flutter. في هذا الدرس، سنتعرف على أهم الطرق المستخدمة في إدارة الحالة مثل setState و Provider و Riverpod، مع تقديم أمثلة عملية توضح كيفية استخدامها في المشاريع.",
      status:  StatusLesson.accepted.name,

    ),
    LessonModel(
      name: "التعامل مع البيانات في Flutter",
      description: "سنتعلم كيفية تخزين البيانات واسترجاعها في تطبيقات Flutter. سنتعرف على SQLite، Shared Preferences، و Firebase Firestore، مع تقديم أمثلة على كيفية استخدام كل تقنية في حفظ بيانات المستخدم.",
      status: StatusLesson.accepted.name,

    ),
    LessonModel(
      name: "تصميم واجهات احترافية باستخدام Flutter",
      description: "هذا الدرس سيوضح كيفية تصميم واجهات احترافية وجذابة باستخدام Flutter. سنتعلم كيفية استخدام Material Design و Cupertino Widgets، بالإضافة إلى تطبيق مفاهيم التصميم الحديثة مثل التدرجات اللونية والـ Animations.",
      status: StatusLesson.accepted.name,

    ),
    LessonModel(
      name: "التعامل مع واجهات برمجة التطبيقات (APIs)",
      description: "في هذا الدرس، سنتعلم كيفية جلب البيانات من الإنترنت والتعامل مع REST APIs باستخدام مكتبة HTTP في Flutter. سنبني تطبيقًا بسيطًا يقوم بجلب بيانات من API وعرضها على الشاشة بطريقة ديناميكية.",
      status: StatusLesson.accepted.name,

    ),
    LessonModel(
      name: "إرسال الإشعارات في Flutter",
      description: "سنتعلم كيفية إرسال الإشعارات إلى المستخدمين باستخدام Firebase Cloud Messaging (FCM). سنتعرف على كيفية إعداد Firebase في مشروع Flutter، وإرسال إشعارات مخصصة بناءً على أحداث معينة داخل التطبيق.",
      status:  StatusLesson.accepted.name,

    ),
    LessonModel(
      name: "تحسين أداء تطبيقات Flutter",
      description: "سنتناول في هذا الدرس استراتيجيات تحسين أداء تطبيقات Flutter. سنتحدث عن Lazy Loading، وكيفية تقليل استهلاك الذاكرة، وتحسين سرعة التطبيق من خلال تقنيات مثل Code Splitting و Isolates.",
      status: StatusLesson.accepted.name,

    ),
    LessonModel(
      name: "نشر تطبيق Flutter على المتاجر",
      description: "سنتعلم في هذا الدرس كيفية تجهيز التطبيق للنشر على متجر Google Play و Apple App Store. سنتناول خطوات بناء ملفات APK و App Bundle، وإعداد شهادات التوقيع، وتجهيز التطبيق ليكون متوافقًا مع سياسات المتاجر.",
      status:StatusLesson.accepted.name,

    ),
  ];

  static List<LessonModel> lessonRequests =  [
    LessonModel(
      name: "الألوان وأسماؤها",
      description: "في هذا الدرس، سيتعرف الطفل على الألوان الأساسية مثل الأحمر والأزرق والأصفر، بالإضافة إلى كيفية مزج الألوان للحصول على ألوان جديدة بطريقة ممتعة.",
    ),
    LessonModel(
      name: "الأشكال الهندسية",
      description: "سيتعلم الطفل في هذا الدرس الأشكال الأساسية مثل الدائرة والمربع والمثلث والمستطيل، مع أمثلة على أماكن وجودها في الحياة اليومية.",
    ),
    LessonModel(
      name: "الحروف الأبجدية",
      description: "يهدف هذا الدرس إلى تعليم الطفل الحروف العربية من الألف إلى الياء، مع نطق كل حرف وأمثلة على كلمات تبدأ به.",
    ),
    LessonModel(
      name: "الأرقام والعدّ",
      description: "سيتعلم الطفل الأرقام من 1 إلى 10، مع تمارين عد الأشياء بطريقة مسلية باستخدام الصور والألعاب.",
    ),
    LessonModel(
      name: "أيام الأسبوع",
      description: "في هذا الدرس، سيتعرف الطفل على أيام الأسبوع بالترتيب، مع أنشطة تفاعلية لمساعدته على تذكرها بسهولة.",
    ),
    LessonModel(
      name: "الحيوانات وأصواتها",
      description: "سيكتشف الطفل في هذا الدرس أسماء الحيوانات المختلفة وأصواتها، مع صور ممتعة تساعده على التعرف عليها بسهولة.",
    ),
    LessonModel(
      name: "الفواكه والخضروات",
      description: "سيتعرف الطفل على أسماء الفواكه والخضروات وألوانها، مع تمارين تفاعلية لمساعدته على التمييز بينها.",
    ),
    LessonModel(
      name: "أجزاء الجسم",
      description: "في هذا الدرس، سيتعلم الطفل أسماء أجزاء الجسم مثل اليدين، القدمين، العيون، والأنف، مع أنشطة تساعده على التعرف عليها.",
    ),
    LessonModel(
      name: "النظافة الشخصية",
      description: "سيتم تعليم الطفل أهمية النظافة الشخصية مثل غسل اليدين، تنظيف الأسنان، والاستحمام، مع نصائح للحفاظ على الصحة.",
    ),
    LessonModel(
      name: "التصرف بأدب",
      description: "يهدف هذا الدرس إلى تعليم الطفل أهمية التحلي بالأخلاق الحميدة مثل قول 'شكراً' و 'من فضلك'، وكيفية التعامل مع الآخرين باحترام.",
    ),
  ];
  static List<Question> questions = [
    Question(
      text: "ما هي اللغة المستخدمة في تطوير تطبيقات Flutter؟",
      options: ["Java", "Dart", "Kotlin", "Swift"],
      correctOptionIndex: 1,
    ),
    Question(
      text: "ما هو الفرق الرئيسي بين StatelessWidget و StatefulWidget؟",
      options: [
        "StatelessWidget يمكنه إعادة بناء نفسه تلقائيًا",
        "StatefulWidget لا يمكنه تغيير حالته الداخلية",
        "StatefulWidget يسمح بتغيير الحالة أثناء التشغيل",
        "StatelessWidget يستخدم لإدارة الحالة المعقدة"
      ],
      correctOptionIndex: 2,
    ),
    Question(
      text: "ما هي الأداة (Widget) الأساسية التي تحتوي على جميع الواجهات؟",
      options: ["MaterialApp", "Scaffold", "Container", "Column"],
      correctOptionIndex: 0,
    ),
    Question(
      text: "أي من الخيارات التالية يُستخدم لحفظ البيانات محليًا في Flutter؟",
      options: ["Firebase Firestore", "SharedPreferences", "Dart Compiler", "HTTP Requests"],
      correctOptionIndex: 1,
    ),
    Question(
      text: "ما هي مكتبة Flutter المستخدمة لجلب البيانات من REST API؟",
      options: ["http", "flutter_api", "request_handler", "networking"],
      correctOptionIndex: 0,
    ),
    Question(
      text: "ما هو العنصر المسؤول عن إدارة الحالة في Flutter؟",
      options: ["StatefulWidget", "StatelessWidget", "InheritedWidget", "Container"],
      correctOptionIndex: 0,
    ),
    Question(
      text: "أي من الأدوات التالية يُستخدم لإنشاء تصاميم متجاوبة؟",
      options: ["MediaQuery", "ResponsiveWidget", "AdaptiveDesign", "AutoLayout"],
      correctOptionIndex: 0,
    ),
    Question(
      text: "ما هي الطريقة التي تستخدم لتحديث واجهة المستخدم في StatefulWidget؟",
      options: ["setState()", "updateUI()", "refreshWidget()", "rebuild()"],
      correctOptionIndex: 0,
    ),
    Question(
      text: "ما هو نوع الملفات المستخدم عند نشر تطبيق Flutter على متجر Google Play؟",
      options: ["APK", "IPA", "EXE", "DMG"],
      correctOptionIndex: 0,
    ),
    Question(
      text: "أي مما يلي يُستخدم لإرسال إشعارات في تطبيقات Flutter؟",
      options: ["Firebase Cloud Messaging (FCM)", "Dart Notifier", "Flutter Alerts", "Push Notification Center"],
      correctOptionIndex: 0,
    ),
    Question(
      text: "ما هي قاعدة البيانات المحلية التي يدعمها Flutter؟",
      options: ["PostgreSQL", "MongoDB", "SQLite", "OracleDB"],
      correctOptionIndex: 2,
    ),
    Question(
      text: "أي من الأدوات التالية تُستخدم لتحليل أداء تطبيقات Flutter؟",
      options: ["Flutter Inspector", "Dart Debugger", "Android Studio Profiler", "All of the above"],
      correctOptionIndex: 3,
    ),
    Question(
      text: "ما هو الفرق بين ListView و Column؟",
      options: [
        "ListView يتم تمريرها بينما Column لا يتم تمريرها تلقائيًا",
        "ListView تدعم تخطيطات متعددة بينما Column تدعم تخطيطًا واحدًا فقط",
        "Column مخصصة للقوائم بينما ListView تُستخدم للعناصر الفردية",
        "لا يوجد فرق بينهما"
      ],
      correctOptionIndex: 0,
    ),
    Question(
      text: "أي Widget يُستخدم لإنشاء زر في Flutter؟",
      options: ["FlatButton", "TextButton", "ElevatedButton", "جميع ما سبق"],
      correctOptionIndex: 3,
    ),
    Question(
      text: "ما هي الطريقة الصحيحة لإضافة صورة في Flutter؟",
      options: ["Image.asset()", "Image.network()", "Image.file()", "جميع ما سبق"],
      correctOptionIndex: 3,
    ),
    Question(
      text: "أي من هذه الطرق تُستخدم لجلب البيانات من API بشكل آمن؟",
      options: ["try-catch", "async-await", "FutureBuilder", "جميع ما سبق"],
      correctOptionIndex: 3,
    ),
    Question(
      text: "ما هي الميزة الأساسية لـ Hot Reload في Flutter؟",
      options: ["تحديث التطبيق دون إعادة تشغيله", "إعادة تشغيل التطبيق بالكامل", "تسريع أداء التطبيق", "تقليل حجم التطبيق"],
      correctOptionIndex: 0,
    ),
    Question(
      text: "أي مكتبة تُستخدم لإدارة الحالة بشكل متقدم في Flutter؟",
      options: ["Provider", "Redux", "Riverpod", "جميع ما سبق"],
      correctOptionIndex: 3,
    ),
    Question(
      text: "ما هي الأداة (Widget) التي تُستخدم لإنشاء تخطيطات مرنة في Flutter؟",
      options: ["Row", "Column", "Flex", "GridView"],
      correctOptionIndex: 2,
    ),
    Question(
      text: "ما هي وظيفة pubspec.yaml في مشروع Flutter؟",
      options: [
        "إدارة الحزم والمكتبات",
        "كتابة كود التطبيق",
        "إعدادات واجهة المستخدم",
        "إعدادات الأمان"
      ],
      correctOptionIndex: 0,
    ),
    Question(
      text: "أي من الخيارات التالية هو نوع من التحولات (Transitions) في Flutter؟",
      options: ["FadeTransition", "SlideTransition", "ScaleTransition", "جميع ما سبق"],
      correctOptionIndex: 3,
    ),
    Question(
      text: "كيف يمكن التعامل مع الأخطاء في Dart؟",
      options: ["try-catch", "onError()", "errorHandler()", "ExceptionHandler"],
      correctOptionIndex: 0,
    ),
    Question(
      text: "ما هي الطريقة المستخدمة لإنشاء صفحة جديدة في Flutter؟",
      options: ["Navigator.push()", "PageRoute()", "Screen.load()", "OpenPage()"],
      correctOptionIndex: 0,
    ),
    Question(
      text: "ما هي الأداة التي تُستخدم للتحكم في حجم العنصر؟",
      options: ["SizedBox", "Container", "Expanded", "جميع ما سبق"],
      correctOptionIndex: 3,
    ),
    Question(
      text: "ما هي الميزة الرئيسية لاستخدام FutureBuilder؟",
      options: [
        "تحميل البيانات بشكل غير متزامن",
        "إعادة بناء الواجهة عند تحديث البيانات",
        "تحسين الأداء عبر التعامل مع Future",
        "جميع ما سبق"
      ],
      correctOptionIndex: 3,
    ),
    Question(
      text: "ما هو الفرق بين Expanded و Flexible؟",
      options: [
        "Expanded يأخذ كل المساحة المتاحة بينما Flexible يأخذ مساحة مرنة",
        "Flexible لا يمكن استخدامه داخل Column",
        "Expanded يحدد عرض العنصر بينما Flexible يحدد ارتفاعه",
        "لا يوجد فرق بينهما"
      ],
      correctOptionIndex: 0,
    ),
    Question(
      text: "ما هي الأداة المستخدمة لإضافة تمرير Scroll في Flutter؟",
      options: ["ListView", "SingleChildScrollView", "Scrollable", "جميع ما سبق"],
      correctOptionIndex: 3,
    ),
    Question(
      text: "كيف يمكن تحديد حجم الخط في Text Widget؟",
      options: ["TextStyle", "FontSize", "Typography", "TextFormat"],
      correctOptionIndex: 0,
    ),
    Question(
      text: "أي مكتبة تُستخدم لدمج Flutter مع Firebase؟",
      options: ["firebase_core", "firebase_auth", "cloud_firestore", "جميع ما سبق"],
      correctOptionIndex: 3,
    ),
  ];



  static _generateUid(String name){
    // return "$name${Timestamp.now().millisecondsSinceEpoch}";
    return '${name}00000'.substring(0,5)+'${Timestamp.now().microsecondsSinceEpoch}';
  }
  static _getRandomItem(List items){

    return items[Random().nextInt(items.length)];
  }


}