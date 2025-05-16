import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd_store/data/model/remote/recycle_product_model.dart';

class RecycleProductNotifier extends StateNotifier<List<RecycleProductModel>> {
  RecycleProductNotifier() : super([]);

  void shopProduct(String shopId) async {
    final querySnap = await FirebaseFirestore.instance
        .collection("recycleProduct")
        .where('shopID', isEqualTo: shopId)
        .get();

    for (var inout in querySnap.docs) {
      state = [...state, RecycleProductModel.fromJson(inout.data())];
    }
  }
}

final recycleProductProvider =
    StateNotifierProvider<RecycleProductNotifier, List<RecycleProductModel>>(
  (ref) {
    return RecycleProductNotifier();
  },
);
