import 'package:flutter/material.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';



class PageHeader extends StatelessWidget {
  const PageHeader({super.key, required this.pageName});
  final String pageName;

  @override
  Widget build(BuildContext context) {
    return Text(
      pageName,
      textAlign: TextAlign.center,
      style: AppFont.bodyMedium(context).copyWith(color: Colors.white),
    );
  }
}
