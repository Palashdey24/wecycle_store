import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';
import 'package:wcycle_bd_store/core/config/theme/gap.dart';

class EmptyWidgetWithAction extends StatelessWidget {
  const EmptyWidgetWithAction(
      {super.key,
      required this.emptyTitle,
      required this.emptySubTitle,
      this.onBtnFn,
      this.btnText});
  final String emptyTitle;
  final String emptySubTitle;
  final String? btnText;
  final void Function()? onBtnFn;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Empty",
          style: AppFont.bodyMedium(context),
        ),
        const Gap(normalGap),
        Text(
          "No product Available. Add product",
          style: AppFont.bodySmall(context).copyWith(color: Colors.white),
        ),
        const Gap(normalGap),
        if (onBtnFn != null)
          ElevatedButton(onPressed: onBtnFn, child: Text(btnText ?? "Hello")),
      ],
    );
  }
}
