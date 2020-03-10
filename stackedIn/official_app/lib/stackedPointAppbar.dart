import 'package:flutter/material.dart';

class stackedInAppBar extends StatefulWidget with PreferredSizeWidget{
  @override
  _stackedInAppBarState createState() => _stackedInAppBarState();
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _stackedInAppBarState extends State<stackedInAppBar> {
  @override
  Widget build(BuildContext context) {
    int _stackedPoint=800;
    return AppBar(
      title: Text("StackedPoint: ${_stackedPoint.toString()}"),
    );
  }
}
