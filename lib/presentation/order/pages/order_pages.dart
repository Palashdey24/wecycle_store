import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd_store/api/firebase_api.dart';
import 'package:wcycle_bd_store/common/dimensions/phone_size.dart';
import 'package:wcycle_bd_store/common/widgets/btn/back_btn.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';
import 'package:wcycle_bd_store/core/config/theme/app_font.dart';
import 'package:wcycle_bd_store/domain/entities/order_data_entities.dart';
import 'package:wcycle_bd_store/presentation/order/state_managment/indiviual_order_provider.dart';
import 'package:wcycle_bd_store/presentation/order/widgets/order_list_item.dart';
import 'package:wcycle_bd_store/presentation/shimmer/lt_shimmer.dart';

class OrderPages extends ConsumerWidget {
  const OrderPages({super.key});

  static const List<String> statusList = <String>[
    'All',
    'Placed',
    'Processing',
    'Out to take',
    'To Pay',
    'Paid',
    'Cancelled',
    'Pending',
    'Completed',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<OrderDataEntity> orders = [];

    return Scaffold(
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flex(
              direction: Axis.horizontal,
              spacing: 10,
              children: [
                const BackBtn(),
                Text(
                  "Orders",
                  style:
                      AppFont.bodyMedium(context).copyWith(color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              width: PhoneSize.deviceWidth(context),
              height: 60,
              child: ListView(scrollDirection: Axis.horizontal, children: [
                for (var status in statusList)
                  TextButton(onPressed: () {}, child: Text(status)),
              ]),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 0),
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(40),
                    right: Radius.circular(40),
                  ),
                ),
                child: StreamBuilder(
                    stream: FirebaseApi()
                        .fireStore
                        .collection("recycleOrder")
                        .where("storeId",
                            isEqualTo: FirebaseApi().currentUser.uid)
                        .snapshots(),
                    builder: (BuildContext context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return const SizedBox(
                            height: 300,
                            child: LtShimmer(),
                          );

                        case ConnectionState.active:
                        case ConnectionState.done:
                          final datas = snapshot.data!.docs;

                          //Add data to model list one after one
                          orders = datas
                              .map(
                                (e) => OrderDataEntity.fromJson(e.data(),
                                    orderID: e.id),
                              )
                              .toList();

                        /*
                for (var inout in datas!) {
                  log(jsonEncode(inout.data()));
                }*/
                      }

                      return orders.isNotEmpty
                          ? ListView.builder(
                              itemCount: orders.length,
                              itemBuilder: (context, index) {
                                ref
                                    .read(individualOrderProvider.notifier)
                                    .getOrder(orders[index].orderID!);
                                return OrderListItem(
                                  order: orders[index],
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                "No Order Yet",
                                style: AppFont.bodyLarge(context)
                                    .copyWith(color: AppColor.kDarkColor),
                              ),
                            );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
