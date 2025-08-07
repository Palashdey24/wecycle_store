import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd_store/common/widgets/other/clay_logo_text.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';
import 'package:wcycle_bd_store/core/config/theme/gap.dart';

class CredentialTextContainer extends StatelessWidget {
  const CredentialTextContainer(
      {super.key, required this.btnWidgets, required this.isSign});

  final Widget btnWidgets;
  final bool isSign;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const ClayLogoText(
          clayTColor: Colors.grey,
        ),
        const Gap(largeGap),
        Text(
          isSign ? "Welcome Back" : "Welcome",
          textAlign: TextAlign.center,
          style:
              AppFont.bodyMedium(context).copyWith(color: Colors.grey.shade600),
        ),
        const Gap(normalGap),
        Text(
          isSign
              ? "To keep connected with us.Please login with your personal info"
              : "Please create A account with us.For access more Feature",
          textAlign: TextAlign.center,
          style: AppFont.bodyMedium(context),
        ),
        const Gap(mediumGap),
        btnWidgets,
      ],
    );
  }
}
