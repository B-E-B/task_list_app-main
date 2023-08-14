import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final Color titleColor;
  final Color backgroundColor;
  final List<Widget>? actions;

  const MyAppBar({
    Key? key,
    required this.title,
    this.centerTitle = true,
    this.titleColor = Colors.black,
    this.backgroundColor = Colors.cyan,
    this.actions,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: FittedBox(
        fit: BoxFit.fitWidth,
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: titleColor,
          ),
        ),
      ),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      actions: actions,
    );
  }
}
