import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:clay_containers/widgets/clay_text.dart';
import 'package:flutter/material.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';

class CredentialBtn extends StatelessWidget {
  const CredentialBtn({super.key, required this.signText});

  final String signText;

  @override
  Widget build(BuildContext context) {
    return ClayContainer(
      color: Colors.black,
      curveType: CurveType.concave,
      customBorderRadius: const BorderRadius.only(
          topRight: Radius.elliptical(35, 35), bottomLeft: Radius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ClayText(
          signText,
          emboss: true,
          color: Colors.white,
          style: AppFont.bodyMedium(context),
        ),
      ),
    );
  }
}
