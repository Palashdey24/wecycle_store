import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';
import 'package:wcycle_bd_store/core/config/theme/gap.dart';

class BodyIntroductionSections extends StatelessWidget {
  const BodyIntroductionSections(
      {super.key, required this.titleTxt, this.icons, this.bIsectionFn});
  final String titleTxt;
  final IconData? icons;
  final void Function()? bIsectionFn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: mediumGap, right: mediumGap),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              titleTxt,
              textAlign: TextAlign.left,
              style: AppFont.bodyMedium(context).copyWith(color: Colors.white),
            ),
          ),
          if (icons != null)
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: AppColor.kDarkColor,
                  child: IconButton(
                      onPressed: bIsectionFn,
                      icon: FaIcon(
                        icons,
                        size: 15,
                        color: Colors.white,
                      )),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
