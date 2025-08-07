import 'package:flutter/material.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';

class StoreProfileDataUi extends StatelessWidget {
  const StoreProfileDataUi(
      {super.key, required this.data, required this.title});
  final String data;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 5,
        children: [
          Text(
            title,
            style: AppFont.bodyMedium(context).copyWith(color: Colors.white54),
          ),
          Text(
            data,
            style: AppFont.bodySmall(context).copyWith(color: Colors.yellow),
          ),
        ],
      ),
    );
  }
}
