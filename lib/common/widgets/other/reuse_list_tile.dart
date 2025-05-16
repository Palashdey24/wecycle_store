import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';

class ReuseListTile extends StatelessWidget {
  const ReuseListTile(
      {super.key, required this.listTitle, required this.listIcon, this.onTap});

  final String listTitle;
  final IconData listIcon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          if (onTap == null) return;
          onTap!();
        },
        child: SizedBox(
          height: 90,
          child: Card(
            color: AppColor.kDarkColor,
            elevation: 8,
            child: ListTile(
              leading: FaIcon(
                listIcon,
                color: Colors.lightGreen,
              ),
              title: Text(
                listTitle,
                style: AppFont.bodySmall(context).copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
