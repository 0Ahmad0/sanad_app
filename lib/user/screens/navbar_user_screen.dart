import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import '../../app/core/helper/helpers.dart';
import '../../app/core/utils/app_string.dart';
import '../../app/core/utils/assets_manager.dart';
import '../../app/core/utils/color_manager.dart';
import '../../app/core/utils/styles_manager.dart';
import '../../app/core/utils/values_manager.dart';
import '../../app/screens/profile_screen.dart';
import 'home_user_screen.dart';
import 'lessons_user_screen.dart';


class NavbarUserScreen extends StatefulWidget {
  const NavbarUserScreen({Key? key}) : super(key: key);

  @override
  _NavbarUserScreenState createState() => _NavbarUserScreenState();
}

class _NavbarUserScreenState extends State<NavbarUserScreen> {
  int _selectedItemPosition = 1;
  List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
        icon: Image.asset(AssetsManager.profileIcon),
        activeIcon: Image.asset(
          AssetsManager.profileIcon,
          color: ColorManager.whiteColor,
        ),
        label: AppString.userAccount),
    BottomNavigationBarItem(
      icon: Image.asset(AssetsManager.homeIcon),
      activeIcon: Image.asset(
        AssetsManager.homeIcon,
        color: ColorManager.whiteColor,
      ),
      label: AppString.homeUser,
    ),
    BottomNavigationBarItem(
      icon: Image.asset(
        AssetsManager.lessonIcon,
      ),
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
      label: AppString.aneerName,
    ),
  ];
  List<Widget> _screens = [
    ProfileScreen(showNourIcon:true),
    HomeUserScreen(),
    LessonUserScreen(),
    SizedBox()
  ];
  List<String?> _audios = [
    AssetsManager.editProfileScreenSound,
    AssetsManager.homeScreenSound,
    AssetsManager.lessonsScreenSound,

    null
  ];

  @override
  void initState() {
    // Get.lazyPut(() => ProfileController());
    // ProfileController.instance.getUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: _screens[_selectedItemPosition],
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 0.0,
        backgroundColor: ColorManager.whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        onPressed: () async {
          ///TODO turn on أنير
          print(_audios[_selectedItemPosition]);
          turnAudio(_audios[_selectedItemPosition]);

        },
        label: Column(
          children: [
            Image.asset(
              AssetsManager.nourSoundIcon,
            ),
            Text(
              AppString.aneerName,
              style: StylesManager.textBoldStyle(
                size: 10.sp,
                color: ColorManager.primaryColor
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        selectedItemColor: ColorManager.whiteColor,
        unselectedItemColor: ColorManager.primaryColor,
        snakeViewColor: ColorManager.primaryColor,
        padding: EdgeInsets.symmetric(
            horizontal: AppPadding.p14, vertical: AppPadding.p20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.r),
        ),
        snakeShape: SnakeShape.circle,
        showSelectedLabels: true,
        backgroundColor: ColorManager.whiteColor,
        showUnselectedLabels: true,
        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() => _selectedItemPosition = index),
        items: _items,
        unselectedLabelStyle: StylesManager.textBoldStyle(
          size: 10.sp,
          color: ColorManager.primaryColor,
        ),
      ),
    );
  }
}
