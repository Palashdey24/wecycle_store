import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd_store/common/helper/dialog_loading/dialogs_helper.dart';
import 'package:wcycle_bd_store/domain/entities/store_data_entities.dart';

class IndividualStoreProviderNotifier extends StateNotifier<StoreDataEntity> {
  IndividualStoreProviderNotifier()
      : super(StoreDataEntity(
            rating: 0,
            totalRated: 0,
            phoneNumber: "N/A",
            storeAddress: "N?A",
            locations: Locations.fromJson({}),
            storeName: "N/A",
            docUri: "N?A",
            id: "N/A",
            logoUri: "N/A",
            storeStatus: "N/A",
            email: "N/A",
            storeBin: "N/A"));

  Future<void> shopData(BuildContext context) async {
    final fsRef = FirebaseFirestore.instance
        .collection('store')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    fsRef.snapshots().listen(
      (event) {
        var data = event.data();
        StoreDataEntity shopModel = StoreDataEntity.fromJson(data!);
        state = shopModel;
      },
      onError: (error) {
        if (!context.mounted) return;
        DialogsLoading.showMessage(context, "Listen Failed: $error");
      },
    );
  }
}

final individualStoreProvider =
    StateNotifierProvider<IndividualStoreProviderNotifier, StoreDataEntity>(
        (ref) {
  return IndividualStoreProviderNotifier();
});
