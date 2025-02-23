import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sanad_app/app/widgets/button_app_widget.dart';
import 'package:sanad_app/app/widgets/constants_widgets.dart';
import 'package:sanad_app/app/widgets/custom_appbar_widget.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';

import 'app/widgets/textfield_app.dart';

void main() {
  runApp(TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(backgroundColor: Colors.greenAccent)),
      home: ScreenOne(),
    );
  }
}

class ScreenOne extends StatelessWidget {
  const ScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(),
      body: DefaultScaffoldWidget(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Text('Ahmad'),
              Text('Layan'),
              Text('Sara'),
              Text(
                'Mohamad',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Divider(),
              ButtonAppWidget(onPressed: () {}, text: 'Print Ahmad'),
              Divider(),
              TextButton(
                  onPressed: () {
                    Get.to(() => ScreenTow());
                  },
                  child: Text(
                    'Go To Next Screen',
                  )),
              Divider(),
              Row(
                children: [
                  Text('Ahmad'),
                  Text('Layan'),
                  Text('Sara'),
                  Text('Mohamad'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ScreenTow extends StatefulWidget {
  const ScreenTow({super.key});

  @override
  State<ScreenTow> createState() => _ScreenTowState();
}

class _ScreenTowState extends State<ScreenTow> {
  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultScaffoldWidget(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Back To One Screen')),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _keyForm,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.length != 5) {
                        return 'False';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: Icon(Icons.data_exploration),
                      prefixIcon: Icon(Icons.place),
                      hintText: 'Enter Phone',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red, width: 3)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.red, width: 3)),
                    ),
                  ),
                ),
              ),
              Divider(),
              Divider(),
              ButtonAppWidget(onPressed: () {
                if(_keyForm.currentState!.validate()){
                 ConstantsWidgets.TOAST(context,textToast: 'True');
                }
                ConstantsWidgets.TOAST(context,textToast: 'false');

              }, text: 'VAlidate'),
              Divider(),
              Divider(),
              TextFiledApp(
                hintText: "Enter Name",
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
