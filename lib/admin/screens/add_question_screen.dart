
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sanad_app/app/core/helper/sizer_media_query.dart';
import 'package:sanad_app/app/core/utils/app_string.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';
import 'package:sanad_app/app/core/utils/styles_manager.dart';
import 'package:sanad_app/app/core/utils/values_manager.dart';
import 'package:sanad_app/app/screens/auth/widgets/divider_auth_widgets.dart';
import 'package:sanad_app/app/widgets/button_app_widget.dart';
import 'package:sanad_app/app/widgets/custom_appbar_widget.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';
import 'package:sanad_app/app/widgets/textfield_app.dart';

import '../../app/models/question_model.dart';

class AddQuestionPage extends StatefulWidget {
  final Function(Question) onSave;

  AddQuestionPage({required this.onSave});

  @override
  _AddQuestionPageState createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  final _formKey = GlobalKey<FormState>();
  final _questionController = TextEditingController();
  final List<TextEditingController> _optionControllers =
      List.generate(4, (_) => TextEditingController());
  int _correctOptionIndex = -1;

  Future<void> _saveQuestion() async {
    if (_formKey.currentState?.validate() ?? false) {
      final question = Question(
        text: _questionController.text,
        options:
            _optionControllers.map((controller) => controller.text).toList(),
        correctOptionIndex: _correctOptionIndex,
      );
      await widget.onSave(question);
      // Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(),
      body: DefaultScaffoldWidget(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppString.addQuestion,
                    style: StylesManager.textBoldStyle(
                        color: ColorManager.primaryColor
                    ),
                  ),
                  SizedBox(height: AppSize.s20),
                  TextFiledApp(
                    minLine: 1,
                    maxLine: 3,
                    suffixIcon: false,
                    noPrefixIcon: true,
                    controller: _questionController,
                    hintText: AppString.question,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppString.pleaseEnterQuestion;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: AppSize.s20),
                  const DividerAuthWidget(),
                  SizedBox(height: AppSize.s20),
                  ...List.generate(4, (index) {
                    return Column(
                      children: [
                        TextFiledApp(
                          suffixIcon: false,
                          noPrefixIcon: true,
                          controller: _optionControllers[index],
                          hintText: AppString.option + '${index + 1}',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppString.pleaseEnterOption + ' ${index + 1}';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s20,
                        ),
                      ],
                    );
                  }),
                  SizedBox(height: AppSize.s10),
                  Text(
                    AppString.selectTheCorrectOption,
                    style: StylesManager.textBoldStyle(
                      color: ColorManager.primaryColor
                    ),
                  ),
                  SizedBox(height: AppSize.s10),
                  StatefulBuilder(
                    builder: (context,setStateOption) {
                      return Wrap(
                        alignment: WrapAlignment.center,
                        children: List.generate(4, (index) {
                            return SizedBox(
                              width: (getWidth(context) / 2) - 18,
                              child: RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(AppString.option + '${index + 1}'),
                                value: index,
                                groupValue: _correctOptionIndex,
                                onChanged: (value) {
                                  setStateOption(() {
                                    _correctOptionIndex = value as int;
                                  });
                                },
                              ),
                            );
        
                        }),
                      );
                    }
                  ),
                  SizedBox(height: AppSize.s20),
                  ButtonAppWidget(
                      onPressed: _saveQuestion, text: AppString.saveQuestion)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    _optionControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }
}
