import 'package:flutter/material.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';

class OrderDeliveryInfoUi extends StatelessWidget {
  const OrderDeliveryInfoUi(
      {super.key, required this.uiTittle, required this.uiData});

  final String uiTittle;
  final String uiData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              uiTittle,
              style: AppFont.bodyMedium(context),
            ),
          ),
          Expanded(
            child: Text(
              uiData,
              style: AppFont.bodySmall(context),
              softWrap: true,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
