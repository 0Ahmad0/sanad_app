import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../app/core/utils/color_manager.dart';
import '../../app/core/utils/styles_manager.dart';
import '../../app/core/utils/values_manager.dart';
import '../../app/models/lesson_model.dart';
import '../../app/widgets/container_auth_widget.dart';
import '../../app/widgets/custom_appbar_widget.dart';
import '../../app/widgets/default_scaffold.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ShowTextScreen extends StatelessWidget {
  ShowTextScreen({super.key});

  String text =
      'تعريف الذكاء الاصطناعي:يعد الذكاء الاصطناعي فرعاً من علوم الكمبيوتر يهدف إلى إنشاء أنظمة يمكنها أداء المهام التي تتطلب عادةً ذكاءً بشرياً مثل الإدراك والاستدلال والتعلم واتخاذ القرار، وتتضمن مجالات الذكاء الاصطناعي تطوير الخوارزميات والبرامج الحاسوبية التي يمكنها تحليل البيانات والتعلم منها وعمل تنبؤات أو قرارات بناءً على هذا التحليل، ويمكن تصنيف الذكاء الاصطناعي إلى عدة حقول فرعية مثل التعلم الآلي ومعالجة اللغة الطبيعية والروبوتات والكمبيوتر؛ لذلك سوف يكتسب مفهوم الذكاء الاصطناعي أهمية الذكاء كبيرة على مستوى العالم.يمكن القول أيضاً، مفهوم الذكاء الاصطناعي يقصد به محاكاة عمليات الذكاء البشري بواسطة أنظمة خاصة تشبه أنظمة الكمبيوتر، ويتميز الذكاء الاصطناعي بالقدرة على "التفكير" و"التعلم" من خلال تحليل كميات كبيرة من البيانات، ويمكن استخدام الذكاء الاصطناعي لأتمتة المهام أو إجراء تنبؤات أو تحديد الأنماط التي قد لا يتمكن البشر من اكتشافها.يُستخدَم الذكاء الاصطناعي في مجموعة واسعة من التطبيقات من المساعدين الشخصيين الافتراضيين وروبوتات المحادثة إلى السيارات ذاتية القيادة وأنظمة التشخيص الطبي؛ لذلك يعدُّ مستقبل الذكاء الاصطناعي واعداً ويحمل آفاقاً جديدة؛ ولذلك سنقدم في هذا المقال بحثاً عن الذكاء الاصطناعي.تاريخ الذكاء الاصطناعي:يعود تاريخ الذكاء الاصطناعي إلى منتصف القرن العشرين، ففي عام 1956 نظَّم جون مكارثي ومارفن مينسكي وناثانيال روتشستر وكلود شانون مؤتمر دارتموث، واقترح الباحثون في المؤتمر أنَّه يمكن تصميم آلة لمحاكاة أي مهمة تحتاج إلى ذكاء بشري.في السنوات التي تلت ذلك تقدمت أبحاث الذكاء الاصطناعي بسرعة وطوَّر الباحثون عدة تقنيات مثل التفكير الرمزي والأنظمة الخبيرة لتمكين الآلات من اتخاذ القرارات وحل المشكلات بناءً على القواعد والمعرفة، وفي الثمانينيات ظهر التعلم الآلي نهجاً جديداً للذكاء الاصطناعي والذي سمح للآلات بالتعلم من البيانات وتحسين أدائها بمرور الوقت.على الرغم من التقدم الكبير، لكن واجه الذكاء الاصطناعي عدة انتكاسات في التسعينيات بسبب القيود التقنية وخفض التمويل، ومع ذلك استعاد هذا المجال الزخم في القرن الواحد والعشرين؛ وذلك بفضل توفر كميات كبيرة من البيانات وموارد الحوسبة القوية، واليوم يُستخدم الذكاء الاصطناعي في مجموعة واسعة من التطبيقات مثل التعرف إلى الصور والكلام؛ لذلك سيكون مستقبل الذكاء الاصطناعي حافلاً بالفوائد، وستتعدد بمرور الوقت مجالاته.';
  late LessonModel lesson;

  init() {
    lesson = Get.arguments['lesson'];
    if (lesson?.description != null && lesson!.description!.isNotEmpty)
      text = lesson.description!;
  }

  @override
  Widget build(BuildContext context) {
    init();

    return Scaffold(
      appBar: CustomAppBarWidget(),
      body: DefaultScaffoldWidget(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p4),
          child: SingleChildScrollView(
            child: ContainerAuthWidget(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      text,
                      style: StylesManager.textNormalStyle(
                              color: ColorManager.blackColor, size: 14.sp)
                          ?.copyWith(height: 1.8, wordSpacing: 4),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Visibility(
                    visible: lesson.imagesPath.isNotEmpty,
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  Visibility(
                    visible: lesson.imagesPath.isNotEmpty,
                    child: CarouselSlider(
                        options: CarouselOptions(
                          height: MediaQuery.sizeOf(context).height / 3,
                          clipBehavior: Clip.hardEdge,
                          enlargeFactor: 0.3,
                          viewportFraction: 0.8,
                          enableInfiniteScroll: false,
                        ),
                        items: lesson.imagesPath
                            .map(
                              (e) => InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(20),
                                                child: Image.network(e),
                                              ),
                                              PositionedDirectional(
                                                top: 10.sp,
                                                start: 10.sp,
                                                child: IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: CircleAvatar(
                                                      backgroundColor:
                                                          ColorManager
                                                              .whiteColor,
                                                      child: Icon(
                                                        Icons.close,
                                                        color: ColorManager
                                                            .errorColor,
                                                      ),
                                                    )),
                                              )
                                            ],
                                          ));
                                },
                                child: Container(
                                  clipBehavior: Clip.hardEdge,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14.r),
                                      border: Border.all(
                                          color: ColorManager.primaryColor,
                                          width: 2)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: Image.network(
                                      e,
                                      width: MediaQuery.sizeOf(context).width,
                                      height: MediaQuery.sizeOf(context).width,

                                      // fit: BoxFit.cover,
                                      // loadingBuilder: (_, __, ___) =>
                                      //     Center(child: CircularProgressIndicator()),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
