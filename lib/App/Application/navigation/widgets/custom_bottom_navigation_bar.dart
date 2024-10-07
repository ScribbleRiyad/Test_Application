import 'dart:io';
import 'package:flutter/material.dart';


class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar(
      {super.key, required this.items,
      this.onTap,
      required this.selectedIndex,
      required this.unSelectedColor,
      required this.selectedColor,
      required this.labelStyle,
      this.unSelectedTextStyle,});

  final List<CustomBottomNavigationBarItem> items;
  final ValueChanged<int>? onTap;
  final int selectedIndex;
  final Color unSelectedColor;
  final Color selectedColor;
  final TextStyle labelStyle;
  final TextStyle? unSelectedTextStyle;


  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState
    extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _createItemTiles(),
    );
  }

  List<Widget> _createItemTiles() {
    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i < widget.items.length; i++) {
      tiles.add(_BottomNavigationBarTile(
          item: widget.items[i],
          selected: i == widget.selectedIndex,
          onTap: () {
            widget.onTap?.call(i);
          }));
    }
    return tiles;
  }
}

class _BottomNavigationBarTile extends StatelessWidget {
  const _BottomNavigationBarTile(
      {this.onTap, required this.item, required this.selected});

  final VoidCallback? onTap;
  final CustomBottomNavigationBarItem item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(

            padding:  EdgeInsets.symmetric(horizontal:Platform.isAndroid? 10.0:15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                item.topIcon!,
                const SizedBox(height: 6,),
                item.icon,
                item.title!,
                item.bottomIcon!
              ],
            )));
  }
}

class CustomBottomNavigationBarItem {
  final Widget icon;
  final Widget selectedIcon;
  final Widget? bottomIcon;
  final Widget? topIcon;
  final Widget? title;

  CustomBottomNavigationBarItem(
      {required this.icon,
      Widget? selectedIcon,
      this.bottomIcon,
      this.topIcon,
      this.title})
      : selectedIcon = selectedIcon ?? icon;
}
