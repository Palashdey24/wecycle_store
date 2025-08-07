import 'package:flutter/material.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';
import 'package:wcycle_bd_store/presentation/overview/widgets/pie_ui.dart';

enum OrderStatus {
  pending,
  completed,
  cancelled,
}

class OverviewStatusInfoUi extends StatelessWidget {
  const OverviewStatusInfoUi(
      {super.key,
      required this.uniqueCustomers,
      required this.totalOrders,
      required this.pendingOrders,
      required this.completedOrders,
      required this.cancelledOrders});

  final int uniqueCustomers;
  final int totalOrders;
  final int pendingOrders;
  final int completedOrders;
  final int cancelledOrders;

  @override
  Widget build(BuildContext context) {
    Map<OrderStatus, int> orderStatus = {
      OrderStatus.completed: completedOrders,
      OrderStatus.pending: pendingOrders,
      OrderStatus.cancelled: cancelledOrders,
    };
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          Text(
            "Orders",
            style: AppFont.bodyMedium(context).copyWith(color: Colors.white),
          ),
          Text(
            "Unique Customers: $uniqueCustomers",
            style: AppFont.bodySmall(context).copyWith(color: Colors.grey),
          ),
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                  flex: 2,
                  child: Card(
                    elevation: 15,
                    color: Colors.transparent,
                    shadowColor: AppColor.kLightColor.withValues(alpha: 0.2),
                    child: PieUi(
                      cancelledOrders: cancelledOrders,
                      completedOrders: completedOrders,
                      pendingOrders: pendingOrders,
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Flex(
                    direction: Axis.vertical,
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final entry in orderStatus.entries)
                        Flex(
                            direction: Axis.vertical,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            spacing: 2,
                            children: [
                              Text(
                                entry.key.name,
                                textAlign: TextAlign.center,
                                style: AppFont.bodySmall(context)
                                    .copyWith(color: AppColor.kLightColor),
                              ),
                              Text(
                                "${entry.value}",
                                textAlign: TextAlign.center,
                                style: AppFont.bodySmall(context)
                                    .copyWith(color: Colors.yellowAccent),
                              )
                            ]),
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}
