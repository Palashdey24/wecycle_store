import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';
import 'package:wcycle_bd_store/presentation/main_screen/widgets/page_frame.dart';
import 'package:wcycle_bd_store/presentation/main_screen/widgets/page_header.dart';

class ServicePages extends StatelessWidget {
  const ServicePages({super.key});

  @override
  Widget build(BuildContext context) {
    return PageFrame(pageWidgets: [
      const PageHeader(pageName: "Service"),
      const Gap(50),
      Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/under-construction-4401023_640.png"),
          Text(
            "Service will be available soon",
            style: AppFont.bodyMedium(context)
                .copyWith(color: AppColor.kLightColor),
          )
        ],
      )
    ]);
  }
}
