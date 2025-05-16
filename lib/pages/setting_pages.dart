import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd_store/widgets/page_header.dart';
import 'package:wcycle_bd_store/core/config/theme/gap.dart';
import 'package:wcycle_bd_store/widgets/page_frame.dart';

class SettingPages extends StatelessWidget {
  const SettingPages({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageFrame(pageWidgets: [
      PageHeader(pageName: "Setting"),
      Gap(largeGap),
    ]);
  }
}
