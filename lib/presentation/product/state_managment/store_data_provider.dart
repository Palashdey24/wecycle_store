import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd_store/api/firebase_api.dart';
import 'package:wcycle_bd_store/data/model/remote/recycle_product_model.dart';

class StoreDataProviderNotifier
    extends StateNotifier<List<RecycleProductModel>> {
  StoreDataProviderNotifier() : super(List<RecycleProductModel>.empty());

  Future<List<RecycleProductModel>> shopData() async {
    final fsRef = FirebaseFirestore.instance.collection("recycleProduct");
    List<RecycleProductModel> recycleDataList = [];

    fsRef
        .where('shopID', isEqualTo: FirebaseApi().currentUser.uid)
        .snapshots()
        .listen(
      (event) {
        final recycleData = event.docs;
        //Add data to model list one after one
        recycleDataList = recycleData
            .map(
              (e) => RecycleProductModel.fromJson(e.data()),
            )
            .toList();

        state = recycleDataList;
      },
      onError: (error) {
        log("error: $error");
        return recycleDataList.isEmpty;
      },
    );
    if (recycleDataList.isEmpty) {
      return [];
    }
    return state;
  }
}

final storeDataProvider =
    StateNotifierProvider<StoreDataProviderNotifier, List<RecycleProductModel>>(
        (ref) {
  return StoreDataProviderNotifier();
});
