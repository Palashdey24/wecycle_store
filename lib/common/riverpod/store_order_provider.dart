import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd_store/api/firebase_api.dart';
import 'package:wcycle_bd_store/domain/entities/order_data_entities.dart';

class StoreOrderProviderNotifier extends StateNotifier<List<OrderDataEntity>> {
  StoreOrderProviderNotifier() : super(List<OrderDataEntity>.empty());

  Future<void> orderData() async {
    final fsRef = FirebaseFirestore.instance.collection("recycleOrder");
    List<OrderDataEntity> orderDataList = [];

    fsRef
        .where("storeId", isEqualTo: FirebaseApi().currentUser.uid)
        .snapshots()
        .listen(
      (event) {
        final orderDatas = event.docs;
        //Add data to model list one after one
        orderDataList = orderDatas
            .map(
              (e) => OrderDataEntity.fromJson(e.data(), orderID: e.id),
            )
            .toList();

        if (orderDataList.isEmpty) {
          return;
        }
        state = orderDataList;
      },
      onError: (error) {
        log("error: $error");
      },
    );
  }
}

final storeOrderProvider =
    StateNotifierProvider<StoreOrderProviderNotifier, List<OrderDataEntity>>(
        (ref) {
  return StoreOrderProviderNotifier();
});
