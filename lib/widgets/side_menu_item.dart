import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';

class SideMenuItem extends StatelessWidget {
  const SideMenuItem(
      {super.key,
      required this.itemTittle,
      required this.itemIcons,
      required this.itemFn});

  final String itemTittle;
  final IconData itemIcons;
  final void Function() itemFn;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: itemFn,
      child: ListTile(
        leading: FaIcon(
          itemIcons,
          size: 20,
          color: Colors.blueGrey,
        ),
        title: Text(
          itemTittle,
          style: AppFont.bodyMedium(context).copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
