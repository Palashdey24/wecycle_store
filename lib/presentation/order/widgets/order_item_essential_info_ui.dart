import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';
import 'package:wcycle_bd_store/domain/entities/order_data_entities.dart';
import 'package:wcycle_bd_store/presentation/order/widgets/order_delivery_info_ui.dart';

import 'order_item_product_info.dart';

class OrderItemEssentialInfoUi extends StatelessWidget {
  const OrderItemEssentialInfoUi(
      {super.key,
      required this.order,
      required this.deliveryInfo,
      this.divider});

  final OrderDataEntity order;
  final List<OrderDeliveryInfoUi> deliveryInfo;
  final double? divider;

  @override
  Widget build(BuildContext context) {
    final OrderDataEntity(:address, :products) = order;
    return Flex(
      direction: Axis.vertical,
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                address.name ?? "N/A",
                style: AppFont.bodyMedium(context),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.blueGrey.withValues(alpha: 0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                padding: const EdgeInsets.all(5),
                child: Text(
                  order.status![order.status!.length - 1].status,
                  style: AppFont.bodySmall(context),
                ),
              ),
            ],
          ),
        ),
        for (final product in products!)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OrderItemProductInfo(
              products: product,
            ),
          ),
        if (divider != null)
          Divider(
            color: Colors.green,
            thickness: divider,
          ),
        const Gap(5),
        ...deliveryInfo,
      ],
    );
  }
}
