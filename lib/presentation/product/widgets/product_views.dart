import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wcycle_bd_store/common/helper/navigator/app_navigator.dart';
import 'package:wcycle_bd_store/common/widgets/empty_display/empty_widget_with_action.dart';
import 'package:wcycle_bd_store/common/widgets/shimmer/recycle_shimmer.dart';
import 'package:wcycle_bd_store/data/model/remote/recycle_product_model.dart';
import 'package:wcycle_bd_store/presentation/add_data/pages/add_recycle_product_page.dart';
import 'package:wcycle_bd_store/presentation/product/widgets/recycle_list_item.dart';

class ProductViews extends StatelessWidget {
  const ProductViews({super.key, required this.shopId});

  final String shopId;

  @override
  Widget build(BuildContext context) {
    List<RecycleProductModel> recycleDataList = [];

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("recycleProduct")
          .where('shopID', isEqualTo: shopId)
          .snapshots(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
            return const SizedBox(
              height: 150,
              child: RecycleShimmer(),
            );

          case ConnectionState.active:
          case ConnectionState.done:
            final recycleData = snapshot.data!.docs;
            //Add data to model list one after one
            recycleDataList = recycleData
                .map(
                  (e) => RecycleProductModel.fromJson(e.data()),
                )
                .toList();
        }
        return SizedBox(
          height: 150,
          child: recycleDataList.isEmpty
              ? EmptyWidgetWithAction(
                  emptyTitle: "Empty Product",
                  emptySubTitle: "No Product Added.",
                  btnText: "Add Product",
                  onBtnFn: () {
                    AppNavigatior.navigatorPushWithTransition(
                        context,
                        const AddRecycleProductPage(),
                        const Offset(0, -1),
                        Curves.easeInSine);
                  },
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recycleDataList.length,
                  itemBuilder: (context, index) {
                    return RecycleListItem(
                      rcListModel: recycleDataList[index],
                      isDtPage: false,
                    );
                  },
                ),
        );
      },
    );
  }
}
