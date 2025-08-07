import 'package:flutter/material.dart';

class ReuseableContainer extends StatelessWidget {
  const ReuseableContainer(
      {super.key,
      required this.ctColor,
      required this.ctMargin,
      this.ctWidget,
      this.ctWidth});

  final Color ctColor;
  final EdgeInsetsGeometry ctMargin;
  final Widget? ctWidget;
  final double? ctWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ctWidth,
      margin: ctMargin,
      decoration: BoxDecoration(
        boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 5)],
        color: ctColor,
        borderRadius: const BorderRadius.horizontal(
          right: Radius.circular(30),
        ),
      ),
      child: ctWidget,
    );
  }
}
