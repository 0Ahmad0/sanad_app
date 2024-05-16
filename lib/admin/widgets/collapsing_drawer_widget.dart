import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sanad_app/app/core/helper/sizer_media_query.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';
import 'package:sanad_app/app/core/utils/values_manager.dart';

class CollapsingNavigationDrawer extends StatefulWidget {
  const CollapsingNavigationDrawer({super.key});

  @override
  _CollapsingNavigationDrawerState createState() =>
      _CollapsingNavigationDrawerState();
}

class _CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer>
    with SingleTickerProviderStateMixin {
  double maxWidth = 290.0;
  double minWidth = 100.0;
  bool isCollpased = false;
  late AnimationController _animationController;
  late Animation<double> widthAnimation;
  int currentSelectedIndex = 0;

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
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) => getWidget(context, widget),
    );
  }

  /// ---------------------------
  /// Building a home widget with Animated Builder.
  /// ---------------------------

  Widget getWidget(context, widget) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: getHeight(context) / 8),
        width: widthAnimation.value,
        decoration: const BoxDecoration(
            color: ColorManager.primaryColor,
            borderRadius: BorderRadius.horizontal(left: Radius.circular(24))),
        child: Column(
          children: <Widget>[
            CollapsingListTile(
                onTap: () {},
                isSelected: false,
                image: '',
                title: 'John',
                icon: Icons.person,
                animationController: _animationController),
            const Divider(
              color: Colors.grey,
              height: 40.0,
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, counter) {
                  return const Divider(
                    height: 12.0,
                  );
                },
                itemBuilder: (context, counter) {
                  return CollapsingListTile(
                      onTap: () {
                        setState(() {
                          currentSelectedIndex = counter;
                        });
                      },
                      isSelected: currentSelectedIndex == counter,
                      title: navigationItem[counter].title,
                      icon: navigationItem[counter].icon,
                      animationController: _animationController);
                },
                itemCount: navigationItem.length,
              ),
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

                /// ---------------------------
                /// Animated Icon List with Title widget for Animated Builder.
                /// ---------------------------

                child: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: _animationController,
                  color: Colors.white,
                  size: 40.0,
                )),
            const SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------------------
///  List Tile   widget for Drawer items.
/// ---------------------------

class CollapsingListTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final AnimationController animationController;
  final bool isSelected;
  final Function() onTap;
  final String? image;
  Color selectedColor = const Color(0xFF4AC8EA);

  CollapsingListTile({super.key,
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
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          color: widget.isSelected
              ? Colors.transparent.withOpacity(0.3)
              : Colors.transparent,
        ),
        width: widthAnimation.value,
        margin: const EdgeInsets.symmetric(horizontal: AppMargin.m8,vertical: AppMargin.m8),
        padding: const EdgeInsets.symmetric( vertical: AppPadding.p4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: (widthAnimation.value >= 220)?MainAxisAlignment.start:MainAxisAlignment.center,
          children: <Widget>[
            widget.image == null ?Icon(
              widget.icon,
              color: widget.isSelected ? selectedColor : Colors.white30,
              size: 38.0,
            ) : CircleAvatar(
              radius: 24,
            ),
            SizedBox(
              width: sizedBoxAnimation.value,
            ),
            (widthAnimation.value >= 220)
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

/// ---------------------------
///  Model list item drawer.
/// ---------------------------

class NavigationItem {
  String title;
  IconData icon;

  NavigationItem({required this.title, required this.icon});
}

/// ---------------------------
///  Placeholder Model list items drawer.
/// ---------------------------

List<NavigationItem> navigationItem = [
  NavigationItem(title: 'Dashboard', icon: Icons.home),
  NavigationItem(title: 'Favorites', icon: Icons.favorite),
  NavigationItem(title: 'Music Videos', icon: Icons.music_video),
  NavigationItem(title: 'Notification', icon: Icons.notifications),
  NavigationItem(title: 'Settings', icon: Icons.settings)
];

/// ---------------------------
///  Some extras styling and colors.
/// ---------------------------

TextStyle listTileDefaultStyle = const TextStyle(
    color: Colors.white70, fontSize: 20.0, fontWeight: FontWeight.w600);
TextStyle listTileSelectedStyle = const TextStyle(
    color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600);

Color selectedColor = const Color(0xFF4AC8EA);
Color drawerBackgroundColor = const Color(0xFF272D34);
