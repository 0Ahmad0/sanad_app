import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sanad_app/app/controller/admin_controller.dart';
import 'package:sanad_app/app/core/helper/sizer_media_query.dart';
import 'package:sanad_app/app/core/utils/app_string.dart';
import 'package:sanad_app/app/core/utils/assets_manager.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';
import 'package:sanad_app/app/core/utils/styles_manager.dart';
import 'package:sanad_app/app/core/utils/values_manager.dart';

import '../../app/controller/profile_controller.dart';
import '../../app/screens/auth/widgets/circle_profile_widget.dart';

class CollapsingNavigationDrawer extends StatefulWidget {
  const CollapsingNavigationDrawer({super.key});

  @override
  _CollapsingNavigationDrawerState createState() =>
      _CollapsingNavigationDrawerState();
}

class _CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer>
    with SingleTickerProviderStateMixin {
  double maxWidth = 200.0;
  double minWidth = 80.0;
  bool isCollpased = false;
  late AnimationController _animationController;
  late Animation<double> widthAnimation;
  // int currentSelectedIndex = -1;

  /// ---------------------------
  /// Initializing AnimationController Drawer and configs to it.
  /// ---------------------------

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    widthAnimation = Tween<double>(begin: minWidth, end: maxWidth)
        .animate(_animationController);
  }

  /// ---------------------------
  /// Building Animated Builder Drawer and state.
  /// ---------------------------

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminController());
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) => getWidget(context, widget, controller),
    );
  }

  /// ---------------------------
  /// Building a home widget with Animated Builder.
  /// ---------------------------

  Widget getWidget(context, widget, AdminController controller) {
    return GetBuilder<AdminController>(
        init: AdminController(),
        builder: (adminController) {
          return Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: getHeight(context) / 14),
              width: widthAnimation.value,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: ColorManager.blackColor.withOpacity(.3),
                        offset: Offset(-4, 4),
                        blurRadius: 8),
                  ],
                  color: ColorManager.primaryColor,
                  borderRadius:
                      BorderRadius.horizontal(left: Radius.circular(24))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  GetBuilder<ProfileController>(
                    // init: profileController,
                      builder: (controller) {
                        return  CollapsingListTileForImage(
                            onTap: () {},
                            title: controller.currentUser?.value?.name??'',
                            icon: 'https',
                            animationController: _animationController);
                      }
                  ),

                  const Divider(
                    color: ColorManager.greyColor,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, counter) {
                        return CollapsingListTile(
                            onTap: () {
                              setState(() {
                                adminController.currentIndex = counter;
                                adminController.changePage(counter);
                              });
                            },
                            isSelected: adminController.currentIndex == counter,
                            title: navigationItem[counter].title,
                            icon: navigationItem[counter].icon,
                            animationController: _animationController);
                      },
                      itemCount: navigationItem.length,
                    ),
                  ),
                  const Divider(
                    color: ColorManager.greyColor,
                  ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          isCollpased = !isCollpased;
                          !isCollpased
                              ? _animationController.forward()
                              : _animationController.reverse();
                        });
                      },
                      child: AnimatedIcon(
                        icon: AnimatedIcons.menu_close,
                        progress: _animationController,
                        color: Colors.white,
                        size: 30.sp,
                      )),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

/// ---------------------------
///  List Tile   widget for Drawer items.
/// ---------------------------

class CollapsingListTile extends StatefulWidget {
  final String title;
  final String icon;
  final AnimationController animationController;
  final bool isSelected;
  final Function() onTap;
  final String? image;
  Color selectedColor = const Color(0xFF4AC8EA);

  CollapsingListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.animationController,
    required this.isSelected,
    required this.onTap,
    this.image,
  });

  @override
  _CollapsingListTileState createState() => _CollapsingListTileState();
}

class _CollapsingListTileState extends State<CollapsingListTile> {
  late Animation<double> widthAnimation, sizedBoxAnimation;
  double maxWidth = 220.0;
  double minWidth = 70.0;

  /// ---------------------------
  ///  Iniliaz ainmation and sizes for list item drawer.
  /// ---------------------------

