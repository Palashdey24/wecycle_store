import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wcycle_bd_store/api/firebase_api.dart';
import 'package:wcycle_bd_store/domain/entities/order_data_entities.dart';

final apis = FirebaseApi();

class IndividualOrderProviderNotifier extends StateNotifier<OrderDataEntity> {
  IndividualOrderProviderNotifier()
      : super(OrderDataEntity(
            address: Address(
                zip: "",
                isDefault: false,
                apt: "",
                city: "",
                street: "",
                contactNumber: "",
                name: "",
                userId: "",
                long: 0,
                lat: 0,
                mapAddress: ""),
            totalPrice: 0,
            status: [Status(Time: "", status: "")],
            metaDatas: [MetaData(metaName: '', metaData: '')],
            products: [
              Products(
                  impactLevel: "",
                  quantity: 0,
                  productImage:
                      "https://firebasestorage.googleapis.com/v0/b/wcyclebd.appspot.com/o/RecycleCategory%2F640.png?alt=media&token=31e2b4de-2c79-4b6b-ba57-5b91c6a68bcf",
                  productID: "",
                  productOnline: false,
                  shopID: "",
                  productName: "",
                  productPrice: 0)
            ],
            storeId: ""));

  Future<void> getOrder(String orderID) async {
    final fsRef = apis.fireStore.collection('recycleOrder').doc(orderID);

    fsRef.snapshots().listen(
      (event) {
        if (event.exists) {
          var data = event.data();
          OrderDataEntity order =
              OrderDataEntity.fromJson(data!, orderID: orderID);
          state = order;
        }
      },
      onError: (error) {
        log(error);
      },
    );
  }
}

final individualOrderProvider =
    StateNotifierProvider<IndividualOrderProviderNotifier, OrderDataEntity>(
        (ref) {
  return IndividualOrderProviderNotifier();
});
