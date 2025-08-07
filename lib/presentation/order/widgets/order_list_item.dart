import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wcycle_bd_store/common/dimensions/app_gaps.dart';
import 'package:wcycle_bd_store/common/dimensions/phone_size.dart';
import 'package:wcycle_bd_store/common/helper/navigator/app_navigator.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';
import 'package:wcycle_bd_store/domain/entities/order_data_entities.dart';
import 'package:wcycle_bd_store/presentation/order/pages/order_process_ui_page.dart';
import 'package:wcycle_bd_store/presentation/order/state_managment/indiviual_order_provider.dart';
import 'package:wcycle_bd_store/presentation/order/widgets/address_locations_ui.dart';
import 'package:wcycle_bd_store/presentation/order/widgets/order_delivery_info_ui.dart';
import 'package:wcycle_bd_store/presentation/order/widgets/order_item_essential_info_ui.dart';

class OrderListItem extends ConsumerWidget {
  const OrderListItem({
    super.key,
    required this.order,
  });

  final OrderDataEntity order;

  static void processBtn(
      BuildContext context, OrderDataEntity order, WidgetRef ref) {
    ref.watch(individualOrderProvider.notifier).getOrder(order.orderID!).then(
      (value) {
        for (final processOptions in OrderProcessUiPage.processOptions) {
          if (processOptions ==
              order.status![order.status!.length - 1].status) {
            if (!context.mounted) return;
            AppNavigatior.navigatorPush(
                context,
                OrderProcessUiPage(
                  currentProcessIndex:
                      OrderProcessUiPage.processOptions.indexOf(processOptions),
                  nextOrFinalStep: processOptions == "Cancelled"
                      ? "Cancelled"
                      : OrderProcessUiPage.processOptions[OrderProcessUiPage
                              .processOptions
                              .indexOf(processOptions) +
                          1],
                ));
            return;
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderdata = ref.watch(individualOrderProvider);
    final OrderDataEntity(
      :address,
      :orderID,
      :status,
      :metaDatas,
      :totalPrice
    ) = order;

    void showOrderDetailsDialog() {
      ref.read(individualOrderProvider.notifier).getOrder(orderID!);

      showBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            width: PhoneSize.deviceWidth(context),
            height: PhoneSize.deviceHeight(context) * 0.7,
            decoration: const BoxDecoration(
                color: AppColor.kLightColor,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppGaps.largeGap))),
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppGaps.normalGap,
              ),
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const FaIcon(
                      FontAwesomeIcons.squareCaretDown,
                      size: AppGaps.largeGap,
                      color: AppColor.kDarkColor,
                    )),
                const Gap(AppGaps.mediumGap),
                Text(
                  "Customer Details",
                  textAlign: TextAlign.center,
                  style: AppFont.bodyLarge(context),
                ),
                OrderDeliveryInfoUi(uiTittle: "Name", uiData: address.name),
                const Gap(AppGaps.mediumGap),
                OrderDeliveryInfoUi(
                    uiTittle: "Number", uiData: address.contactNumber),
                const Gap(AppGaps.mediumGap),
                OrderDeliveryInfoUi(
                    uiTittle: "PickUp Address",
                    uiData:
                        "${address.apt} - ${address.mapAddress} - ${address.street} - ${address.city} - ${address.zip}"),
                const Gap(AppGaps.mediumGap),
                if (metaDatas != null)
                  for (final metaData in metaDatas)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppGaps.mediumGap),
                      child: OrderDeliveryInfoUi(
                          uiTittle: metaData.metaName,
                          uiData: metaData.metaData),
                    ),
                const Gap(AppGaps.mediumGap),
                AddressLocationsUi(
                  addressModel: address,
                  takeLocationsData:
                      (String? address, double? lat, double? long) {},
                ),
                const Gap(AppGaps.largeGap),
              ],
            ),
          );
        },
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsetsGeometry.only(bottom: 20),
          child: Card(
            clipBehavior: Clip.hardEdge,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Flex(
              direction: Axis.vertical,
              children: [
                OrderItemEssentialInfoUi(
                  order: order,
                  divider: 3,
                  deliveryInfo: [
                    OrderDeliveryInfoUi(
                        uiTittle: "Date:",
                        uiData: status![status.length - 1].Time),
                    OrderDeliveryInfoUi(
                        uiTittle: "Total Payable:",
                        uiData: totalPrice.toString()),
                  ],
                ),
                const Gap(5),
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => showOrderDetailsDialog(),
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.black)),
                      child: Text("Details",
                          style: AppFont.bodySmall(context)
                              .copyWith(color: Colors.white)),
                    ),
                    TextButton(
                      onPressed: () => processBtn(context, order, ref),
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.black)),
                      child: Text("Update Order",
                          style: AppFont.bodySmall(context)
                              .copyWith(color: Colors.white)),
                    ),
                  ],
                ),
                const Gap(25),
              ],
            ),
          ),
        ),
        Positioned(
            bottom: 10,
            child: Card(
              color: Colors.blueGrey,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "ID: $orderID",
                  textAlign: TextAlign.center,
                  style:
                      AppFont.bodyMedium(context).copyWith(color: Colors.white),
                ),
              ),
            ))
      ],
    );
  }
}
