import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';

class BackBtn extends StatelessWidget {
  const BackBtn({super.key, this.onBtn});
  final void Function()? onBtn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10),
      child: CircleAvatar(
        backgroundColor: AppColor.kSecondColor,
        radius: 15,
        child: IconButton(
            alignment: Alignment.center,
            onPressed: onBtn ?? () => Navigator.pop(context),
            icon: const FaIcon(
              FontAwesomeIcons.leftLong,
              size: 15,
              color: AppColor.kLightColor,
            )),
      ),
    );
  }
}
