
import 'package:flutter/material.dart';
import 'package:sanad_app/app/core/utils/color_manager.dart';

class CollapsingNavigationDrawer extends StatefulWidget {
  const CollapsingNavigationDrawer({super.key});

  @override
  _CollapsingNavigationDrawerState createState() =>
      _CollapsingNavigationDrawerState();
}

class _CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer>
    with SingleTickerProviderStateMixin {
  double maxWidth = 290.0;
  double minWidth = 70.0;
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
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    widthAnimation = Tween<double>(begin: maxWidth, end: minWidth)
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
        width: widthAnimation.value,
        decoration: BoxDecoration(
            color: ColorManager.primaryColor,
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(24))),
        child: Column(
          children: <Widget>[

            CollapsingListTile(
                onTap: () {},
                isSelected: false,
                title: 'John',
                icon: Icons.person,
                animationController: _animationController),

            Divider(
              color: Colors.grey,
              height: 40.0,
            ),

            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, counter) {
                  return Divider(
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
                    isCollpased
                        ? _animationController.forward()
                        : _animationController.reverse();
                  });
                },

                /// ---------------------------
                /// Animated Icon List with Title widget for Animated Builder.
                /// ---------------------------

                child: AnimatedIcon(
                  icon: AnimatedIcons.close_menu,
                  progress: _animationController,
                  color: Colors.white,
                  size: 40.0,
                )),
            SizedBox(
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
  Color selectedColor = Color(0xFF4AC8EA);

  CollapsingListTile(
      {required this.title,
      required this.icon,
      required this.animationController,
      required this.isSelected,
      required this.onTap});

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
    widthAnimation = Tween<double>(begin: maxWidth, end: minWidth)
        .animate(widget.animationController);
    sizedBoxAnimation = Tween<double>(begin: 10.0, end: 0.0)
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
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: widget.isSelected
              ? Colors.transparent.withOpacity(0.3)
              : Colors.transparent,
        ),
        width: widthAnimation.value,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: new Row(
          children: <Widget>[
            Icon(
              widget.icon,
              color: widget.isSelected ? selectedColor : Colors.white30,
              size: 38.0,
            ),
            SizedBox(
              width: sizedBoxAnimation.value,
            ),
            (widthAnimation.value >= 220)
                ? Text(
                    widget.title,
                    style: widget.isSelected
                        ? listTileSelectedStyle
                        : listTileDefaultStyle,
                  )
                : Container()
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

TextStyle listTileDefaultStyle = TextStyle(
    color: Colors.white70, fontSize: 20.0, fontWeight: FontWeight.w600);
TextStyle listTileSelectedStyle =
    TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600);

Color selectedColor = Color(0xFF4AC8EA);
Color drawerBackgroundColor = Color(0xFF272D34);