  @override
  void initState() {
    super.initState();
    widthAnimation = Tween<double>(begin: minWidth, end: maxWidth)
        .animate(widget.animationController);
    sizedBoxAnimation = Tween<double>(begin: 0.0, end: 10.0)
        .animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    /// ---------------------------
    ///  Building drawer item list.
    /// ---------------------------

    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: 40.sp,
        height: 40.sp,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          color: widget.isSelected
              ? ColorManager.whiteColor.withOpacity(.3)
              : Colors.transparent,
        ),
        margin: const EdgeInsets.symmetric(
            horizontal: AppMargin.m8, vertical: AppMargin.m8),
        padding: const EdgeInsets.symmetric(
            vertical: AppPadding.p4, horizontal: AppPadding.p4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: (widthAnimation.value >= 200)
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: <Widget>[
            widget.image == null
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p4),
                    child: Image.asset(
                      widget.icon,
                      width: 30.sp,
                      height: 30.sp,
                      fit: BoxFit.cover,
                      color: !widget.isSelected
                          ? ColorManager.whiteColor
                          : Colors.white,
                    ),
                  )
                : CircleAvatar(
                    radius: 24,
                  ),
            SizedBox(
              width: sizedBoxAnimation.value,
            ),
            (widthAnimation.value >= 200)
                ? Text(
                    widget.title,
                    style: !widget.isSelected
                        ? listTileSelectedStyle
                        : listTileDefaultStyle,
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

class CollapsingListTileForImage extends StatefulWidget {
  final String title;
  final String icon;
  final AnimationController animationController;
  final Function() onTap;

  CollapsingListTileForImage({
    super.key,
    required this.title,
    required this.icon,
    required this.animationController,
    required this.onTap,
  });

  @override
  _CollapsingListTileForImageState createState() =>
      _CollapsingListTileForImageState();
}

class _CollapsingListTileForImageState
    extends State<CollapsingListTileForImage> {
  late Animation<double> widthAnimation, sizedBoxAnimation;
  double maxWidth = 220.0;
  double minWidth = 70.0;

  /// ---------------------------
  ///  Iniliaz ainmation and sizes for list item drawer.
  /// ---------------------------

  @override
  void initState() {
    super.initState();
    widthAnimation = Tween<double>(begin: minWidth, end: maxWidth)
        .animate(widget.animationController);
    sizedBoxAnimation = Tween<double>(begin: 0.0, end: 10.0)
        .animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    /// ---------------------------
    ///  Building drawer item list.
    /// ---------------------------

    return Container(
      height: 75.sp,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      padding: const EdgeInsets.symmetric(
          vertical: AppPadding.p4, horizontal: AppPadding.p4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: (widthAnimation.value >= 200)
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: <Widget>[

          CircleAvatar(
            radius: 28.sp,
            child: CircleProfilePictureWidget(
              path: ProfileController.instance.currentUser?.value?.photoUrl,
            ),
          ),
          SizedBox(
            width: sizedBoxAnimation.value,
          ),
          (widthAnimation.value >= 200)
              ? Text(
                  widget.title,
                  style: StylesManager.textNormalStyle(),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}

/// ---------------------------
///  Model list item drawer.
/// ---------------------------

class NavigationItem {
  String title;
  String icon;

  NavigationItem({required this.title, required this.icon});
}

/// ---------------------------
///  Placeholder Model list items drawer.
/// ---------------------------

List<NavigationItem> navigationItem = [
  NavigationItem(title:'Dashboard'/*'Dashboard'*/, icon: AssetsManager.adminDrawer1Icon),
  NavigationItem(title:'Favorites' /*'Favorites'*/, icon: AssetsManager.adminDrawer2Icon),
  NavigationItem(title:'Music Videos' /*'Music Videos'*/, icon: AssetsManager.adminDrawer3Icon),
  NavigationItem(title:'Notification' /*'Notification'*/, icon: AssetsManager.adminDrawer4Icon),
  NavigationItem(title:'Notification' /*'Notification'*/, icon: AssetsManager.adminDrawer5Icon),
  NavigationItem(title:'Settings' /*'Settings'*/, icon: AssetsManager.logoutIcon)
];

/// ---------------------------
///  Some extras styling and colors.
/// ---------------------------

TextStyle listTileDefaultStyle = TextStyle(
    color: Colors.white70,
    fontWeight: FontWeight.w600,
    fontFamily: GoogleFonts.cairo().fontFamily);
TextStyle listTileSelectedStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontFamily: GoogleFonts.cairo().fontFamily);

Color selectedColor = const Color(0xFF4AC8EA);
Color drawerBackgroundColor = const Color(0xFF272D34);
