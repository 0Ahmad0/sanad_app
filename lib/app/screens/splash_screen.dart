import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultScaffoldWidget(
        child: Center(
          child: ZoomIn(child: Image.asset('assets/images/logo.png')),
        ),

      ),
    );
  }
}
