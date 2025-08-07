import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wcycle_bd_store/api/firebase_api.dart';
import 'package:wcycle_bd_store/common/dimensions/phone_size.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';
import 'package:wcycle_bd_store/data/model/local/menu_item_model.dart';
import 'package:wcycle_bd_store/presentation/main_screen/widgets/bottom_sections.dart';
import 'package:wcycle_bd_store/presentation/main_screen/widgets/profile_sections.dart';
import 'package:wcycle_bd_store/presentation/main_screen/widgets/side_menu_item.dart';

final fsApis = FirebaseApi();
final menuItemData = [
  MenuItemModel(itemTittle: "Home", itemIcon: FontAwesomeIcons.house),
  MenuItemModel(
      itemTittle: "Waste Collections", itemIcon: FontAwesomeIcons.dumpster),
  MenuItemModel(itemTittle: "Payment", itemIcon: FontAwesomeIcons.moneyBill1),
  MenuItemModel(itemTittle: "Statistics", itemIcon: FontAwesomeIcons.chartPie),
];

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int activeSlide = 0;
  @override
  Widget build(BuildContext context) {
    final screenWidth = PhoneSize.deviceWidth(context);
    final screenHeight = PhoneSize.deviceHeight(context);
    return Container(
      width: screenWidth / 1.5,
      height: screenHeight,
      decoration: const BoxDecoration(color: AppColor.kDarkColor),
      padding: const EdgeInsets.all(12),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              const ProfileSections(),
              const Divider(),
              for (final menuItem in menuItemData)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    decoration: menuItemData.indexOf(menuItem) == activeSlide
                        ? BoxDecoration(
                            color: AppColor.kPrimaryColor,
                            borderRadius: BorderRadius.circular(10))
                        : null,
                    child: SideMenuItem(
                      itemTittle: menuItem.itemTittle,
                      itemIcons: menuItem.itemIcon,
                      itemFn: () {
                        setState(() {
                          activeSlide = menuItemData.indexOf(menuItem);
                        });
                      },
                    ),
                  ),
                ),
              const Spacer(),
              const BottomSections()
            ],
          ),
        ],
      ),
    );
  }
}
