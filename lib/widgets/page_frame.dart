import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd_store/core/config/theme/gap.dart';

class PageFrame extends StatelessWidget {
  const PageFrame({super.key, required this.pageWidgets});
  final List<Widget> pageWidgets;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Gap(largeGap),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: pageWidgets,
          )
        ],
      ),
    );
  }
}
