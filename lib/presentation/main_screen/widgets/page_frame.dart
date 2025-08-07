import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd_store/core/config/theme/gap.dart';

class PageFrame extends StatelessWidget {
  const PageFrame({super.key, required this.pageWidgets, this.padding});
  final List<Widget> pageWidgets;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Gap(largeGap),
          Padding(
            padding: padding ?? const EdgeInsetsGeometry.all(0),
            child: Flex(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              direction: Axis.vertical,
              children: pageWidgets,
            ),
          )
        ],
      ),
    );
  }
}
