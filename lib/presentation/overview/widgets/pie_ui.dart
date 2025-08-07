import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';

enum OrderStatus { pending, completed, cancelled }

class PieUi extends StatelessWidget {
  const PieUi(
      {super.key,
      required this.completedOrders,
      required this.pendingOrders,
      required this.cancelledOrders});

  final int completedOrders;
  final int pendingOrders;
  final int cancelledOrders;

  @override
  Widget build(BuildContext context) {
    Map<OrderStatus, Map<String, dynamic>> pieChart = {
      OrderStatus.pending: {"color": Colors.blueGrey, "value": pendingOrders},
      OrderStatus.completed: {
        "color": AppColor.kSecondColor,
        "value": completedOrders
      },
      OrderStatus.cancelled: {"color": Colors.black, "value": cancelledOrders}
    };
    return SizedBox(
      height: 125,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
              curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
              duration: const Duration(microseconds: 900),
              PieChartData(sections: [
                for (final pieChartItem in pieChart.entries)
                  PieChartSectionData(
                    color: pieChartItem.value["color"],
                    value: pieChartItem.value["value"].toDouble(),
                  )
              ])),
          Text(
            "Chart",
            style: AppFont.bodySmall(context)
                .copyWith(color: AppColor.kLightColor),
          ),
        ],
      ),
    );
  }
}
