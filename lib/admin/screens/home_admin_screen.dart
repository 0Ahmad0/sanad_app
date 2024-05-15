import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';

import '../widgets/collapsing_drawer_widget.dart';

class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CollapsingNavigationDrawer(),
    );
  }
}
