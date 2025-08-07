import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd_store/common/dimensions/app_gaps.dart';
import 'package:wcycle_bd_store/common/riverpod/store_order_provider.dart';
import 'package:wcycle_bd_store/common/widgets/card_container/reuseable_container.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';
import 'package:wcycle_bd_store/data/model/local/overview_model.dart';
import 'package:wcycle_bd_store/presentation/overview/state_managment/store_overview_data_provider.dart';
import 'package:wcycle_bd_store/presentation/overview/widgets/overview_status_info_ui.dart';

class OverviewSections extends ConsumerWidget {
  const OverviewSections({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeOrder = ref.watch(storeOrderProvider);
    ref.watch(storeOverviewDataProvider.notifier).getOverviewData(storeOrder);
    final overviewData = ref.watch(storeOverviewDataProvider);

    final OverviewModel(
      :uniqueCustomers,
      :totalOrders,
      :pendingOrders,
      :completedOrders,
      :cancelledOrders,
      :completedProducts,
      :completedProductsWeight,
      :pendingProducts,
      :totalPendingProductsWeight,
    ) = overviewData;

    List<IconData> completeIcons = [
      FontAwesomeIcons.weightHanging,
      FontAwesomeIcons.diamond,
    ];

    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          flex: 2,
          child: ReuseableContainer(
            ctColor: Colors.orange.shade500,
            ctMargin: const EdgeInsets.symmetric(horizontal: 12),
            ctWidget: ReuseableContainer(
              ctColor: AppColor.kDarkColor,
              ctMargin: const EdgeInsets.only(right: 10),
              ctWidget: OverviewStatusInfoUi(
                  uniqueCustomers: uniqueCustomers,
                  totalOrders: totalOrders,
                  pendingOrders: pendingOrders,
                  completedOrders: completedOrders,
                  cancelledOrders: cancelledOrders),
            ),
          ),
        ),
        Expanded(
            child: Flex(
          direction: Axis.vertical,
          spacing: 2,
          children: [
            Expanded(
              child: ReuseableContainer(
                ctColor: Colors.blueGrey,
                ctMargin: const EdgeInsets.all(2),
                ctWidget: ReuseableContainer(
                  ctColor: AppColor.kDarkColor,
                  ctMargin: const EdgeInsetsGeometry.only(
                    right: 7,
                  ),
                  ctWidget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Flex(
                        direction: Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: AppGaps.normalGap,
                        children: [
                          Text(
                            "Complete",
                            style: AppFont.bodySmall(context)
                                .copyWith(color: Colors.white),
                          ),
                          for (int i = 0; i < completeIcons.length; i++)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FaIcon(
                                    completeIcons[i],
                                    size: 15,
                                    color: Colors.limeAccent,
                                  ),
                                  Text(
                                    i == 1
                                        ? completedProducts.toString()
                                        : "$completedProductsWeight kg",
                                    style: AppFont.bodySmall(context)
                                        .copyWith(color: AppColor.kLightColor),
                                  ),
                                ],
                              ),
                            )
                        ]),
                  ),
                ),
              ),
            ),
            const Gap(2),
            Expanded(
              child: ReuseableContainer(
                ctColor: Colors.blueGrey,
                ctMargin: const EdgeInsets.all(2),
                ctWidget: ReuseableContainer(
                  ctColor: AppColor.kDarkColor,
                  ctMargin: const EdgeInsetsGeometry.only(
                    right: 7,
                  ),
                  ctWidget: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Flex(
                        direction: Axis.vertical,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: AppGaps.normalGap,
                        children: [
                          Text(
                            "Pending",
                            style: AppFont.bodySmall(context)
                                .copyWith(color: Colors.white),
                          ),
                          for (int i = 0; i < completeIcons.length; i++)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FaIcon(
                                    completeIcons[i],
                                    size: 15,
                                    color: Colors.limeAccent,
                                  ),
                                  Text(
                                    i == 1
                                        ? pendingProducts.toString()
                                        : "$totalPendingProductsWeight kg",
                                    style: AppFont.bodySmall(context)
                                        .copyWith(color: AppColor.kLightColor),
                                  ),
                                ],
                              ),
                            )
                        ]),
                  ),
                ),
              ),
            ),
          ],
        ))
      ],
    );
  }
}
