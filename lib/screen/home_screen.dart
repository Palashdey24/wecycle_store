import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';
import 'package:wcycle_bd_store/pages/home_pages.dart';
import 'package:wcycle_bd_store/pages/order_pages.dart';
import 'package:wcycle_bd_store/pages/setting_pages.dart';
import 'package:wcycle_bd_store/pages/services_pages.dart';

import 'package:wcycle_bd_store/utilts/nav_items.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _notchBottomBarContro = NotchBottomBarController(index: 0);
  static const int kDurationMiSec = 200;
  int navIndex = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _notchBottomBarContro.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        bottomNavigationBar: AnimatedNotchBottomBar(
            notchBottomBarController: _notchBottomBarContro,
            durationInMilliSeconds: kDurationMiSec,
            textAlign: TextAlign.center,
            color: AppColor.kSecondColor,
            showShadow: true,
            shadowElevation: 12,
            notchGradient: const LinearGradient(
                end: Alignment.topLeft,
                begin: FractionalOffset.bottomRight,
                colors: [AppColor.kPrimaryColor, Colors.grey]),
            itemLabelStyle: const TextStyle(
                color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
            bottomBarItems: NavItems.values
                .map(
                  (e) => e.navOptions,
                )
                .toList(),
            onTap: (value) {
              setState(() {});
            },
            kIconSize: 5,
            kBottomRadius: 20),
        body: IndexedStack(
          index: _notchBottomBarContro.index,
          children: const [
            HomePages(),
            OrderPages(),
            ServicePages(),
            SettingPages()
          ],
        ));
  }
}
