import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:sanad_app/app/core/utils/app_string.dart';
import 'package:sanad_app/app/core/utils/assets_manager.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';
import 'package:sanad_app/app/core/utils/styles_manager.dart';
import 'package:sanad_app/app/core/utils/values_manager.dart';
import 'package:sanad_app/app/screens/auth/widgets/circle_profile_widget.dart';
import 'package:sanad_app/app/screens/profile_screen.dart';
import 'package:sanad_app/app/widgets/custom_appbar_widget.dart';
import 'package:sanad_app/app/widgets/default_scaffold.dart';
import 'package:sanad_app/user/screens/home_user_screen.dart';
import 'package:sanad_app/user/screens/lessons_user_screen.dart';

class NavbarUserScreen extends StatefulWidget {
  const NavbarUserScreen({Key? key}) : super(key: key);

  @override
  _NavbarUserScreenState createState() => _NavbarUserScreenState();
}

class _NavbarUserScreenState extends State<NavbarUserScreen> {
  int _selectedItemPosition = 0;
  List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
        icon: Image.asset(AssetsManager.profileIcon),
        activeIcon: Image.asset(AssetsManager.profileIcon,color: ColorManager.whiteColor,),
        label: AppString.userAccount),
    BottomNavigationBarItem(
      icon: Image.asset(AssetsManager.homeIcon),
      activeIcon: Image.asset(AssetsManager.homeIcon,color: ColorManager.whiteColor,),
      label: AppString.homeUser,
    ),
    BottomNavigationBarItem(
      icon: Image.asset(AssetsManager.lessonIcon,),
      activeIcon: Image.asset(
        AssetsManager.lessonIcon,
        color: ColorManager.whiteColor,
      ),
      label: AppString.lessons,
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        AssetsManager.nourSoundIcon,
      ),
      activeIcon: Image.asset(
        AssetsManager.nourSoundIcon,
        color: ColorManager.whiteColor,
      ),
      label: AppString.nourName,
    ),
  ];
  List<Widget> _screens =[
    ProfileScreen(),
    HomeUserScreen(),
    LessonUserScreen(),
    HomeUserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: _screens[_selectedItemPosition],
      bottomNavigationBar: SnakeNavigationBar.color(
        selectedItemColor: ColorManager.whiteColor,
        unselectedItemColor: ColorManager.primaryColor,
        snakeViewColor: ColorManager.primaryColor,
        padding: EdgeInsets.all(AppPadding.p20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.r),
        ),
        snakeShape: SnakeShape.circle,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() => _selectedItemPosition = index),
        items: _items,
        unselectedLabelStyle: StylesManager.textNormalStyle(
            size: 10.sp, color: ColorManager.primaryColor),
      ),
    );
  }
}
