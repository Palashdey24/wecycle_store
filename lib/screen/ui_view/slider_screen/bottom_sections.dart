import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd_store/api/firebase_api.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';
import 'package:wcycle_bd_store/core/config/theme/gap.dart';
import 'package:wcycle_bd_store/widgets/side_menu_item.dart';

final fsApis = FirebaseApi();

class BottomSections extends StatelessWidget {
  const BottomSections({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        SideMenuItem(
            itemTittle: "LogOut",
            itemIcons: FontAwesomeIcons.rightFromBracket,
            itemFn: () async {
              await FirebaseAuth.instance.signOut();
            }),
        const Gap(largeGap),
        Text(
          "Version: 1.0.0",
          style: AppFont.bodyMedium(context)
              .copyWith(color: Colors.blueGrey.shade300),
        ),
        const Gap(largeGap),
      ],
    );
  }
}
