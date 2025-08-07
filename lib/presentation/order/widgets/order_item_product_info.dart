import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';
import 'package:wcycle_bd_store/core/config/theme/gap.dart';
import 'package:wcycle_bd_store/domain/entities/order_data_entities.dart';

class OrderItemProductInfo extends StatelessWidget {
  const OrderItemProductInfo({super.key, required this.products});

  final Products products;

  @override
  Widget build(BuildContext context) {
    String imgUri = products.productImage;
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 50,
            child: Column(
              spacing: normalGap,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(normalGap),
                  child: CachedNetworkImage(height: 50, imageUrl: imgUri),
                ),
                Text(
                  "\$ ${products.productPrice.toString()}",
                  style: AppFont.bodySmall(context),
                )
              ],
            )),
        Expanded(
          flex: 50,
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Qty: ${products.quantity}",
                style: AppFont.bodySmall(context),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
