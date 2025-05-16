import 'package:flutter/material.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';
import 'package:wcycle_bd_store/common/widgets/loading/loading_widget.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 300,
      child: LoadingWidgets(
        backgroundColor: AppColor.kPrimaryColor,
      ),
    );
  }
}
