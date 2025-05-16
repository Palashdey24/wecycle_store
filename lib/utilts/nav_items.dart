import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';

enum NavItems {
  home,
  order,
  service,
  setting;

  IconData? get iconData {
    switch (this) {
      case home:
        return FontAwesomeIcons.house;
      case order:
        return FontAwesomeIcons.basketShopping;
      case service:
        return FontAwesomeIcons.table;
      case setting:
        return FontAwesomeIcons.userGear;
    }
  }

  Color? get color {
    switch (this) {
      case home:
        return Colors.green;
      case order:
        return Colors.blue;
      case service:
        return Colors.yellowAccent;
      case setting:
        return Colors.black;
    }
  }

  String get tittle {
    switch (this) {
      case home:
        return "Home";
      case order:
        return "Order";
      case service:
        return "Service";
      case setting:
        return "Setting";
    }
  }

  BottomBarItem get navOptions {
    return BottomBarItem(
      inActiveItem: FaIcon(
        iconData,
        color: AppColor.kPrimaryColor,
      ),
      activeItem: FaIcon(
        iconData,
        color: color,
      ),
      itemLabel: tittle,
    );
  }
}
