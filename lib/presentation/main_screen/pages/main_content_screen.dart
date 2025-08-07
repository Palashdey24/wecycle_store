import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd_store/common/helper/navigator/app_navigator.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';
import 'package:wcycle_bd_store/data/model/local/nav_items_model.dart';
import 'package:wcycle_bd_store/presentation/home/pages/home_pages.dart';
import 'package:wcycle_bd_store/presentation/order/pages/order_pages.dart';
import 'package:wcycle_bd_store/presentation/services/pages/services_pages.dart';
import 'package:wcycle_bd_store/presentation/setting/pages/setting_pages.dart';

class MainContentScreen extends ConsumerStatefulWidget {
  const MainContentScreen({super.key});

  @override
  ConsumerState<MainContentScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<MainContentScreen> {
  final _notchBottomBarContro = NotchBottomBarController(index: 0);
  static const int kDurationMiSec = 200;
  int navIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
            bottomBarItems: NavItemsModel.values
                .map(
                  (e) => e.navOptions,
                )
                .toList(),
            onTap: (value) {
              setState(() {
                if (value == 1) {
                  _notchBottomBarContro.index = 0;
                  AppNavigatior.navigatorPush(context, const OrderPages());
                }
              });
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
