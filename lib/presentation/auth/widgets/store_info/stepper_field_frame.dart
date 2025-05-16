import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';

import 'package:wcycle_bd_store/core/config/theme/gap.dart';

class StepperFieldFrame extends StatelessWidget {
  const StepperFieldFrame(
      {super.key, required this.steperFieldText, required this.fieldWidget});
  final String steperFieldText;
  final Widget fieldWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: normalGap),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Gap(largeGap),
          Text(
            steperFieldText,
            textAlign: TextAlign.left,
            style: AppFont.bodyMedium(context)
                .copyWith(color: AppColor.kLightColor),
          ),
          const Gap(normalGap),
          fieldWidget,
        ],
      ),
    );
  }
}
