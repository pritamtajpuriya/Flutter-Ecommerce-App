import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SajilodokanBottomMenu extends StatelessWidget {
  final int? bottomMenuIndex;
  final ValueChanged<int>? onChanged;
  SajilodokanBottomMenu({this.bottomMenuIndex, this.onChanged});

  BottomNavigationBarItem getItem(
    String image,
    String title,
    int index,
    ThemeData theme,
  ) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        image,
        height: 24.0,
        width: 24.0,
        color: bottomMenuIndex == index
            ? theme.primaryColor
            : theme.primaryColorLight,
      ),
      label: title,
    );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    List<BottomNavigationBarItem> items = [
      getItem('assets/icons/bottom_menu/home.svg', 'Home', 0, _theme),
      getItem('assets/icons/bottom_menu/menu.svg', 'Categories', 1, _theme),
      getItem('assets/icons/bottom_menu/cart.svg', 'Cart', 2, _theme),
      getItem('assets/icons/bottom_menu/profile.svg', 'Account', 3, _theme)
    ];
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: bottomMenuIndex!,
          onTap: (value) {
            switch (value) {
              case 0:
                onChanged!(0);
                break;

              case 1:
                onChanged!(1);
                break;
              case 2:
                onChanged!(2);
                break;
              case 3:
                onChanged!(3);
                break;
            }
          },
          items: items,
          selectedItemColor: _theme.primaryColor,
          unselectedItemColor: _theme.primaryColorLight,
          unselectedIconTheme: IconThemeData(size: 30),
          selectedIconTheme: IconThemeData(size: 34),
        ),
      ),
    );
  }
}
